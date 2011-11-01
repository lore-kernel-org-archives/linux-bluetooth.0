Return-Path: <cyrus@holtmann.org>
From: "Cho, Yu-Chen" <acho@suse.com>
To: marcel@holtmann.org,
	padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: acho@novell.com,
	jlee@novell.com,
	oneukum@suse.com,
	acho@suse.com,
	jlee@suse.com
Subject: [PATCH 1/3] add device entry for Broadcom Valentine combo card
Date: Tue,  1 Nov 2011 17:33:05 +0800
Message-Id: <944af9667334f5677be87e89fe8f38486823cc95.1320139612.git.acho@suse.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This device declares itself to be vendor specific
It therefore needs to be added to the device table
to make btusb bind.

Signed-off-by: Cho, Yu-Chen <acho@suse.com>
---
 drivers/bluetooth/btusb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index abfc4ee..be01260 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -97,6 +97,10 @@ static struct usb_device_id btusb_table[] = {
 	/* Ericsson with non-standard id */
 	{ USB_DEVICE(0x0bdb, 0x1002) },
 
+	/* Broadcom 20702 Bluetooth 4.0 Adapter */
+	/* Broadcom Valentine 802.11bgn 1x1 Combo HMC */
+	{ USB_DEVICE(0x0a5c, 0x21e3) },
+
 	/* Canyon CN-BTU1 with HID interfaces */
 	{ USB_DEVICE(0x0c10, 0x0000) },
 
-- 
1.7.3.4
