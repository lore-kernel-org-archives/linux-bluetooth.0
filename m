Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7CAC77B75
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 May 2023 00:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjEIAPC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 May 2023 20:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEIAPB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 May 2023 20:15:01 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258031BC5
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 May 2023 17:15:00 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33494fe24b5so26480865ab.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 May 2023 17:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683591299; x=1686183299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QP2u4dzfbHtwtJDzfyrnAqvEHvqfz1qEEK080Ga+21M=;
        b=rBKnkPEXIWF8sB/5XTt8kwXQMs0SZR9+m3NwyZuyTDsySuga3m9KWfuXUPiH9lXmaO
         1vg7sbYzXP0h5q0ZzF8yXAg0GNwu4ehE7bPh+BSsc2E+y3TSPWQJeoxA/NlAywREqsEG
         eF9UXGT0Lad3XMrufKYcDEJJt0jLzAfPwDhRxAngD0nnertsl3KBgQP7QauhGtZlsUBr
         py8ghxz8ghjOmL5lqKOnLY5oi7cOF9H+r2zCnEecRbmjI3NYYCVfEUljiD8eSJMxzbr3
         xKcv+UKjS0D9xGMYMkcMDa03Y4LUyMcrzqphrG6XZgZ+42AoCR/WYb/V26MIQMd3Bq0m
         Pg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683591299; x=1686183299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QP2u4dzfbHtwtJDzfyrnAqvEHvqfz1qEEK080Ga+21M=;
        b=gjSbGkcKk2Jh6O5ZN8xuGWw+xLk8Y9FcqQSviXr1rwbx0tHITIe8qNINOnXKbsatKO
         ISuL2YSkhFrXzcC9AuLdZ88wno1IecyTDEuk2m+qCSPD+s08qScAEQslV2OiidgjU+Cl
         rebMYhy6AsdM/bCmnwDpGqnKmIpBc5Fi5ujGbq9MFkCiwwt9j/Btq3Mf93EcjA62gAbT
         dfTH9lSsuAF5EHP3KEa75ZeWFGOV6cvxIMktIx3pMha2u/OoQhmaBKs2pmbq+zeC+Ivk
         dwBmaEFon4tN0Vh5gy0OaEhrDCIQgrER1/xMTqTy5c9LAxZKM4VujR1wAd6H1VCPWeiH
         L73A==
X-Gm-Message-State: AC+VfDxIJdbr+i4Ev5+Si/dyHVnRA0kZgJKUNRzXwnJ5+JfnVLLvT3CH
        s5daoLQ5NSWZoDsxfZ8E/MEr/JmzzjBV8g==
X-Google-Smtp-Source: ACHHUZ4FaET94Yenf+XsIvjAm/zbHtmRqQeURKLLRDwgCluvQWkZrtos0SMXIETlVgV+c35CMBcDvQ==
X-Received: by 2002:a92:cb10:0:b0:334:9ab1:b3c3 with SMTP id s16-20020a92cb10000000b003349ab1b3c3mr7415592ilo.19.1683591298581;
        Mon, 08 May 2023 17:14:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t7-20020a056e02010700b00328c680966fsm2765228ilm.0.2023.05.08.17.14.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:14:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: Cleanup code related to btintel_set_quality_report
