Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Raghuram Hegde <raghuram.hegde@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghuram.hegde@intel.com, chethan.tumkur.narayan@intel.com,
        sukumar.ghorai@intel.com, amit.k.bag@intel.com
Subject: [PATCH 1/2] Bluetooth: btintel: Add platform device for rfkill signal
Date: Tue, 21 Aug 2018 15:04:39 +0530
Message-Id: <1534844080-31240-1-git-send-email-raghuram.hegde@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sukumar Ghorai <sukumar.ghorai@intel.com>

Driver to add INTL6205 platform ACPI device to enable out
of band GPIO signalling to handle rfkill and reset the
bluetooth controller. Expose an interface in kernel to
assert GPIO signal.

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
---
 drivers/bluetooth/btintel.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  6 ++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5270d5513201..538cd6b6c524 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -24,6 +24,9 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/regmap.h>
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include <linux/gpio/consumer.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -375,6 +378,71 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 }
 EXPORT_SYMBOL_GPL(btintel_read_version);
 
+static struct gpio_desc *reset_gpio_handler;
+void btintel_reset_bt(struct hci_dev *hdev, unsigned char code)
+{
+	if (!reset_gpio_handler)
+		return;
+
+	gpiod_set_value(reset_gpio_handler, 0);
+	mdelay(100);
+	gpiod_set_value(reset_gpio_handler, 1);
+}
+EXPORT_SYMBOL_GPL(btintel_reset_bt);
+
+static const struct acpi_gpio_params reset_gpios = { 0, 0, false };
+static const struct acpi_gpio_mapping acpi_btintel_gpios[] = {
+	{ "reset-gpios", &reset_gpios, 1 },
+	{ },
+};
+
+static int btintel_probe(struct platform_device *pdev)
+{
+	struct device *hdev;
+
+	hdev = devm_kzalloc(&pdev->dev, sizeof(*hdev), GFP_KERNEL);
+	if (!hdev)
+		return -ENOMEM;
+
+	if (!ACPI_HANDLE(&pdev->dev))
+		return -ENODEV;
+
+	if (acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
+				     acpi_btintel_gpios))
+		return -EINVAL;
+
+	reset_gpio_handler = devm_gpiod_get_optional(&pdev->dev,
+					"reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio_handler))
+		return PTR_ERR(reset_gpio_handler);
+
+	return 0;
+}
+
+static int btintel_remove(struct platform_device *pdev)
+{
+	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&pdev->dev));
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id btintel_acpi_match[] = {
+	{ "INTL6205", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, btintel_acpi_match);
+#endif
+
+static struct platform_driver btintel_driver = {
+	.probe = btintel_probe,
+	.remove = btintel_remove,
+	.driver = {
+		.name = "btintel",
+		.acpi_match_table = ACPI_PTR(btintel_acpi_match),
+	},
+};
+module_platform_driver(btintel_driver);
+
 /* ------- REGMAP IBT SUPPORT ------- */
 
 #define IBT_REG_MODE_8BIT  0x00
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 41c642cc523f..7686fab52054 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -94,6 +94,7 @@ int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name);
 int btintel_set_event_mask(struct hci_dev *hdev, bool debug);
 int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);
 int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver);
+void btintel_reset_bt(struct hci_dev *hdev, unsigned char code);
 
 struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
 				   u16 opcode_write);
@@ -171,6 +172,11 @@ static inline int btintel_read_version(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline void btintel_reset_bt(struct hci_dev *hdev, unsigned char code)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct regmap *btintel_regmap_init(struct hci_dev *hdev,
 						 u16 opcode_read,
 						 u16 opcode_write)
-- 
2.7.4
