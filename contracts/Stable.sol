pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Stable is ERC20 {

    address public minter;

    modifier onlyMinter {
        require(msg.sender == minter, "Caller not minter");

        _;
    }

    constructor(string memory _name, string memory _symbol, address _minter) ERC20(_name, _symbol) {
        minter = _minter;
    }

    function mint(address _to, uint256 _amount) external onlyMinter {
        _mint(_to, _amount);
    }

    function burn(address _from, uint256 _amount) external onlyMinter {
        _burn(_from, _amount);
    }

}