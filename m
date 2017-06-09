Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Send HCI Set Event Mask Page 2 command only when needed
Date: Fri,  9 Jun 2017 18:11:09 +0200
Message-Id: <20170609161109.4475-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7655b4005dfb..b7f3a0e5835e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -548,6 +548,7 @@ static void hci_set_event_mask_page_2(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	u8 events[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	bool changed = false;
 
 	/* If Connectionless Slave Broadcast master role is supported
 	 * enable all necessary events for it.
@@ -557,6 +558,7 @@ static void hci_set_event_mask_page_2(struct hci_request *req)
 		events[1] |= 0x80;	/* Synchronization Train Complete */
 		events[2] |= 0x10;	/* Slave Page Response Timeout */
 		events[2] |= 0x20;	/* CSB Channel Map Change */
+		changed = true;
 	}
 
 	/* If Connectionless Slave Broadcast slave role is supported
@@ -567,13 +569,24 @@ static void hci_set_event_mask_page_2(struct hci_request *req)
 		events[2] |= 0x02;	/* CSB Receive */
 		events[2] |= 0x04;	/* CSB Timeout */
 		events[2] |= 0x08;	/* Truncated Page Complete */
+		changed = true;
 	}
 
 	/* Enable Authenticated Payload Timeout Expired event if supported */
-	if (lmp_ping_capable(hdev) || hdev->le_features[0] & HCI_LE_PING)
+	if (lmp_ping_capable(hdev) || hdev->le_features[0] & HCI_LE_PING) {
 		events[2] |= 0x80;
+		changed = true;
+	}
 
-	hci_req_add(req, HCI_OP_SET_EVENT_MASK_PAGE_2, sizeof(events), events);
+	/* Some Broadcom based controllers indicate support for Set Event
+	 * Mask Page 2 command, but then actually do not support it. Since
+	 * the default value is all bits set to zero, the command is only
+	 * required if the event mask has to be changed. In case no change
+	 * to the event mask is needed, then skip this command.
+	 */
+	if (changed)
+		hci_req_add(req, HCI_OP_SET_EVENT_MASK_PAGE_2,
+			    sizeof(events), events);
 }
 
 static int hci_init3_req(struct hci_request *req, unsigned long opt)
-- 
2.9.4

