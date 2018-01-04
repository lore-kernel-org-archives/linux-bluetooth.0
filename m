Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Disable autosuspend on QCA Rome devices
Date: Thu,  4 Jan 2018 09:51:54 +0100
Message-Id: <20180104085154.31377-1-hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commit fd865802c66b ("Bluetooth: btusb: fix QCA Rome suspend/resume") fixes
a suspend/resume problem on QCA devices by doing a full reset on resume,
reloading the firmware.

A similar problem happens when using runtime-pm / autosuspend, when this is
enabled by the user the QCA Rome device stops working. Reloading the
firmware after a runtime suspend is not really an option since the latency
caused by this is unacceptable.

To fix the runtime-pm issues, this commit disables runtime-pm on QCA Rome
HCIs, by getting (and not releasing) an usb autopm reference on the btusb
interface.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 808c249845db..6ed3a0e5b8f6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3122,8 +3122,15 @@ static int btusb_probe(struct usb_interface *intf,
 		/* QCA Rome devices lose their updated firmware over suspend,
 		 * but the USB hub doesn't notice any status change.
 		 * Explicitly request a device reset on resume.
+		 * And disable runtime pm by getting a pm reference, the USB
+		 * core will drop our reference on disconnect.
 		 */
 		set_bit(BTUSB_RESET_RESUME, &data->flags);
+		err = usb_autopm_get_interface(data->intf);
+		if (err < 0) {
+			BT_ERR("failed to get pm reference %d", err);
+			goto out_free_dev;
+		}
 	}
 
 #ifdef CONFIG_BT_HCIBTUSB_RTL
-- 
2.14.3

