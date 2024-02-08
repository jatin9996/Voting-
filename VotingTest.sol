// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "truffle/Assert.sol";
//import "truffle/DeployedAddresses.sol";
import ""

contract TestVoting {
    Voting voting = Voting(DeployedAddresses.Voting());

    // Test case for proposing items and voting
    function testVotingProcess() public {
        // Propose items
        voting.proposeItem("Blockchain");
        voting.proposeItem("Solidity");
        voting.proposeItem("Ethereum");

        // Cast votes
        voting.voteForItem(0); // Voting for "Blockchain"
        voting.voteForItem(0); // Another vote for "Blockchain"
        voting.voteForItem(1); // Voting for "Solidity"

        // Check the winner
        (uint256 winnerItemId, string memory winnerName) = voting.getWinner();

        // Asserts
        Assert.equal(winnerItemId, 0, "The item with ID 0 should be the winner.");
        Assert.equal(winnerName, "Blockchain", "The winner should be 'Blockchain'.");
    }
}