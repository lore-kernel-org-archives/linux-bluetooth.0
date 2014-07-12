Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Read LE Advertising Channel TX Power only when available
Date: Sat, 12 Jul 2014 23:20:50 +0200
Message-Id: <1405200050-23210-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Read LE Advertising Channel TX Power command is not mandatory for
a Bluetooth HCI controller only supporting receiption. Move the command
to the third stage of the controller initialization and only execute it
when support for it has been indicated.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 347f84fb66f9..b29a984f7dd4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1348,9 +1348,6 @@ static void le_setup(struct hci_request *req)
 	/* Read LE Supported States */
 	hci_req_add(req, HCI_OP_LE_READ_SUPPORTED_STATES, 0, NULL);
 
-	/* Read LE Advertising Channel TX Power */
-	hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
-
 	/* Read LE White List Size */
 	hci_req_add(req, HCI_OP_LE_READ_WHITE_LIST_SIZE, 0, NULL);
 
@@ -1657,6 +1654,11 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 		hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
 			    events);
 
+		if (hdev->commands[25] & 0x40) {
+			/* Read LE Advertising Channel TX Power */
+			hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
+		}
+
 		hci_set_le_support(req);
 	}
 
-- 
1.9.3

