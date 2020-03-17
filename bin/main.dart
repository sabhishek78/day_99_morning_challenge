//  Good morning! Here's your coding interview problem for today.
//
//  Suppose an arithmetic expression is given as a binary tree. Each leaf is an
//  integer and each internal node is one of '+', '−', '∗', or '/'.
//
//  Given the root to such a tree, write a function to evaluate it.
//
//  For example, given the following tree:
//
//         *
//      /     \
//     +       +
//    /  \    / \
//   3    2  4   5
//  You should return 45, as it is ((3 + 2) * (4 + 5)).
//1.If the current token is a '(', add a new node as the left child of the current node,
//and descend to the left child.
//2.If the current token is in the list ['+','-','/','*'], set the root value
//of the current node to the operator represented by the current token.
//Add a new node as the right child of the current node and descend to the right child.
//3.If the current token is a number, set the root value of the current node to
//the number and return to the parent
//4.If the current token is a ')', go to the parent of the current node
import 'package:validators/validators.dart';
class Node{
  String data;
  Node leftNode;
  Node rightNode;
  Node parentNode;
  Node(data){
    this.data=data;

  }
}
printNode(Node currentNode){
  print('Node data=${currentNode.data}');
  print('leftNode=${currentNode.leftNode.data}');
  print('rightNode=${currentNode.rightNode.data}');
}
bool isRightNodeNumeric(currentNode){
  return isNumeric(currentNode.rightNode.data);
}
bool isLeftNodeNumeric(currentNode){
  return isNumeric(currentNode.leftNode.data);
}
bool isCurrentNodeNumeric(currentNode){
  return isNumeric(currentNode.data);
}
Node moveLeft(currentNode){
  return currentNode.leftNode;
}
Node moveRight(currentNode){
  return currentNode.rightNode;
}
Node moveUp(currentNode){
  return currentNode.parentNode;
}
createTree1(){
  Node node1=Node('*');
  Node node2=Node('+');
  Node node3=Node('+');
  Node node4=Node('3');
  Node node5=Node('2');
  Node node6=Node('4');
  Node node7=Node('5');
  node1.leftNode=node2;
  node2.parentNode=node1;
  node1.rightNode=node3;
  node3.parentNode=node1;
  node2.leftNode=node4;
  node4.parentNode=node2;
  node2.rightNode=node5;
  node5.parentNode=node2;
  node3.leftNode=node6;
  node6.parentNode=node3;
  node3.rightNode=node7;
  node7.parentNode=node3;
  return node1;
}
createTree2(){
  Node node1=Node('/');
  Node node2=Node('+');
  Node node3=Node('+');
  Node node4=Node('6');
  Node node5=Node('2');
  Node node6=Node('4');
  Node node7=Node('5');
  node1.leftNode=node2;
  node2.parentNode=node1;
  node1.rightNode=node3;
  node3.parentNode=node1;
  node2.leftNode=node4;
  node4.parentNode=node2;
  node2.rightNode=node5;
  node5.parentNode=node2;
  node3.leftNode=node6;
  node6.parentNode=node3;
  node3.rightNode=node7;
  node7.parentNode=node3;
  return node1;
}
 performOperation(Node currentNode){
  print("performing operation");
  printNode(currentNode);
  if(currentNode.data=='+'){
    currentNode.data=(int.parse(currentNode.leftNode.data)+int.parse(currentNode.rightNode.data)).toString();
    print(currentNode.data);
  }
  else if(currentNode.data=='-'){
    currentNode.data=(int.parse(currentNode.leftNode.data)-int.parse(currentNode.rightNode.data)).toString();
    print(currentNode.data);
  }
  else if(currentNode.data=='*'){
    currentNode.data=((int.parse(currentNode.leftNode.data))*(int.parse(currentNode.rightNode.data))).toString();
    print("data after calculation=${currentNode.data}");
  }
  else if(currentNode.data=='/'){
    currentNode.data=(int.parse(currentNode.leftNode.data)/int.parse(currentNode.rightNode.data)).floor().toString();
    print(currentNode.data);
  }
  return currentNode;
}
traverseTree(Node currentNode){
  while(!isLeftNodeNumeric(currentNode)){
    currentNode=moveLeft(currentNode);
  }
  while(!isRightNodeNumeric(currentNode)){
    currentNode=moveRight(currentNode);
     traverseTree(currentNode);
  }
  return currentNode;
}
String solveTree(Node currentNode){
  Node root=currentNode;
  if(isCurrentNodeNumeric(currentNode)){
    print("Tree solved");
    printNode(root);
    return root.data;
  }
  else{
     currentNode=traverseTree(currentNode);
     currentNode=performOperation(currentNode);
     currentNode=moveUp(currentNode);
     solveTree(root);
  }
}
void main() {
  Node root=createTree1();
  print(solveTree(root));
  root=createTree2();
  print(solveTree(root));
}
