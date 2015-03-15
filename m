Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add simple version of Read Advertising Features command
Date: Sat, 14 Mar 2015 20:45:29 -0700
Message-Id: <1426391129-15865-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for the simplest possible version of Read Advertising
Features management command. It allows basic testing of the interface.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h | 11 +++++++++++
 net/bluetooth/mgmt.c         | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f3baad589db0..4d0ccd194c01 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -517,6 +517,17 @@ struct mgmt_rp_read_ext_index_list {
 	} entry[0];
 } __packed;
 
+#define MGMT_OP_READ_ADV_FEATURES	0x0003D
+#define MGMT_READ_ADV_FEATURES_SIZE	0
+struct mgmt_rp_read_adv_features {
+	__le32 supported_flags;
+	__u8   max_adv_data_len;
+	__u8   max_scan_rsp_len;
+	__u8   max_instances;
+	__u8   num_instances;
+	__u8   instance[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 981dfb4f94f0..57de151902f8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -97,6 +97,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_PUBLIC_ADDRESS,
 	MGMT_OP_START_SERVICE_DISCOVERY,
 	MGMT_OP_READ_EXT_INDEX_LIST,
+	MGMT_OP_READ_ADV_FEATURES,
 };
 
 static const u16 mgmt_events[] = {
@@ -6254,6 +6255,40 @@ unlock:
 	return err;
 }
 
+static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
+			     void *data, u16 data_len)
+{
+	struct mgmt_rp_read_adv_features *rp;
+	size_t rp_len;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	hci_dev_lock(hdev);
+
+	rp_len = sizeof(*rp);
+	rp = kmalloc(rp_len, GFP_ATOMIC);
+	if (!rp) {
+		hci_dev_unlock(hdev);
+		return -ENOMEM;
+	}
+
+	rp->supported_flags = cpu_to_le32(0);
+	rp->max_adv_data_len = 31;
+	rp->max_scan_rsp_len = 31;
+	rp->max_instances = 0;
+	rp->num_instances = 0;
+
+	hci_dev_unlock(hdev);
+
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_ADV_FEATURES, 0,
+				rp, rp_len);
+
+	kfree(rp);
+
+	return err;
+}
+
 static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ NULL }, /* 0x0000 (no command) */
 	{ read_version,            MGMT_READ_VERSION_SIZE,
@@ -6337,6 +6372,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ read_ext_index_list,     MGMT_READ_EXT_INDEX_LIST_SIZE,
 						HCI_MGMT_NO_HDEV |
 						HCI_MGMT_UNTRUSTED },
+	{ read_adv_features,       MGMT_READ_ADV_FEATURES_SIZE },
 };
 
 int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
-- 
2.1.0

