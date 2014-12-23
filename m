Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix controller configuration with HCI_QUIRK_INVALID_BDADDR
Date: Tue, 23 Dec 2014 23:10:48 +0100
Message-Id: <1419372648-5111-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When controllers set the HCI_QUIRK_INVALID_BDADDR flag, it is required
by userspace to program a valid public Bluetooth device address into
the controller before it can be used.

After successful address configuration, the internal state changes and
the controller runs the complete initialization procedure. However one
small difference is that this is no longer the HCI_SETUP stage. The
HCI_SETUP stage is only valid during initial controller setup. In this
case the stack runs the initialization as part of the HCI_CONFIG stage.

The controller version information, default name and supported commands
are only stored during HCI_SETUP. While these information are static,
they are not read initially when HCI_QUIRK_INVALID_BDADDR is set. So
when running in HCI_CONFIG state, these information need to be updated
as well.

This especially impacts Bluetooth 4.1 and later controllers using
extended feature pages and second event mask page.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org # 3.17.x
---
 net/bluetooth/hci_event.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index eed44c643c0c..7926fd1d13de 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -244,7 +244,8 @@ static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 	if (rp->status)
 		return;
 
-	if (test_bit(HCI_SETUP, &hdev->dev_flags))
+	if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
+	    test_bit(HCI_CONFIG, &hdev->dev_flags))
 		memcpy(hdev->dev_name, rp->name, HCI_MAX_NAME_LENGTH);
 }
 
@@ -511,7 +512,8 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 	if (rp->status)
 		return;
 
-	if (test_bit(HCI_SETUP, &hdev->dev_flags)) {
+	if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
+	    test_bit(HCI_CONFIG, &hdev->dev_flags)) {
 		hdev->hci_ver = rp->hci_ver;
 		hdev->hci_rev = __le16_to_cpu(rp->hci_rev);
 		hdev->lmp_ver = rp->lmp_ver;
@@ -530,7 +532,8 @@ static void hci_cc_read_local_commands(struct hci_dev *hdev,
 	if (rp->status)
 		return;
 
-	if (test_bit(HCI_SETUP, &hdev->dev_flags))
+	if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
+	    test_bit(HCI_CONFIG, &hdev->dev_flags))
 		memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
 }
 
-- 
2.1.0

