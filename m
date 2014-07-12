Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Enable LE encryption events only when supported
Date: Sat, 12 Jul 2014 23:36:16 +0200
Message-Id: <1405200976-27292-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The support for LE encryption is optional. When encryption is not
supported then also do not enable the encryption related events.

This moves the event mask setting to the third initialization
stage to ensure that the LE features are available.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_core.c    | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7f754a246ca5..2fee852816ee 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -329,6 +329,7 @@ enum {
 #define LMP_HOST_SC		0x08
 
 /* LE features */
+#define HCI_LE_ENCRYPTION		0x01
 #define HCI_LE_CONN_PARAM_REQ_PROC	0x02
 #define HCI_LE_PING			0x10
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b29a984f7dd4..ff150e3c7ad1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1422,14 +1422,17 @@ static void hci_setup_event_mask(struct hci_request *req)
 		/* Use a different default for LE-only devices */
 		memset(events, 0, sizeof(events));
 		events[0] |= 0x10; /* Disconnection Complete */
-		events[0] |= 0x80; /* Encryption Change */
 		events[1] |= 0x08; /* Read Remote Version Information Complete */
 		events[1] |= 0x20; /* Command Complete */
 		events[1] |= 0x40; /* Command Status */
 		events[1] |= 0x80; /* Hardware Error */
 		events[2] |= 0x04; /* Number of Completed Packets */
 		events[3] |= 0x02; /* Data Buffer Overflow */
-		events[5] |= 0x80; /* Encryption Key Refresh Complete */
+
+		if (hdev->le_features[0] & HCI_LE_ENCRYPTION) {
+			events[0] |= 0x80; /* Encryption Change */
+			events[5] |= 0x80; /* Encryption Key Refresh Complete */
+		}
 	}
 
 	if (lmp_inq_rssi_capable(hdev))
@@ -1482,8 +1485,6 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
 	if (lmp_le_capable(hdev))
 		le_setup(req);
 
-	hci_setup_event_mask(req);
-
 	/* AVM Berlin (31), aka "BlueFRITZ!", doesn't support the read
 	 * local supported commands HCI command.
 	 */
@@ -1611,6 +1612,8 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 	struct hci_dev *hdev = req->hdev;
 	u8 p;
 
+	hci_setup_event_mask(req);
+
 	/* Some Broadcom based Bluetooth controllers do not support the
 	 * Delete Stored Link Key command. They are clearly indicating its
 	 * absence in the bit mask of supported commands.
-- 
1.9.3

