Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix memory leak with L2CAP signal channels
Date: Wed,  2 Oct 2013 08:28:21 -0700
Message-Id: <1380727701-44925-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The wrong type of L2CAP signalling packets on the wrong type of
either BR/EDR or LE links need to be dropped. When that happens
the packet is dropped, but the memory not freed. So actually
free the memory as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6d42498..814563d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5330,7 +5330,7 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 	l2cap_raw_recv(conn, skb);
 
 	if (hcon->type != LE_LINK)
-		return;
+		goto drop;
 
 	while (len >= L2CAP_CMD_HDR_SIZE) {
 		u16 cmd_len;
@@ -5363,6 +5363,7 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 		len  -= cmd_len;
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
@@ -5378,7 +5379,7 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 	l2cap_raw_recv(conn, skb);
 
 	if (hcon->type != ACL_LINK)
-		return;
+		goto drop;
 
 	while (len >= L2CAP_CMD_HDR_SIZE) {
 		u16 cmd_len;
@@ -5411,6 +5412,7 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 		len  -= cmd_len;
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
1.8.3.1

