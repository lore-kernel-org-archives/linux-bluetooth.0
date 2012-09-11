Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org
Subject: [RFCv1 02/20] Bluetooth: Factor out common L2CAP connection code
Date: Tue, 11 Sep 2012 11:21:13 -0700
Message-Id: <1347387691-5285-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

L2CAP connect requests and create channel requests share a significant
amount of code.  This change moves common code to a new function.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 111e716..166382c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3362,7 +3362,8 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	return 0;
 }
 
-static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
+static void __l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
+			    u8 *data, u8 rsp_code, u8 amp_id)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
@@ -3456,7 +3457,7 @@ sendresp:
 	rsp.dcid   = cpu_to_le16(dcid);
 	rsp.result = cpu_to_le16(result);
 	rsp.status = cpu_to_le16(status);
-	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+	l2cap_send_cmd(conn, cmd->ident, rsp_code, sizeof(rsp), &rsp);
 
 	if (result == L2CAP_CR_PEND && status == L2CAP_CS_NO_INFO) {
 		struct l2cap_info_req info;
@@ -3479,7 +3480,12 @@ sendresp:
 					l2cap_build_conf_req(chan, buf), buf);
 		chan->num_conf_req++;
 	}
+}
 
+static int l2cap_connect_req(struct l2cap_conn *conn,
+			     struct l2cap_cmd_hdr *cmd, u8 *data)
+{
+	__l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP, 0);
 	return 0;
 }
 
-- 
1.7.12

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
