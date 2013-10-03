Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Clear class of device when BR/EDR is disabled
Date: Wed,  2 Oct 2013 21:53:37 -0700
Message-Id: <1380776017-19489-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since it is possible to disable BR/EDR on dual-mode controllers, some
extra care needs to be taken for the class of device value. When BR/EDR
is disabled, the value should be set to its default. And properly
restored in case BR/EDR get re-enabled later on.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9dbf185..5c44e30 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -642,9 +642,15 @@ static void update_class(struct hci_request *req)
 	if (test_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		return;
 
-	cod[0] = hdev->minor_class;
-	cod[1] = hdev->major_class;
-	cod[2] = get_service_classes(hdev);
+	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+		cod[0] = hdev->minor_class;
+		cod[1] = hdev->major_class;
+		cod[2] = get_service_classes(hdev);
+	} else {
+		cod[0] = 0x00;
+		cod[1] = 0x00;
+		cod[2] = 0x00;
+	}
 
 	if (memcmp(cod, hdev->dev_class, 3) == 0)
 		return;
@@ -3523,12 +3529,16 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	}
 
 	/* We need to flip the bit already here so that hci_update_ad
-	 * generates the correct flags.
+	 * generates the correct flags and update_class sets the correct
+	 * class of device information.
 	 */
 	set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
 
 	hci_req_init(&req, hdev);
+
+	update_class(&req);
 	hci_update_ad(&req);
+
 	err = hci_req_run(&req, set_bredr_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
-- 
1.8.3.1

