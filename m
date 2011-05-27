Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH] Bluetooth: Do not send SET_EVENT_MASK for 1.1 and earlier devices
Date: Fri, 27 May 2011 11:16:21 +0300
Message-Id: <1306484181-2615-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some old hci controllers do not accept any mask so leave the
default mask on for these devices.

< HCI Command: Set Event Mask (0x03|0x0001) plen 8
    Mask: 0xfffffbff00000000
> HCI Event: Command Complete (0x0e) plen 4
    Set Event Mask (0x03|0x0001) ncmd 1
    status 0x12
    Error: Invalid HCI Command Parameters

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/hci_event.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f13ddbf..77930aa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -477,14 +477,16 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 	 * command otherwise */
 	u8 events[8] = { 0xff, 0xff, 0xfb, 0xff, 0x00, 0x00, 0x00, 0x00 };
 
-	/* Events for 1.2 and newer controllers */
-	if (hdev->lmp_ver > 1) {
-		events[4] |= 0x01; /* Flow Specification Complete */
-		events[4] |= 0x02; /* Inquiry Result with RSSI */
-		events[4] |= 0x04; /* Read Remote Extended Features Complete */
-		events[5] |= 0x08; /* Synchronous Connection Complete */
-		events[5] |= 0x10; /* Synchronous Connection Changed */
-	}
+	/* CSR 1.1 dongles does not accept any bitfield so don't try to set
+	 * any event mask for pre 1.2 devices */
+	if (hdev->lmp_ver <= 1)
+		return;
+
+	events[4] |= 0x01; /* Flow Specification Complete */
+	events[4] |= 0x02; /* Inquiry Result with RSSI */
+	events[4] |= 0x04; /* Read Remote Extended Features Complete */
+	events[5] |= 0x08; /* Synchronous Connection Complete */
+	events[5] |= 0x10; /* Synchronous Connection Changed */
 
 	if (hdev->features[3] & LMP_RSSI_INQ)
 		events[4] |= 0x04; /* Inquiry Result with RSSI */
-- 
1.7.4.4

