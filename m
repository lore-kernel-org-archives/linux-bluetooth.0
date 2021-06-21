Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C7CC4743C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 10:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A153F611CE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 10:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFUKZ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFUKZw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 06:25:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB08CC0617A8
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 03:23:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m17so5108169plx.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 03:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yfZszNu/qpVMlW2+e/ON9/cSXeVNWmCiXwm+WJdOfww=;
        b=BT6wXhjIXeaw3RAoW0VU3OorirrBKsxCj1aS/BDFFlxcx8lDhaQgnM6Sn8B87Jq95b
         IYmCP6WQs3ZCYL647151LGLodEK53fbydTYMMD9WDVJU+qcqQWcCLnjiL374aGiu4FG3
         zffw4emoiBIfraZYLh2t7znqslNW7mXvSs2Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yfZszNu/qpVMlW2+e/ON9/cSXeVNWmCiXwm+WJdOfww=;
        b=EKraz9TVrdoYH9FyJCtmwBSJQXxoFRgFP0BzlAl4uBcqJNqGmu/uFjUO2jw+lHwCmP
         /qoh9opf2PNeu/uOGGs8Dyz4mpO+sCVrGLEOtrbfyZjvpO4A+rqlpL+B6Fjj5oXc0q1/
         esROwWmRV8El2OegSxcMgpS1ktYhwr8KEo/tYiCfy3U11vU3wo8HLQ2iRBtBcZoVEGPP
         U6fnqriPXWSlLk1bt6EqzrommcgwQkJWfVoX5KQyGcpz4QvoRH1mqLBSdiVwpEdMjVLB
         Dv69wUm1ZebSPx8cSUGSqaTV67nyyCYapdIRMYeL/67Xfk5cTkzZSKyx12wWQwTaPQiu
         0Djg==
X-Gm-Message-State: AOAM530mDJQVZERI4jX8a7UgBUXSwKIy6OaUqX1w7NqhIDvarz5Wcfzm
        Wl5c1g0KmyhLlLHwHmBdRywAqjnHnHoz3A==
X-Google-Smtp-Source: ABdhPJxx5LbM13dNsDS8P0I53zo9sM9lqhNk+XnHeOm7SQr5PrDIeeDadaw5KWMwsc+OAh2zTqRGkA==
X-Received: by 2002:a17:90a:46c8:: with SMTP id x8mr38306889pjg.216.1624271015005;
        Mon, 21 Jun 2021 03:23:35 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:1c86:d28:c4ad:7497])
        by smtp.gmail.com with ESMTPSA id j10sm15375153pjb.36.2021.06.21.03.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 03:23:34 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2 3/3] adapter: set quality report feature
Date:   Mon, 21 Jun 2021 18:23:01 +0800
Message-Id: <20210621182149.BlueZ.v2.3.I5b72c623fb8b002a5e1f000149b362af3c01ab98@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210621182149.BlueZ.v2.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210621182149.BlueZ.v2.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
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
---

(no changes since v1)

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

