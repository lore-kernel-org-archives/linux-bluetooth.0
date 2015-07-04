Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: hci_uart: Add Intel address and hardware error handlers
Date: Sat,  4 Jul 2015 15:15:23 +0200
Message-Id: <1436015723-43145-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel specific Bluetooth module provides support for pubic address
configuration and hardware error handling. So make sure that they are
enabled for Intel UART devices.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 378b6b95e6ce..49da2a7dccc4 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -175,6 +175,9 @@ static int intel_setup(struct hci_uart *hu)
 
 	BT_DBG("%s", hdev->name);
 
+	hu->hdev->hw_error = btintel_hw_error;
+	hu->hdev->set_bdaddr = btintel_set_bdaddr;
+
 	calltime = ktime_get();
 
 	set_bit(STATE_BOOTLOADER, &intel->flags);
-- 
2.4.3

