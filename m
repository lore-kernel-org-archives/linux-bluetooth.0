Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC 2/3] Bluetooth: Add connection parameter update response
Date: Fri, 11 Feb 2011 19:28:55 -0200
Message-Id: <1297459736-24514-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1297459736-24514-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1297459736-24514-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements L2CAP Connection Parameter Update Response defined in
the Bluetooth Core Specification, Volume 3, Part A, section 4.21.
Address the LE Connection Parameter Procedure initiated by the slave.

Connection Interval Minimum and Maximum have the same range: 6 to
3200. Time = N * 1.25ms. Minimum shall be less or equal to Maximum.
The Slave Latency field shall have a value in the range of 0 to
((connSupervisionTimeout / connIntervalMax) - 1). Latency field shall
be less than 500. connSupervisionTimeout = Timeout Multiplier * 10 ms.
Multiplier field shall have a value in the range of 10 to 3200.

Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
---
 include/net/bluetooth/l2cap.h |   15 ++++++++++
 net/bluetooth/l2cap_core.c    |   60 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 6aa70e9..be0116b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -261,6 +261,21 @@ struct l2cap_info_rsp {
 #define L2CAP_IR_SUCCESS    0x0000
 #define L2CAP_IR_NOTSUPP    0x0001
 
+struct l2cap_conn_param_update_req {
+	__le16      min;
+	__le16      max;
+	__le16      latency;
+	__le16      to_multiplier;
+} __packed;
+
+struct l2cap_conn_param_update_rsp {
+	__le16      result;
+} __packed;
+
+/* Connection Parameters result */
+#define L2CAP_CONN_PARAM_ACCEPTED	0x0000
+#define L2CAP_CONN_PARAM_REJECTED	0x0001
+
 /* ----- L2CAP connections ----- */
 struct l2cap_chan_list {
 	struct sock	*head;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 122fc1c..8b76a72 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2508,6 +2508,64 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 	return 0;
 }
 
+static int inline l2cap_check_conn_param(u16 min, u16 max, u16 latency,
+							u16 to_multiplier)
+{
+	u16 max_latency;
+
+	if (min > max || min < 6 || max > 3200)
+		return -EINVAL;
+
+	if (to_multiplier < 10 || to_multiplier > 3200)
+		return -EINVAL;
+
+	if (max >= to_multiplier * 8)
+		return -EINVAL;
+
+	max_latency = (to_multiplier * 8 / max) - 1;
+	if (latency > 499 || latency > max_latency)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
+					struct l2cap_cmd_hdr *cmd, u8 *data)
+{
+	struct hci_conn *hcon = conn->hcon;
+	struct l2cap_conn_param_update_req *req;
+	struct l2cap_conn_param_update_rsp rsp;
+	u16 min, max, latency, to_multiplier, cmd_len;
+	int err;
+
+	if (!(hcon->link_mode & HCI_LM_MASTER))
+		return -EINVAL;
+
+	cmd_len = __le16_to_cpu(cmd->len);
+	if (cmd_len != sizeof(struct l2cap_conn_param_update_req))
+		return -EPROTO;
+
+	req = (struct l2cap_conn_param_update_req *) data;
+	min 		= __le16_to_cpu(req->min);
+	max 		= __le16_to_cpu(req->max);
+	latency		= __le16_to_cpu(req->latency);
+	to_multiplier	= __le16_to_cpu(req->to_multiplier);
+
+	BT_DBG("min 0x%4.4x max 0x%4.4x latency: 0x%4.4x Timeout: 0x%4.4x",
+						min, max, latency, to_multiplier);
+
+	memset(&rsp, 0, sizeof(rsp));
+	if (l2cap_check_conn_param(min, max, latency, to_multiplier))
+		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
+	else
+		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_ACCEPTED);
+
+	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_PARAM_UPDATE_RSP,
+							sizeof(rsp), &rsp);
+
+	return 0;
+}
+
 static inline int bredr_sig_cmd(struct l2cap_conn *conn,
 			struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
@@ -2577,7 +2635,7 @@ static inline int le_sig_cmd(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_CONN_PARAM_UPDATE_REQ:
-		err = -EINVAL;
+		err = l2cap_conn_param_update_req(conn, cmd, data);
 		break;
 
 	case L2CAP_CONN_PARAM_UPDATE_RSP:
-- 
1.7.4

