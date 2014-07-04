Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Fix quirks that are valid during setup driver callback
Date: Fri,  4 Jul 2014 17:23:34 +0200
Message-Id: <1404487415-15089-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For the quirks that are allow to be set during setup callback, the
check needs to be modified so that they are applied even if no
setup callback provided by the driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c007b3543e70..b29f3938e6b3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2246,9 +2246,16 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	atomic_set(&hdev->cmd_cnt, 1);
 	set_bit(HCI_INIT, &hdev->flags);
 
-	if (hdev->setup && test_bit(HCI_SETUP, &hdev->dev_flags)) {
-		ret = hdev->setup(hdev);
+	if (test_bit(HCI_SETUP, &hdev->dev_flags)) {
+		if (hdev->setup)
+			ret = hdev->setup(hdev);
 
+		/* The transport driver can set these quirks before
+		 * creating the HCI device or in its setup callback.
+		 *
+		 * In case any of them is set, the controller has to
+		 * start up as unconfigured.
+		 */
 		if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
 		    test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks))
 			set_bit(HCI_UNCONFIGURED, &hdev->dev_flags);
-- 
1.9.3

