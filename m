Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: btusb: Set early vendor info for Intel and Broadcom
Date: Tue, 20 Oct 2015 02:30:48 +0200
Message-Id: <1445301048-46533-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For the controllers from Intel and Broadcom (including Apple), it is
helpful to have the information about the manufacturer send out early.

This patch sets the hdev->manufacturer information which will be send
out before actually calling the vendor specific hdev->setup driver
callback.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5ee98231ac27..bbe25e397f41 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2882,6 +2882,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 #ifdef CONFIG_BT_HCIBTUSB_BCM
 	if (id->driver_info & BTUSB_BCM_PATCHRAM) {
+		hdev->manufacturer = 15;
 		hdev->setup = btbcm_setup_patchram;
 		hdev->set_diag = btusb_bcm_set_diag;
 		hdev->set_bdaddr = btbcm_set_bdaddr;
@@ -2891,6 +2892,7 @@ static int btusb_probe(struct usb_interface *intf,
 	}
 
 	if (id->driver_info & BTUSB_BCM_APPLE) {
+		hdev->manufacturer = 15;
 		hdev->setup = btbcm_setup_apple;
 		hdev->set_diag = btusb_bcm_set_diag;
 
@@ -2900,6 +2902,7 @@ static int btusb_probe(struct usb_interface *intf,
 #endif
 
 	if (id->driver_info & BTUSB_INTEL) {
+		hdev->manufacturer = 2;
 		hdev->setup = btusb_setup_intel;
 		hdev->shutdown = btusb_shutdown_intel;
 		hdev->set_diag = btintel_set_diag_mfg;
@@ -2910,6 +2913,7 @@ static int btusb_probe(struct usb_interface *intf,
 	}
 
 	if (id->driver_info & BTUSB_INTEL_NEW) {
+		hdev->manufacturer = 2;
 		hdev->send = btusb_send_frame_intel;
 		hdev->setup = btusb_setup_intel_new;
 		hdev->hw_error = btintel_hw_error;
-- 
2.4.3

