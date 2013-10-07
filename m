Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/9] Bluetooth: Make mgmt_remote_name() return void
Date: Sun,  6 Oct 2013 23:55:52 -0700
Message-Id: <1381128953-32080-8-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_remote_name() function is not used
and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 4 ++--
 net/bluetooth/mgmt.c             | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5b738a2..960c64b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1143,8 +1143,8 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
 		       u8 ssp, u8 *eir, u16 eir_len);
-int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		     u8 addr_type, s8 rssi, u8 *name, u8 name_len);
+void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index abf500b..4a4545e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4562,8 +4562,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
 }
 
-int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		     u8 addr_type, s8 rssi, u8 *name, u8 name_len)
+void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+		      u8 addr_type, s8 rssi, u8 *name, u8 name_len)
 {
 	struct mgmt_ev_device_found *ev;
 	char buf[sizeof(*ev) + HCI_MAX_NAME_LENGTH + 2];
@@ -4582,8 +4582,7 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	ev->eir_len = cpu_to_le16(eir_len);
 
-	return mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev,
-			  sizeof(*ev) + eir_len, NULL);
+	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, sizeof(*ev) + eir_len, NULL);
 }
 
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
-- 
1.8.3.1

