Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add management command for setting Device ID
Date: Sun, 11 Mar 2012 20:00:29 -0700
Message-Id: <1331521229-497-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Device ID details need to be programmed into the kernel for every
controller at least once. So provide management command for this.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |    9 +++++++++
 net/bluetooth/mgmt.c         |   26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index ffc1377..53b8a32 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -341,6 +341,15 @@ struct mgmt_cp_unblock_device {
 } __packed;
 #define MGMT_UNBLOCK_DEVICE_SIZE	MGMT_ADDR_INFO_SIZE
 
+#define MGMT_OP_SET_DEVICE_ID		0x0028
+struct mgmt_cp_set_device_id {
+	__le16	source;
+	__le16	vendor;
+	__le16	product;
+	__le16	version;
+} __packed;
+#define MGMT_SET_DEVICE_ID_SIZE		8
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2c09f0a..5aa2c9e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -78,6 +78,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_CONFIRM_NAME,
 	MGMT_OP_BLOCK_DEVICE,
 	MGMT_OP_UNBLOCK_DEVICE,
+	MGMT_OP_SET_DEVICE_ID,
 };
 
 static const u16 mgmt_events[] = {
@@ -2522,6 +2523,30 @@ static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
+			 u16 len)
+{
+	struct mgmt_cp_set_device_id *cp = data;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	hci_dev_lock(hdev);
+
+	hdev->devid_source = __le16_to_cpu(cp->source);
+	hdev->devid_vendor = __le16_to_cpu(cp->vendor);
+	hdev->devid_product = __le16_to_cpu(cp->product);
+	hdev->devid_version = __le16_to_cpu(cp->version);
+
+	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_ID, 0, NULL, 0);
+
+	update_eir(hdev);
+
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 				void *data, u16 len)
 {
@@ -2663,6 +2688,7 @@ struct mgmt_handler {
 	{ confirm_name,           false, MGMT_CONFIRM_NAME_SIZE },
 	{ block_device,           false, MGMT_BLOCK_DEVICE_SIZE },
 	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
+	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
 };
 
 
-- 
1.7.7.6

