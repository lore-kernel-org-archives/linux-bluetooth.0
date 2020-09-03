Return-Path: <SRS0=fWrd=CM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16543C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 18:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66202083B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 18:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgICSs5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:48:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:2719 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgICSsy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Sep 2020 14:48:54 -0400
IronPort-SDR: bf7bqfuTGKMG01nEz0iB7v7SF1q2X4oeTDFLVvg/iMvpAAh+jyfplUd8AMaY9oHl67GjRCocdV
 kwXRPSFtYf9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="157648334"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="157648334"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 11:48:53 -0700
IronPort-SDR: vbaEYy4SvjTnc5ZeAisbk3O8Wau4H4/kRKXTmU+66LMX2a5N0JQGh8EV2sgABdhPNB6Lc14XvA
 qg1olUTIKJ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="282774887"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Sep 2020 11:48:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3535621D; Thu,  3 Sep 2020 21:48:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] Bluetooth: hci_intel: sort headers alphabetically
Date:   Thu,  3 Sep 2020 21:48:50 +0300
Message-Id: <20200903184850.53055-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903184850.53055-1-andriy.shevchenko@linux.intel.com>
References: <20200903184850.53055-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Sort headers alphabetically to increase readability
and make maintenance easier.

While here, update copyright year.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bluetooth/hci_intel.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index b20a40fab83e..17f51bc17bb5 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -3,21 +3,21 @@
  *
  *  Bluetooth HCI UART driver for Intel devices
  *
- *  Copyright (C) 2015  Intel Corporation
+ *  Copyright (C) 2015,2020 Intel Corporation
  */
 
-#include <linux/kernel.h>
+#include <linux/acpi.h>
 #include <linux/errno.h>
-#include <linux/skbuff.h>
 #include <linux/firmware.h>
-#include <linux/module.h>
-#include <linux/wait.h>
-#include <linux/tty.h>
-#include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
-#include <linux/acpi.h>
 #include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/skbuff.h>
+#include <linux/tty.h>
+#include <linux/wait.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
-- 
2.28.0

