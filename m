Return-Path: <kai.heng.feng@canonical.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 2/4] Bluetooth: btusb: Cache firmware for Intel Bluetooth
Date: Fri, 25 Aug 2017 15:18:27 +0800
Message-Id: <20170825071829.1829-2-kai.heng.feng@canonical.com>
In-Reply-To: <20170825071829.1829-1-kai.heng.feng@canonical.com>
References: <20170825071829.1829-1-kai.heng.feng@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

For Intel Bluetooth that downloads firmware based on patched status, it
should still call request_firmware() once if download is not needed.

Verified on Intel 7265 wireless module (8087:0a2a).

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2: Split patches for different vendors.

 drivers/bluetooth/btusb.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2313d20c6d60..4cb206ecfa7d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1583,18 +1583,12 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 }
 
 static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
-						       struct intel_version *ver)
+						       const char *fwname,
+						       const char *default_fwname)
 {
 	const struct firmware *fw;
-	char fwname[64];
 	int ret;
 
-	snprintf(fwname, sizeof(fwname),
-		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
-		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
-		 ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
-		 ver->fw_build_ww, ver->fw_build_yy);
-
 	ret = request_firmware(&fw, fwname, &hdev->dev);
 	if (ret < 0) {
 		if (ret == -EINVAL) {
@@ -1609,11 +1603,9 @@ static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
 		/* If the correct firmware patch file is not found, use the
 		 * default firmware patch file instead
 		 */
-		snprintf(fwname, sizeof(fwname), "intel/ibt-hw-%x.%x.bseq",
-			 ver->hw_platform, ver->hw_variant);
-		if (request_firmware(&fw, fwname, &hdev->dev) < 0) {
+		if (request_firmware(&fw, default_fwname, &hdev->dev) < 0) {
 			BT_ERR("%s failed to open default Intel fw file: %s",
-			       hdev->name, fwname);
+			       hdev->name, default_fwname);
 			return NULL;
 		}
 	}
@@ -1741,6 +1733,8 @@ static int btusb_setup_intel_patching(struct hci_dev *hdev,
 static int btusb_setup_intel(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
+	char fwname[64];
+	char default_fwname[64];
 	const struct firmware *fw;
 	const u8 *fw_ptr;
 	int disable_patch, err;
@@ -1779,6 +1773,15 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 		ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
 		ver.fw_build_ww, ver.fw_build_yy, ver.fw_patch_num);
 
+	snprintf(fwname, sizeof(fwname),
+		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
+		 ver.hw_platform, ver.hw_variant, ver.hw_revision,
+		 ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
+		 ver.fw_build_ww, ver.fw_build_yy);
+
+	snprintf(default_fwname, sizeof(default_fwname),
+		"intel/ibt-hw-%x.%x.bseq", ver.hw_platform, ver.hw_variant);
+
 	/* fw_patch_num indicates the version of patch the device currently
 	 * have. If there is no patch data in the device, it is always 0x00.
 	 * So, if it is other than 0x00, no need to patch the device again.
@@ -1786,6 +1789,8 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	if (ver.fw_patch_num) {
 		BT_INFO("%s: Intel device is already patched. patch num: %02x",
 			hdev->name, ver.fw_patch_num);
+		btusb_request_firmware_async(hdev, fwname);
+		btusb_request_firmware_async(hdev, default_fwname);
 		goto complete;
 	}
 
@@ -1795,7 +1800,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * If no patch file is found, allow the device to operate without
 	 * a patch.
 	 */
-	fw = btusb_setup_intel_get_fw(hdev, &ver);
+	fw = btusb_setup_intel_get_fw(hdev, fwname, default_fwname);
 	if (!fw)
 		goto complete;
 	fw_ptr = fw->data;
-- 
2.14.1
