pragma solidity ^ 0.8.0;

contract Will {
    address owner;
    uint fortune;
    bool deceased;

  // payable allow this function to initializer to send a receive ether
  constructor() payable public {
    owner = msg.sender; // msg.sender represents address that is being called
    fortune = msg.value; // msg value tells us how much ether is being sent
    deceased = false;
  }

    // create modifier so the only person who can call the contract is the owner
    modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

    // create modifier so that we only allocate funds if friends gramps deceased
    modifier mustBeDeceased {
    require(deceased == true);
    _;
  }

    // list of family wallets 
    address payable[] familyWallets;

  // map through inheritance
  mapping(address => uint) inheritance;

  // set inheritance for each address
  function setInheritance(address payable wallet, uint amount) public onlyOwner {
    familyWallets.push(wallet);
    inheritance[wallet] = amount;
  }

  function payout() private mustBeDeceased {
    for (uint i = 0; i < familyWallets.length; i++) {
      // transfering fund from contract address to receiver address
      familyWallets[i].transfer(inheritance[familyWallets[i]]);
    }
  }

  // oracle switch simulation
  function hasDeceased() public onlyOwner {
    deceased = true;
    payout();
  }
}