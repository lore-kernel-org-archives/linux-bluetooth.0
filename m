Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Clear all LE white list entries when powering controller
Date: Thu, 27 Feb 2014 20:37:29 -0800
Message-Id: <1393562251-7555-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When starting up a controller make sure that all LE white list entries
are cleared. Normally the HCI Reset takes care of this. This is just
in case no HCI Reset has been executed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b0aa4eaa4660..c6cbe78e685f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1346,14 +1346,17 @@ static void le_setup(struct hci_request *req)
 	/* Read LE Local Supported Features */
 	hci_req_add(req, HCI_OP_LE_READ_LOCAL_FEATURES, 0, NULL);
 
+	/* Read LE Supported States */
+	hci_req_add(req, HCI_OP_LE_READ_SUPPORTED_STATES, 0, NULL);
+
 	/* Read LE Advertising Channel TX Power */
 	hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
 
 	/* Read LE White List Size */
 	hci_req_add(req, HCI_OP_LE_READ_WHITE_LIST_SIZE, 0, NULL);
 
-	/* Read LE Supported States */
-	hci_req_add(req, HCI_OP_LE_READ_SUPPORTED_STATES, 0, NULL);
+	/* Clear LE White List */
+	hci_req_add(req, HCI_OP_LE_CLEAR_WHITE_LIST, 0, NULL);
 
 	/* LE-only controllers have LE implicitly enabled */
 	if (!lmp_bredr_capable(hdev))
-- 
1.8.5.3

