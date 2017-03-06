Return-Path: <tedd.an@intel.com>
Date: Mon, 6 Mar 2017 15:38:32 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>, "jaya.p.g"
 <jaya.p.g@linux.intel.com>
Subject: [PATCH 3/4] Bluetooth: hci_intel: Fix firmware file name to use
 hw_variant
Message-ID: <20170306153832.289fabd5@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

The format of Intel Bluetooth firmware for bootloader product is
ibt-<hw_variant>-<device_revision_id>.sfi and .ddc.

This patch uses a hw_variant value read from the device during
runtime to form the firmware filenames instead of using a constant
value, so it can support multiple prouducts.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/hci_intel.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 351e868..63970d0 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -704,11 +704,14 @@ static int intel_setup(struct hci_uart *hu)
 	/* With this Intel bootloader only the hardware variant and device
 	 * revision information are used to select the right firmware.
 	 *
-	 * Currently this bootloader support is limited to hardware variant
-	 * iBT 3.0 (LnP/SfP) which is identified by the value 11 (0x0b).
+	 * The firmware filename is ibt-<hw_variant>-<dev_revid>.sfi.
+	 *
+	 * Currently the supported hardware variants are:
+	 *   11 (0x0b) for iBT3.0 (LnP/SfP)
 	 */
-	snprintf(fwname, sizeof(fwname), "intel/ibt-11-%u.sfi",
-		 le16_to_cpu(params->dev_revid));
+	snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.sfi",
+		le16_to_cpu(ver.hw_variant),
+		le16_to_cpu(params->dev_revid));
 
 	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err < 0) {
@@ -721,8 +724,9 @@ static int intel_setup(struct hci_uart *hu)
 	bt_dev_info(hdev, "Found device firmware: %s", fwname);
 
 	/* Save the DDC file name for later */
-	snprintf(fwname, sizeof(fwname), "intel/ibt-11-%u.ddc",
-		 le16_to_cpu(params->dev_revid));
+	snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.ddc",
+		le16_to_cpu(ver.hw_variant),
+		le16_to_cpu(params->dev_revid));
 
 	kfree_skb(skb);
 
-- 
2.7.4
