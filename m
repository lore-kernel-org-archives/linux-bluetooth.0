Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559F9C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 16:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DAAD6103A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 16:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhHMQwX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbhHMQwW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 12:52:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6289C0617AD
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 09:51:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a20so12812088plm.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwvlmIW3sKwwfKbchmjaCB92kRmEpG8rF5msAYBmFTs=;
        b=m6CGbPdNNJDSL6N64bluj3z2soh/Ofd4U4droZIpBt9DHnRNS0zECLxarnxW2HUq0A
         kv26UTnUKmgJgHVQP74LhQd1bZ7WSTuAygAdFpemd78QJ/NIOPiJkM8QShYxof3gMpLX
         1D2zpRzILnMIfhrUJYWZ1H7J8TOA6AsUuEpIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwvlmIW3sKwwfKbchmjaCB92kRmEpG8rF5msAYBmFTs=;
        b=JFRGLliwURap80G2uKPIkSb0q1oX77UNnzosKWj9orcUeI5GMMHrhRU7TgVaE/XlRW
         Q/tR+AlyE/BYxkT7lgat5b2K9yoIJWfiNMPl4SAu7Xe6DUQ+fo10cRlX5kVSRkSgcQei
         hM/nku6J4opaB84yrPaz327Ut89mFg/erg2MP2PTCLGlX2BNj+H2g2khWQiWKE7qHlrA
         r8ZNdUhfLtHzj0rFtdsxspszg4WGcgCePWL6zlH6ECJ5IorGViKsXbvFDMBWCBabc9Nh
         4lf9P9aS/mXj9DP1w4I5jY7D0tNof/WDf6e0zqAhC+VpoeQKBNjQIOEarL6WW8f/14wB
         aO5A==
X-Gm-Message-State: AOAM5322h0GIbjgn9CmiH2rV5cUmQ5ZpxcIcBolg3/VL0P7ffp8iRmxQ
        GZ/gmhe3uA3zqmsbk6Y7iIpvL/RvFxgzBw==
X-Google-Smtp-Source: ABdhPJwRavtFY7T4cke/4Qzqi4atpJ7JkAgxq8GUyxZnbWX1+cCDbr/xreSEK6wOS/Nl98SYDYRveQ==
X-Received: by 2002:a17:902:d645:b029:12c:2759:ce2b with SMTP id y5-20020a170902d645b029012c2759ce2bmr2758181plh.58.1628873514787;
        Fri, 13 Aug 2021 09:51:54 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:755d:cdee:3203:71c5])
        by smtp.gmail.com with ESMTPSA id w3sm2907407pfn.96.2021.08.13.09.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:51:53 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiran.k@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/5] Bluetooth: btusb: disable Intel link statistics telemetry events
Date:   Sat, 14 Aug 2021 00:51:44 +0800
Message-Id: <20210814005024.v8.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
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

Changes in v8:
- This version adds a new patch which refactors the set_exp_feature
  function with a feature table.
- Swap the patches per the comments on v7.
- Remove the unsuitable debug messages.
- This patch is not changed in this version.

Changes in v7:
- Rebase on Tedd's patches that moved functionality from btusb to
  btintel.

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

 drivers/bluetooth/btintel.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index f1705b46fc88..0fe093fa5158 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1893,7 +1893,6 @@ static int btintel_bootloader_setup(struct hci_dev *hdev,
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 
 	BT_DBG("%s", hdev->name);
 
@@ -1934,15 +1933,6 @@ static int btintel_bootloader_setup(struct hci_dev *hdev,
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
 	err = btintel_read_version(hdev, &new_ver);
 	if (err)
@@ -2089,7 +2079,6 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 	struct intel_version_tlv new_ver;
 
 	bt_dev_dbg(hdev, "");
@@ -2125,15 +2114,6 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
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
 	err = btintel_read_version_tlv(hdev, &new_ver);
 	if (err)
-- 
2.33.0.rc1.237.g0d66db33f3-goog

