// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";



interface IAggregator {


    
    /// @notice find the best market to execute swap
    /// @param fromToken  fromToken
    /// @param toToken   toToken
    /// @param amount  amount
    function calculateMarketReturn(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 amount
    ) external view returns(uint256[] memory marketOutput); // [Uniswap,SushiSwap,etc.]

    

    /// @notice find the best market to execute swap
    /// @param fromToken  fromToken
    /// @param toToken   toToken
    /// @param minReturn   minReturn
    /// @param marketID marketID
    function swap(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 minReturn,
        uint256 marketID
    ) external payable;

}