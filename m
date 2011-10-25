Return-Path: <cyrus@holtmann.org>
Message-ID: <4EA67552.1090703@canonical.com>
Date: Tue, 25 Oct 2011 16:37:38 +0800
From: Jesse Sung <jesse.sung@canonical.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: 812132@bugs.launchpad.net
Subject: [PATCH] Bluetooth: set reset_resume handler
Content-Type: multipart/mixed;
 boundary="------------000704000705030801070003"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000704000705030801070003
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On some machines, it seems that usb hubs do not get power while
being suspended. We can get something like this in dmesg:
     usb usb2: root hub lost power or was reset

When this is the case, .reset_resume is called instead of .resume.
If .reset_resume is not set, bluetooth modules would stay in an unusable
state because the resume function is not called.

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
  drivers/bluetooth/btusb.c |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)



--------------000704000705030801070003
Content-Type: text/x-patch;
 name="0001-Bluetooth-set-reset_resume-handler.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Bluetooth-set-reset_resume-handler.patch"

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index abfc4ee..db2a4d1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1220,6 +1220,7 @@ static struct usb_driver btusb_driver = {
 #ifdef CONFIG_PM
 	.suspend	= btusb_suspend,
 	.resume		= btusb_resume,
+	.reset_resume	= btusb_resume,
 #endif
 	.id_table	= btusb_table,
 	.supports_autosuspend = 1,


--------------000704000705030801070003--
