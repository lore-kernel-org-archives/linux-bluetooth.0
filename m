Return-Path: <kai.heng.feng@canonical.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: acelan.kao@canonical.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] Bluetooth: btusb: Disable Bluetooth controller during S3
Date: Tue, 31 Jul 2018 15:37:57 +0800
Message-Id: <20180731073757.14561-1-kai.heng.feng@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We've found there are several systems got woken up from S3 by Bluetooth
controller.

We do want the system to be able to be woken up by Bluetooth devices
from Suspend2Idle, but not from S3.

Unconditionally disables Bluetooth controller during S3 to avoid this
issue.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199451
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200039
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 572fd75fbcf6..60f2832c4ff2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3290,6 +3290,9 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 		enable_irq(data->oob_wake_irq);
 	}
 
+	if (!PMSG_IS_AUTO(message) && pm_suspend_via_firmware())
+		interface_to_usbdev(intf)->quirks |= USB_QUIRK_DISCONNECT_SUSPEND;
+
 	return 0;
 }
 
@@ -3334,6 +3337,9 @@ static int btusb_resume(struct usb_interface *intf)
 	if (--data->suspend_count)
 		return 0;
 
+	if (pm_resume_via_firmware())
+		interface_to_usbdev(intf)->quirks &= ~USB_QUIRK_DISCONNECT_SUSPEND;
+
 	/* Disable only if not already disabled (keep it balanced) */
 	if (test_and_clear_bit(BTUSB_OOB_WAKE_ENABLED, &data->flags)) {
 		disable_irq(data->oob_wake_irq);
-- 
2.17.1
