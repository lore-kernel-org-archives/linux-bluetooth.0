Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2ACC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 07:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2984860FDA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 07:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbhIMHaB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 03:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbhIMHaA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 03:30:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C81C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 00:28:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id bg1so5201001plb.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 00:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DnoYR5x/DwI9mRpxTVlQwvsfoxsFdaE2SzPcs+yYnk8=;
        b=njbPXFywfXR+xOmYU3z+sSYoLjhwfEyrdlj+CwD2HXM0s09iyTR72harRqICh/4+UZ
         1a4u/M+XDdnyEJhasMj8jGa2fiua74bxGbyiMnhqYy6ZzFpZGmqYUNK9GdSVBrRiZZys
         7T9AKPlAQeS0s4KNdRBbnLKbhecNb14ghu1x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DnoYR5x/DwI9mRpxTVlQwvsfoxsFdaE2SzPcs+yYnk8=;
        b=UH1KHajidFIL4F9hXZe2YUxAxvxiCInV+QjbmJU7wHP1cJLsL2WrVZwd5WX0lvsDvM
         JY/cOkyxoBprodJnn79/N5vgnp3fQbJdXvpCxOrUzymiXxX16An1zyNugQXWwanen1oO
         kRbu+TzOEcr6j/48b7c70spp/yNxDQQmgnK3XqG7lfB0w4pHe/c00Spt1a+VdQ7UAxdz
         f9CinYQC5yDsG+ceJnvMbQvwejGZeVzjvoqUv0rnuPfBc87g9+M/AAUZkwuRZdejLC6U
         w8/aOlDgvPX17Vu+wk4o+LcakVE2nmQIgpcGWEP++21cqFg1m7LOZ/6e2YmKIfK34bqI
         tHMg==
X-Gm-Message-State: AOAM530SdCbo7TZARMsnmGS0KAHjFzbt72OV7eg3A/uP4zYOMtmAuW/5
        2pFuzHnDzNxt67zPpTY3nJolWmAxrHSrqA==
X-Google-Smtp-Source: ABdhPJyIXiW/sfh6i4lN8UmYLjjuq2GGPYZKMncz+ZlPySfACwqkuEAp19mPfM1R4zlmNgsHCfdoUQ==
X-Received: by 2002:a17:90b:1c07:: with SMTP id oc7mr11579080pjb.209.1631518124059;
        Mon, 13 Sep 2021 00:28:44 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:b418:a601:c444:4951])
        by smtp.gmail.com with ESMTPSA id g8sm5688019pfv.51.2021.09.13.00.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:28:43 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] Bluetooth: btandroid: Support Android Bluetooth Quality Report
Date:   Mon, 13 Sep 2021 15:28:36 +0800
Message-Id: <20210913152801.v3.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the btandroid.c file to support Android BQR commands.

This module may be referenced by btusb, btrtl, and hci_qca when a
Bluetooth controller supports the Android Bluetooth Quality Report.

Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v3:
- Fix the auto build test ERROR
  "undefined symbol: btandroid_set_quality_report" that occurred
  with some kernel configs.
- Note that the mgmt-tester "Read Exp Feature - Success" failed.
  But on my test device, the same test passed. Please kindly let me
  know what may be going wrong. These patches do not actually
  modify read/set experimental features.
- As to CheckPatch failed. No need to modify the MAINTAINERS file.
  Thanks.

Changes in v2:
- Fix the titles of patches 2/3 and 3/3 and reduce their lengths.

 drivers/bluetooth/Kconfig     |   5 ++
 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/btandroid.c | 106 ++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btandroid.h |  10 ++++
 4 files changed, 122 insertions(+)
 create mode 100644 drivers/bluetooth/btandroid.c
 create mode 100644 drivers/bluetooth/btandroid.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 851842372c9b..0be352cdc6c9 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -19,10 +19,14 @@ config BT_QCA
 	tristate
 	select FW_LOADER
 
+config BT_HCIBTANDROID
+	tristate
+
 config BT_HCIBTUSB
 	tristate "HCI USB driver"
 	depends on USB
 	select BT_INTEL
+	select BT_HCIBTANDROID
 	help
 	  Bluetooth HCI USB driver.
 	  This driver is required if you want to use Bluetooth devices with
@@ -90,6 +94,7 @@ config BT_HCIUART
 	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
 	depends on NVMEM || !NVMEM
 	depends on TTY
