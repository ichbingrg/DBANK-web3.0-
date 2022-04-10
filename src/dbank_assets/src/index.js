import { dbank } from "../../declarations/dbank";

window.addEventListener("load", async ()=>{
  console.log("loaded");
  update();
});

document.querySelector("form").addEventListener("submit", async (event)=>{
  event.preventDefault();
  const button = event.target.querySelector("#submit-btn");

  console.log("submitted");

  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const withdrawalAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  button.setAttribute("disabled", true); //once the button is pressed disable it to prevent users from clicking it multiple times
  //top ups and withdrawal are updates on the DS thus will take a while to finish.
  console.log("Topup amount : " + inputAmount);
  console.log("withdrawal amount : " + withdrawalAmount);

  if((document.getElementById("input-amount").value)){
    await dbank.topUp(inputAmount);
  }

  if((document.getElementById("withdrawal-amount").value)){
    const balance = await dbank.checkBalance();
    if(withdrawalAmount>balance){
      console.log("not enough funds");
    }else{
      await dbank.withdraw(withdrawalAmount);
    }
  }

  // dbank.compound(); // to enable compound interest, but the compount interest is set to 1% per second for experimental reasons, therefore might result in astronomical numbers
  
  update();
  button.removeAttribute("disabled"); // button enabled again after the update has finished
})

async function update(){
  const currentAmount = await dbank.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount*100) / 100;
  document.getElementById("input-amount").value="" ; //empty the textfield after the update
  document.getElementById("withdrawal-amount").value="" ; //empty the textfield after the update
  
}