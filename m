Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Update the list of L2CAP fixed channels
Date: Fri, 11 Jul 2014 06:03:08 +0200
Message-Id: <1405051388-56471-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The list of L2CAP fixed channels increased with newer versions of the
specification. This just updates the constants for it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h | 5 ++++-
 net/bluetooth/l2cap_core.c    | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e0c6a9abdb62..d8e7b9330ab8 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -134,9 +134,12 @@ struct l2cap_conninfo {
 #define L2CAP_FCS_CRC16		0x01
 
 /* L2CAP fixed channels */
-#define L2CAP_FC_L2CAP		0x02
+#define L2CAP_FC_SIG_BREDR	0x02
 #define L2CAP_FC_CONNLESS	0x04
 #define L2CAP_FC_A2MP		0x08
+#define L2CAP_FC_ATT		0x10
+#define L2CAP_FC_SIG_LE		0x20
+#define L2CAP_FC_SMP_LE		0x40
 
 /* L2CAP Control Field bit masks */
 #define L2CAP_CTRL_SAR			0xC000
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8680aae678ce..0c3c4935f635 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -46,7 +46,7 @@
 bool disable_ertm;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN | L2CAP_FEAT_UCD;
-static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP | L2CAP_FC_CONNLESS, };
+static u8 l2cap_fixed_chan[8] = { L2CAP_FC_SIG_BREDR | L2CAP_FC_CONNLESS, };
 
 static LIST_HEAD(chan_list);
 static DEFINE_RWLOCK(chan_list_lock);
-- 
1.9.3

