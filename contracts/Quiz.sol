pragma solidity ^0.4.18;

contract Quiz {
    address private owner;
    uint256 private expires;
    address[26] private participants; // list of participants that can submit answers.

    string[6] public questions;
    bytes32[6] private answers;

    bool public claimed;

    function Quiz() public {
        owner = msg.sender;
        // expires = now + 2 days;
        claimed = false;

        participants[0] = 0xB144024e2B9f86249574fB3e74BDDfE17813CD30; // TomAccount 1
        participants[1] = 0xcC62A08E24e75BfDb00733D17F43fbC57C5da242; // TomAccount 2

        // participants[2] = 0x4e57621ea5674dfc56731439f9fb8d0935541c56; // Start of Participant Accounts
        participants[3] = 0xcf852Ba1B11086c184B70a66360f1081ba3ad1a8;
        participants[4] = 0xF85c3026fCC18A3B210Df59555A7F30Dd933f10d;
        // participants[5] = 0xb71abeeaeb3f1173c45852d2d9dd9e22886b0df6;
        // participants[6] = 0x7792b7ed85da6710504949e87fb8d14ad5dc66ae;
        participants[7] = 0xAe471D927BDc4859A99e1CA4F6110cc3628ac7d0;
        // participants[8] = 0xa557414726513a92d6f827f460ac47463d362ff0;
        participants[9] = 0xD6500dF4c703B2139c9B0F3779FAF44e2a1CaEa6;
        participants[10] = 0xAe471D927BDc4859A99e1CA4F6110cc3628ac7d0;
        // participants[11] = 0x9b0c352b8111958f6cb4f6e08fba3a2b343d3a2c;
        participants[12] = 0xcC7A1D643714f9b7159D3D5339F58640E0584255;
        participants[13] = 0xF19349B488221160760c02C789Bf2380E1499442;
        participants[14] = 0xD33a015476C8a7f28d68cf179813ffC643295abA;
        participants[15] = 0xF5e75aAa8986D5412addA254da8b6f8F00E4Fac4;
        participants[16] = 0x58232c5a2ddB6DF823B21a8C58770D1407c55E27;
        participants[17] = 0x7B1F482b08C3Cc5E967b48cbaAb7Ce54f25AdC56;
        participants[18] = 0xAe471D927BDc4859A99e1CA4F6110cc3628ac7d0;
        participants[19] = 0x4ec8645e682995FAb6A092346980c673139822E4;
        participants[20] = 0xAe471D927BDc4859A99e1CA4F6110cc3628ac7d0;
        // participants[21] = 0x9b0c352b8111958f6cb4f6e08fba3a2b343d3a2c;
        participants[22] = 0xebE3D3fDc9E4E30a0416E4Ee5D821603d6c3F728;
        participants[23] = 0x5536731010446febB3D681760d290eb6CeD493A2;
        // participants[24] = 0x9b0c352b8111958f6cb4f6e08fba3a2b343d3a2c;
        participants[25] = 0x58232c5a2ddB6DF823B21a8C58770D1407c55E27;






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

        //this function requires you to be whitelisted
    function submitYourAnswers(string a0, string a1, string a2, string a3, string a4, string a5) public onlyParticipants returns(bool) {
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
        // require(claimed != true);
        // require(now > expires + 1 days);
        
        to.transfer(this.balance);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyParticipants() {
        require (
            msg.sender == participants[0] || 
            msg.sender == participants[1] ||
            msg.sender == participants[2] ||
            msg.sender == participants[3] ||
            msg.sender == participants[4] ||
            msg.sender == participants[5] ||
            msg.sender == participants[6] ||
            msg.sender == participants[7] ||
            msg.sender == participants[8] ||
            msg.sender == participants[9] ||
            msg.sender == participants[10] ||
            msg.sender == participants[11] ||
            msg.sender == participants[12] ||
            msg.sender == participants[13] ||
            msg.sender == participants[14] ||
            msg.sender == participants[15] ||
            msg.sender == participants[16] ||
            msg.sender == participants[17] ||
            msg.sender == participants[18] ||
            msg.sender == participants[19] ||
            msg.sender == participants[20] ||
            msg.sender == participants[22] ||
            msg.sender == participants[23] ||
            msg.sender == participants[24] ||
            msg.sender == participants[25]
        );
        _;
    }
    
    
}