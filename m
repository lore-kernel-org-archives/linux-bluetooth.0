Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't copy L2CAP LE signalling to raw sockets
Date: Wed,  2 Oct 2013 23:51:49 -0700
Message-Id: <1380783109-37739-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP raw sockets are only used for BR/EDR signalling. Packets
on LE links should not be forwarded there.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0661ca6..65c5371 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5327,8 +5327,6 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 	struct l2cap_cmd_hdr cmd;
 	int err;
 
-	l2cap_raw_recv(conn, skb);
-
 	if (hcon->type != LE_LINK)
 		goto drop;
 
-- 
1.8.3.1

