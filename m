Return-Path: <kai.heng.feng@canonical.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 4/4] Bluetooth: ath3k: Cache firmware for Atheros Bluetooth
Date: Fri, 25 Aug 2017 15:18:29 +0800
Message-Id: <20170825071829.1829-4-kai.heng.feng@canonical.com>
In-Reply-To: <20170825071829.1829-1-kai.heng.feng@canonical.com>
References: <20170825071829.1829-1-kai.heng.feng@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

For Intel Bluetooth that downloads firmware based on patched status,
it should still call request_firmware() once if download is not needed.

Verified on DW1707 wireless module (0cf3:e005).

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2: Split patches for different vendors.

 drivers/bluetooth/ath3k.c | 59 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 204afe66de92..f7c7077d312b 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -209,6 +209,54 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
 #define TIMEGAP_USEC_MIN	50
 #define TIMEGAP_USEC_MAX	100
 
+#ifdef CONFIG_PM_SLEEP
+static void ath3k_request_firmware_done(const struct firmware *firmware,
+					void *context)
+{
+	const char *name = (const char *)context;
+
+	if (!firmware) {
+		BT_WARN("firmware %s will not be cached", name);
+		goto done;
+	}
+
+	BT_DBG("firmware %s will be cached", name);
+
+	release_firmware(firmware);
+done:
+	kfree_const(name);
+}
+
+static int ath3k_request_firmware_async(struct usb_device *udev,
+					const char *fwname)
+{
+	const char *name;
+	int err;
+
+	name = kstrdup_const(fwname, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	err = request_firmware_nowait(THIS_MODULE, true, name, &udev->dev,
+				      GFP_KERNEL, (void *)name,
+				      ath3k_request_firmware_done);
+	if (err) {
+		BT_WARN("%s %s: failed to async request firmware for file: %s (%d)",
+			udev->manufacturer, udev->product, name, err);
+		kfree_const(name);
+		return err;
+	}
+
+	return 0;
+}
+#else
+static int ath3k_request_firmware_async(struct usb_device *udev,
+					const char *fwname)
+{
+	return 0;
+}
+#endif
+
 static int ath3k_load_firmware(struct usb_device *udev,
 				const struct firmware *firmware)
 {
@@ -410,11 +458,6 @@ static int ath3k_load_patch(struct usb_device *udev)
 		return ret;
 	}
 
-	if (fw_state & ATH3K_PATCH_UPDATE) {
-		BT_DBG("Patch was already downloaded");
-		return 0;
-	}
-
 	ret = ath3k_get_version(udev, &fw_version);
 	if (ret < 0) {
 		BT_ERR("Can't get version to change to load ram patch err");
@@ -424,6 +467,12 @@ static int ath3k_load_patch(struct usb_device *udev)
 	snprintf(filename, ATH3K_NAME_LEN, "ar3k/AthrBT_0x%08x.dfu",
 		 le32_to_cpu(fw_version.rom_version));
 
+	if (fw_state & ATH3K_PATCH_UPDATE) {
+		BT_DBG("Patch was already downloaded");
+		ath3k_request_firmware_async(udev, filename);
+		return 0;
+	}
+
 	ret = request_firmware(&firmware, filename, &udev->dev);
 	if (ret < 0) {
 		BT_ERR("Patch file not found %s", filename);
-- 
2.14.1
