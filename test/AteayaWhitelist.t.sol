// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {AteayaWhitelist} from "../src/AteayaWhitelist.sol";

contract AteayaWhitelistTest is Test {
    AteayaWhitelist public whitelist;

    address public deployer;
    address public admin;
    address public operator;
    address public user;

    function setUp() public {
        string memory mnemonic = "test test test test test test test test test test test junk";
        uint256 privateKey = vm.deriveKey(mnemonic, 0);
        deployer = msg.sender;
        admin = vm.addr(privateKey);
        operator = vm.addr(privateKey + 1);
        user = vm.addr(privateKey + 2);

        whitelist = new AteayaWhitelist(admin, operator);
    }

    // helper for hashing the addresses
    function hash(address account) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(account)));
    }

    function test_InitiallyNotWhitelisted() public {
        bool wl = whitelist.isWhitelisted(hash(user));
        assertEq(wl, false);
    }

    function test_WhitelistUser() public {
        vm.prank(operator);
        whitelist.update(hash(user), true);
        bool wl = whitelist.isWhitelisted(hash(user));
        assertEq(wl, true);
    }

    function testFail_AdminCannotWhitelistUser() public {
        vm.prank(admin);
        whitelist.update(hash(user), true);
    }

    function testFail_RegularUserCannotWhitelistUser() public {
        vm.prank(user);
        whitelist.update(hash(admin), true);
    }

    function testFail_RegularUserCannotWhitelistHimself() public {
        vm.prank(user);
        whitelist.update(hash(user), true);
    }
}
