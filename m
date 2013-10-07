Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Read flow control mode on AMP controller init
Date: Mon,  7 Oct 2013 03:55:53 -0700
Message-Id: <1381143353-57149-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When initializing an AMP controller, read its current flow control
mode so that the correct value is used.

The AMP controller defaults to block based flow control and this
extra command is just to double check.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 967739c..0c636ba 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -319,6 +319,9 @@ static void amp_init(struct hci_request *req)
 	/* Read Data Blk size */
 	hci_req_add(req, HCI_OP_READ_DATA_BLOCK_SIZE, 0, NULL);
 
+	/* Read Flow Control Mode */
+	hci_req_add(req, HCI_OP_READ_FLOW_CONTROL_MODE, 0, NULL);
+
 	/* Read Location Data */
 	hci_req_add(req, HCI_OP_READ_LOCATION_DATA, 0, NULL);
 }
-- 
1.8.3.1

