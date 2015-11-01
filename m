Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Move BR/EDR default events behind its features
Date: Sun,  1 Nov 2015 09:39:49 +0100
Message-Id: <1446367191-67668-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are some BR/EDR default events for Bluetooth 1.2 or later
controllers that are not conditional on their features being present.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 62edbf1b114e..db423657935a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -531,10 +531,6 @@ static void hci_setup_event_mask(struct hci_request *req)
 
 	if (lmp_bredr_capable(hdev)) {
 		events[4] |= 0x01; /* Flow Specification Complete */
-		events[4] |= 0x02; /* Inquiry Result with RSSI */
-		events[4] |= 0x04; /* Read Remote Extended Features Complete */
-		events[5] |= 0x08; /* Synchronous Connection Complete */
-		events[5] |= 0x10; /* Synchronous Connection Changed */
 	} else {
 		/* Use a different default for LE-only devices */
 		memset(events, 0, sizeof(events));
@@ -555,6 +551,14 @@ static void hci_setup_event_mask(struct hci_request *req)
 	if (lmp_inq_rssi_capable(hdev))
 		events[4] |= 0x02; /* Inquiry Result with RSSI */
 
+	if (lmp_ext_feat_capable(hdev))
+		events[4] |= 0x04; /* Read Remote Extended Features Complete */
+
+	if (lmp_esco_capable(hdev)) {
+		events[5] |= 0x08; /* Synchronous Connection Complete */
+		events[5] |= 0x10; /* Synchronous Connection Changed */
+	}
+
 	if (lmp_sniffsubr_capable(hdev))
 		events[5] |= 0x20; /* Sniff Subrating */
 
-- 
2.4.3

