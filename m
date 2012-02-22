Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Send management event for class of device changes
Date: Wed, 22 Feb 2012 18:38:01 +0100
Message-Id: <1329932281-15409-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently there are no events to other management sockets if the class of
device got changed. So make sure they are sent.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |   13 +++++++++----
 net/bluetooth/mgmt.c             |    9 +++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index abdaa79..ee99b30 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1007,6 +1007,7 @@ int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 						u8 addr_type, u8 status);
 int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
 int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
+int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class, u8 status);
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 						u8 *randomizer, u8 status);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e44e3fd..c79ffb9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -350,14 +350,19 @@ static void hci_cc_write_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (status)
-		return;
-
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_CLASS_OF_DEV);
 	if (!sent)
 		return;
 
-	memcpy(hdev->dev_class, sent, 3);
+	hci_dev_lock(hdev);
+
+	if (status == 0)
+		memcpy(hdev->dev_class, sent, 3);
+
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+		mgmt_set_class_of_dev_complete(hdev, sent, status);
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_cc_read_voice_setting(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f7e111f..c6e149d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3546,6 +3546,15 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	return err;
 }
 
+int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class, u8 status)
+{
+	int err;
+
+	err = mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev, dev_class, 3, NULL);
+
+	return err;
+}
+
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 {
 	struct pending_cmd *cmd;
-- 
1.7.7.6

