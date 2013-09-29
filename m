Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Add command for setting static address
Date: Sun, 29 Sep 2013 01:05:37 -0700
Message-Id: <1380441937-55298-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add command for setting static address for use as LE random address.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |  2 ++
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  6 ++++++
 net/bluetooth/hci_core.c         |  5 +++++
 net/bluetooth/mgmt.c             | 43 +++++++++++++++++++++++++++++++++++++++-
 5 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7ede266..809bdf8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -977,6 +977,8 @@ struct hci_rp_le_read_local_features {
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
index 421d763..823ec2d 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -354,6 +354,12 @@ struct mgmt_cp_set_device_id {
 
 #define MGMT_OP_SET_ADVERTISING		0x0029
 
+#define MGMT_OP_SET_STATIC_ADDRESS	0x002B
+struct mgmt_cp_set_static_address {
+	bdaddr_t bdaddr;
+} __packed;
+#define MGMT_SET_STATIC_ADDRESS_SIZE	6
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4549b5c..3f1fb1b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -393,6 +393,11 @@ static void le_setup(struct hci_request *req)
 	/* LE-only controllers have LE implicitly enabled */
 	if (!lmp_bredr_capable(hdev))
 		set_bit(HCI_LE_ENABLED, &hdev->dev_flags);
+
+	/* Set random address to static address if configured */
+	if (bacmp(&hdev->static_addr, BDADDR_ANY))
+		hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
+			    &hdev->static_addr);
 }
 
 static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1b5b10f..fdc591b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -77,6 +77,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_UNBLOCK_DEVICE,
 	MGMT_OP_SET_DEVICE_ID,
 	MGMT_OP_SET_ADVERTISING,
+	MGMT_OP_SET_STATIC_ADDRESS,
 };
 
 static const u16 mgmt_events[] = {
@@ -3230,6 +3231,46 @@ unlock:
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
+				  MGMT_STATUS_BUSY);
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
@@ -3442,9 +3483,9 @@ static const struct mgmt_handler {
 	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
 	{ set_advertising,        false, MGMT_SETTING_SIZE },
+	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
 };
 
-
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	void *buf;
-- 
1.8.3.1

