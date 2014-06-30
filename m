Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Start background scanning only when controller is ready
Date: Mon, 30 Jun 2014 16:04:12 +0200
Message-Id: <1404137052-15424-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the controller is not active or in init/setup phase, do not
try to start or stop background scanning.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index adea7de95633..2312e77582b0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5317,7 +5317,10 @@ void hci_update_background_scan(struct hci_dev *hdev)
 	struct hci_conn *conn;
 	int err;
 
-	if (test_bit(HCI_UNREGISTER, &hdev->dev_flags))
+	if (!test_bit(HCI_UP, &hdev->flags) ||
+	    test_bit(HCI_INIT, &hdev->flags) ||
+	    test_bit(HCI_SETUP, &hdev->dev_flags) ||
+	    test_bit(HCI_UNREGISTER, &hdev->dev_flags))
 		return;
 
 	hci_req_init(&req, hdev);
-- 
1.9.3

