Return-Path: <cyrus@holtmann.org>
From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [RFC 4/9] Bluetooth: Add set controller data MGMT command
Date: Wed, 24 Oct 2012 12:58:10 -0300
Message-Id: <1351094295-10418-5-git-send-email-aloisio.almeida@openbossa.org>
In-Reply-To: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
References: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set controller data allows user to set advertising data. The available data
types are 'service data' and 'manufacturer specific data'.

If LE_ENABLED is set, the HCI_OP_LE_SET_ADV_DATA command will be sent.

This command is available on the powered off state.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 include/net/bluetooth/hci.h      |    3 ++
 include/net/bluetooth/hci_core.h |   15 ++++++++
 include/net/bluetooth/mgmt.h     |    9 +++++
 net/bluetooth/hci_core.c         |   36 +++++++++++++++++++
 net/bluetooth/mgmt.c             |   74 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 75b7e58..c0e9c3f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -333,6 +333,9 @@ enum {
 #define EIR_SSP_HASH_C		0x0E /* Simple Pairing Hash C */
 #define EIR_SSP_RAND_R		0x0F /* Simple Pairing Randomizer R */
 #define EIR_DEVICE_ID		0x10 /* device ID */
+/* Advertising field types */
+#define ADV_SERVICE_DATA	0x16 /* Service Data */
+#define ADV_MANUFACTURER_DATA	0xFF /* Manufacturer Specific Data */
 
 /* -----  HCI Commands ---- */
 #define HCI_OP_NOP			0x0000
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c885e54..4046111 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -123,6 +123,14 @@ struct le_scan_params {
 	int timeout;
 };
 
+struct controller_data {
+	struct list_head list;
+	u8 flags;
+	u8 type;
+	u8 length;
+	u8 data[0];
+};
+
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 struct amp_assoc {
@@ -280,6 +288,9 @@ struct hci_dev {
 
 	__s8			adv_tx_power;
 
+	struct list_head	controller_data;
+	__u16			adv_data_len;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
@@ -747,6 +758,10 @@ void hci_conn_init_sysfs(struct hci_conn *conn);
 void hci_conn_add_sysfs(struct hci_conn *conn);
 void hci_conn_del_sysfs(struct hci_conn *conn);
 
+int hci_controller_data_add(struct hci_dev *hdev, u8 flags, u8 type, u8 length,
+			    u8 *data);
+int hci_controller_data_clear(struct hci_dev *hdev);
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
index 5a3400d..e5ab961 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1405,6 +1405,40 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 	return 0;
 }
 
+int hci_controller_data_add(struct hci_dev *hdev, u8 flags, u8 type, u8 length,
+			    u8 *data)
+{
+	struct controller_data *c_data;
+
+	c_data = kmalloc(sizeof(*c_data) + length, GFP_KERNEL);
+	if (!c_data)
+		return -ENOMEM;
+
+	c_data->flags = flags;
+	c_data->type = type;
+	c_data->length = length;
+	memcpy(c_data->data, data, length);
+
+	list_add(&c_data->list, &hdev->controller_data);
+	hdev->adv_data_len += sizeof(length) + sizeof(type) + length;
+
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
+	hdev->adv_data_len = 0;
+
+	return 0;
+}
+
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct bdaddr_list *b;
@@ -1617,6 +1651,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->long_term_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
+	INIT_LIST_HEAD(&hdev->controller_data);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
@@ -1781,6 +1816,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_link_keys_clear(hdev);
 	hci_smp_ltks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
+	hci_controller_data_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 399e502..1ada019 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2685,6 +2685,76 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return 0;
 }
 
+static void update_adv_data(struct hci_dev *hdev)
+{
+	struct hci_cp_le_set_adv_data cp;
+	struct controller_data *d;
+	u8 len, *ptr;
+
+	if (!hdev_is_powered(hdev))
+		return;
+
+	memset(&cp.data, 0, sizeof(cp.data));
+	ptr = cp.data;
+	len = 0;
+
+	list_for_each_entry(d, &hdev->controller_data, list) {
+		u8 entry_len = sizeof(d->length) + sizeof(d->type) + d->length;
+
+		if (len + entry_len > HCI_MAX_ADV_LENGTH) {
+			BT_DBG("Controller data bigger than adv data slot");
+			return;
+		}
+
+		ptr[0] = sizeof(d->type) + d->length;
+		ptr[1] = d->type;
+		memcpy(&ptr[2], d->data, d->length);
+
+		len += entry_len;
+		ptr += entry_len;
+	}
+
+	cp.data_len = len;
+
+	hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
+}
+
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
+	room = HCI_MAX_ADV_LENGTH - hdev->adv_data_len;
+	if (sizeof(cp->length) + sizeof(cp->type) + cp->length > room) {
+		hci_dev_unlock(hdev);
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONTROLLER_DATA,
+				  MGMT_STATUS_NO_RESOURCES);
+	}
+
+	BT_DBG("flags:0x%02x length:%i type:0x%02x", cp->flags, cp->length,
+	       cp->type);
+
+	hci_controller_data_add(hdev, cp->flags, cp->type, cp->length,
+				cp->data);
+
+	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		update_adv_data(hdev);
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
@@ -2732,6 +2802,7 @@ static const struct mgmt_handler {
 	{ block_device,           false, MGMT_BLOCK_DEVICE_SIZE },
 	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
+	{ set_controller_data,    true,  MGMT_SET_CONTROLLER_DATA_SIZE },
 };
 
 
@@ -2911,6 +2982,9 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 		update_class(hdev);
 		update_name(hdev, hdev->dev_name);
 		update_eir(hdev);
+
+		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+			update_adv_data(hdev);
 	} else {
 		u8 status = MGMT_STATUS_NOT_POWERED;
 		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
-- 
1.7.10.4

