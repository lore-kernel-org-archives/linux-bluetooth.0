Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Add device set-alias bluetoothctl command
Date: Fri,  2 Sep 2016 11:08:54 +0200
Message-Id: <1472807335-14958-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for setting a device alias from bluetoothctl.

Francois Beaufort (1):
  Add device set-alias bluetoothctl command

 client/main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
2.7.0

