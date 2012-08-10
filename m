Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC 2/5] Bluetooth: Add set controller data MGMT command
Date: Fri, 10 Aug 2012 17:01:44 -0400
Message-Id: <1344632507-21381-3-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1344632507-21381-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1344632507-21381-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command will be used to sets EIR data for BR/EDR and/or AD for LE.

Signed-off-by: Jefferson Delfes <jefferson.delfes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 14 ++++++++++++++
 include/net/bluetooth/mgmt.h     | 11 +++++++++++
 net/bluetooth/hci_core.c         | 32 ++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 41d9439..3a61227 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -122,6 +122,14 @@ struct le_scan_params {
 	int timeout;
 };
 
+struct controller_data {
+	struct list_head list;
+	u8 flags;
+	u8 data_type;
+	u8 data_length;
+	u8 data[0];
+};
+
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 #define NUM_REASSEMBLY 4
@@ -269,6 +277,8 @@ struct hci_dev {
 	struct work_struct	le_scan;
 	struct le_scan_params	le_scan_params;
 
+	struct list_head	controller_data;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
@@ -715,6 +725,10 @@ void hci_conn_init_sysfs(struct hci_conn *conn);
 void hci_conn_add_sysfs(struct hci_conn *conn);
 void hci_conn_del_sysfs(struct hci_conn *conn);
 
+int hci_controller_data_add(struct hci_dev *hdev, u8 flags, u8 data_type,
+			    u8 data_length, u8 *data);
+int hci_controller_data_clear(struct hci_dev *hdev);
+
 #define SET_HCIDEV_DEV(hdev, pdev) ((hdev)->dev.parent = (pdev))
 
 /* ----- LMP capabilities ----- */
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 4348ee8..1afa399 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -350,6 +350,17 @@ struct mgmt_cp_set_device_id {
 } __packed;
 #define MGMT_SET_DEVICE_ID_SIZE		8
 
+#define MGMT_DATA_HIGH_PRIORITY		BIT(0)
+
+#define MGMT_OP_SET_CONTROLLER_DATA	0x0029
+struct mgmt_cp_set_controller_data {
+	__u8	flags;
+	__u8	data_type;
+	__u8	data_length;
+	__u8	data[0];
+} __packed;
+#define MGMT_SET_CONTROLLER_DATA_SIZE	3
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fa974a1..2e38a1b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1441,6 +1441,36 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 	return 0;
 }
 
+int hci_controller_data_add(struct hci_dev *hdev, u8 flags, u8 data_type,
+			    u8 data_length, u8 *data)
+{
+	struct controller_data *c_data;
+
+	c_data = kmalloc(sizeof(*c_data) + data_length, GFP_KERNEL);
+	if (!c_data)
+		return -ENOMEM;
+
+	c_data->flags = flags;
+	c_data->data_type = data_type;
+	c_data->data_length = data_length;
+	memcpy(c_data->data, data, data_length);
+
+	list_add(&c_data->list, &hdev->controller_data);
+	return 0;
+}
+
+int hci_controller_data_clear(struct hci_dev *hdev)
+{
+	struct controller_data *c_data, *n;
+
+	list_for_each_entry_safe(c_data, n, &hdev->controller_data, list) {
+		list_del(&c_data->list);
+		kfree(c_data);
+	}
+
+	return 0;
+}
+
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct bdaddr_list *b;
@@ -1652,6 +1682,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->link_keys);
 	INIT_LIST_HEAD(&hdev->long_term_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
+	INIT_LIST_HEAD(&hdev->controller_data);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
@@ -1817,6 +1848,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_link_keys_clear(hdev);
 	hci_smp_ltks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
+	hci_controller_data_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a3329cb..9e9702a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2684,6 +2684,38 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return 0;
 }
 
+static int set_controller_data(struct sock *sk, struct hci_dev *hdev,
+			       void *data, u16 len)
+{
+	struct mgmt_cp_set_controller_data *cp = data;
+
+	BT_DBG("%s", hdev->name);
+
+	if (cp->flags > MGMT_DATA_HIGH_PRIORITY)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONTROLLER_DATA,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	if (cp->data_type != EIR_SERVICE_DATA &&
+	    cp->data_type != EIR_MANUFACTURER_DATA)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONTROLLER_DATA,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	if (cp->data_length > HCI_MAX_EIR_LENGTH - 2)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONTROLLER_DATA,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	BT_DBG("flags:0x%02x type:0x%02x length:%i", cp->flags, cp->data_type,
+	       cp->data_length);
+
+	hci_dev_lock(hdev);
+	hci_controller_data_add(hdev, cp->flags, cp->data_type, cp->data_length,
+				cp->data);
+	hci_dev_unlock(hdev);
+
+	return cmd_complete(sk, hdev->id, MGMT_OP_SET_CONTROLLER_DATA, 0, NULL,
+			    0);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -2731,6 +2763,7 @@ static const struct mgmt_handler {
 	{ block_device,           false, MGMT_BLOCK_DEVICE_SIZE },
 	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
+	{ set_controller_data,    true,  MGMT_SET_CONTROLLER_DATA_SIZE },
 };
 
 
-- 
1.7.11.4

