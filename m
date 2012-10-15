Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Cc: sunnyk@codeaurora.org,
	marcel@holtmann.org
Subject: [PATCH 03/19] Bluetooth: Remove unnecessary intermediate function
Date: Mon, 15 Oct 2012 08:33:52 -0700
Message-Id: <1350315248-7690-4-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Resolves a conflict resolution issue in "Bluetooth: Fix L2CAP coding
style".

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 73ce337..ec2b4d9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3537,7 +3537,7 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
 	return 0;
 }
 
-static inline int l2cap_connect_rsp(struct l2cap_conn *conn,
+static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 				    struct l2cap_cmd_hdr *cmd, u8 *data)
 {
 	struct l2cap_conn_rsp *rsp = (struct l2cap_conn_rsp *) data;
@@ -4091,15 +4091,6 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 	return 0;
 }
 
-static inline int l2cap_create_channel_rsp(struct l2cap_conn *conn,
-					   struct l2cap_cmd_hdr *cmd,
-					   void *data)
-{
-	BT_DBG("conn %p", conn);
-
-	return l2cap_connect_rsp(conn, cmd, data);
-}
-
 static void l2cap_send_move_chan_rsp(struct l2cap_conn *conn, u8 ident,
 				     u16 icid, u16 result)
 {
@@ -4306,7 +4297,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 
 	case L2CAP_CONN_RSP:
 	case L2CAP_CREATE_CHAN_RSP:
-		err = l2cap_connect_rsp(conn, cmd, data);
+		err = l2cap_connect_create_rsp(conn, cmd, data);
 		break;
 
 	case L2CAP_CONF_REQ:
-- 
1.7.12.3

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
