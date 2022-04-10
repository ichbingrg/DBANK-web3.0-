import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank{

  //stable keyword makes a variable orthogonally persistant which means the changes on the value remains even if the program is rerun
  stable var currentValue : Float = 300;
  currentValue := 100;
  Debug.print(debug_show(currentValue));


  stable var startTime = Time.now();
  startTime := Time.now();
  Debug.print(debug_show(startTime)); //shows currenttime in nanoseconds

  //Debug.print : (Text) -> (output in terminal) but it only accepts texts => wrapping needed
  //debug_show : () -> (Text)
  // Debug.print(debug_show(currentValue)); // prints currentValue in the terminal

  //let works as constant
  //let id = 342354242343245345;

  //Debug.print(debug_show(debug_show(id)));

  public func topUp(amount: Float){
    currentValue+=amount;
    Debug.print(debug_show(currentValue));
  };




  public func withdraw(amount: Float){
    let remainingValue: Float = currentValue-amount;
    if(remainingValue>=0){
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    }else{
      Debug.print("Not enough funds");
    }
  };

  //topUp();

  //update needs to go through the blockchain and require consensus from each node in the blcokchain that's why it is slow 
  //query - READ ONLY - no update to anything but just fetching the values. -> faster than update
  // <public> query func <funcname>(attributes): async <returnType> { ---- code ----- };
  public query func checkBalance(): async Float {

    return currentValue;

  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime-startTime;
    let timeElapsedS = timeElapsedNS/1000000000;
    currentValue := currentValue*((1.01)** Float.fromInt(timeElapsedS)); 
    startTime := currentTime;
  };
}
