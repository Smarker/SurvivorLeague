pragma solidity ^0.4.4;

contract SurvivorLeague {

  struct Contestant {
    address id;
    bool active;
  }

  Contestant[] public contestants;
  uint8 public currentWeek;

  address chairperson;
  mapping (address => bytes3[]) picks;

  function SurvivorLeague() {
    chairperson = msg.sender;
  }

  function setWinners(bytes3[] teams) {
    require(msg.sender == chairperson);

    for (uint i = 0; i < contestants.length; ++i) {
      bool hasWinner;
      for (uint j = 0; j < teams.length; ++j) {
        if (picks[contestants[i].id][currentWeek] == teams[j]) {
          hasWinner = true;
        }
      }

      if (!hasWinner) {
        contestants[i].active = false;
      }
    }

    ++currentWeek;
  }

  function addContestant(address contestant) {
    require(msg.sender == chairperson);
    require(currentWeek == 0);
    contestants.push(Contestant({
      id: contestant, 
      active: true
    }));
  }

  function setPick(bytes3 team) {
    for (uint i = 0; i < currentWeek; ++i) {
      require(picks[msg.sender][i] != team);
    }

    picks[msg.sender][currentWeek] = team;
  }
}
