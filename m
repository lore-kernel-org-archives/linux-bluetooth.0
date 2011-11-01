Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	andrei.emeltchenko@intel.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv3 5/9] Bluetooth: Add signal handlers for channel creation
Date: Tue,  1 Nov 2011 15:29:24 -0700
Message-Id: <1320186568-25493-6-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1320186568-25493-1-git-send-email-mathewm@codeaurora.org>
References: <1320186568-25493-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle both "create channel request" and "create channel response".

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   47 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index af3e8c5..2a49cf3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3101,6 +3101,45 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 	return 0;
 }
 
+static inline int l2cap_create_channel_req(struct l2cap_conn *conn,
+					struct l2cap_cmd_hdr *cmd, u16 cmd_len,
+					void *data)
+{
+	struct l2cap_create_chan_req *req = data;
+	struct l2cap_create_chan_rsp rsp;
+	u16 psm, scid;
+
+	if (cmd_len != sizeof(*req))
+		return -EPROTO;
+
+	if (!enable_hs)
+		return -EINVAL;
+
+	psm = le16_to_cpu(req->psm);
+	scid = le16_to_cpu(req->scid);
+
+	BT_DBG("psm %d, scid %d, amp_id %d", psm, scid, req->amp_id);
+
+	/* Placeholder: Always reject */
+	rsp.dcid = 0;
+	rsp.scid = cpu_to_le16(scid);
+	rsp.result = L2CAP_CR_NO_MEM;
+	rsp.status = L2CAP_CS_NO_INFO;
+
+	l2cap_send_cmd(conn, cmd->ident, L2CAP_CREATE_CHAN_RSP,
+		       sizeof(rsp), &rsp);
+
+	return 0;
+}
+
+static inline int l2cap_create_channel_rsp(struct l2cap_conn *conn,
+					struct l2cap_cmd_hdr *cmd, void *data)
+{
+	BT_DBG("conn %p", conn);
+
+	return l2cap_connect_rsp(conn, cmd, data);
+}
+
 static inline int l2cap_check_conn_param(u16 min, u16 max, u16 latency,
 							u16 to_multiplier)
 {
@@ -3213,6 +3252,14 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 		err = l2cap_information_rsp(conn, cmd, data);
 		break;
 
+	case L2CAP_CREATE_CHAN_REQ:
+		err = l2cap_create_channel_req(conn, cmd, cmd_len, data);
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
1.7.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

