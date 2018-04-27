Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org,
	Jeremy Cline <jcline@redhat.com>
Subject: [PATCH] Bluetooth: btusb: Only check needs_reset_resume DMI table for QCA rome chipsets
Date: Fri, 27 Apr 2018 11:26:43 +0200
Message-Id: <20180427092643.27140-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Jeremy Cline correctly points out in rhbz#1514836 that a device where the
QCA rome chipset needs the USB_QUIRK_RESET_RESUME quirk, may also ship
with a different wifi/bt chipset in some configurations.

If that is the case then we are needlessly penalizing those other chipsets
with a reset-resume quirk, typically causing 0.4W extra power use because
this disables runtime-pm.

This commit moves the DMI table check to a btusb_check_needs_reset_resume()
helper (so that we can easily also call it for other chipsets) and calls
this new helper only for QCA_ROME chipsets for now.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
Cc: stable@vger.kernel.org
Cc: Jeremy Cline <jcline@redhat.com>
Suggested-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btusb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f064984c9ec0..15e7cdca6eb5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2863,6 +2863,12 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 }
 #endif
 
+static void btusb_check_needs_reset_resume(struct usb_interface *intf)
+{
+	if (dmi_check_system(btusb_needs_reset_resume_table))
+		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
+}
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -2985,9 +2991,6 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
 
-	if (dmi_check_system(btusb_needs_reset_resume_table))
-		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
-
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
 	if (err)
@@ -3076,6 +3079,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+		btusb_check_needs_reset_resume(intf);
 	}
 
 #ifdef CONFIG_BT_HCIBTUSB_RTL
-- 
2.17.0
