// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DisasterRelief {

    address public owner;
    uint public disasterThreshold = 1000; // The threshold to trigger fund release
    uint public totalDonations = 0;

    // Mapping to store donations
    mapping(address => uint) public donations;

    // Event to log donations
    event DonationReceived(address donor, uint amount);

    constructor() {
        owner = msg.sender;
    }

    // Function to donate
    function donate() public payable {
        require(msg.value > 0, "Donation must be greater than 0");

        donations[msg.sender] += msg.value;
        totalDonations += msg.value;

        emit DonationReceived(msg.sender, msg.value);
    }

    // Function to release funds based on disaster threshold
    function releaseFunds(address payable recipient) public {
        require(msg.sender == owner, "Only the owner can release funds");
        require(totalDonations >= disasterThreshold, "Donations haven't reached the threshold");

        recipient.transfer(totalDonations);  // Send funds to recipient

        // Reset total donations after funds are distributed
        totalDonations = 0;
    }

    // Get the total donations
    function getTotalDonations() public view returns (uint) {
        return totalDonations;
    }
}
