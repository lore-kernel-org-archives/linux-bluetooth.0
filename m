Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: hci_uart: Add Intel address configuration support
Date: Sun,  5 Jul 2015 14:37:40 +0200
Message-Id: <1436099860-77732-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel specific Bluetooth module provides support for pubic address
configuration. So make sure that it is enabled for Intel UART devices.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index ade19aaeb5c5..06398cc0d95c 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -175,6 +175,8 @@ static int intel_setup(struct hci_uart *hu)
 
 	BT_DBG("%s", hdev->name);
 
+	hu->hdev->set_bdaddr = btintel_set_bdaddr;
+
 	calltime = ktime_get();
 
 	set_bit(STATE_BOOTLOADER, &intel->flags);
-- 
2.4.3

