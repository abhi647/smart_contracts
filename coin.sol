// Coin ICO
// version of complier
pragma solidity ^0.5.2;

contract coin {
    
    // maximum count of coins available for sale 
    uint public max_coin = 1000000;
    
    // Introducing USD to coin conversion rate 
    uint public usd_to_coin = 1000;
    
    // Introducing total number of coins bought by the investors 
    uint public total_coin_bought = 0;
    
    // Mapping investors address to equity and USD
    mapping(address => uint) equity_coins;
    mapping(address => uint) equity_usd;
    
    //checking if investors can buy coins
    modifier can_buy_coin (uint usd_invested) {
        require (usd_invested * usd_to_coin + total_coin_bought <= max_coin);
        _;
    }
    
    //getting equity in coins
    function equity_in_coins(address investor) external view returns (uint) {
        return equity_coins[investor];
    }
    
    // getting equity in usd
    function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }
    
    // Buying coins
    function buy_coins(address investor, uint usd_invested) external
    can_buy_coin (usd_invested) {
        uint coins_bought = usd_invested * usd_to_coin;
        equity_coins[investor] += coins_bought;
        equity_usd[investor] = equity_coins[investor] / 1000;
        total_coin_bought += coins_bought;
    }
    
    // Buying coins
    function sell_coins(address investor, uint coins_sold) external {
        equity_coins[investor] - coins_sold;
        equity_usd[investor] = equity_coins[investor] / 1000 ;
        total_coin_bought -= coins_sold;
    }
    
}