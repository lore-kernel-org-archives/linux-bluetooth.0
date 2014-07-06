Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Skip unconfigured init procedure for raw-only devices
Date: Sun,  6 Jul 2014 13:43:20 +0200
Message-Id: <1404647000-44459-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the driver sets HCI_QUIRK_RAW_DEVICE, the controller will be set
as unconfigured. However running the unconfigured init procecure is
not useful since raw-only devices are not allowed to change its
configuration. This change skips the init procedure and just allows
user channel operation for this device.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b1d423efa109..fc7abd3c012d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1813,6 +1813,9 @@ static int __hci_unconf_init(struct hci_dev *hdev)
 {
 	int err;
 
+	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+		return 0;
+
 	err = __hci_req_sync(hdev, hci_init0_req, 0, HCI_INIT_TIMEOUT);
 	if (err < 0)
 		return err;
-- 
1.9.3

