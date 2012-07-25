Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 04/21] Bluetooth: Process create response and connect response identically
Date: Wed, 25 Jul 2012 16:50:56 -0700
Message-Id: <1343260274-11953-5-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 131d0da..d7a501e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4038,14 +4038,6 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
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
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
