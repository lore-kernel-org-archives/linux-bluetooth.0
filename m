Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org
Subject: [RFCv1 04/20] Bluetooth: Process create response and connect response identically
Date: Tue, 11 Sep 2012 11:21:15 -0700
Message-Id: <1347387691-5285-5-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This removes an intermediate function for sending a create response
which added no functionality.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 17e02d9..a042bcf 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3501,7 +3501,8 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
 	return 0;
 }
 
-static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
+static inline int l2cap_connect_create_rsp(struct l2cap_conn *conn,
+					   struct l2cap_cmd_hdr *cmd, u8 *data)
 {
 	struct l2cap_conn_rsp *rsp = (struct l2cap_conn_rsp *) data;
 	u16 scid, dcid, result, status;
@@ -4039,14 +4040,6 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
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
@@ -4250,7 +4243,8 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_CONN_RSP:
-		err = l2cap_connect_rsp(conn, cmd, data);
+	case L2CAP_CREATE_CHAN_RSP:
+		err = l2cap_connect_create_rsp(conn, cmd, data);
 		break;
 
 	case L2CAP_CONF_REQ:
@@ -4288,10 +4282,6 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
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
1.7.12

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
