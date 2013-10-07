Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] Bluetooth: Make mgmt_device_found() return void
Date: Sun,  6 Oct 2013 23:55:51 -0700
Message-Id: <1381128953-32080-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_device_found() function is not used
and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  6 +++---
 net/bluetooth/mgmt.c             | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2b0bc31..5b738a2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1140,9 +1140,9 @@ int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 					    u8 *randomizer, u8 status);
-int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		      u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
-		      u8 ssp, u8 *eir, u16 eir_len);
+void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
+		       u8 ssp, u8 *eir, u16 eir_len);
 int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		     u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b9cd582..abf500b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4524,20 +4524,20 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 	return err;
 }
 
-int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		      u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name, u8
-		      ssp, u8 *eir, u16 eir_len)
+void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name, u8
+		       ssp, u8 *eir, u16 eir_len)
 {
 	char buf[512];
 	struct mgmt_ev_device_found *ev = (void *) buf;
 	size_t ev_size;
 
 	if (!hci_discovery_active(hdev))
-		return -EPERM;
+		return;
 
 	/* Leave 5 bytes for a potential CoD field */
 	if (sizeof(*ev) + eir_len + 5 > sizeof(buf))
-		return -EINVAL;
+		return;
 
 	memset(buf, 0, sizeof(buf));
 
@@ -4559,7 +4559,7 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev->eir_len = cpu_to_le16(eir_len);
 	ev_size = sizeof(*ev) + eir_len;
 
-	return mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
+	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
 }
 
 int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-- 
1.8.3.1

