Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Enable LE Channel Selection Algorithm event
Date: Mon,  1 May 2017 23:54:17 -0700
Message-Id: <20170502065419.7959-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the Channel Selection Algorithm #2 feature is supported, then enable
the new LE Channel Selection Algorithm event.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 1 +
 net/bluetooth/hci_core.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 99aa5e5e3100..dd43cfdd443a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -399,6 +399,7 @@ enum {
 #define HCI_LE_PING			0x10
 #define HCI_LE_DATA_LEN_EXT		0x20
 #define HCI_LE_EXT_SCAN_POLICY		0x80
+#define HCI_LE_CHAN_SEL_ALG2		0x40
 
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4a0cac774107..e58b9034afff 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -635,6 +635,14 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 						 * Report
 						 */
 
+		/* If the controller supports Channel Selection Algorithm #2
+		 * feature, enable the corresponding event.
+		 */
+		if (hdev->le_features[1] & HCI_LE_CHAN_SEL_ALG2)
+			events[2] |= 0x08;	/* LE Channel Selection
+						 * Algorithm
+						 */
+
 		/* If the controller supports the LE Set Scan Enable command,
 		 * enable the corresponding advertising report event.
 		 */
-- 
2.9.3

