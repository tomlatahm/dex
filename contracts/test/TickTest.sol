// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.8.13;
pragma abicoder v2;

import {Tick} from '../libraries/Tick.sol';
import {Cycle} from '../libraries/Cycle.sol';

contract TickTest {
    using Tick for mapping(int24 => Tick.Info);

    mapping(int24 => Tick.Info) public ticks;
    mapping(bytes32 => Cycle.Info) public cycles;

    function tickSpacingToMaxLiquidityPerTick(int24 tickSpacing) external pure returns (uint128) {
        return Tick.tickSpacingToMaxLiquidityPerTick(tickSpacing);
    }

    function setTick(int24 tick, Tick.Info memory info) external {
        ticks[tick] = info;
    }

    function getFeeGrowthInside(
        int24 tickLower,
        int24 tickUpper,
        int24 tickCurrent,
        uint256 feeGrowthGlobal0X128,
        uint256 feeGrowthGlobal1X128
    ) external view returns (uint256 feeGrowthInside0X128, uint256 feeGrowthInside1X128) {
        return ticks.getFeeGrowthInside(tickLower, tickUpper, tickCurrent, feeGrowthGlobal0X128, feeGrowthGlobal1X128);
    }

    function update(
        int24 tick,
        int24 tickCurrent,
        int128 liquidityDelta,
        uint256 feeGrowthGlobal0X128,
        uint256 feeGrowthGlobal1X128,
        uint160 secondsPerLiquidityCumulativeX128,
        int56 tickCumulative,
        uint32 time,
        bool upper,
        uint128 maxLiquidity
    ) external returns (bool flipped) {
        return
            ticks.update(
                tick,
                tickCurrent,
                liquidityDelta,
                feeGrowthGlobal0X128,
                feeGrowthGlobal1X128,
                secondsPerLiquidityCumulativeX128,
                tickCumulative,
                time,
                upper,
                maxLiquidity
            );
    }

    function clear(int24 tick) external {
        ticks.clear(tick);
    }

    function cross(
        Tick.TickCross memory tickCross
    ) external returns (int128 liquidityNet) {
        return
            ticks.cross(
                cycles,
                tickCross
            );
    }
}
