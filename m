Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDEAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 08:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C7B61176
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 08:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351177AbhIHIwk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Sep 2021 04:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350217AbhIHIwk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Sep 2021 04:52:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F7C061757
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Sep 2021 01:51:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso979437pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Sep 2021 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7vMB4x/Wb37AldCIAXgjMXYhtwhLXldtwUSdZamrps=;
        b=naRme10Kjn9PE7VIELGWd6j9EhiDueS0iAysmAUryLbxvmirvNCjsudOAJjSgNYvfO
         rhMOlCLlCgSHNvy91r9BQrA3jZJW3ed+XzCcwX2HuAf5gm/R81oyHjlvtwwu5ElsseBO
         MHffa+iaYw7D5t0JbTI/i6ZqMWNqJ1sh5g6gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7vMB4x/Wb37AldCIAXgjMXYhtwhLXldtwUSdZamrps=;
        b=ig4fl3fKmsCCU3W3Qzw1XjTL8SsQyP+hPmaW26EFh+vza/sJKqqsx9GX6CKx+jxPrb
         0qyWR5/3IHp0SJryG/vsJVGxF6lGuNBUCqjNRHM4aSlspqqrPERINjGVqrjDZOTK/rNE
         XpO+l+mcSyP0zVi8BQgWBTKCIPZJZrTr8QIx9NCuvt4VvtYnfV6O64drroiuBQ2/leBT
         aUxeICHwfuugtfXu95530mOd+4khw1lMD6EwZdUJ2VrcRwRrvn5+FMD2+DUxXd1YavT0
         K3FYe0hwmsqoLFWH1OqCUI4iprErAHQoyiu8rUa/WefevbbG1w4sGvoV2yjptYW4Zx0n
         elLA==
X-Gm-Message-State: AOAM5329KWjwRxOfCpYa6ZAiPqQaHn5BURz13/GeutL9ALdWyR2HtV4d
        m5CtlewcoBeaQ28PwTZxLRbaHt9MB7SbCg==
X-Google-Smtp-Source: ABdhPJwfpK6c0euMJ5wcalgYvT9mdb+fN76do4pBn+iXOZLclZxVe5xIHsgUkJJD/552ayAvYo0kuQ==
X-Received: by 2002:a17:90a:eb0d:: with SMTP id j13mr2849648pjz.163.1631091092055;
        Wed, 08 Sep 2021 01:51:32 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6939:f2f4:4be:bf22])
        by smtp.gmail.com with ESMTPSA id i7sm2116694pgd.56.2021.09.08.01.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 01:51:31 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] Bluetooth: btandroid: Support Android Bluetooth Quality Report
Date:   Wed,  8 Sep 2021 16:51:17 +0800
Message-Id: <20210908165017.v1.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the btandroid.c file to support Android BQR commands.

This module may be referenced by btusb, btrtl, and hci_qca when a
Bluetooth controller supports the Android Bluetooth Quality Report.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/btandroid.c | 106 ++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btandroid.h |  10 ++++
 3 files changed, 117 insertions(+)
 create mode 100644 drivers/bluetooth/btandroid.c
 create mode 100644 drivers/bluetooth/btandroid.h

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 16286ea2655d..4d5d010bb947 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_BT_HCIBT3C)	+= bt3c_cs.o
 obj-$(CONFIG_BT_HCIBLUECARD)	+= bluecard_cs.o
 
 obj-$(CONFIG_BT_HCIBTUSB)	+= btusb.o
+obj-$(CONFIG_BT_HCIBTUSB)	+= btandroid.o
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
2.33.0.153.gba50c8fa24-goog

