Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Enable LE PHY Update Complete event
Date: Mon,  1 May 2017 23:54:18 -0700
Message-Id: <20170502065419.7959-2-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If either LE Set Default PHY command or LE Set PHY commands is
supported, then enable the LE PHY Update Complete event.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e58b9034afff..88a616a2b959 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -685,6 +685,12 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 		if (hdev->commands[34] & 0x04)
 			events[1] |= 0x01;	/* LE Generate DHKey Complete */
 
+		/* If the controller supports the LE Set Default PHY or
+		 * LE Set PHY commands, enable the corresponding event.
+		 */
+		if (hdev->commands[35] & (0x20 | 0x40))
+			events[1] |= 0x08;        /* LE PHY Update Complete */
+
 		hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
 			    events);
 
-- 
2.9.3

