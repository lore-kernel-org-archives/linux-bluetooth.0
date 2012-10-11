Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: mathewm@codeaurora.org
Subject: [RFC 2/6] Bluetooth: Process create response and connect response identically
Date: Thu, 11 Oct 2012 17:48:21 +0300
Message-Id: <1349966905-32336-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1349966905-32336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349966905-32336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mat Martineau <mathewm@codeaurora.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1560108..632f291 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4038,14 +4038,6 @@ static inline int l2cap_create_channel_req(struct l2cap_conn *conn,
 	return 0;
 }
 
-static inline int l2cap_create_channel_rsp(struct l2cap_conn *conn,
-					struct l2cap_cmd_hdr *cmd, void *data)
-{
-	BT_DBG("conn %p", conn);
-
-	return l2cap_connect_rsp(conn, cmd, data);
-}
-
 static void l2cap_send_move_chan_rsp(struct l2cap_conn *conn, u8 ident,
 				     u16 icid, u16 result)
 {
@@ -4249,6 +4241,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_CONN_RSP:
+	case L2CAP_CREATE_CHAN_RSP:
 		err = l2cap_connect_rsp(conn, cmd, data);
 		break;
 
@@ -4287,10 +4280,6 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 		err = l2cap_create_channel_req(conn, cmd, cmd_len, data);
 		break;
 
-	case L2CAP_CREATE_CHAN_RSP:
-		err = l2cap_create_channel_rsp(conn, cmd, data);
-		break;
-
 	case L2CAP_MOVE_CHAN_REQ:
 		err = l2cap_move_channel_req(conn, cmd, cmd_len, data);
 		break;
-- 
1.7.9.5

