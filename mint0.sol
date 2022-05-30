// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC721 {
    function mint(uint256 count, address user) external returns(uint256);
}

contract Mint0 {
    address public owner = 0x1E3ADF6a9200ec7e392B83131b11BeA062d956Eb;
    address public operator;
    address public nft;
    uint256 public price = 0.002 ether;
    uint256 public total = 0;

    constructor(address _nft) {
      operator = msg.sender;
      nft = _nft;
    }

    function setNft(address _nft) external {
      require(msg.sender == operator, "!not operator");
      nft = _nft;
    }

    function mint(uint256 count) external payable {
        uint256 cost = IERC721(nft).mint(count, msg.sender);
        require(msg.value >= cost, "not enough fee.");
        (bool success, ) = payable(owner).call{
            value: address(this).balance
        }("");
        require(success, "Transfer failed."); 
        total += count;
    }
}
