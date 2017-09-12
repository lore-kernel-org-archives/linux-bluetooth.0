Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Cc: jaya.p.g@linux.intel.com, jaya.p.g@linux.intel.com,
        "An, Tedd" <tedd.an@intel.com>, anand.kalyanakrishnan@intel.com,
        ravishankar.srivatsa@intel.com, amit.k.bag@intel.com,
        sukumar.ghorai@intel.com
To: linux-bluetooth@vger.kernel.org
From: "jaya.p.g" <jaya.p.g@linux.intel.com>
Subject: [PATCH] Bluetooth: btusb: Update firmware filename for Intel 9x60
 and,later
Message-ID: <59B7D929.7060908@linux.intel.com>
Date: Tue, 12 Sep 2017 18:25:05 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jaya P G <jaya.p.g@intel.com>
Date: Wed, 6 Sep 2017 19:51:26 +0530
Subject: [PATCH] Bluetooth: btusb: Update firmware filename for Intel 9x60 and
 later

The format of Intel Bluetooth firmware for bootloader product is
ibt-<hw_variant>-<device_revision_id>.sfi and .ddc.

But for the SKU's 9x60, there a 3 variants of FW, which cannot be
differentiated just with hw_variant and devision_revision_id.
So to pick the appropriate FW file for 9x60 SKU's, it will be
differentiated using hw_variant, hw_revision and fw_revision rather
than hw_variant and device_revision_id only.

Format will be like this:
ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi and .ddc

Signed-off-by: Jaya P G <jaya.p.g@intel.com>
---
 drivers/bluetooth/btusb.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7a5c06a..370cc22 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2151,20 +2151,36 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	}
 
 	/* With this Intel bootloader only the hardware variant and device
-	 * revision information are used to select the right firmware.
+	 * revision information are used to select the right firmware for SfP
+	 * and WsP.
 	 *
 	 * The firmware filename is ibt-<hw_variant>-<dev_revid>.sfi.
 	 *
 	 * Currently the supported hardware variants are:
 	 *   11 (0x0b) for iBT3.0 (LnP/SfP)
 	 *   12 (0x0c) for iBT3.5 (WsP)
+	 *
+	 * For ThP/JfP and for future SKU's, the FW name varies based on HW
+	 * variant, HW revision and FW revision, as these are dependent on CNVi
+	 * and RF Combination.
+	 *
 	 *   17 (0x11) for iBT3.5 (JfP)
 	 *   18 (0x12) for iBT3.5 (ThP)
+	 *
+	 * The firmware file name for these will be
+	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
+	 *
 	 */
-	snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.sfi",
-		 le16_to_cpu(ver.hw_variant),
-		 le16_to_cpu(params->dev_revid));
-
+	if (ver.hw_variant >= 0x11) {
+		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.sfi",
+			 le16_to_cpu(ver.hw_variant),
+			 le16_to_cpu(ver.hw_revision),
+			 le16_to_cpu(ver.fw_revision));
+	} else {
+		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.sfi",
+			 le16_to_cpu(ver.hw_variant),
+			 le16_to_cpu(params->dev_revid));
+	}
 	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err < 0) {
 		BT_ERR("%s: Failed to load Intel firmware file (%d)",
@@ -2178,10 +2194,16 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	/* Save the DDC file name for later use to apply once the firmware
 	 * downloading is done.
 	 */
-	snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.ddc",
-		 le16_to_cpu(ver.hw_variant),
-		 le16_to_cpu(params->dev_revid));
-
+	if (ver.hw_variant >= 0x11) {
+		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.ddc",
+			 le16_to_cpu(ver.hw_variant),
+			 le16_to_cpu(ver.hw_revision),
+			 le16_to_cpu(ver.fw_revision));
+	} else {
+		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.ddc",
+			 le16_to_cpu(ver.hw_variant),
+			 le16_to_cpu(params->dev_revid));
+	}
 	kfree_skb(skb);
 
 	if (fw->size < 644) {
-- 
1.9.1
