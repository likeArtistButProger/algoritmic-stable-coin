pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract Minter is AccessControl {
    bytes32 constant public ADMIN_ROLE = keccak256("ADMIN_ROLE");

    address public stable;
    address public unstable;

    modifier onlyAdmin {
        require(hasRole(ADMIN_ROLE, msg.sender), "Caller not admin");
        _;
    }

    constructor(address _stable, address _unstable, address[] memory _admins) {
        stable = _stable;
        unstable = _unstable;

        for(uint256 i = 0; i < _admins.length; i++) {
            address _admin = _admins[i];

            _setupRole(ADMIN_ROLE, _admin);
        }
    }

    function mintStable(address _to, uint256 _amount) external onlyAdmin {
        (bool success,) = stable.call(
            abi.encodeWithSignature(
                "mint(address,uint256)",
                _to,
                _amount
            )
        );
        require(success, "Call mintStable went wrong");
    }

    function burnStable(address _from, uint256 _amount) external onlyAdmin {
        (bool success,) = stable.call(
            abi.encodeWithSignature(
                "burn(address,uint256)", 
                _from,
                _amount
            )
        );
        require(success, "Call burnStable went wrong");
    }

    function mintUnstable(address _to, uint256 _amount) external onlyAdmin {
        (bool success,) = unstable.call(
            abi.encodeWithSignature(
                "mint(address,uint256)",
                _to,
                _amount
            )
        );
        require(success, "Call mintUnstable went wrong");
    }

    function burnUnstable(address _from, uint256 _amount) external onlyAdmin {
        (bool success,) = unstable.call(
            abi.encodeWithSignature(
                "burn(address,uint256)", 
                _from,
                _amount
            )
        );
        require(success, "Call burnUnstable went wrong");
    }

}