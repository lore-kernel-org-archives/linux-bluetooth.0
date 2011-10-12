Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 1/4] Bluetooth: L2CAP Create Chan Req/Rsp support
Date: Wed, 12 Oct 2011 10:53:56 +0300
Message-Id: <1318406039-24843-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318406039-24843-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318406039-24843-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Backport l2cap create channel req/rsp from codeaurora tree
git://codeaurora.org/kernel/msm.git
Currently functionality is the same like in l2cap connect req/rsp

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h   |    3 ++
 include/net/bluetooth/l2cap.h |   22 +++++++++++-
 net/bluetooth/l2cap_core.c    |   72 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index aaf79af..f8adc8e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -56,6 +56,9 @@
 #define HCI_BREDR	0x00
 #define HCI_AMP		0x01
 
+#define HCI_AMP_ID(id)     ((id) + 0x10)  /* convert HCI dev index to AMP ID */
+#define AMP_HCI_ID(id)     ((id) - 0x10)  /* convert AMP ID to HCI dev index */
+
 /* HCI device quirks */
 enum {
 	HCI_QUIRK_NO_RESET,
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ebd6392..45d1814 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -91,6 +91,8 @@ struct l2cap_conninfo {
 #define L2CAP_ECHO_RSP		0x09
 #define L2CAP_INFO_REQ		0x0a
 #define L2CAP_INFO_RSP		0x0b
+#define L2CAP_CREATE_CHAN_REQ	0x0c
+#define L2CAP_CREATE_CHAN_RSP	0x0d
 #define L2CAP_CONN_PARAM_UPDATE_REQ	0x12
 #define L2CAP_CONN_PARAM_UPDATE_RSP	0x13
 
@@ -214,14 +216,15 @@ struct l2cap_conn_rsp {
 #define L2CAP_CID_DYN_START	0x0040
 #define L2CAP_CID_DYN_END	0xffff
 
-/* connect result */
+/* connect/create channel results */
 #define L2CAP_CR_SUCCESS	0x0000
 #define L2CAP_CR_PEND		0x0001
 #define L2CAP_CR_BAD_PSM	0x0002
 #define L2CAP_CR_SEC_BLOCK	0x0003
 #define L2CAP_CR_NO_MEM		0x0004
+#define L2CAP_CR_BAD_AMP	0x0005
 
-/* connect status */
+/* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
 #define L2CAP_CS_AUTHEN_PEND	0x0001
 #define L2CAP_CS_AUTHOR_PEND	0x0002
@@ -298,6 +301,19 @@ struct l2cap_info_rsp {
 	__u8        data[0];
 } __packed;
 
+struct l2cap_create_chan_req {
+	__le16      psm;
+	__le16      scid;
+	__u8        amp_id;
+} __packed;
+
+struct l2cap_create_chan_rsp {
+	__le16      dcid;
+	__le16      scid;
+	__le16      result;
+	__le16      status;
+} __packed;
+
 /* info type */
 #define L2CAP_IT_CL_MTU		0x0001
 #define L2CAP_IT_FEAT_MASK	0x0002
@@ -353,6 +369,8 @@ struct l2cap_chan {
 
 	__u8		ident;
 
+	__u8		amp_id;
+
 	__u8		conf_req[64];
 	__u8		conf_len;
 	__u8		num_conf_req;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d418ddb..9144d70 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2392,7 +2392,8 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	return 0;
 }
 
-static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
+static inline struct sock *__l2cap_connect(struct l2cap_conn *conn,
+		struct l2cap_cmd_hdr *cmd, u8 *data, u8 rsp_code, u8 amp_id)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
@@ -2464,6 +2465,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	__set_chan_timer(chan, sk->sk_sndtimeo);
 
 	chan->ident = cmd->ident;
+	chan->amp_id = amp_id;
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
 		if (l2cap_check_security(chan)) {
@@ -2526,6 +2528,14 @@ sendresp:
 	return 0;
 }
 
+static inline int l2cap_connect_req(struct l2cap_conn *conn,
+					struct l2cap_cmd_hdr *cmd, u8 *data)
+{
+	__l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP, 0);
+
+	return 0;
+}
+
 static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
 	struct l2cap_conn_rsp *rsp = (struct l2cap_conn_rsp *) data;
@@ -2950,6 +2960,58 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 	return 0;
 }
 
+static inline int l2cap_create_channel_req(struct l2cap_conn *conn,
+					struct l2cap_cmd_hdr *cmd, u8 *data)
+{
+	struct l2cap_create_chan_req *req =
+		(struct l2cap_create_chan_req *) data;
+	struct sock *sk;
+	u16 psm, scid;
+
+	psm = le16_to_cpu(req->psm);
+	scid = le16_to_cpu(req->scid);
+
+	BT_DBG("psm %d, scid %d, amp_id %d", psm, scid, req->amp_id);
+
+	if (req->amp_id) {
+		struct hci_dev *hdev;
+
+		/* Validate AMP controller id */
+		hdev = hci_dev_get(AMP_HCI_ID(req->amp_id));
+		if (!hdev || !test_bit(HCI_UP, &hdev->flags)) {
+			struct l2cap_create_chan_rsp rsp;
+
+			rsp.dcid = 0;
+			rsp.scid = cpu_to_le16(scid);
+			rsp.result = L2CAP_CR_BAD_AMP;
+			rsp.status = L2CAP_CS_NO_INFO;
+
+			l2cap_send_cmd(conn, cmd->ident, L2CAP_CREATE_CHAN_RSP,
+							sizeof(rsp), &rsp);
+
+			if (hdev)
+				hci_dev_put(hdev);
+
+			return 0;
+		}
+
+		hci_dev_put(hdev);
+	}
+
+	sk = __l2cap_connect(conn, cmd, data, L2CAP_CREATE_CHAN_RSP,
+								req->amp_id);
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
@@ -3062,6 +3124,14 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
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
1.7.4.1

