Return-Path: <kai.heng.feng@canonical.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/2] Bluetooth: btusb: ath3k: Cache firmware for already patched Bluetooth chip
Date: Thu, 24 Aug 2017 17:06:29 +0800
Message-Id: <20170824090629.13381-2-kai.heng.feng@canonical.com>
In-Reply-To: <20170824090629.13381-1-kai.heng.feng@canonical.com>
References: <20170824090629.13381-1-kai.heng.feng@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

When a system reboot, the USB power never gets cut off, so the firmware
is already updated on the Bluetooth chip.

Several btusb setup functions check firmware updated status before
download firmware, the loading part will be skipped if it's updated.
Because the firmware is never asked by request_firmware(),
firmware_class does not know it needs to be cached before system enters
sleep.

Now, system suspend/resume may cause the driver failed to request the
firmware because it's not in the firmware cache:

[   87.539434] firmware request while host is not available

This can be solved by calling request_firmware() even if the chip is
already updated - now the firmware_class knows what to cache.

In this case, we don't really need to wait for the firmware content, so
we use the async version of request_firmware().

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/ath3k.c | 49 +++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btusb.c | 56 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 280849dba51e..27a7415f9fd7 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -208,6 +208,54 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
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
@@ -420,6 +468,7 @@ static int ath3k_load_patch(struct usb_device *udev)
 
 	if (fw_state & ATH3K_PATCH_UPDATE) {
 		BT_DBG("Patch was already downloaded");
+		ath3k_request_firmware_async(udev, filename);
 		return 0;
 	}
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 732fe6c3e789..7de2156debd8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1459,6 +1459,54 @@ static void btusb_waker(struct work_struct *work)
 	usb_autopm_put_interface(data->intf);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static void btusb_request_firmware_done(const struct firmware *firmware,
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
+static int btusb_request_firmware_async(struct hci_dev *hdev,
+					const char *fwname)
+{
+	const char *name;
+	int err;
+
+	name = kstrdup_const(fwname, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	err = request_firmware_nowait(THIS_MODULE, true, name, &hdev->dev,
+				      GFP_KERNEL, (void *)name,
+				      btusb_request_firmware_done);
+	if (err) {
+		BT_WARN("%s: failed to async request firmware for file: %s (%d)",
+			hdev->name, name, err);
+		kfree_const(name);
+		return err;
+	}
+
+	return 0;
+}
+#else
+static int btusb_request_firmware_async(struct hci_dev *hdev,
+					const char *fwname)
+{
+	return 0;
+}
+#endif
+
 static int btusb_setup_bcm92035(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -1724,6 +1772,8 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	if (ver.fw_patch_num) {
 		BT_INFO("%s: Intel device is already patched. patch num: %02x",
 			hdev->name, ver.fw_patch_num);
+		btusb_request_firmware_async(hdev, fwname);
+		btusb_request_firmware_async(hdev, default_fwname);
 		goto complete;
 	}
 
@@ -2696,7 +2746,8 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 		err = btusb_setup_qca_load_rampatch(hdev, fwname, &ver, info);
 		if (err < 0)
 			return err;
-	}
+	} else
+		btusb_request_firmware_async(hdev, fwname);
 
 	snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
 		 ver.rom_version);
@@ -2705,7 +2756,8 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 		err = btusb_setup_qca_load_nvm(hdev, fwname, info);
 		if (err < 0)
 			return err;
-	}
+	} else
+		btusb_request_firmware_async(hdev, fwname);
 
 	return 0;
 }
-- 
2.14.1
