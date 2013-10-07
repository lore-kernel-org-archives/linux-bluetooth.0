Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 9/9] Bluetooth: Make mgmt_discovering() return void
Date: Sun,  6 Oct 2013 23:55:53 -0700
Message-Id: <1381128953-32080-9-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_discovering() function is not used
and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/mgmt.c             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 960c64b..c065527 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1145,7 +1145,7 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 ssp, u8 *eir, u16 eir_len);
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
-int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
+void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4a4545e..4070bb0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4585,7 +4585,7 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, sizeof(*ev) + eir_len, NULL);
 }
 
-int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
+void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 {
 	struct mgmt_ev_discovering ev;
 	struct pending_cmd *cmd;
@@ -4609,7 +4609,7 @@ int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 	ev.type = hdev->discovery.type;
 	ev.discovering = discovering;
 
-	return mgmt_event(MGMT_EV_DISCOVERING, hdev, &ev, sizeof(ev), NULL);
+	mgmt_event(MGMT_EV_DISCOVERING, hdev, &ev, sizeof(ev), NULL);
 }
 
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
-- 
1.8.3.1

