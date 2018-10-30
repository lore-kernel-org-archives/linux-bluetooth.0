Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F63C2BC61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 10:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7AE20848
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 10:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7AE20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJ3TpB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:45:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:52980 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbeJ3TpB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 15:45:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 03:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="86729064"
Received: from ubuntu16.iind.intel.com ([10.224.186.218])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2018 03:52:00 -0700
From:   Chethan T N <chethan.tumkur.narayan@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     amit.k.bag@intel.com, Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sukumar Ghorai <sukumar.ghorai@intel.com>
Subject: [PATCH 1/2] Bluetooth: Add Rfkill driver for Intel Bluetooth controller
Date:   Tue, 30 Oct 2018 16:20:33 +0530
Message-Id: <1540896634-17173-1-git-send-email-chethan.tumkur.narayan@intel.com>
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
 drivers/platform/x86/intel_bt_rfkill.c | 133 +++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 drivers/platform/x86/intel_bt_rfkill.c

diff --git a/drivers/platform/x86/intel_bt_rfkill.c b/drivers/platform/x86/intel_bt_rfkill.c
new file mode 100644
index 000000000000..89a3d7f4b32c
--- /dev/null
+++ b/drivers/platform/x86/intel_bt_rfkill.c
@@ -0,0 +1,133 @@
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
+struct btintel_rfkill_dev {
+	struct rfkill *rfk;
+	struct gpio_desc *reset_gpio_handler;
+};
+
+static const struct acpi_gpio_params reset_gpios = { 0, 0, false };
+static const struct acpi_gpio_mapping acpi_btintel_gpios[] = {
+	{ "reset-gpios", &reset_gpios, 1 },
+	{ },
+};
+
+static const struct acpi_device_id btintel_acpi_match[] = {
+	{ "INTL6205", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, btintel_acpi_match);
+
+static int btintel_disable_bt(struct gpio_desc *reset_gpio)
+{
+	if (!reset_gpio)
+		return -EINVAL;
+
+	/* This will detach the Intel BT controller */
+	gpiod_set_value(reset_gpio, 0);
+	return 0;
+}
+
+static int btintel_enable_bt(struct gpio_desc *reset_gpio)
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
+static int bt_rfkill_set_block(void *data, bool blocked)
+{
+	struct btintel_rfkill_dev *bt_dev = data;
+	int ret;
+
+	if (blocked)
+		ret = btintel_disable_bt(bt_dev->reset_gpio_handler);
+	else
+		ret = btintel_enable_bt(bt_dev->reset_gpio_handler);
+
+	return ret;
+}
+static const struct rfkill_ops rfk_ops = {
+	.set_block = bt_rfkill_set_block,
+};
+
+/* ACPI object probe */
+static int btintel_probe(struct platform_device *pdev)
+{
+	struct btintel_rfkill_dev *bt_dev;
+	int result;
+
+	bt_dev = kzalloc(sizeof(*bt_dev), GFP_KERNEL);
+	if (!bt_dev)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, bt_dev);
+
+	if (acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
+				     acpi_btintel_gpios)) {
+		kfree(bt_dev);
+		return -EINVAL;
+	}
+
+	bt_dev->reset_gpio_handler = devm_gpiod_get_optional(&pdev->dev,
+					"reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(bt_dev->reset_gpio_handler)) {
+		kfree(bt_dev);
+		return PTR_ERR(bt_dev->reset_gpio_handler);
+	}
+
+	bt_dev->rfk = rfkill_alloc("intel_bluetooth",
+				   &pdev->dev,
+				   RFKILL_TYPE_BLUETOOTH,
+				   &rfk_ops,
+				   bt_dev);
+	if (!bt_dev->rfk) {
+		kfree(bt_dev);
+		return -ENOMEM;
+	}
+
+	result = rfkill_register(bt_dev->rfk);
+	if (result) {
+		rfkill_destroy(bt_dev->rfk);
+		kfree(bt_dev);
+	}
+
+	return result;
+}
+
+static int btintel_remove(struct platform_device *pdev)
+{
+	struct btintel_rfkill_dev *bt_dev = dev_get_drvdata(&pdev->dev);
+
+	if (bt_dev->rfk) {
+		rfkill_unregister(bt_dev->rfk);
+		rfkill_destroy(bt_dev->rfk);
+	}
+
+	kfree(bt_dev);
+
+	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&pdev->dev));
+
+	return 0;
+}
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
-- 
2.7.4

