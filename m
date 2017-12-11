Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH 0/3] mesh: Add configuration commands to meshctl
Date: Mon, 11 Dec 2017 14:58:36 +0000
Message-Id: <20171211145839.19573-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

This series adds additional configuration commands to meshctl.

It also fixes a bug that was exposed by the commands.

This work was done in conjunction with the Zephyr pull request.
https://github.com/zephyrproject-rtos/zephyr/pull/5322

For testing, that patch is available at
https://github.com/zephyrproject-rtos/zephyr/pull/5322.patch

Steve Brown (3):
  mesh: Segmentation fails in gatt.c:pipe_write()
  mesh: meshctl: Add commands
  mesh: meshctl: Add support for subscriptions in node and database

 mesh/config-client.c | 461 ++++++++++++++++++++++++++++++++++++++++++++++++---
 mesh/gatt.c          | 141 ++--------------
 mesh/net.c           |  20 ++-
 mesh/node.c          |  32 ++++
 mesh/node.h          |   3 +
 mesh/prov-db.c       |  66 ++++++++
 mesh/prov-db.h       |   2 +
 7 files changed, 580 insertions(+), 145 deletions(-)

-- 
2.11.0

