Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DC1C2BC61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 13:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6B120823
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 13:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6B120823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJ3WuK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:50:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:57742 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbeJ3WuK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 18:50:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 06:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="96261125"
Received: from ubuntu16.iind.intel.com ([10.224.186.218])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2018 06:56:33 -0700
From:   Chethan T N <chethan.tumkur.narayan@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     amit.k.bag@intel.com, Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sukumar Ghorai <sukumar.ghorai@intel.com>
Subject: [Patch v1] Bluetooth: Add Rfkill driver for Intel Bluetooth controller
Date:   Tue, 30 Oct 2018 19:26:04 +0530
Message-Id: <1540907764-26294-1-git-send-email-chethan.tumkur.narayan@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Raghuram Hegde <raghuram.hegde@intel.com>

Register ACPI object INTL6205 as platform Bluetooth RfKill
driver to attach/detach Intel Bluetooth controller from
platform USB bus.

Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
---
 drivers/platform/x86/Kconfig           |   9 +++
 drivers/platform/x86/Makefile          |   1 +
 drivers/platform/x86/intel_bt_rfkill.c | 123 +++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 drivers/platform/x86/intel_bt_rfkill.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0c1aa6c314f5..bf050ba644c6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1229,6 +1229,15 @@ config I2C_MULTI_INSTANTIATE
	  To compile this driver as a module, choose M here: the module
	  will be called i2c-multi-instantiate.

+config INTEL_BT_RFKILL
+	tristate "Intel bluetooth platform rfkill support"
+	depends on ACPI
+	depends on RFKILL || !RFKILL
+	---help---
+	  This option adds support for rfkill switch on Intel bluetooth
+	  controllers.
+	  If you have a PC with Intel Bluetooth controller, choose Y.
+
 endif # X86_PLATFORM_DEVICES

 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e6d1becf81ce..af9ac3cd6151 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -92,3 +92,4 @@ obj-$(CONFIG_MLX_PLATFORM)	+= mlx-platform.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
 obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
+obj-$(CONFIG_INTEL_BT_RFKILL)   += intel_bt_rfkill.o
diff --git a/drivers/platform/x86/intel_bt_rfkill.c b/drivers/platform/x86/intel_bt_rfkill.c
new file mode 100644
index 000000000000..904440dadb64
--- /dev/null
+++ b/drivers/platform/x86/intel_bt_rfkill.c
@@ -0,0 +1,123 @@
+/*
+ *  Intel Bluetooth Rfkill Driver
+ */
+
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include <linux/rfkill.h>
+#include <linux/gpio/consumer.h>
+
+struct intel_bt_rfkill_dev {
+	struct rfkill *rfkill;
+	struct gpio_desc *reset_gpio_handler;
+};
+
+static const struct acpi_gpio_params reset_gpios = { 0, 0, false };
+static const struct acpi_gpio_mapping acpi_intel_bt_rfkill_gpios[] = {
+	{ "reset-gpios", &reset_gpios, 1 },
+	{ },
+};
+
+static int intel_bt_disable(struct gpio_desc *reset_gpio)
+{
+	if (!reset_gpio)
+		return -EINVAL;
+
+	/* This will detach the Intel BT controller */
+	gpiod_set_value(reset_gpio, 0);
+	return 0;
+}
+
+static int intel_bt_enable(struct gpio_desc *reset_gpio)
+{
+	if (!reset_gpio)
+		return -EINVAL;
+
+	/* This will re-attach the Intel BT controller */
+	gpiod_set_value(reset_gpio, 1);
+	return 0;
+}
+
+/* RFKill handlers */
+static int intel_bt_rfkill_set_block(void *data, bool blocked)
+{
+	struct intel_bt_rfkill_dev *bt_dev = data;
+	int ret;
+
+	if (blocked)
+		ret = intel_bt_disable(bt_dev->reset_gpio_handler);
+	else
+		ret = intel_bt_enable(bt_dev->reset_gpio_handler);
+
+	return ret;
+}
+static const struct rfkill_ops rfk_ops = {
+	.set_block = intel_bt_rfkill_set_block,
+};
+
+/* ACPI object probe */
+static int intel_bt_rfkill_probe(struct platform_device *pdev)
+{
+	struct intel_bt_rfkill_dev *bt_dev;
+	int result;
+
+	bt_dev = devm_kzalloc(&pdev->dev, sizeof(*bt_dev), GFP_KERNEL);
+	if (!bt_dev)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, bt_dev);
+
+	if (acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
+				     acpi_intel_bt_rfkill_gpios))
+		return -EINVAL;
+
+	bt_dev->reset_gpio_handler = devm_gpiod_get_optional(&pdev->dev,
+					"reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(bt_dev->reset_gpio_handler))
+		return PTR_ERR(bt_dev->reset_gpio_handler);
+
+	bt_dev->rfkill = rfkill_alloc("intel_bluetooth",
+				   &pdev->dev,
+				   RFKILL_TYPE_BLUETOOTH,
+				   &rfk_ops,
+				   bt_dev);
+	if (!bt_dev->rfkill)
+		return -ENOMEM;
+
+	result = rfkill_register(bt_dev->rfkill);
+	if (result)
+		rfkill_destroy(bt_dev->rfkill);
+
+	return result;
+}
+
+static int intel_bt_rfkill_remove(struct platform_device *pdev)
+{
+	struct intel_bt_rfkill_dev *bt_dev = dev_get_drvdata(&pdev->dev);
+
+	if (bt_dev->rfkill) {
+		rfkill_unregister(bt_dev->rfkill);
+		rfkill_destroy(bt_dev->rfkill);
+	}
+
+	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&pdev->dev));
+
+	return 0;
+}
+
+static const struct acpi_device_id intel_bt_rfkill_acpi_match[] = {
+	{ "INTL6205", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, intel_bt_rfkill_acpi_match);
+
+static struct platform_driver intel_bt_rfkill_driver = {
+	.probe = intel_bt_rfkill_probe,
+	.remove = intel_bt_rfkill_remove,
+	.driver = {
+		.name = "intel_bt_rfkill",
+		.acpi_match_table = ACPI_PTR(intel_bt_rfkill_acpi_match),
+	},
+};
+module_platform_driver(intel_bt_rfkill_driver);
--
2.7.4
