Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove LE fixed channel mask bits
Date: Mon,  1 Sep 2014 09:45:02 +0300
Message-Id: <1409553903-25260-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The LE fixed channels are never exposed through the supported channels
bit mask so just remove their defines to avoid any mistaken usage.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index be25eddea615..a8ac05b0e8e3 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -137,9 +137,6 @@ struct l2cap_conninfo {
 #define L2CAP_FC_SIG_BREDR	0x02
 #define L2CAP_FC_CONNLESS	0x04
 #define L2CAP_FC_A2MP		0x08
-#define L2CAP_FC_ATT		0x10
-#define L2CAP_FC_SIG_LE		0x20
-#define L2CAP_FC_SMP_LE		0x40
 
 /* L2CAP Control Field bit masks */
 #define L2CAP_CTRL_SAR			0xC000
-- 
1.9.3

