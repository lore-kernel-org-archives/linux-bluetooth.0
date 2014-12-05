Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: Enable events for P-256 Public Key and DHKey commands
Date: Fri,  5 Dec 2014 16:20:15 +0100
Message-Id: <1417792815-55907-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the LE Read Local P-256 Public Key command is supported, then
enable its corresponding complete event. And when the LE Generate DHKey
command is supported, enable its corresponding complete event as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c1d5726cb8c9..93f92a085506 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1743,6 +1743,20 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 						 * Report
 						 */
 
+		/* If the controller supports the LE Read Local P-256
+		 * Public Key command, enable the corresponding event.
+		 */
+		if (hdev->commands[34] & 0x02)
+			events[0] |= 0x80;	/* LE Read Local P-256
+						 * Public Key Complete
+						 */
+
+		/* If the controller supports the LE Generate DHKey
+		 * command, enable the corresponding event.
+		 */
+		if (hdev->commands[34] & 0x04)
+			events[1] |= 0x01;	/* LE Generate DHKey Complete */
+
 		hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
 			    events);
 
-- 
1.9.3

