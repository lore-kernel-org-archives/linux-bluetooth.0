Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH v2 3/3] Bluetooth: btusb: intel: Use btintel_load_ddc_config for device config
Date: Fri,  4 Sep 2015 17:54:36 +0200
Message-Id: <1441382076-7737-3-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1441382076-7737-1-git-send-email-loic.poulain@intel.com>
References: <1441382076-7737-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

btintel_load_ddc_config is now part of btintel.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: introduce this patch in the serie

 drivers/bluetooth/btusb.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index eeff7ca..9521b7b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2219,36 +2219,7 @@ done:
 	 * The device can work without DDC parameters, so even if it fails
 	 * to load the file, no need to fail the setup.
 	 */
-	err = request_firmware_direct(&fw, fwname, &hdev->dev);
-	if (err < 0)
-		return 0;
-
-	BT_INFO("%s: Found Intel DDC parameters: %s", hdev->name, fwname);
-
-	fw_ptr = fw->data;
-
-	/* DDC file contains one or more DDC structure which has
-	 * Length (1 byte), DDC ID (2 bytes), and DDC value (Length - 2).
-	 */
-	while (fw->size > fw_ptr - fw->data) {
-		u8 cmd_plen = fw_ptr[0] + sizeof(u8);
-
-		skb = __hci_cmd_sync(hdev, 0xfc8b, cmd_plen, fw_ptr,
-				     HCI_INIT_TIMEOUT);
-		if (IS_ERR(skb)) {
-			BT_ERR("%s: Failed to send Intel_Write_DDC (%ld)",
-			       hdev->name, PTR_ERR(skb));
-			release_firmware(fw);
-			return PTR_ERR(skb);
-		}
-
-		fw_ptr += cmd_plen;
-		kfree_skb(skb);
-	}
-
-	release_firmware(fw);
-
-	BT_INFO("%s: Applying Intel DDC parameters completed", hdev->name);
+	btintel_load_ddc_config(hdev, fwname);
 
 	return 0;
 }
-- 
1.9.1
