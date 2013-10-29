Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Set default own address type only during controller setup
Date: Tue, 29 Oct 2013 12:26:51 -0700
Message-Id: <1383074811-6623-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The default own address type is currently set at every power on of
a controller. This overwrites the value set via debugfs. To avoid
this issue, set the default own address type only during controller
setup.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6ccc4eb..03e8355 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1275,15 +1275,17 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 		hci_setup_link_policy(req);
 
 	if (lmp_le_capable(hdev)) {
-		/* If the controller has a public BD_ADDR, then by
-		 * default use that one. If this is a LE only
-		 * controller without one, default to the random
-		 * address.
-		 */
-		if (bacmp(&hdev->bdaddr, BDADDR_ANY))
-			hdev->own_addr_type = ADDR_LE_DEV_PUBLIC;
-		else
-			hdev->own_addr_type = ADDR_LE_DEV_RANDOM;
+		if (test_bit(HCI_SETUP, &hdev->dev_flags)) {
+			/* If the controller has a public BD_ADDR, then
+			 * by default use that one. If this is a LE only
+			 * controller without a public address, default
+			 * to the random address.
+			 */
+			if (bacmp(&hdev->bdaddr, BDADDR_ANY))
+				hdev->own_addr_type = ADDR_LE_DEV_PUBLIC;
+			else
+				hdev->own_addr_type = ADDR_LE_DEV_RANDOM;
+		}
 
 		hci_set_le_support(req);
 	}
-- 
1.8.3.1

