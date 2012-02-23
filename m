Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: mgmt: Track pending class changes
Date: Thu, 23 Feb 2012 23:32:52 +0200
Message-Id: <1330032774-16206-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a flag to track pending changes to the class of device.
This is needed since we cannot cleanly handle multiple simultaneous
commands and need to return a "busy" error status in the mgmt commands
that might trigger a class change.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/mgmt.c        |   29 +++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c97cf08..05bd9ac 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -100,6 +100,7 @@ enum {
 	HCI_CONNECTABLE,
 	HCI_DISCOVERABLE,
 	HCI_LINK_SECURITY,
+	HCI_PENDING_CLASS,
 };
 
 /* HCI ioctl defines */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 79fe575..9f912dc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -570,6 +570,7 @@ static u8 get_service_classes(struct hci_dev *hdev)
 static int update_class(struct hci_dev *hdev)
 {
 	u8 cod[3];
+	int err;
 
 	BT_DBG("%s", hdev->name);
 
@@ -586,7 +587,11 @@ static int update_class(struct hci_dev *hdev)
 	if (memcmp(cod, hdev->dev_class, 3) == 0)
 		return 0;
 
-	return hci_send_cmd(hdev, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
+	err = hci_send_cmd(hdev, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
+	if (err == 0)
+		set_bit(HCI_PENDING_CLASS, &hdev->dev_flags);
+
+	return err;
 }
 
 static void service_cache_off(struct work_struct *work)
@@ -1344,6 +1349,12 @@ static int add_uuid(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
+	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
+		err = cmd_status(sk, index, MGMT_OP_ADD_UUID,
+							MGMT_STATUS_BUSY);
+		goto failed;
+	}
+
 	uuid = kmalloc(sizeof(*uuid), GFP_ATOMIC);
 	if (!uuid) {
 		err = -ENOMEM;
@@ -1393,6 +1404,12 @@ static int remove_uuid(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
+	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
+		err = cmd_status(sk, index, MGMT_OP_REMOVE_UUID,
+							MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
 	if (memcmp(cp->uuid, bt_uuid_any, 16) == 0) {
 		err = hci_uuids_clear(hdev);
 
@@ -1460,6 +1477,12 @@ static int set_dev_class(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
+	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS,
+							MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
 	hdev->major_class = cp->major;
 	hdev->minor_class = cp->minor;
 
@@ -3259,7 +3282,7 @@ int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	bacpy(&ev->addr.bdaddr, bdaddr);
 	ev->addr.type = link_to_mgmt(link_type, addr_type);
 
-	put_unaligned_le32(flags, &ev->flags);
+	ev->flags = __cpu_to_le32(flags);
 
 	if (name_len > 0)
 		eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE,
@@ -3614,6 +3637,8 @@ int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 {
 	int err;
 
+	clear_bit(HCI_PENDING_CLASS, &hdev->dev_flags);
+
 	err = mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev, dev_class, 3, NULL);
 
 	return err;
-- 
1.7.9

