Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP connectionless channels are only valid for BR/EDR
Date: Thu,  3 Oct 2013 00:03:39 -0700
Message-Id: <1380783819-47726-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When receiving connectionless packets on a LE connection, just drop
the packet. There is no concept of connectionless channels for LE.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index eee18f3..583517e1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6403,8 +6403,12 @@ done:
 static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 				  struct sk_buff *skb)
 {
+	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan;
 
+	if (hcon->type != ACL_LINK)
+		goto drop;
+
 	chan = l2cap_global_chan_by_psm(0, psm, conn->src, conn->dst);
 	if (!chan)
 		goto drop;
-- 
1.8.3.1

