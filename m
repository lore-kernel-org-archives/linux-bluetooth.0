Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Allow HCI User Channel usage for controllers without address
Date: Mon, 17 Feb 2014 09:21:19 -0800
Message-Id: <1392657679-32983-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Trying to setup HCI User Channel usage for LE only controllers without
a public address or configured static address will fail with an error
saying that no address is available.

In case of HCI User Channel the requirement for a valid address is not
needed. So allow skipping this extra validation step.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 58d2f9bf241f..b40d52446f8f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1937,10 +1937,15 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		 * be able to determine if there is a public address
 		 * or not.
 		 *
+		 * In case of user channel usage, it is not important
+		 * if a public address or static random address is
+		 * available.
+		 *
 		 * This check is only valid for BR/EDR controllers
 		 * since AMP controllers do not have an address.
 		 */
-		if (hdev->dev_type == HCI_BREDR &&
+		if (!test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) &&
+		    hdev->dev_type == HCI_BREDR &&
 		    !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
 		    !bacmp(&hdev->static_addr, BDADDR_ANY)) {
 			ret = -EADDRNOTAVAIL;
-- 
1.8.5.3

