Return-Path: <SRS0=fWrd=CM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2F5C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 18:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01EBC208CA
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 18:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgICSs4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:48:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:5597 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgICSsy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Sep 2020 14:48:54 -0400
IronPort-SDR: cX7RIt8mOU9XYajnDl8i51bOwBDXPgS4OEJo31cH8SY0sLMYopnmbYi7y/CBKk5FCNHNf7B5dT
 FZVQ9mRG5clw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="145339778"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="145339778"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 11:48:53 -0700
IronPort-SDR: AxVQagXXeA9mwAZXm0ncCysWDVDq2yVqPWetu9TCqE+KkzD+ZO9kD09mywrPxHMVB7ZQLlZgs0
 W8qiAOwuPK0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="284172582"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 03 Sep 2020 11:48:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1A27C11C; Thu,  3 Sep 2020 21:48:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] Bluetooth: hci_intel: enable on new platform
Date:   Thu,  3 Sep 2020 21:48:47 +0300
Message-Id: <20200903184850.53055-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On new Intel platform the device is provided with INT33E3 ID.
Append it to the list.

This will require ACPI_GPIO_QUIRK_ONLY_GPIOIO to be enabled because
the relevant ASL looks like:

	UartSerialBusV2 ( ... )
	GpioInt ( ... ) { ... }
	GpioIo ( ... ) { ... }

which means that first GPIO resource is an interrupt, while we are expecting it
to be reset one (output). Do the same for host-wake because in case of
GpioInt() the platform_get_irq() will do the job and should return correct
Linux IRQ number. That said, host-wake GPIO can only be GpioIo() resource.

While here, drop commas in terminator lines.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bluetooth/hci_intel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index f1299da6eed8..703d774be5a6 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1076,7 +1076,8 @@ static const struct hci_uart_proto intel_proto = {
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id intel_acpi_match[] = {
 	{ "INT33E1", 0 },
-	{ },
+	{ "INT33E3", 0 },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, intel_acpi_match);
 #endif
@@ -1138,9 +1139,9 @@ static const struct acpi_gpio_params reset_gpios = { 0, 0, false };
 static const struct acpi_gpio_params host_wake_gpios = { 1, 0, false };
 
 static const struct acpi_gpio_mapping acpi_hci_intel_gpios[] = {
-	{ "reset-gpios", &reset_gpios, 1 },
-	{ "host-wake-gpios", &host_wake_gpios, 1 },
-	{ },
+	{ "reset-gpios", &reset_gpios, 1, ACPI_GPIO_QUIRK_ONLY_GPIOIO },
+	{ "host-wake-gpios", &host_wake_gpios, 1, ACPI_GPIO_QUIRK_ONLY_GPIOIO },
+	{ }
 };
 
 static int intel_probe(struct platform_device *pdev)
-- 
2.28.0

