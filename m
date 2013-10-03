Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Drop packets on ATT fixed channel on BR/EDR
Date: Thu,  3 Oct 2013 02:54:11 -0700
Message-Id: <1380794051-8488-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The ATT fixed channel is only valid when using LE connections. On
BR/EDR it is required to go through L2CAP connection oriented
channel for ATT.

Drop ATT packets when they are received on a BR/EDR connection.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 102a510..583517e1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6431,8 +6431,12 @@ drop:
 static void l2cap_att_channel(struct l2cap_conn *conn,
 			      struct sk_buff *skb)
 {
+	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan;
 
+	if (hcon->type != LE_LINK)
+		goto drop;
+
 	chan = l2cap_global_chan_by_scid(BT_CONNECTED, L2CAP_CID_ATT,
 					 conn->src, conn->dst);
 	if (!chan)
-- 
1.8.3.1

