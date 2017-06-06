Return-Path: <andriy.shevchenko@linux.intel.com>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] Bluetooth: hci_intel: Add GPIO ACPI mapping table
Date: Tue,  6 Jun 2017 17:47:18 +0300
Message-Id: <20170606144718.77620-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170606144718.77620-1-andriy.shevchenko@linux.intel.com>
References: <20170606144718.77620-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

In order to make GPIO ACPI library stricter prepare users of
gpiod_get_index() to correctly behave when there no mapping is
provided by firmware.

Here we add explicit mapping between _CRS GpioIo() resources and
their names used in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bluetooth/hci_intel.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index fa5099986f1b..851bee82df2a 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1205,9 +1205,19 @@ static const struct dev_pm_ops intel_pm_ops = {
 	SET_RUNTIME_PM_OPS(intel_suspend_device, intel_resume_device, NULL)
 };
 
+static const struct acpi_gpio_params reset_gpios = { 0, 0, false };
+static const struct acpi_gpio_params host_wake_gpios = { 1, 0, false };
+
+static const struct acpi_gpio_mapping acpi_hci_intel_gpios[] = {
+	{ "reset-gpios", &reset_gpios, 1 },
+	{ "host-wake-gpios", &host_wake_gpios, 1 },
+	{ },
+};
+
 static int intel_probe(struct platform_device *pdev)
 {
 	struct intel_device *idev;
+	int ret;
 
 	idev = devm_kzalloc(&pdev->dev, sizeof(*idev), GFP_KERNEL);
 	if (!idev)
@@ -1217,6 +1227,10 @@ static int intel_probe(struct platform_device *pdev)
 
 	idev->pdev = pdev;
 
+	ret = devm_acpi_dev_add_driver_gpios(&pdev->dev, acpi_hci_intel_gpios);
+	if (ret)
+		dev_dbg(&pdev->dev, "Unable to add GPIO mapping table\n");
+
 	idev->reset = devm_gpiod_get(&pdev->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(idev->reset)) {
 		dev_err(&pdev->dev, "Unable to retrieve gpio\n");
-- 
2.11.0
