Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: The L2CAP fixed channel connectionless data is supported
Date: Sat, 12 Oct 2013 08:18:18 -0700
Message-Id: <1381591099-13207-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The implementation actually supports the L2CAP connectionless data
channel. So set it as supported in the fixed channels bitmask.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/l2cap_core.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 12523c7..56f540e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -131,6 +131,7 @@ struct l2cap_conninfo {
 
 /* L2CAP fixed channels */
 #define L2CAP_FC_L2CAP		0x02
+#define L2CAP_FC_CONNLESS	0x04
 #define L2CAP_FC_A2MP		0x08
 
 /* L2CAP Control Field bit masks */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e932ffd..8b5437c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -44,7 +44,7 @@
 bool disable_ertm;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
-static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP, };
+static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP | L2CAP_FC_CONNLESS, };
 
 static LIST_HEAD(chan_list);
 static DEFINE_RWLOCK(chan_list_lock);
-- 
1.8.3.1

