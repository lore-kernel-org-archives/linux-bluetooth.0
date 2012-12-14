Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>,
	Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH 03/12] Bluetooth: Add set controller data MGMT command
Date: Fri, 14 Dec 2012 14:51:29 -0400
Message-Id: <1355511098-10190-4-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>

Set controller data allows user to set broadcast advertising data. The available
data types are 'service data' and 'manufacturer specific data'.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Signed-off-by: Jefferson Delfes <jefferson.delfes@openbossa.org>
---
 include/net/bluetooth/hci.h      |  3 +++
 include/net/bluetooth/hci_core.h | 15 +++++++++++++++
 include/net/bluetooth/mgmt.h     |  9 +++++++++
 net/bluetooth/hci_core.c         | 36 ++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 39 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e89311d..a89ff01 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -337,6 +337,9 @@ enum {
 #define EIR_SSP_HASH_C		0x0E /* Simple Pairing Hash C */
 #define EIR_SSP_RAND_R		0x0F /* Simple Pairing Randomizer R */
 #define EIR_DEVICE_ID		0x10 /* device ID */
+/* Advertising field types */
+#define ADV_SERVICE_DATA	0x16 /* Service Data */
+#define ADV_MANUFACTURER_DATA	0xFF /* Manufacturer Specific Data */
 
 /* Low Energy Advertising Flags */
 #define LE_AD_LIMITED		0x01 /* Limited Discoverable */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 014a2ea..49a9ead 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -123,6 +123,14 @@ struct le_scan_params {
 	int timeout;
 };
 
+struct broadcast_data {
+	struct list_head list;
+	u8 flags;
+	u8 type;
+	u8 length;
+	u8 data[0];
+};
+
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 struct amp_assoc {
@@ -282,6 +290,9 @@ struct hci_dev {
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
 	__u8			adv_data_len;
 
+	struct list_head	broadcast_data;
+	__u16			broadcast_data_len;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
@@ -752,6 +763,10 @@ void hci_conn_init_sysfs(struct hci_conn *conn);
 void hci_conn_add_sysfs(struct hci_conn *conn);
 void hci_conn_del_sysfs(struct hci_conn *conn);
 
+int hci_broadcast_data_add(struct hci_dev *hdev, u8 flags, u8 type, u8 length,
+			   u8 *data);
+int hci_broadcast_data_clear(struct hci_dev *hdev);
+
 #define SET_HCIDEV_DEV(hdev, pdev) ((hdev)->dev.parent = (pdev))
 
 /* ----- LMP capabilities ----- */
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 22980a7..f99e0a8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -350,6 +350,15 @@ struct mgmt_cp_set_device_id {
 } __packed;
 #define MGMT_SET_DEVICE_ID_SIZE		8
 
+#define MGMT_OP_SET_CONTROLLER_DATA	0x0029
+struct mgmt_cp_set_controller_data {
+	__u8	flags;
+	__u8	type;
+	__u8	length;
+	__u8	data[0];
+} __packed;
+#define MGMT_SET_CONTROLLER_DATA_SIZE	3
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ec7d3a7..6d6ee0c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1504,6 +1504,40 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 	return 0;
 }
 
+int hci_broadcast_data_add(struct hci_dev *hdev, u8 flags, u8 type, u8 length,
+			    u8 *data)
+{
+	struct broadcast_data *b_data;
+
+	b_data = kmalloc(sizeof(*b_data) + length, GFP_KERNEL);
+	if (!b_data)
+		return -ENOMEM;
+
+	b_data->flags = flags;
+	b_data->type = type;
+	b_data->length = length;
+	memcpy(b_data->data, data, length);
+
+	list_add(&b_data->list, &hdev->broadcast_data);
+	hdev->broadcast_data_len += sizeof(length) + sizeof(type) + length;
+
+	return 0;
+}
+
+int hci_broadcast_data_clear(struct hci_dev *hdev)
+{
+	struct broadcast_data *b_data, *n;
+
+	list_for_each_entry_safe(b_data, n, &hdev->broadcast_data, list) {
+		list_del(&b_data->list);
+		kfree(b_data);
+	}
+
+	hdev->broadcast_data_len = 0;
+
+	return 0;
+}
+
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct bdaddr_list *b;
@@ -1721,6 +1755,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->long_term_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
+	INIT_LIST_HEAD(&hdev->broadcast_data);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
@@ -1887,6 +1922,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_link_keys_clear(hdev);
 	hci_smp_ltks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
+	hci_broadcast_data_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5d0ef75..4623cf0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2701,6 +2701,44 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return 0;
 }
 
+static int set_controller_data(struct sock *sk, struct hci_dev *hdev,
+			       void *data, u16 len)
+{
+	struct mgmt_cp_set_controller_data *cp = data;
+	u8 room;
+
+	BT_DBG("%s", hdev->name);
+
+	if (cp->type != ADV_SERVICE_DATA && cp->type != ADV_MANUFACTURER_DATA)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONTROLLER_DATA,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		hci_dev_unlock(hdev);
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONTROLLER_DATA,
+				  MGMT_STATUS_NOT_POWERED);
+	}
+
+	room = HCI_MAX_AD_LENGTH - hdev->broadcast_data_len;
+	if (sizeof(cp->length) + sizeof(cp->type) + cp->length > room) {
+		hci_dev_unlock(hdev);
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONTROLLER_DATA,
+				  MGMT_STATUS_NO_RESOURCES);
+	}
+
+	BT_DBG("flags:0x%02x length:%i type:0x%02x", cp->flags, cp->length,
+	       cp->type);
+
+	hci_broadcast_data_add(hdev, cp->flags, cp->type, cp->length, cp->data);
+
+	hci_dev_unlock(hdev);
+
+	return cmd_complete(sk, hdev->id, MGMT_OP_SET_CONTROLLER_DATA, 0, NULL,
+			    0);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -2748,6 +2786,7 @@ static const struct mgmt_handler {
 	{ block_device,           false, MGMT_BLOCK_DEVICE_SIZE },
 	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
+	{ set_controller_data,    true,  MGMT_SET_CONTROLLER_DATA_SIZE },
 };
 
 
-- 
1.8.0.2

