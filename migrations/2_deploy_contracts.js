var SurvivorLeague = artifacts.require("./SurvivorLeague.sol");

module.exports = function(deployer) {
  deployer.deploy(SurvivorLeague);
};
