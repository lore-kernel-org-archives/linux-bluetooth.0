Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD16BC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B09860FC4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 09:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhHLJQl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Aug 2021 05:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbhHLJQi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Aug 2021 05:16:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DCAC0613D3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 02:16:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a8so8355413pjk.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xPMr4/ugeTOejV/0npnKnxH7FKFFvNEuCvzfZr3CVQ=;
        b=cgXuO8KxZP8omjWubSbzwTrtg3b/PQJyQhmIDSDO7tMYxMm11k61ea1d0p0wCvtYlg
         K5hDtWTr7mGS5rDFJS4JWj1f1tZ0QRJ6ss1XKO821iA9UxaFgi2p6TzU3oIUuRCz+91v
         6Xiz4z6FJpNRSndKfdiOvb+koupYvHFYAEmz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xPMr4/ugeTOejV/0npnKnxH7FKFFvNEuCvzfZr3CVQ=;
        b=OUUKkSjW3XAn4/6aM4lVCqWxVijZZNrf9EgzTkcG6kOMR2oXt8ysC62J5wGCUCjNIO
         z9raaqfKDVXUYKaPQEqHRnUxmDfqXRLh6AQhhD6gE3B2+1OGNtsK+AM5NssnhI/DF6rZ
         efih84/7rqDycZxfrdKdEufmAZkosGQWNfwPff2RuttgC6BbqQ88KMvwktl8LWptRXMH
         39+kb/vrseUerdXx3yOUdHW4QR2ik1ecUk5RsTgzLWA4az8UebKcmsk7ElFnLqci2G0x
         QrVonuAn+dUDPK5gWh1MQzmuSmgjwepDORH/zfMWuh+yYT/TVNWDhMnEuRMZtfKP06OD
         IUbQ==
X-Gm-Message-State: AOAM530v++4aQPpdsjxXdubSoMIHkPZpY4L4s0TvQHPF5/QosqunuCgR
        ipD10gK+RlgRTz71aZotU6Ys7+QqAud51Q==
X-Google-Smtp-Source: ABdhPJzeDt0keUxuuAzh40qBTOf2sm5IToI6wsNS8BXt5bz+he9bpAaqPkxttqmTsRdnIyg5jyaawQ==
X-Received: by 2002:a63:1056:: with SMTP id 22mr3041922pgq.178.1628759772682;
        Thu, 12 Aug 2021 02:16:12 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:8f67:7d0e:97df:b4b4])
        by smtp.gmail.com with ESMTPSA id n32sm2563966pgl.69.2021.08.12.02.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:16:11 -0700 (PDT)
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
Subject: [PATCH v7 1/4] Bluetooth: btusb: disable Intel link statistics telemetry events
Date:   Thu, 12 Aug 2021 17:15:58 +0800
Message-Id: <20210812171533.v7.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
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
2.32.0.605.g8dce9f2422-goog

