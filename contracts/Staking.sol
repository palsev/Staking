// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Staking is ReentrancyGuard {
    IERC20 public stakingToken;
    
    mapping(address => uint) public userBalance;
    mapping(address => uint) public userReward;

    uint public constant rewardRate = 100;
    uint public lastUpdateTime;
    uint public claimAmount;

    constructor(address _stakingToken) {
        stakingToken = IERC20(_stakingToken);
    }

    //Getter
    function getStaked(address account) public view returns(uint){
        return userBalance[account];
    }

    //Setter
    function updateRewardAmount() external{
        claimAmount = ((block.timestamp - lastUpdateTime) / 3600 / 24) * (userBalance[msg.sender] * rewardRate / 100 / 12 / 30);
    }

    function claim() external {
        userBalance[msg.sender] += claimAmount;
        userReward[msg.sender] += claimAmount;
        claimAmount = 0;

        lastUpdateTime = block.timestamp;        
    }

    function stake(uint amount) external {
        userBalance[msg.sender] += amount;
        lastUpdateTime = block.timestamp;

        stakingToken.approve(address(this), 2001128);
        stakingToken.transferFrom(msg.sender, address(this), amount);
    }

    function withDraw(uint amount) external {
        userBalance[msg.sender] -= amount;
        lastUpdateTime = block.timestamp;
        
        IERC20(address(this)).transfer(msg.sender, amount);
    }
}
