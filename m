Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: Enabled LE Direct Advertising Report event if supported
Date: Fri,  5 Dec 2014 16:20:12 +0100
Message-Id: <1417792815-55907-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the controller supports the Extended Scanner Filter Policies, it
supports the LE Direct Advertising Report event. However by default
that event is blocked by the LE event mask. It is required to enable
it during controller setup.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 1 +
 net/bluetooth/hci_core.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ffebd393af4f..40129b3838b2 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -343,6 +343,7 @@ enum {
 #define HCI_LE_ENCRYPTION		0x01
 #define HCI_LE_CONN_PARAM_REQ_PROC	0x02
 #define HCI_LE_PING			0x10
+#define HCI_LE_EXT_SCAN_POLICY		0x80
 
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 523700eefdd1..da8969e08b0c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1735,6 +1735,14 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 						 * Parameter Request
 						 */
 
+		/* If the controller supports Extended Scanner Filter
+		 * Policies, enable the correspondig event.
+		 */
+		if (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY)
+			events[1] |= 0x04;	/* LE Direct Advertising
+						 * Report
+						 */
+
 		hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
 			    events);
 
-- 
1.9.3