+	select BT_HCIBTANDROID
 	help
 	  Bluetooth HCI UART driver.
 	  This driver is required if you want to use Bluetooth devices with
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 16286ea2655d..3a2ca2eb7cd7 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_BT_HCIBT3C)	+= bt3c_cs.o
 obj-$(CONFIG_BT_HCIBLUECARD)	+= bluecard_cs.o
 
 obj-$(CONFIG_BT_HCIBTUSB)	+= btusb.o
+obj-$(CONFIG_BT_HCIBTANDROID)	+= btandroid.o
 obj-$(CONFIG_BT_HCIBTSDIO)	+= btsdio.o
 
 obj-$(CONFIG_BT_INTEL)		+= btintel.o
diff --git a/drivers/bluetooth/btandroid.c b/drivers/bluetooth/btandroid.c
new file mode 100644
index 000000000000..fffacc8d67cc
--- /dev/null
+++ b/drivers/bluetooth/btandroid.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Support for Android Bluetooth Quality Report (BQR) specifications
+ *      https://source.android.com/devices/bluetooth/hci_requirements
+ *
+ *  Copyright (C) 2021 Google Corporation
+ */
+
+#include <linux/module.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci.h>
+
+#include "btandroid.h"
+
+#define VERSION "0.1"
+
+/*
+ * Reference for the command op codes and parameters below:
+ *   https://source.android.com/devices/bluetooth/hci_requirements#bluetooth-quality-report-command
+ */
+#define BQR_COMMAND_OCF			0x015e
+#define BQR_OPCODE			hci_opcode_pack(0x3f, BQR_COMMAND_OCF)
+
+/* report action */
+#define REPORT_ACTION_ADD		0x00
+#define REPORT_ACTION_DELETE		0x01
+#define REPORT_ACTION_CLEAR		0x02
+
+/* BQR event masks */
+#define QUALITY_MONITORING		(1 << 0)
+#define APPRAOCHING_LSTO		(1 << 1)
+#define A2DP_AUDIO_CHOPPY		(1 << 2)
+#define SCO_VOICE_CHOPPY		(1 << 3)
+
+#define DEFAULT_BQR_EVENT_MASK	(QUALITY_MONITORING | APPRAOCHING_LSTO | \
+				 A2DP_AUDIO_CHOPPY | SCO_VOICE_CHOPPY)
+
+/*
+ * Reporting at seconds so as not to stress the controller too much.
+ * Range: 0 ~ 65535 ms
+ */
+#define DEFALUT_REPORT_INTERVAL_MS	5000
+
+struct android_bqr_cp {
+	__u8	report_action;
+	__u32	event_mask;
+	__u16	min_report_interval;
+} __packed;
+
+static int enable_quality_report(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct android_bqr_cp cp;
+
+	cp.report_action = REPORT_ACTION_ADD;
+	cp.event_mask = DEFAULT_BQR_EVENT_MASK;
+	cp.min_report_interval = DEFALUT_REPORT_INTERVAL_MS;
+
+	skb = __hci_cmd_sync(hdev, BQR_OPCODE, sizeof(cp), &cp,
+							HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Enabling Android BQR failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static int disable_quality_report(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct android_bqr_cp cp = { 0 };
+
+	cp.report_action = REPORT_ACTION_CLEAR;
+
+	skb = __hci_cmd_sync(hdev, BQR_OPCODE, sizeof(cp), &cp,
+							HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Disabling Android BQR failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+	return 0;
+}
+
+int btandroid_set_quality_report(struct hci_dev *hdev, bool enable)
+{
+	bt_dev_info(hdev, "quality report enable %d", enable);
+
+	/* Enable or disable the quality report feature. */
+	if (enable)
+		return enable_quality_report(hdev);
+	else
+		return disable_quality_report(hdev);
+}
+EXPORT_SYMBOL_GPL(btandroid_set_quality_report);
+
+MODULE_AUTHOR("Google");
+MODULE_DESCRIPTION("Support for Android Bluetooth Specification " VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
diff --git a/drivers/bluetooth/btandroid.h b/drivers/bluetooth/btandroid.h
new file mode 100644
index 000000000000..6abc9e8e0838
--- /dev/null
+++ b/drivers/bluetooth/btandroid.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Bluetooth support for Android specifications
+ *
+ *  Copyright (C) 2021 Google Corporation
+ */
+
+#include <net/bluetooth/hci_core.h>
+
+int btandroid_set_quality_report(struct hci_dev *hdev, bool enable);
-- 
2.33.0.309.g3052b89438-goog

