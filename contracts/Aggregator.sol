// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;


import "./IAggregator.sol";
import "./lib/UniswapV2ExchangeLib.sol";
import "./external/IUniswapV2Factory.sol";
import "@openzeppelin/contracts/proxy/Initializable.sol";



contract  Arrgegator is IAggregator,Initializable {

    using UniversalERC20 for IERC20;
    using UniswapV2ExchangeLib for IUniswapV2Exchange;
    uint256 constant public DEXES_COUNT = 2;
    IERC20  public weth ;
    IUniswapV2Factory public uniswapV2Factory;
    IUniswapV2Factory public sushiSwapFactory;
        
    
    function initialize(
        address _weth,
        address _uniswapV2Factory,
        address _sushiSwapFactory
    ) external initializer {
        weth = IERC20(_weth);
        uniswapV2Factory = IUniswapV2Factory(_uniswapV2Factory);
        sushiSwapFactory = IUniswapV2Factory(_sushiSwapFactory);
    }


    /// @notice find the best market to execute swap
    /// @param fromToken  fromToken
    /// @param toToken   toToken
    /// @param amount  amount
    function calculateMarketReturn(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 amount
    ) public override view returns(uint256[] memory marketOutput){

    }


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
    ) public override payable{

    }


    function calculateUniswapV2(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 amount
    ) public view returns(uint256) {
        IERC20 fromTokenReal = fromToken.isETH() ? weth : fromToken;
        IERC20 toTokenReal = toToken.isETH() ? weth : toToken;
        IUniswapV2Exchange fromExchange = uniswapV2Factory.getPair(fromTokenReal, toTokenReal);
        if (fromExchange != IUniswapV2Exchange(0)) {
            return fromExchange.getReturn(fromTokenReal, toTokenReal, amount);
        }
    }

    function calculateSushiSwap(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 amount
    ) public view returns(uint256) {
        IERC20 fromTokenReal = fromToken.isETH() ? weth : fromToken;
        IERC20 toTokenReal = toToken.isETH() ? weth : toToken;
        IUniswapV2Exchange fromExchange = sushiSwapFactory.getPair(fromTokenReal, toTokenReal);
        if (fromExchange != IUniswapV2Exchange(0)) {
            return fromExchange.getReturn(fromTokenReal, toTokenReal, amount);
        }
    }
}