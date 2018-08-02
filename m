Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v4 04/10] Bluetooth: btrtl: add support for retrieving the UART settings
Date: Thu,  2 Aug 2018 16:57:15 +0200
Message-Id: <20180802145721.31390-5-hdegoede@redhat.com>
In-Reply-To: <20180802145721.31390-1-hdegoede@redhat.com>
References: <20180802145721.31390-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The UART settings are embedded in the config blob. This has to be parsed
to successfully initialize the Bluetooth part of the RTL8723BS (which is
an SDIO chip, but the Bluetooth part is connected via UART).

The Realtek "rtl8723bs_bt" and "rtl8723ds_bt" userspace Bluetooth UART
initialization tools (rtk_hciattach) use the following sequence:
- send H5 sync pattern (already supported by hci_h5)
- get LMP version (already supported by btrtl)
- get ROM version (already supported by btrtl)
- load the firmware and config for the current chipset (already
  supported by btrtl)
- read UART settings from the config blob (part of this patch)
- send UART settings via a vendor command to the device (which changes
  the baudrate of the device and enables or disables flow control
  depending on the config)
- change the baudrate and flow control settings on the host
- send the firmware and config blob to the device (already supported by
  btrtl)

Sending the last firmware and config blob download command
(rtl_download_cmd) fails if the UART settings are not updated
beforehand. This is presumably because the device applies the config
right after the firmware and config blob download - which means that at
this point the host is using different UART settings than the device
(which will obviously result in non-working communication).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Make btrtl_convert_baudrate() static

Changes in v4:
-Use new rtl_dev_err and rtl_dev_dbg helpers
---
 drivers/bluetooth/btrtl.c | 109 ++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btrtl.h |  25 +++++++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 0500b598691e..75d6acb3ee82 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -34,6 +34,7 @@
 #define RTL_ROM_LMP_8821A	0x8821
 #define RTL_ROM_LMP_8761A	0x8761
 #define RTL_ROM_LMP_8822B	0x8822
+#define RTL_CONFIG_MAGIC	0x8723ab55
 
 #define IC_MATCH_FL_LMPSUBV	(1 << 0)
 #define IC_MATCH_FL_HCIREV	(1 << 1)
@@ -587,6 +588,114 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btrtl_setup_realtek);
 
+static unsigned int btrtl_convert_baudrate(u32 device_baudrate)
+{
+	switch (device_baudrate) {
+	case 0x0252a00a:
+		return 230400;
+
+	case 0x05f75004:
+		return 921600;
+
+	case 0x00005004:
+		return 1000000;
+
+	case 0x04928002:
+	case 0x01128002:
+		return 1500000;
+
+	case 0x00005002:
+		return 2000000;
+
+	case 0x0000b001:
+		return 2500000;
+
+	case 0x04928001:
+		return 3000000;
+
+	case 0x052a6001:
+		return 3500000;
+
+	case 0x00005001:
+		return 4000000;
+
+	case 0x0252c014:
+	default:
+		return 115200;
+	}
+}
+
+int btrtl_get_uart_settings(struct hci_dev *hdev,
+			    struct btrtl_device_info *btrtl_dev,
+			    unsigned int *controller_baudrate,
+			    u32 *device_baudrate, bool *flow_control)
+{
+	struct rtl_vendor_config *config;
+	struct rtl_vendor_config_entry *entry;
+	int i, total_data_len;
+	bool found = false;
+
+	total_data_len = btrtl_dev->cfg_len - sizeof(*config);
+	if (total_data_len <= 0) {
+		rtl_dev_warn(hdev, "no config loaded\n");
+		return -EINVAL;
+	}
+
+	config = (struct rtl_vendor_config *)btrtl_dev->cfg_data;
+	if (le32_to_cpu(config->signature) != RTL_CONFIG_MAGIC) {
+		rtl_dev_err(hdev, "invalid config magic\n");
+		return -EINVAL;
+	}
+
+	if (total_data_len < le16_to_cpu(config->total_len)) {
+		rtl_dev_err(hdev, "config is too short\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < total_data_len; ) {
+		entry = ((void *)config->entry) + i;
+
+		switch (le16_to_cpu(entry->offset)) {
+		case 0xc:
+			if (entry->len < sizeof(*device_baudrate)) {
+				rtl_dev_err(hdev, "invalid UART config entry\n");
+				return -EINVAL;
+			}
+
+			*device_baudrate = get_unaligned_le32(entry->data);
+			*controller_baudrate = btrtl_convert_baudrate(
+							*device_baudrate);
+
+			if (entry->len >= 13)
+				*flow_control = !!(entry->data[12] & BIT(2));
+			else
+				*flow_control = false;
+
+			found = true;
+			break;
+
+		default:
+			rtl_dev_dbg(hdev, "skipping config entry 0x%x (len %u)\n",
+				   le16_to_cpu(entry->offset), entry->len);
+			break;
+		};
+
+		i += sizeof(*entry) + entry->len;
+	}
+
+	if (!found) {
+		rtl_dev_err(hdev, "no UART config entry found\n");
+		return -ENOENT;
+	}
+
+	rtl_dev_dbg(hdev, "device baudrate = 0x%08x\n", *device_baudrate);
+	rtl_dev_dbg(hdev, "controller baudrate = %u\n", *controller_baudrate);
+	rtl_dev_dbg(hdev, "flow control %d\n", *flow_control);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
+
 MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Realtek devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index e41974f8af40..9249ad1e9a1d 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -45,6 +45,18 @@ struct rtl_epatch_header {
 	__le16 num_patches;
 } __packed;
 
+struct rtl_vendor_config_entry {
+	__le16 offset;
+	__u8 len;
+	__u8 data[0];
+} __packed;
+
+struct rtl_vendor_config {
+	__le32 signature;
+	__le16 total_len;
+	struct rtl_vendor_config_entry entry[0];
+} __packed;
+
 #if IS_ENABLED(CONFIG_BT_RTL)
 
 struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev);
@@ -52,6 +64,10 @@ void btrtl_free(struct btrtl_device_info *btrtl_dev);
 int btrtl_download_firmware(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev);
 int btrtl_setup_realtek(struct hci_dev *hdev);
+int btrtl_get_uart_settings(struct hci_dev *hdev,
+			    struct btrtl_device_info *btrtl_dev,
+			    unsigned int *controller_baudrate,
+			    u32 *device_baudrate, bool *flow_control);
 
 #else
 
@@ -75,4 +91,13 @@ static inline int btrtl_setup_realtek(struct hci_dev *hdev)
 	return -EOPNOTSUPP;
 }
 
+static inline int btrtl_get_uart_settings(struct hci_dev *hdev,
+					  struct btrtl_device_info *btrtl_dev,
+					  unsigned int *controller_baudrate,
+					  u32 *device_baudrate,
+					  bool *flow_control)
+{
+	return -ENOENT;
+}
+
 #endif
-- 
2.18.0
