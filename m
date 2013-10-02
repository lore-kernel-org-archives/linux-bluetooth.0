Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add management command for setting static address
Date: Wed,  2 Oct 2013 04:41:30 -0700
Message-Id: <1380714090-11609-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On dual-mode BR/EDR/LE and LE only controllers it is possible
to configure a random address. There are two types or random
addresses, one is static and the other private. Since the
random private addresses require special privacy feature to
be supported, the configuration of these two are kept separate.

This command allows for setting the static random address. It is
only supported on controllers with LE support. The static random
address is suppose to be valid for the lifetime of the controller
or at least until the next power cycle. To ensure such behavior,
setting of the address is limited to when the controller is
powered off.

The special BDADDR_ANY address (00:00:00:00:00:00) can be used to
disable the static address. This is also the default value.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |  2 ++
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  6 +++++
 net/bluetooth/mgmt.c             | 49 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4fa08d7..d7fd825 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -978,6 +978,8 @@ struct hci_rp_le_read_local_features {
 	__u8     features[8];
 } __packed;
 
+#define HCI_OP_LE_SET_RANDOM_ADDR	0x2005
+
 #define HCI_OP_LE_READ_ADV_TX_POWER	0x2007
 struct hci_rp_le_read_adv_tx_power {
 	__u8	status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 26cc9f7..e09c305 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -140,6 +140,7 @@ struct hci_dev {
 	__u8		bus;
 	__u8		dev_type;
 	bdaddr_t	bdaddr;
+	bdaddr_t	static_addr;
 	__u8		dev_name[HCI_MAX_NAME_LENGTH];
 	__u8		short_name[HCI_MAX_SHORT_NAME_LENGTH];
 	__u8		eir[HCI_MAX_EIR_LENGTH];
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 7347df8..2ad433bb 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -356,6 +356,12 @@ struct mgmt_cp_set_device_id {
 
 #define MGMT_OP_SET_BREDR		0x002A
 
+#define MGMT_OP_SET_STATIC_ADDRESS	0x002B
+struct mgmt_cp_set_static_address {
+	bdaddr_t bdaddr;
+} __packed;
+#define MGMT_SET_STATIC_ADDRESS_SIZE	6
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4ac3169..b871632 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -76,6 +76,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_DEVICE_ID,
 	MGMT_OP_SET_ADVERTISING,
 	MGMT_OP_SET_BREDR,
+	MGMT_OP_SET_STATIC_ADDRESS,
 };
 
 static const u16 mgmt_events[] = {
@@ -3247,6 +3248,46 @@ unlock:
 	return err;
 }
 
+static int set_static_address(struct sock *sk, struct hci_dev *hdev,
+			      void *data, u16 len)
+{
+	struct mgmt_cp_set_static_address *cp = data;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!lmp_le_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	if (hdev_is_powered(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS,
+				  MGMT_STATUS_REJECTED);
+
+	if (bacmp(&cp->bdaddr, BDADDR_ANY)) {
+		if (!bacmp(&cp->bdaddr, BDADDR_NONE))
+			return cmd_status(sk, hdev->id,
+					  MGMT_OP_SET_STATIC_ADDRESS,
+					  MGMT_STATUS_INVALID_PARAMS);
+
+		/* Two most significant bits shall be set */
+		if ((cp->bdaddr.b[5] & 0xc0) != 0xc0)
+			return cmd_status(sk, hdev->id,
+					  MGMT_OP_SET_STATIC_ADDRESS,
+					  MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	hci_dev_lock(hdev);
+
+	bacpy(&hdev->static_addr, &cp->bdaddr);
+
+	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS, 0, NULL, 0);
+
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static void fast_connectable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
@@ -3576,6 +3617,7 @@ static const struct mgmt_handler {
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
 	{ set_advertising,        false, MGMT_SETTING_SIZE },
 	{ set_bredr,              false, MGMT_SETTING_SIZE },
+	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
 };
 
 
@@ -3762,6 +3804,13 @@ static int powered_update_hci(struct hci_dev *hdev)
 		hci_update_ad(&req);
 	}
 
+	if (lmp_le_capable(hdev)) {
+		/* Set random address to static address if configured */
+		if (bacmp(&hdev->static_addr, BDADDR_ANY))
+			hci_req_add(&req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
+				    &hdev->static_addr);
+	}
+
 	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags)) {
 		u8 adv = 0x01;
 
-- 
1.8.3.1

