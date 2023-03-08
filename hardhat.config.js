require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
	solidity: "0.8.17",
	networks: {
		scrollAlpha: {
			url: process.env.SCROLL_RPC_URL,
			accounts: [process.env.ACCOUNT_KEY],
		}
}
};

