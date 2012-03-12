Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 0/3] DeviceInfo: Add main logic
Date: Mon, 12 Mar 2012 16:54:25 +0200
Message-Id: <1331564068-2658-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add more logic to the Device Info Service Gatt client.

This patch set is based on my previous patch set, sent earlyer today.

Chen Ganir (3):
  DeviceInfo: Add connection logic
  DeviceInfo: Discover Characteristics
  DeviceInfo: Read PNP ID

 deviceinfo/deviceinfo.c |  129 +++++++++++++++++++++++++++++++++++++++++++++++
 src/device.c            |   23 ++++++++
 src/device.h            |    3 +
 3 files changed, 155 insertions(+), 0 deletions(-)

-- 
1.7.4.1

