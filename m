Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC 4/5] Bluetooth: Add set broadcaster MGMT command
Date: Fri, 10 Aug 2012 17:01:46 -0400
Message-Id: <1344632507-21381-5-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1344632507-21381-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1344632507-21381-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command will enable or disable broadcaster mode. Data can be added
with set_controller_data command. If there are more data that can be
broadcasted, it will be ignored for while.

Signed-off-by: Jefferson Delfes <jefferson.delfes@openbossa.org>
---
 include/net/bluetooth/hci.h  |  1 +
 include/net/bluetooth/mgmt.h |  3 ++
 net/bluetooth/mgmt.c         | 75 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e4d4717..80f585a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -118,6 +118,7 @@ enum {
 	HCI_LINK_SECURITY,
 	HCI_PENDING_CLASS,
 	HCI_PERIODIC_INQ,
+	HCI_BROADCASTER,
 };
 
 /* HCI ioctl defines */
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index eda2755..2e85012 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -92,6 +92,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_BREDR		0x00000080
 #define MGMT_SETTING_HS			0x00000100
 #define MGMT_SETTING_LE			0x00000200
+#define MGMT_SETTING_BROADCASTER	0x00000400
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -367,6 +368,8 @@ struct mgmt_cp_unset_controller_data {
 } __packed;
 #define MGMT_UNSET_CONTROLLER_DATA_SIZE	1
 
+#define MGMT_OP_SET_BROADCASTER		0x002B
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 51d0e2f..ae4910a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -379,6 +379,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	settings |= MGMT_SETTING_FAST_CONNECTABLE;
 	settings |= MGMT_SETTING_DISCOVERABLE;
 	settings |= MGMT_SETTING_PAIRABLE;
+	settings |= MGMT_SETTING_BROADCASTER;
 
 	if (lmp_ssp_capable(hdev))
 		settings |= MGMT_SETTING_SSP;
@@ -419,6 +420,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
 		settings |= MGMT_SETTING_LE;
 
+	if (test_bit(HCI_BROADCASTER, &hdev->dev_flags))
+		settings |= MGMT_SETTING_BROADCASTER;
+
 	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags))
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
@@ -2731,6 +2735,76 @@ static int unset_controller_data(struct sock *sk, struct hci_dev *hdev,
 			    NULL, 0);
 }
 
+static int set_broadcaster_le(struct hci_dev *hdev, u8 enable)
+{
+	BT_DBG("%s enable:%i", hdev->name, enable);
+
+	if (enable) {
+		struct hci_cp_le_set_adv_params params;
+		struct hci_cp_le_set_adv_data data;
+		struct controller_data *d;
+
+		params.interval_min = __constant_cpu_to_le16(0x0800);
+		params.interval_max = __constant_cpu_to_le16(0x0800);
+		params.type = ADV_NONCONN_IND;
+		params.own_address_type = ADDR_LE_DEV_PUBLIC;
+		params.direct_address_type = ADDR_LE_DEV_PUBLIC;
+		memset(&params.direct_address, 0,
+		       sizeof(params.direct_address));
+		params.channel_map = ADV_USE_ALL_CHANNELS;
+		params.filter_policy = 0x00;
+		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_PARAMS, sizeof(params),
+			     &params);
+
+		data.data_len = 0;
+		memset(&data.data, 0, sizeof(data.data));
+		list_for_each_entry(d, &hdev->controller_data, list) {
+			if (data.data_len + d->data_length + 2 >
+			    HCI_MAX_ADV_LENGTH)
+				break;
+
+			data.data[data.data_len] = d->data_length + 1;
+			data.data[data.data_len + 1] = d->data_type;
+			memcpy(&data.data[data.data_len + 2], d->data,
+			       d->data_length);
+			data.data_len += d->data_length + 2;
+		}
+		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_DATA, sizeof(data), &data);
+	}
+
+	return hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
+			    &enable);
+}
+
+static int set_broadcaster(struct sock *sk, struct hci_dev *hdev, void *data,
+			   u16 len)
+{
+	struct mgmt_mode *cp = data;
+	int err;
+
+	BT_DBG("%s val:%i", hdev->name, cp->val);
+
+	if (cp->val)
+		set_bit(HCI_BROADCASTER, &hdev->dev_flags);
+	else
+		clear_bit(HCI_BROADCASTER, &hdev->dev_flags);
+
+	hci_dev_lock(hdev);
+
+	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		set_broadcaster_le(hdev, cp->val);
+
+	err = send_settings_rsp(sk, MGMT_OP_SET_BROADCASTER, hdev);
+	if (err < 0)
+		goto failed;
+
+	err = new_settings(hdev, sk);
+
+failed:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -2780,6 +2854,7 @@ static const struct mgmt_handler {
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
 	{ set_controller_data,    true,  MGMT_SET_CONTROLLER_DATA_SIZE },
 	{ unset_controller_data,  false, MGMT_UNSET_CONTROLLER_DATA_SIZE },
+	{ set_broadcaster,        false, MGMT_SETTING_SIZE },
 };
 
 
-- 
1.7.11.4

