pragma solidity ^0.4.18;

contract Quiz {
    address private owner;
    uint256 private expires;

    string[6] public questions;
    bytes32[6] private answers;

    bool public claimed;

    function Quiz() public {
        owner = msg.sender;
        expires = now + 2 days;
        claimed = false;

        questions[0] = "What is the network ID number of the public ethereum blockchain?";
        answers[0] = 0xc89efdaa54c0f20c7adf612882df0950f5a951637e0307cdcb4c672f298b8bc6;

        questions[1] = "What is fuel of the etherum network called?";
        answers[1] = 0x4498c2139ad6cf2beef3ae7bec34c4856d471c8680dfd28d553f117df74df6b7;
        
        questions[2] = "What is the name of the JavaScript Stack dapp framework?";
        answers[2] = 0x28610e27d085e348e6ebd0da2c982947eddf7d308b82e951a896432cdac99a74;
        
        questions[3] = "What is the name of the name of software that allows you to deploy and development blockchain on your local computer?";
        answers[3] = 0x0bdc38f1a57daae7b3c874f2d50314c08c68bd340dd018c1072ee23f3a6d72c0;
        
        questions[4] = "What is the of main smart contracting language on the general purpose ethereum blockchain?";
        answers[4] = 0xa477d97b122e6356d32a064f9ee824230d42d04c7d66d8e7d125a091a42b0b25;
        
        questions[5] = "What is the name of the chrome extension that allows you to access web3 object to broadcast to the public ethereum network?";
        answers[5] = 0x69edc0ff6c1e084ebd1295782a6c284c57eda43f402b6ecc23762b9316812888;

    }

    function numberOfQuestions() public constant returns (uint256) {
        return questions.length;
    }

    function updateQuestionAndAnswer(string question, bytes answer, uint index) public onlyOwner {
        questions[index] = question;
        answers[index] = keccak256(answer);
    }

    function checkAnswer(uint index, string answer) public constant returns(bool) {
        bytes32 hashedAnswer = keccak256(answer);
        return answers[index] == hashedAnswer;
    }

    function checkAllAnswers(string a0, string a1, string a2, string a3, string a4, string a5) public constant returns(bool) {
        require(answers[0] == keccak256(a0));
        require(answers[1] == keccak256(a1));
        require(answers[2] == keccak256(a2));
        require(answers[3] == keccak256(a3));
        require(answers[4] == keccak256(a4));
        require(answers[5] == keccak256(a5));
        return true;
    }

    function submitYourAnswers(string a0, string a1, string a2, string a3, string a4, string a5) public returns(bool) {
        require(claimed != true);

        require(answers[0] == keccak256(a0));
        require(answers[1] == keccak256(a1));
        require(answers[2] == keccak256(a2));
        require(answers[3] == keccak256(a3));
        require(answers[4] == keccak256(a4));
        require(answers[5] == keccak256(a5));

        claimed = true;
        msg.sender.transfer(this.balance);
        return claimed;
    }

    function () public payable {
    }

    function refund(address to) public onlyOwner {
        require(claimed != true);
        require(now > expires + 1 days);
        
        to.transfer(this.balance);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    
}