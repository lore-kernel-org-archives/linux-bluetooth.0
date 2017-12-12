Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V2 0/8] mesh: Add configuration commands to meshctl
Date: Tue, 12 Dec 2017 12:58:24 +0000
Message-Id: <20171212125832.13440-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

This work was done in conjunction with Zephyr pull request.
https://github.com/zephyrproject-rtos/zephyr/pull/5322

Steve Brown (8):
  mesh: meshctl: Change command names to <cmd>-<get/set>
  mesh: meshctl: Add add/get Subscribe
  mesh: meshctl: Add set heartbeat command
  mesh: meshctl: Add get app keys command
  mesh: meshctl: Add get publish command
  mesh: meshctl: Add set/get proxy command
  mesh: meshctl: Add get/set identity
  mesh: meshctl: Add get/set relay command

 mesh/config-client.c | 452 ++++++++++++++++++++++++++++++++++++++++++++++++---
 mesh/net.c           |  20 ++-
 2 files changed, 447 insertions(+), 25 deletions(-)

-- 
2.11.0

