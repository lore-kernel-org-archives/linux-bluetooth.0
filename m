Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: tedd.an@intel.com, anand.kalyanakrishnan@intel.com
From: "jaya.p.g" <jaya.p.g@linux.intel.com>
Subject: [PATCH] Bluetooth: Add Support for Intel Bluetooth Devices JfP and
 ThP [8087:0025,8087:0aaa]
Message-ID: <589B24EF.4000401@linux.intel.com>
Date: Wed, 8 Feb 2017 19:32:23 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 From 1f59dbab81364031ea380d6e4ab79ce0c293b31e Mon Sep 17 00:00:00 2001
From: Jaya Praveen G <jaya.p.g@linux.intel.com>
Date: Wed, 8 Feb 2017 17:30:55 +0530
Subject: [PATCH] Bluetooth: Add Support for Intel Bluetooth Devices JfP 
and ThP [8087:0025,8087:0aaa]

This Patch add support for ThP and JfP Bluetooth Modules.
ThP and JfP are the next generation of Intel Bluetooth Modules.

JeffersonPeak
PID:0XAAA
HW Variant: 0x11 (17)

ThunderPeak
PID:0x0025
HW Variant: 0x12 (18)

Signed-off-by: jaya.p.g <jaya.p.g@intel.com>
---
  drivers/bluetooth/btusb.c | 10 +++++++---
  1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2f633df..5e37628 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -317,11 +317,13 @@
  	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },

  	/* Intel Bluetooth devices */
+	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW },
  	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
  	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
  	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
  	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW },
  	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL },
+	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW },

  	/* Other Intel Bluetooth devices */
  	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
@@ -2010,13 +2012,15 @@ static int btusb_setup_intel_new(struct hci_dev 
*hdev)
  		return -EINVAL;
  	}

-	/* At the moment the iBT 3.0 hardware variants 0x0b (LnP/SfP)
-	 * and 0x0c (WsP) are supported by this firmware loading method.
+	/* At the moment the iBT 3.0 hardware variants 0x0b (LnP/SfP),
+	 * 0x0c (WsP),0x11 (JfP), and 0x12 (ThP) are supported by this
+	 * firmware loading method.
  	 *
  	 * This check has been put in place to ensure correct forward
  	 * compatibility options when newer hardware variants come along.
  	 */
-	if (ver.hw_variant != 0x0b && ver.hw_variant != 0x0c) {
+	if (ver.hw_variant != 0x0b && ver.hw_variant != 0x0c &&
+		ver.hw_variant != 0x11 && ver.hw_variant != 0x12) {
  		BT_ERR("%s: Unsupported Intel hardware variant (%u)",
  		       hdev->name, ver.hw_variant);
  		return -EINVAL;
-- 
1.9.1

