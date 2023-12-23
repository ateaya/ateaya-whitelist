// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @author  PRC
 * @title   Ateaya KYC Account Whitelist Smart Contract
 */
interface IAteayaWhitelist {
    /**
     * @notice  This function checks an entry in the whitelist.
     * @dev     Call this function to check an entry hash.
     * @param   hash The address hash to check -> hash = uint256(keccak256(abi.encodePacked(address)))
     * @return  The whitelist state for the address hash.
     */
    function isWhitelisted(uint256 hash) external returns (bool);

    /**
     * @notice  This function updates an entry in the whitelist.
     * @dev     Call this function to update an entry hash.
     * @param   hash        The address hash to update -> hash = uint256(keccak256(abi.encodePacked(address)))
     * @param   whitelist   The whitelist state for the address hash.
     */
    function update(uint256 hash, bool whitelist) external;

    /**
     * @notice  This function updates a set of entries in the whitelist.
     * @dev     Call this function to update a set of entries hashes.
     * @param   hashes      The address hashes to update -> hash = uint256(keccak256(abi.encodePacked(address)))
     * @param   whitelist   The whitelist state for the address hashes.
     */
    function updateMulti(uint256[] memory hashes, bool whitelist) external;

    /**
     * @notice  This function pauses the contract in an emergency situation. It will simply not allow new deposits.
     * @dev     Call this function to pause new deposits.
     */
    function pause() external;

    /**
     * @notice  This function will resume the normal functionality of the contract.
     * @dev     Call this function to unpause the contract.
     */
    function unpause() external;
}
