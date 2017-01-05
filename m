Return-Path: <drake@endlessm.com>
From: Daniel Drake <drake@endlessm.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux@endlessm.com,
	frederic.danis@linux.intel.com
Subject: [PATCH] Bluetooth: hci_bcm: Add support for BCM2E95 and BCM2E96
Date: Thu,  5 Jan 2017 11:10:54 -0600
Message-Id: <20170105171054.5256-1-drake@endlessm.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The BCM2E96 ID is used by the ECS EF20 laptop, and BCM2E95 is present
in the Weibu F3C. Both are now logged as:

     hci0: BCM: chip id 82
     hci0: BCM43341B0 (002.001.014) build 0000
     hci0: BCM (002.001.014) build 0158

The ECS vendor kernel predates the host-wakeup support in hci_bcm but
it explicitly has a comment saying that the GPIO assignment needs to be
reordered for BCM2E96:
 1. (not used in vendor driver)
 2. Device wakeup
 3. Shutdown

For both devices in question, the DSDT has these GPIOs listed in order
of GpioInt, GpioIo, GpioIo. And if we use the first one listed (GpioInt)
as the host wakeup, that interrupt handler fires while doing bluetooth
I/O.

I am assuming the convention of GPIO ordering has been changed for these
new device IDs, so lets use the new ordering on such devices.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/bluetooth/hci_bcm.c | 68 +++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 8f6c23c..5262a20 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -618,14 +618,25 @@ static int bcm_resume(struct device *dev)
 }
 #endif
 
-static const struct acpi_gpio_params device_wakeup_gpios = { 0, 0, false };
-static const struct acpi_gpio_params shutdown_gpios = { 1, 0, false };
-static const struct acpi_gpio_params host_wakeup_gpios = { 2, 0, false };
-
-static const struct acpi_gpio_mapping acpi_bcm_default_gpios[] = {
-	{ "device-wakeup-gpios", &device_wakeup_gpios, 1 },
-	{ "shutdown-gpios", &shutdown_gpios, 1 },
-	{ "host-wakeup-gpios", &host_wakeup_gpios, 1 },
+static const struct acpi_gpio_params int_last_device_wakeup_gpios = { 0, 0, false };
+static const struct acpi_gpio_params int_last_shutdown_gpios = { 1, 0, false };
+static const struct acpi_gpio_params int_last_host_wakeup_gpios = { 2, 0, false };
+
+static const struct acpi_gpio_mapping acpi_bcm_int_last_gpios[] = {
+	{ "device-wakeup-gpios", &int_last_device_wakeup_gpios, 1 },
+	{ "shutdown-gpios", &int_last_shutdown_gpios, 1 },
+	{ "host-wakeup-gpios", &int_last_host_wakeup_gpios, 1 },
+	{ },
+};
+
+static const struct acpi_gpio_params int_first_host_wakeup_gpios = { 0, 0, false };
+static const struct acpi_gpio_params int_first_device_wakeup_gpios = { 1, 0, false };
+static const struct acpi_gpio_params int_first_shutdown_gpios = { 2, 0, false };
+
+static const struct acpi_gpio_mapping acpi_bcm_int_first_gpios[] = {
+	{ "device-wakeup-gpios", &int_first_device_wakeup_gpios, 1 },
+	{ "shutdown-gpios", &int_first_shutdown_gpios, 1 },
+	{ "host-wakeup-gpios", &int_first_host_wakeup_gpios, 1 },
 	{ },
 };
 
@@ -692,12 +703,19 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	struct platform_device *pdev = dev->pdev;
 	LIST_HEAD(resources);
 	const struct dmi_system_id *dmi_id;
+	const struct acpi_gpio_mapping *gpio_mapping = acpi_bcm_int_last_gpios;
+	const struct acpi_device_id *id;
 	int ret;
 
-	/* Retrieve GPIO data */
 	dev->name = dev_name(&pdev->dev);
+
+	/* Retrieve GPIO data */
+	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
+	if (id)
+		gpio_mapping = (const struct acpi_gpio_mapping *) id->driver_data;
+
 	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
-					acpi_bcm_default_gpios);
+					gpio_mapping);
 	if (ret)
 		return ret;
 
@@ -822,20 +840,22 @@ static const struct hci_uart_proto bcm_proto = {
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id bcm_acpi_match[] = {
-	{ "BCM2E1A", 0 },
-	{ "BCM2E39", 0 },
-	{ "BCM2E3A", 0 },
-	{ "BCM2E3D", 0 },
-	{ "BCM2E3F", 0 },
-	{ "BCM2E40", 0 },
-	{ "BCM2E54", 0 },
-	{ "BCM2E55", 0 },
-	{ "BCM2E64", 0 },
-	{ "BCM2E65", 0 },
-	{ "BCM2E67", 0 },
-	{ "BCM2E71", 0 },
-	{ "BCM2E7B", 0 },
-	{ "BCM2E7C", 0 },
+	{ "BCM2E1A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E39", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E3A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E3D", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E3F", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E40", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E54", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E55", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E64", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E65", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E67", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E71", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E7B", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E7C", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E95", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
+	{ "BCM2E96", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
-- 
2.9.3
