Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Do not trigger background scanning when HCI_AUTO_OFF is set
Date: Tue,  1 Jul 2014 19:28:23 +0200
Message-Id: <1404235704-10483-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a new controller is initialized, but not powered from userspace
at the moment, the HCI_AUTO_OFF flag is still set. During this period,
userspace might program device for auto-connection, but never power
on the controller. In this case do not try to start background
scanning and leave it for later to be started.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0aa392406629..25ed6d3de410 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5306,6 +5306,7 @@ void hci_update_background_scan(struct hci_dev *hdev)
 	if (!test_bit(HCI_UP, &hdev->flags) ||
 	    test_bit(HCI_INIT, &hdev->flags) ||
 	    test_bit(HCI_SETUP, &hdev->dev_flags) ||
+	    test_bit(HCI_AUTO_OFF, &hdev->dev_flags) ||
 	    test_bit(HCI_UNREGISTER, &hdev->dev_flags))
 		return;
 
-- 
1.9.3

