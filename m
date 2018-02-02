Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amit K Bag <amit.k.bag@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: tedd.an@intel.com, jaya.p.g@intel.com,
        ravishankar.srivatsa@intel.com, Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH] Bluetooth: btusb: Add support for Intel Bluetooth device 22560 [8087:0026]
Date: Fri,  2 Feb 2018 17:11:36 +0530
Message-Id: <1517571696-32239-1-git-send-email-amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/btusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2a55380ad730..37082a833ca6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -339,6 +339,7 @@ static const struct usb_device_id blacklist_table[] = {
 
 	/* Intel Bluetooth devices */
 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW },
+	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
@@ -2057,6 +2058,8 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	case 0x0c:	/* WsP */
 	case 0x11:	/* JfP */
 	case 0x12:	/* ThP */
+	case 0x13:	/* Quasar */
+	case 0x14:	/* Quasar */
 		break;
 	default:
 		BT_ERR("%s: Unsupported Intel hardware variant (%u)",
@@ -2149,6 +2152,8 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		break;
 	case 0x11:	/* JfP */
 	case 0x12:	/* ThP */
+	case 0x13:      /* Quasar */
+	case 0x14:      /* Quasar */
 		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.sfi",
 			 le16_to_cpu(ver.hw_variant),
 			 le16_to_cpu(ver.hw_revision),
@@ -2180,6 +2185,8 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		break;
 	case 0x11:	/* JfP */
 	case 0x12:	/* ThP */
+	case 0x13:      /* Quasar */
+	case 0x14:      /* Quasar */
 		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.ddc",
 			 le16_to_cpu(ver.hw_variant),
 			 le16_to_cpu(ver.hw_revision),
-- 
2.7.4

