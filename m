Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Rename mgmt_inquiry_failed()
Date: Wed,  9 Nov 2011 17:14:25 -0300
Message-Id: <1320869667-1373-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames the function mgmt_inquiry_failed() to
mgmt_start_discovery_failed(). This function is more related
to MGMT_OP_START_DISCOVERY command handling than to inquiry.
Besides, this functions will be reused by LE based discovery
procedures in case of failure.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_event.c        |    2 +-
 net/bluetooth/mgmt.c             |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0a5a05d..a1c7bea 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -938,7 +938,7 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type,
 					u8 *dev_class, s8 rssi, u8 *eir);
 int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name);
-int mgmt_inquiry_failed(struct hci_dev *hdev, u8 status);
+int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a89cf1f..0c10780 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1014,7 +1014,7 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		hci_conn_check_pending(hdev);
 		hci_dev_lock(hdev);
 		if (test_bit(HCI_MGMT, &hdev->flags))
-			mgmt_inquiry_failed(hdev, status);
+			mgmt_start_discovery_failed(hdev, status);
 		hci_dev_unlock(hdev);
 		return;
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a6720c6..ec89997 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2374,7 +2374,7 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name)
 	return mgmt_event(MGMT_EV_REMOTE_NAME, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_inquiry_failed(struct hci_dev *hdev, u8 status)
+int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
 	int err;
-- 
1.7.7.1

