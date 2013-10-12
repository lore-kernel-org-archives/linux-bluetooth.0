Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Unicast connectionless data reception is supported
Date: Sat, 12 Oct 2013 08:18:19 -0700
Message-Id: <1381591099-13207-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The unicast connectionless data reception feature is actually support
and has been supported all along. Mark it as supported in the L2CAP
features bitmask.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8b5437c..13bb9da 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -43,7 +43,7 @@
 
 bool disable_ertm;
 
-static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
+static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN | L2CAP_FEAT_UCD;
 static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP | L2CAP_FC_CONNLESS, };
 
 static LIST_HEAD(chan_list);
-- 
1.8.3.1

