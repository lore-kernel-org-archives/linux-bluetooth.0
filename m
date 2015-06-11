Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: Read encryption key size for BR/EDR connections
Date: Thu, 11 Jun 2015 13:52:29 +0300
Message-Id: <1434019950-24959-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1434019950-24959-1-git-send-email-johan.hedberg@gmail.com>
References: <1434019950-24959-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since Bluetooth 3.0 there's a HCI command available for reading the
encryption key size of an BR/EDR connection. This information is
essential e.g. for generating an LTK using SMP over BR/EDR, so store
it as part of struct hci_conn.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h | 10 ++++++
 net/bluetooth/hci_event.c   | 87 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index d95da83cb1b0..7ca6690355ea 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1202,6 +1202,16 @@ struct hci_rp_read_clock {
 	__le16   accuracy;
 } __packed;
 
+#define HCI_OP_READ_ENC_KEY_SIZE	0x1408
+struct hci_cp_read_enc_key_size {
+	__le16   handle;
+} __packed;
+struct hci_rp_read_enc_key_size {
+	__u8     status;
+	__le16   handle;
+	__u8     key_size;
+} __packed;
+
 #define HCI_OP_READ_LOCAL_AMP_INFO	0x1409
 struct hci_rp_read_local_amp_info {
 	__u8     status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 62934151431b..88c57b12a222 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2603,6 +2603,64 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
+				       u16 opcode, struct sk_buff *skb)
+{
+	const struct hci_rp_read_enc_key_size *rp;
+	struct hci_conn *conn;
+	u16 handle;
+
+	BT_DBG("%s status 0x%02x", hdev->name, status);
+
+	if (!skb || skb->len < sizeof(*rp)) {
+		BT_ERR("%s invalid HCI Read Encryption Key Size response",
+		       hdev->name);
+		return;
+	}
+
+	rp = (void *)skb->data;
+	handle = le16_to_cpu(rp->handle);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn)
+		goto unlock;
+
+	/* If we fail to read the encryption key size, assume maximum
+	 * (which is the same we do also when this HCI command isn't
+	 * supported.
+	 */
+	if (rp->status) {
+		BT_ERR("%s failed to read key size for handle %u", hdev->name,
+		       handle);
+		conn->enc_key_size = HCI_LINK_KEY_SIZE;
+	} else {
+		conn->enc_key_size = rp->key_size;
+	}
+
+	if (conn->state == BT_CONFIG) {
+		conn->state = BT_CONNECTED;
+		hci_connect_cfm(conn, 0);
+		hci_conn_drop(conn);
+	} else {
+		u8 encrypt;
+
+		if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
+			encrypt = 0x00;
+		else if (conn->type == ACL_LINK &&
+			 test_bit(HCI_CONN_AES_CCM, &conn->flags))
+			encrypt = 0x02;
+		else
+			encrypt = 0x01;
+
+		hci_encrypt_cfm(conn, 0, encrypt);
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_encrypt_change *ev = (void *) skb->data;
@@ -2662,6 +2720,35 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		goto unlock;
 	}
 
+	/* Try reading the encryption key size for encrypted ACL links */
+	if (!ev->status && ev->encrypt && conn->type == ACL_LINK) {
+		struct hci_cp_read_enc_key_size cp;
+		struct hci_request req;
+
+		/* Only send HCI_Read_Encryption_Key_Size if the
+		 * controller really supports it. If it doesn't, assume
+		 * the default size (16).
+		 */
+		if (!(hdev->commands[20] & 0x10)) {
+			conn->enc_key_size = HCI_LINK_KEY_SIZE;
+			goto notify;
+		}
+
+		hci_req_init(&req, hdev);
+
+		cp.handle = cpu_to_le16(conn->handle);
+		hci_req_add(&req, HCI_OP_READ_ENC_KEY_SIZE, sizeof(cp), &cp);
+
+		if (hci_req_run_skb(&req, read_enc_key_size_complete)) {
+			BT_ERR("Sending HCI Read Encryption Key Size failed");
+			conn->enc_key_size = HCI_LINK_KEY_SIZE;
+			goto notify;
+		}
+
+		goto unlock;
+	}
+
+notify:
 	if (conn->state == BT_CONFIG) {
 		if (!ev->status)
 			conn->state = BT_CONNECTED;
-- 
2.4.3

