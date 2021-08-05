Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A1C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 10:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BFE60F94
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 10:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbhHEKDX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbhHEKDW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 06:03:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF8CC0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 03:03:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so10273791pji.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HinnzQs+V+jlpiaHdzAVaf4tg7IFpH4tXsZwcgOSnzM=;
        b=gEotc+qo98CQ3Sm4nZHM9JTaYRfNGwOwG6Beq9BXXg6GhMXhdsZUNIOjHtWNDS3zem
         v4QcdN6PgDDffsxDkAk962JQn67LcVHhyC5yuBQKQbOrgCRJX7DKHZfMBS2NVdY3yCCE
         SAVk4W5UuL8+Jk5nuX0aw3dvxDLadK6f9ZmWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HinnzQs+V+jlpiaHdzAVaf4tg7IFpH4tXsZwcgOSnzM=;
        b=HYWnOLaDmkZ5dxQdFvGsyDkdZpHukMlT5mPK/mbsg3J2ER/Yq12v3ALWl4uGMCmnhR
         N2Dcdz8j/ttDf/C8GzQ6QycHWkyzLXH4C4Md9F5+pNjIhh9l8t1kRSlXM8ZczxVsPAHC
         UNHE6HvJeJvRZ0G47zTE/MwU8zxuDR7qKlyHXkjazI2J1fjjUMt3aG+hRT+B8IrDqO18
         XdvxfrOSx+vH1bFjcaVuxYWZdwdjqIPH5noE4YHF0SbYGZFY1OzocKyfY6AJEIgHHwSO
         byAUlFxOiDmrNl5W5TUOd+JSUkLyUjn8xphNqDS78UyGPYafgoxXgemr0AMLjR7tmRm3
         g/AA==
X-Gm-Message-State: AOAM531+5iO5s+nMJaT+1sapGeIwN0PzhpcuENl1mRF5bU1J7x2TaSlS
        Qrib9EXoGoqtvHUfPabmMq/Q5g8jSu5Kkg==
X-Google-Smtp-Source: ABdhPJzb0GLZ5STr5wX2eHmHTMVBrFYi+kWu4rYVsMeXl+CrEp7OxUlcmDiXyO4mbDvkZyyO0MhULg==
X-Received: by 2002:a65:5288:: with SMTP id y8mr108678pgp.275.1628157786630;
        Thu, 05 Aug 2021 03:03:06 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:2c18:41ac:c6a8:ddfe])
        by smtp.gmail.com with ESMTPSA id jz24sm5436194pjb.9.2021.08.05.03.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:03:05 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiran.k@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] Bluetooth: btusb: disable Intel link statistics telemetry events
Date:   Thu,  5 Aug 2021 18:02:57 +0800
Message-Id: <20210805180227.v6.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To avoid the overhead on both the controller and the host, the
Intel link statistics telemetry events are disabled by default.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v6:
- Rebase on the latest commit.

Changes in v5:
- Rebase this patch 1/4 to resolve conflicts.
- There are changes in patches 3/4 and 4/4.

Changes in v4:
- The original 2 patches in Series-version 3 are split into
  2 patches from each patch per reviewers' comments. There are
  A total of 4 patches in this series now.
- The callback function is renamed from hdev->set_vs_dbg_evt to
  hdev->set_quality_report. Note that there are two different
  specifications which will be integrated soon and enabled/disabled
  with the same callback. One is Android Bluetooth Quality Report
  (BQR), and the other Intel link statistics telemetry events here.
  While most Bluetooth controller vendors have supported or are
  supporting the Android specification in their controllers, it looks
  making sense to use set_quality_report as the callback name.
- Similarly, the config option BT_FEATURE_VS_DBG_EVT is renamed as
  BT_FEATURE_QUALITY_REPORT which depends on BT now.
- The BQR is controller specific. There needs to be a valid hdev in the
  first place. This is fixed in set_exp_feature().
- In set_exp_feature(), bluez will only set experimental feature to set
  BQR when the feature is supported. Please refer to bluez CLs.
- Also refer to bluez patches for the decoding support of btmon.

Changes in v3:
- fix the long line in the commit message

Changes in v2:
- take care of intel_newgen as well as intel_new
- fix the long lines in mgmt.c

 drivers/bluetooth/btusb.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8c4e3977cce2..30462de288c7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2870,7 +2870,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2924,15 +2923,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		btintel_load_ddc_config(hdev, ddcname);
 	}
 
-	/* Read the Intel supported features and if new exception formats
-	 * supported, need to load the additional DDC config to enable.
-	 */
-	err = btintel_read_debug_features(hdev, &features);
-	if (!err) {
-		/* Set DDC mask for available debug features */
-		btintel_set_debug_features(hdev, &features);
-	}
-
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &ver);
 	if (err)
@@ -2971,7 +2961,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 	struct intel_version_tlv version;
 
 	bt_dev_dbg(hdev, "");
@@ -3021,15 +3010,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	 */
 	btintel_load_ddc_config(hdev, ddcname);
 
-	/* Read the Intel supported features and if new exception formats
-	 * supported, need to load the additional DDC config to enable.
-	 */
-	err = btintel_read_debug_features(hdev, &features);
-	if (!err) {
-		/* Set DDC mask for available debug features */
-		btintel_set_debug_features(hdev, &features);
-	}
-
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &version);
 	if (err)
-- 
2.32.0.554.ge1b32706d8-goog

