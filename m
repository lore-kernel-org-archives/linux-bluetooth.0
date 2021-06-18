Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD1C48BE8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 07:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43307613D6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 07:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhFRH7q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jun 2021 03:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhFRH7o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jun 2021 03:59:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86001C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 00:57:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k15so1902162pfp.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pPqziRSzqZjXI99FuqjKJHhPX4q0+WvBG0td3HE735A=;
        b=fVEP1+MDSQ62AzyHwt7jTxL/RQJ1zACl/eBl5Ni+/9zt+dBN+XRgv/j4zKKMHtZuLp
         7t5o+Fr4j39JwIgBQq/dCDwuO/jUKWeIuRlOEZNpaTmpneDA0BJQ/paZ4h7iw+LZ80FU
         DmT9fMnBVezxQPwSLoW/AG3d+TcWje3Sd3PZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pPqziRSzqZjXI99FuqjKJHhPX4q0+WvBG0td3HE735A=;
        b=VxnZGJTXALt98iId/W9PRhgBAOyFudARsnyn7TY7Wc6SsE2DiSwXKI+VEDKttNgrFS
         zC5bT9z17s/hYREm7ucI2SCPCmGT59TVkPFL8kTyxLFDqaNaOZ/e8Bbu8rl4ECwSfAD5
         N9aXNA4wYnbPr6KUpVuDJvV+SHtZYRpLpeNS3PfumrKkEwEemW0dGqh9W5TeSuQzdUNx
         +cmAF3k21dPfiOOZxCQpj1E3/TkYuVEyTU0MiXB0GRjbjqpKTQDesgk2k/FZdoZ+7AL6
         l/SHkdPkd8ydeASiqc4X/lufq0BR3mJdcO5J1EHWQXrIpKDVP5+c/f7EC4a2lwlnH6Nv
         bGsA==
X-Gm-Message-State: AOAM530bEyDrs344udBCHYShZcqBhkMOHDkvEBvNB82AYgGCH6OHSZRU
        E5BW6QosB7r/7Cg4F59Qu0wIwnfG1Uzmhg==
X-Google-Smtp-Source: ABdhPJy+5YzVKgfFUkN2/wkKGw+a8addIb6CSosPKBoQAKtiK29BBxKkUubNQ9ERayR3MX/NFhOncA==
X-Received: by 2002:a62:f20a:0:b029:300:43ed:198d with SMTP id m10-20020a62f20a0000b029030043ed198dmr1295807pfh.55.1624003052734;
        Fri, 18 Jun 2021 00:57:32 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6cbb:95eb:e2ae:8479])
        by smtp.gmail.com with ESMTPSA id z185sm7879219pgb.4.2021.06.18.00.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 00:57:32 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH v1 3/3] adapter: set quality report feature
Date:   Fri, 18 Jun 2021 15:57:17 +0800
Message-Id: <20210618155610.v1.3.I5b72c623fb8b002a5e1f000149b362af3c01ab98@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618155610.v1.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210618155610.v1.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the function to enable/disable the quality report
experimental feature in the controller through MGMT_OP_SET_EXP_FEATURE.

A user space process can enable/disable the quality report feature
by sending a property changed signal to the bluetoothd. The bluetoothd
can set up the signal handlers to handle the signal in a file under
plugins/ to call this function.

Note that the bluetoothd calls the experimental feature only when
the quality_report_supported flag is true.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

 src/adapter.c | 36 ++++++++++++++++++++++++++++++++++++
 src/adapter.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index e2873de46..829d9806b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9332,6 +9332,42 @@ static const struct exp_feat {
 	EXP_FEAT(rpa_resolution_uuid, rpa_resolution_func),
 };
 
+/* A user space process can enable/disable the quality report feature
+ * by sending a property changed signal to the bluetoothd. The bluetoothd
+ * can set up the signal handlers in a file under plugins/ to call
+ * this function.
+ */
+void btd_adapter_update_kernel_quality_report(uint8_t action)
+{
+	struct mgmt_cp_set_exp_feature cp;
+	struct btd_adapter *adapter;
+
+	adapter = btd_adapter_get_default();
+	if (!adapter) {
+		info("No default adapter. Skip enabling quality report.");
+		return;
+	}
+
+	if (!adapter->quality_report_supported) {
+		info("quality report feature not supported.");
+		return;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.uuid, quality_report_uuid, 16);
+
+	cp.action = action;
+	if (cp.action > 1) {
+		error("Unexpected quality report action %u", cp.action);
+		return;
+	}
+
+	mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE, adapter->dev_id,
+			sizeof(cp), &cp, NULL, NULL, NULL);
+	info("update kernel quality report default adapter %d enable %d",
+		adapter->dev_id, cp.action);
+}
+
 static void read_exp_features_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
diff --git a/src/adapter.h b/src/adapter.h
index 60b5e3bcc..001f784e4 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -240,3 +240,5 @@ enum kernel_features {
 };
 
 bool btd_has_kernel_features(uint32_t feature);
+
+void btd_adapter_update_kernel_quality_report(uint8_t action);
-- 
2.32.0.288.g62a8d224e6-goog

