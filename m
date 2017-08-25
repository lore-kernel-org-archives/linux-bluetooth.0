Return-Path: <kai.heng.feng@canonical.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 1/4] Bluetooth: btusb: Add firmware caching function for already patched Bluetooth chip
Date: Fri, 25 Aug 2017 15:18:26 +0800
Message-Id: <20170825071829.1829-1-kai.heng.feng@canonical.com>
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
v2: Split patches for different vendors.

 drivers/bluetooth/btusb.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7a5c06aaa181..2313d20c6d60 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1476,6 +1476,54 @@ static void btusb_waker(struct work_struct *work)
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
-- 
2.14.1
