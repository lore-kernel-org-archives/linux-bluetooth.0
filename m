Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Make mgmt_new_link_key() return void
Date: Tue, 15 Oct 2013 10:15:57 -0700
Message-Id: <1381857357-45105-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_new_link_key() function is not used
and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 4 ++--
 net/bluetooth/mgmt.c             | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index da21a8d..cf6be04 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1103,8 +1103,8 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered);
 void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
 void mgmt_connectable(struct hci_dev *hdev, u8 connectable);
 void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
-int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
-		      bool persistent);
+void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
+		       bool persistent);
 void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			   u8 addr_type, u32 flags, u8 *name, u8 name_len,
 			   u8 *dev_class);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c700940..6fb302e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4341,8 +4341,8 @@ void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
 				     cmd_status_rsp, &mgmt_err);
 }
 
-int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
-		      bool persistent)
+void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
+		       bool persistent)
 {
 	struct mgmt_ev_new_link_key ev;
 
@@ -4355,7 +4355,7 @@ int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 	memcpy(ev.key.val, key->val, HCI_LINK_KEY_SIZE);
 	ev.key.pin_len = key->pin_len;
 
-	return mgmt_event(MGMT_EV_NEW_LINK_KEY, hdev, &ev, sizeof(ev), NULL);
+	mgmt_event(MGMT_EV_NEW_LINK_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
 int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent)
-- 
1.8.3.1

