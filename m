Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 28 Jun 2016 08:56:39 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] Bluetooth: Replace constant hw_variant from Intel Bluetooth
 firmware filename
Message-ID: <20160628085639.7caaf7f7@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

The format of Intel Bluetooth firmware filename for bootloader product
is ibt-<hw_variant>-<device_revision_id>.sfi

Currently the driver uses a constant value 11 (0x0b) for hw_variant
to support LnP/SfP product. But new product like WsP product has
a different value such as 12 (0x0c).

To support the multiple products, this patch replaces the constant
value of hw_variant to the actual hw_variant value read from
the device.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a26278b..a402b7e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2104,10 +2104,14 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	/* With this Intel bootloader only the hardware variant and device
 	 * revision information are used to select the right firmware.
 	 *
-	 * Currently this bootloader support is limited to hardware variant
-	 * iBT 3.0 (LnP/SfP) which is identified by the value 11 (0x0b).
+	 * The firmware filename is ibt-<hw_variant>-<dev_revid>.sfi.
+	 *
+	 * Currently the supported hardware variants are:
+	 * 11 (0x0b) for iBT3.0(LnP/SfP)
+	 * 12 (0x0c) for iBT3.5(WsP)
 	 */
-	snprintf(fwname, sizeof(fwname), "intel/ibt-11-%u.sfi",
+	snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.sfi",
+		 le16_to_cpu(ver.hw_variant),
 		 le16_to_cpu(params->dev_revid));
 
 	err = request_firmware(&fw, fwname, &hdev->dev);
@@ -2123,7 +2127,8 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	/* Save the DDC file name for later use to apply once the firmware
 	 * downloading is done.
 	 */
-	snprintf(fwname, sizeof(fwname), "intel/ibt-11-%u.ddc",
+	snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.ddc",
+		 le16_to_cpu(ver.hw_variant),
 		 le16_to_cpu(params->dev_revid));
 
 	kfree_skb(skb);
-- 
2.4.11

