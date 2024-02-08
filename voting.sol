// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract Voting{
 struct Item{
    
    string name;
    uint256 voteCount;
 }

 Item[] public items;
 mapping (address => bool) public hasVoted;
 mapping (uint256 => Item) private itemIdToItem;

 event ItemProposed(uint256 itemId, string ItemName);
 event Voted(uint256 itemId, address voter);


 function proposeItem(string memory _item) public {
    items.push(Item(_item, 0));
    uint256 itemId = items.length -1;
    itemIdToItem[itemId] = Item(_item, 0);
    emit ItemProposed(itemId, _item);
 }

 function voteForItem(uint256 _itemId) public {
     require(!hasVoted[msg.sender], "You have already voted.");
     require(_itemId < items.length, "Item does not exist.");

     items[_itemId].voteCount += 1;
     hasVoted[msg.sender] = true;

     emit Voted(_itemId, msg.sender);
    
 }
   function getWinner() public view returns (uint256 winnerItemId, string memory winnerName){
     uint256 winningVoteCount = 0;

     for(uint256 i=0; i< items.length; i++){
        if (items[i].voteCount > winningVoteCount){
          winningVoteCount = items [i].voteCount;
          winnerItemId = i;
          winnerName = items[i].name;
        }
     }

      require(winningVoteCount > 0, "No votes has been cast");

   }

}