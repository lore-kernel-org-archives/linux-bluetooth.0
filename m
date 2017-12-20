Return-Path: <kai.heng.feng@canonical.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: gregkh@linuxfoundation.org,
	marcel@holtmann.org
Cc: linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	stable@vger.kernel.org,
	Leif Liddy <leif.linux@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Daniel Drake <drake@endlessm.com>
Subject: [PATCH 2/2] usb: quirks: Add reset-resume quirk for Dell DW1820 QCA Rome Bluetooth
Date: Wed, 20 Dec 2017 19:00:08 +0800
Message-Id: <20171220110008.11856-2-kai.heng.feng@canonical.com>
In-Reply-To: <20171220110008.11856-1-kai.heng.feng@canonical.com>
References: <20171220110008.11856-1-kai.heng.feng@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Commit ("fd865802c66bc451dc515ed89360f84376ce1a56 Bluetooth: btusb: fix
QCA Rome suspend/resume") enables reset_resume in btusb_probe(). This
makes the device resets during btusb_open(), firmware loading gets
interrupted as a result.

We still want to reset the device to solve the original issue, but we
should do it before btusb_open().

Hence, add reset-resume quirk in usb core intead of btusb.

Cc: stable@vger.kernel.org
Cc: Leif Liddy <leif.linux@gmail.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Daniel Drake <drake@endlessm.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index a10b346b9777..96951104c45b 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -197,6 +197,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0b05, 0x17e0), .driver_info =
 			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
 
+	/* QCA Rome Bluetooth in Dell DW1820 wireless module */
+	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	/* Action Semiconductor flash disk */
 	{ USB_DEVICE(0x10d6, 0x2200), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
-- 
2.14.1
