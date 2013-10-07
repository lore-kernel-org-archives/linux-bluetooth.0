Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/9] Bluetooth: Make mgmt_device_connected() return void
Date: Sun,  6 Oct 2013 23:55:49 -0700
Message-Id: <1381128953-32080-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_device_connected() function is not used
and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  6 +++---
 net/bluetooth/mgmt.c             | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d982458..4856944 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1101,9 +1101,9 @@ int mgmt_connectable(struct hci_dev *hdev, u8 connectable);
 int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
 int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		      bool persistent);
-int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-			  u8 addr_type, u32 flags, u8 *name, u8 name_len,
-			  u8 *dev_class);
+void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+			   u8 addr_type, u32 flags, u8 *name, u8 name_len,
+			   u8 *dev_class);
 int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			     u8 link_type, u8 addr_type, u8 reason);
 void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bd32c43..9029e67 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4056,9 +4056,9 @@ int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent)
 			  NULL);
 }
 
-int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-			  u8 addr_type, u32 flags, u8 *name, u8 name_len,
-			  u8 *dev_class)
+void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+			   u8 addr_type, u32 flags, u8 *name, u8 name_len,
+			   u8 *dev_class)
 {
 	char buf[512];
 	struct mgmt_ev_device_connected *ev = (void *) buf;
@@ -4079,8 +4079,8 @@ int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	ev->eir_len = cpu_to_le16(eir_len);
 
-	return mgmt_event(MGMT_EV_DEVICE_CONNECTED, hdev, buf,
-			  sizeof(*ev) + eir_len, NULL);
+	mgmt_event(MGMT_EV_DEVICE_CONNECTED, hdev, buf,
+		    sizeof(*ev) + eir_len, NULL);
 }
 
 static void disconnect_rsp(struct pending_cmd *cmd, void *data)
-- 
1.8.3.1

