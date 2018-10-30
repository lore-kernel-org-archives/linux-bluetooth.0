Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3293C6786F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 10:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980AE20827
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 10:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980AE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJ3TpG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:45:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:44158 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbeJ3TpG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 15:45:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 03:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="86729083"
Received: from ubuntu16.iind.intel.com ([10.224.186.218])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2018 03:52:06 -0700
From:   Chethan T N <chethan.tumkur.narayan@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     amit.k.bag@intel.com, Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sukumar Ghorai <sukumar.ghorai@intel.com>
Subject: [PATCH 2/2] Bluetooth: Add build configuration option for Intel bluetooth rfkill driver
Date:   Tue, 30 Oct 2018 16:20:34 +0530
Message-Id: <1540896634-17173-2-git-send-email-chethan.tumkur.narayan@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540896634-17173-1-git-send-email-chethan.tumkur.narayan@intel.com>
References: <1540896634-17173-1-git-send-email-chethan.tumkur.narayan@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Raghuram Hegde <raghuram.hegde@intel.com>

CONFIG_INTEL_BT_RFKILL option enables the support for Rfkill
switch on Intel bluetooth controllers. If you have a PC with
Intel bluetooth controller,choose Y for this option.

Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
---
 drivers/platform/x86/Kconfig  | 9 +++++++++
 drivers/platform/x86/Makefile | 1 +
 2 files changed, 10 insertions(+)

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
-- 
2.7.4

