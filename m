Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Rename mgmt_inquiry_failed()
Date: Tue,  8 Nov 2011 19:40:01 -0300
Message-Id: <1320792002-31151-1-git-send-email-andre.guedes@openbossa.org>
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
index e6071d0..4e00ae0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -931,7 +931,7 @@ int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 type, u8 *dev_class,
 							s8 rssi, u8 *eir);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
-int mgmt_inquiry_failed(u16 index, u8 status);
+int mgmt_start_discovery_failed(u16 index, u8 status);
 int mgmt_discovering(u16 index, u8 discovering);
 int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr);
 int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2fced8c..e29a3b1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -986,7 +986,7 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 		hci_conn_check_pending(hdev);
 		if (test_bit(HCI_MGMT, &hdev->flags))
-			mgmt_inquiry_failed(hdev->id, status);
+			mgmt_start_discovery_failed(hdev->id, status);
 		return;
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4cb2f95..dc938dc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2379,7 +2379,7 @@ int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name)
 	return mgmt_event(MGMT_EV_REMOTE_NAME, index, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_inquiry_failed(u16 index, u8 status)
+int mgmt_start_discovery_failed(u16 index, u8 status)
 {
 	struct pending_cmd *cmd;
 	int err;
-- 
1.7.7.1

