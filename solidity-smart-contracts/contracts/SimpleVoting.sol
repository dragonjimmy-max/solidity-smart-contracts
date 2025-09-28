// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleVoting {
    struct Proposal { string name; uint voteCount; }
    address public chairperson;
    mapping(address => bool) public hasVoted;
    Proposal[] public proposals;

    constructor(string[] memory proposalNames) {
        chairperson = msg.sender;
        for (uint i=0; i<proposalNames.length; i++) {
            proposals.push(Proposal({name:proposalNames[i], voteCount:0}));
        }
    }

    function vote(uint proposal) external {
        require(!hasVoted[msg.sender], "voted");
        require(proposal < proposals.length, "invalid");
        hasVoted[msg.sender] = true;
        proposals[proposal].voteCount += 1;
    }

    function winner() external view returns (string memory name, uint votes) {
        uint w; uint max;
        for (uint i=0; i<proposals.length; i++) {
            if (proposals[i].voteCount > max) { max = proposals[i].voteCount; w = i; }
        }
        return (proposals[w].name, proposals[w].voteCount);
    }
}
