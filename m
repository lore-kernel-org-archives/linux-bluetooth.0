Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next v2 08/16] Bluetooth: Add support for LE Start Encryption
Date: Thu,  2 Jun 2011 17:32:10 -0300
Message-Id: <1307046738-19588-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307046738-19588-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307046738-19588-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for starting SMP Phase 2 Encryption, when the initial
SMP negotiation is successful. This adds the LE Start Encryption and LE
Long Term Key Request commands and related events.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci.h      |   34 +++++++++++++++++++
 include/net/bluetooth/hci_core.h |    5 +++
 net/bluetooth/hci_conn.c         |   46 ++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   67 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/smp.c              |    9 ++++-
 5 files changed, 160 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bd285c6..65345cd 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -745,6 +745,33 @@ struct hci_cp_le_conn_update {
 	__le16   max_ce_len;
 } __packed;
 
+#define HCI_OP_LE_START_ENC		0x2019
+struct hci_cp_le_start_enc {
+	__le16	handle;
+	__u8	rand[8];
+	__le16	ediv;
+	__u8	ltk[16];
+} __packed;
+
+#define HCI_OP_LE_LTK_REPLY		0x201a
+struct hci_cp_le_ltk_reply {
+	__le16	handle;
+	__u8	ltk[16];
+} __packed;
+struct hci_rp_le_ltk_reply {
+	__u8	status;
+	__le16	handle;
+} __packed;
+
+#define HCI_OP_LE_LTK_NEG_REPLY		0x201b
+struct hci_cp_le_ltk_neg_reply {
+	__le16	handle;
+} __packed;
+struct hci_rp_le_ltk_neg_reply {
+	__u8	status;
+	__le16	handle;
+} __packed;
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
@@ -1035,6 +1062,13 @@ struct hci_ev_le_conn_complete {
 	__u8     clk_accurancy;
 } __packed;
 
+#define HCI_EV_LE_LTK_REQ		0x05
+struct hci_ev_le_ltk_req {
+	__le16	handle;
+	__u8	random[8];
+	__le16	ediv;
+} __packed;
+
 /* Advertising report event types */
 #define ADV_IND		0x00
 #define ADV_DIRECT_IND	0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b749508..2f1c91a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -249,6 +249,7 @@ struct hci_conn {
 	__u8		power_save;
 	__u16		disc_timeout;
 	unsigned long	pend;
+	__u8		ltk[16];
 
 	__u8		remote_cap;
 	__u8		remote_oob;
@@ -849,4 +850,8 @@ void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result);
 
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 					u16 latency, u16 to_multiplier);
+void hci_le_start_enc(struct hci_conn *conn, u8 ltk[16]);
+void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
+void hci_le_ltk_neg_reply(struct hci_conn *conn);
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0408a93..2519f63 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -204,6 +204,52 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 }
 EXPORT_SYMBOL(hci_le_conn_update);
 
+void hci_le_start_enc(struct hci_conn *conn, u8 ltk[16])
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_start_enc cp;
+
+	BT_DBG("%p", conn);
+
+	memset(&cp, 0, sizeof(cp));
+
+	cp.handle = cpu_to_le16(conn->handle);
+	memcpy(cp.ltk, ltk, sizeof(cp.ltk));
+
+	hci_send_cmd(hdev, HCI_OP_LE_START_ENC, sizeof(cp), &cp);
+}
+EXPORT_SYMBOL(hci_le_start_enc);
+
+void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16])
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_ltk_reply cp;
+
+	BT_DBG("%p", conn);
+
+	memset(&cp, 0, sizeof(cp));
+
+	cp.handle = cpu_to_le16(conn->handle);
+	memcpy(cp.ltk, ltk, sizeof(ltk));
+
+	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
+}
+EXPORT_SYMBOL(hci_le_ltk_reply);
+
+void hci_le_ltk_neg_reply(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_ltk_neg_reply cp;
+
+	BT_DBG("%p", conn);
+
+	memset(&cp, 0, sizeof(cp));
+
+	cp.handle = cpu_to_le16(conn->handle);
+
+	hci_send_cmd(hdev, HCI_OP_LE_LTK_NEG_REPLY, sizeof(cp), &cp);
+}
+
 /* Device _must_ be locked */
 void hci_sco_setup(struct hci_conn *conn, __u8 status)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0f643f8..166fa11 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -868,6 +868,30 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_ltk_reply(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_le_ltk_reply *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hci_req_complete(hdev, HCI_OP_LE_LTK_REPLY, rp->status);
+}
+
+static void hci_cc_le_ltk_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_le_ltk_neg_reply *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hci_req_complete(hdev, HCI_OP_LE_LTK_NEG_REPLY, rp->status);
+}
+
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -1248,6 +1272,11 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("%s status 0x%x", hdev->name, status);
+}
+
 static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -1856,6 +1885,14 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_le_set_scan_enable(hdev, skb);
 		break;
 
+	case HCI_OP_LE_LTK_REPLY:
+		hci_cc_le_ltk_reply(hdev, skb);
+		break;
+
+	case HCI_OP_LE_LTK_NEG_REPLY:
+		hci_cc_le_ltk_neg_reply(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
@@ -1934,6 +1971,10 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_le_create_conn(hdev, ev->status);
 		break;
 
+	case HCI_OP_LE_START_ENC:
+		hci_cs_le_start_enc(hdev, ev->status);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
@@ -2745,6 +2786,28 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
+						struct sk_buff *skb)
+{
+	struct hci_ev_le_ltk_req *ev = (void *) skb->data;
+	struct hci_cp_le_ltk_reply cp;
+	struct hci_conn *conn;
+
+	BT_DBG("%s handle %d", hdev->name, cpu_to_le16(ev->handle));
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = cpu_to_le16(conn->handle);
+	memcpy(cp.ltk, conn->ltk, sizeof(conn->ltk));
+
+	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
+
+	hci_dev_unlock(hdev);
+}
+
 static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_meta *le_ev = (void *) skb->data;
@@ -2760,6 +2823,10 @@ static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_le_adv_report_evt(hdev, skb);
 		break;
 
+	case HCI_EV_LE_LTK_REQ:
+		hci_le_ltk_request_evt(hdev, skb);
+		break;
+
 	default:
 		break;
 	}
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index dfb9b63..22c362b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -276,13 +276,16 @@ static void smp_cmd_pairing_confirm(struct l2cap_conn *conn,
 
 static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
+	struct hci_conn *hcon = conn->hcon;
+	struct crypto_blkcipher *tfm = hcon->hdev->tfm;
 	int ret;
 	u8 key[16], res[16], random[16], confirm[16], buf[128];
 
 	swap128(skb->data, random);
 	skb_pull(skb, sizeof(random));
 
+	memset(hcon->ltk, 0, sizeof(hcon->ltk));
+
 	if (conn->hcon->out)
 		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
 				conn->src, 0, conn->dst, res);
@@ -307,6 +310,9 @@ static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	if (conn->hcon->out) {
 		smp_s1(tfm, conn->tk, random, conn->prnd, key);
+		swap128(key, hcon->ltk);
+
+		hci_le_start_enc(hcon, hcon->ltk);
 
 		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf,
 							sizeof(buf), 0);
@@ -318,6 +324,7 @@ static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(r), r);
 
 		smp_s1(tfm, conn->tk, conn->prnd, random, key);
+		swap128(key, hcon->ltk);
 
 		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf,
 							sizeof(buf), 0);
-- 
1.7.5.1

