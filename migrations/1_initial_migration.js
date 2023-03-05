const Staking = artifacts.require("Staking");

module.exports = (deployer) => {
    deployer.deploy(Staking, "0x9585e40636fC7B03e9849e8Ff3643d75a4Fa488E");
};
