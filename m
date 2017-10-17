Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH 0/2] mesh: Add heartbeat command to meshctl
Date: Tue, 17 Oct 2017 09:58:29 -0400
Message-Id: <20171017135831.31179-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

Tested with zephyr/samples/bluetooth/mesh on a nrf52840-pca10056 board
Needs zephyr commits through db0ee4ea626f706248681868d801d4a578d182bb

Steve Brown (2):
  mesh: Add heartbeat publish command and status display
  mesh: Add heartbeat message display

 mesh/config-client.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/net.c           | 18 +++++++++++++++
 2 files changed, 80 insertions(+)

-- 
2.11.0