Date:   Mon,  8 May 2023 17:14:55 -0700
Message-Id: <20230509001455.3111623-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btintel_set_quality_report shall only be registered if debug features
related to it are registered so it is moved under
btintel_register_devcoredump_support since that already performs the
necessary checks and doing this avoid having to call
btintel_read_debug_features everytime set_quality_report is toggled.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 50 +++++++------------------------------
 1 file changed, 9 insertions(+), 41 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d9349ba48281..bf80ae913a7c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1282,7 +1282,7 @@ static int btintel_read_debug_features(struct hci_dev *hdev,
 	skb = __hci_cmd_sync(hdev, 0xfca6, sizeof(page_no), &page_no,
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "Reading supported features failed (%ld)",
+		bt_dev_dbg(hdev, "Reading supported features failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
@@ -1360,8 +1360,7 @@ static acpi_status btintel_ppag_callback(acpi_handle handle, u32 lvl, void *data
 	return AE_CTRL_TERMINATE;
 }
 
-static int btintel_set_debug_features(struct hci_dev *hdev,
-			       const struct intel_debug_features *features)
+static int btintel_set_debug_features(struct hci_dev *hdev)
 {
 	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x7f, 0x00, 0x00, 0x00, 0x00,
 			0x00, 0x00, 0x00 };
@@ -1369,16 +1368,6 @@ static int btintel_set_debug_features(struct hci_dev *hdev,
 	u8 trace_enable = 0x02;
 	struct sk_buff *skb;
 
-	if (!features) {
-		bt_dev_warn(hdev, "Debug features not read");
-		return -EINVAL;
-	}
-
-	if (!(features->page1[0] & 0x3f)) {
-		bt_dev_info(hdev, "Telemetry exception format not supported");
-		return 0;
-	}
-
 	skb = __hci_cmd_sync(hdev, 0xfc8b, 11, mask, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Setting Intel telemetry ddc write event mask failed (%ld)",
@@ -1409,24 +1398,13 @@ static int btintel_set_debug_features(struct hci_dev *hdev,
 	return 0;
 }
 
-static int btintel_reset_debug_features(struct hci_dev *hdev,
-				 const struct intel_debug_features *features)
+static int btintel_reset_debug_features(struct hci_dev *hdev)
 {
 	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00,
 			0x00, 0x00, 0x00 };
 	u8 trace_enable = 0x00;
 	struct sk_buff *skb;
 
-	if (!features) {
-		bt_dev_warn(hdev, "Debug features not read");
-		return -EINVAL;
-	}
-
-	if (!(features->page1[0] & 0x3f)) {
-		bt_dev_info(hdev, "Telemetry exception format not supported");
-		return 0;
-	}
-
 	/* Should stop the trace before writing ddc event mask. */
 	skb = __hci_cmd_sync(hdev, 0xfca1, 1, &trace_enable, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
@@ -1452,23 +1430,15 @@ static int btintel_reset_debug_features(struct hci_dev *hdev,
 
 int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
 {
-	struct intel_debug_features features;
 	int err;
 
 	bt_dev_dbg(hdev, "enable %d", enable);
 
-	/* Read the Intel supported features and if new exception formats
-	 * supported, need to load the additional DDC config to enable.
-	 */
-	err = btintel_read_debug_features(hdev, &features);
-	if (err)
-		return err;
-
 	/* Set or reset the debug features. */
 	if (enable)
-		err = btintel_set_debug_features(hdev, &features);
+		err = btintel_set_debug_features(hdev);
 	else
-		err = btintel_reset_debug_features(hdev, &features);
+		err = btintel_reset_debug_features(hdev);
 
 	return err;
 }
@@ -1512,16 +1482,17 @@ static int btintel_register_devcoredump_support(struct hci_dev *hdev)
 	int err;
 
 	err = btintel_read_debug_features(hdev, &features);
-	if (err) {
-		bt_dev_info(hdev, "Error reading debug features");
+	if (err)
 		return err;
-	}
 
 	if (!(features.page1[0] & 0x3f)) {
 		bt_dev_dbg(hdev, "Telemetry exception format not supported");
 		return -EOPNOTSUPP;
 	}
 
+	/* Set up the quality report callback for Intel devices */
+	hdev->set_quality_report = btintel_set_quality_report;
+
 	hci_devcd_register(hdev, btintel_coredump, btintel_dmp_hdr, NULL);
 
 	return err;
@@ -2599,9 +2570,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 	set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
 
-	/* Set up the quality report callback for Intel devices */
-	hdev->set_quality_report = btintel_set_quality_report;
-
 	/* For Legacy device, check the HW platform value and size */
 	if (skb->len == sizeof(ver) && skb->data[1] == 0x37) {
 		bt_dev_dbg(hdev, "Read the legacy Intel version information");
-- 
2.40.0

