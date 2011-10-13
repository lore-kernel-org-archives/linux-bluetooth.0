Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	andrei.emeltchenko@intel.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 5/9] Bluetooth: Add signal handlers for channel creation
Date: Thu, 13 Oct 2011 15:00:43 -0700
Message-Id: <1318543247-27130-6-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle both "create channel request" and "create channel response".

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 439e715..d023156 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2918,6 +2918,41 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 	return 0;
 }
 
+static inline int l2cap_create_channel_req(struct l2cap_conn *conn,
+					struct l2cap_cmd_hdr *cmd, u8 *data)
+{
+	struct l2cap_create_chan_req *req =
+		(struct l2cap_create_chan_req *) data;
+	struct l2cap_create_chan_rsp rsp;
+	u16 psm, scid;
+
+	psm = le16_to_cpu(req->psm);
+	scid = le16_to_cpu(req->scid);
+
+	BT_DBG("psm %d, scid %d, amp_id %d", (int) psm, (int) scid,
+		(int) req->amp_id);
+
+	/* Placeholder: Always reject */
+
+	rsp.dcid = 0;
+	rsp.scid = cpu_to_le16(scid);
+	rsp.result = L2CAP_CREATE_CHAN_REFUSED_CONTROLLER;
+	rsp.status = L2CAP_CREATE_CHAN_STATUS_NONE;
+
+	l2cap_send_cmd(conn, cmd->ident, L2CAP_CREATE_CHAN_RSP,
+		       sizeof(rsp), &rsp);
+
+	return 0;
+}
+
+static inline int l2cap_create_channel_rsp(struct l2cap_conn *conn,
+					struct l2cap_cmd_hdr *cmd, u8 *data)
+{
+	BT_DBG("conn %p", conn);
+
+	return l2cap_connect_rsp(conn, cmd, data);
+}
+
 static inline int l2cap_check_conn_param(u16 min, u16 max, u16 latency,
 							u16 to_multiplier)
 {
@@ -3030,6 +3065,14 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 		err = l2cap_information_rsp(conn, cmd, data);
 		break;
 
+	case L2CAP_CREATE_CHAN_REQ:
+		err = l2cap_create_channel_req(conn, cmd, data);
+		break;
+
+	case L2CAP_CREATE_CHAN_RSP:
+		err = l2cap_create_channel_rsp(conn, cmd, data);
+		break;
+
 	default:
 		BT_ERR("Unknown BR/EDR signaling command 0x%2.2x", cmd->code);
 		err = -EINVAL;
-- 
1.7.7

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

