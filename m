Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D54ECDE44
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 11:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7B820827
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 11:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7B820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeJ3UBT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:01:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:37299 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbeJ3UBT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 16:01:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 04:08:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="245540717"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga004.jf.intel.com with ESMTP; 30 Oct 2018 04:08:17 -0700
Received: from bgsmsx151.gar.corp.intel.com (10.224.48.42) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Oct 2018 04:08:16 -0700
Received: from bgsmsx102.gar.corp.intel.com ([169.254.2.202]) by
 BGSMSX151.gar.corp.intel.com ([169.254.3.245]) with mapi id 14.03.0415.000;
 Tue, 30 Oct 2018 16:38:13 +0530
From:   "Hegde, Raghuram" <raghuram.hegde@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Bag, Amit K" <amit.k.bag@intel.com>,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH 1/2] Bluetooth: Add Rfkill driver for Intel Bluetooth
 controller
Thread-Topic: [PATCH 1/2] Bluetooth: Add Rfkill driver for Intel Bluetooth
 controller
Thread-Index: AQHUcD6lzzk++Xw+iUaMmcDEaIU1LKU3ntDw
Date:   Tue, 30 Oct 2018 11:08:13 +0000
Message-ID: <E5FA71999F8E8845A748D0B68F0A4BDF25C3512F@BGSMSX102.gar.corp.intel.com>
References: <1540896634-17173-1-git-send-email-chethan.tumkur.narayan@intel.com>
In-Reply-To: <1540896634-17173-1-git-send-email-chethan.tumkur.narayan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTRlMDE3ODAtY2JlOS00NjAzLThkZTEtMDQzMjY2ODU4MGQ2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWGlhU09IU2orUkJKVks0OVkrQnRWcFUrMFlGVVNsUDN5YXJFNjFWZ0dZVXIzVXo0RVB6Ujc2T3JyeVhiV2UxVCJ9
x-ctpclassification: CTP_NT
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello All,

In this patch, we have implemented the Rfkill driver for Intel Bluetooth controllers as suggested by Marcel. 
We believe this approach handles the scenario of multiple Bluetooth Controllers.

We need suggestion on how we can link this rfkill object with the corresponding hdev object, so that we can invoke the set_block function from hci core if the BT controller goes to a un-recoverable state.

Thanks
Raghuram

-----Original Message-----
From: Tumkur Narayan, Chethan 
Sent: Tuesday, October 30, 2018 4:21 PM
To: linux-bluetooth@vger.kernel.org
Cc: Bag, Amit K <amit.k.bag@intel.com>; Hegde, Raghuram <raghuram.hegde@intel.com>; Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>; Ghorai, Sukumar <sukumar.ghorai@intel.com>
Subject: [PATCH 1/2] Bluetooth: Add Rfkill driver for Intel Bluetooth controller

From: Raghuram Hegde <raghuram.hegde@intel.com>

Register ACPI object INTL6205 as platform Bluetooth RfKill driver to attach/detach Intel Bluetooth controller from platform USB bus.

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
+static int btintel_disable_bt(struct gpio_desc *reset_gpio) {
+	if (!reset_gpio)
+		return -EINVAL;
+
+	/* This will detach the Intel BT controller */
+	gpiod_set_value(reset_gpio, 0);
+	return 0;
+}
+
+static int btintel_enable_bt(struct gpio_desc *reset_gpio) {
+	if (!reset_gpio)
+		return -EINVAL;
+
+	/* This will re-attach the Intel BT controller */
+	gpiod_set_value(reset_gpio, 1);
+	return 0;
+}
+
+/* RFKill handlers */
+static int bt_rfkill_set_block(void *data, bool blocked) {
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
+static int btintel_probe(struct platform_device *pdev) {
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
+static int btintel_remove(struct platform_device *pdev) {
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

