Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E7CC11F67
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 07:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893C861DE3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 07:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhF2HuI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jun 2021 03:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbhF2HuI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jun 2021 03:50:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3E7C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jun 2021 00:47:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id d12so17728572pgd.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jun 2021 00:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Pol7EU6cLeB9bzs3xLMxd7uFMdBT25dp4ht2BBEEjg=;
        b=V5MNpof1PuRabfyaJvj7DmJL47DUKQK52lCaUhTcVjtKbsqwwETxYrpMQHRCMo8fNA
         AYSrye4KjNJm1Q3TvvW8W4AQSEa+9sUXpY0e3q5QetIB1MGwEk2SVV3y86WrreikWkty
         C5tcgYhf//EWCf7vLn+L9qaq8BFekOGL1ADLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Pol7EU6cLeB9bzs3xLMxd7uFMdBT25dp4ht2BBEEjg=;
        b=eDbFBoWRMU92HVnKiu5p3ZGmyn09qRqTtq4wkwkmmrGjTBS4w1ObM7Ks0usugyge2V
         X7H+b4t5VA+dEQ7BXjP+/1y+f5gYbHnYQ25zHwRCOaHoYKlNh23zq/I0kyB1e4s1RQW0
         cc4uMi/vzacOMw4qYR8Xk57QsBHFKVqIVu69Td0zZz7vpEvxE+COa3epR1/T0Ui6vPff
         YCysuYh0HY1Cj1yMnoerFwrNDUgSfLrkw+2DHYL7aSpTPR5sUUs/6GsZPUyEDwRm64lz
         w87VDVaR7gSswB5D+VhBL4RDUdjqOqqPEya4TjsmBoPN0cS0NFTx32CplHElFt1C3nLU
         J/mw==
X-Gm-Message-State: AOAM533qa0P8w9wA7uga2yDmyM44JqfJu6j739v5iyIHHvlu9FyQPSBV
        8ChaM0ERya3kAQzPnPHoUvCcCh0fZ6IkQA==
X-Google-Smtp-Source: ABdhPJwV5PuD/et0H7Xho7iPUhBD8rAtxJEaudng0THOrWKb8BzDQT8YQSqO+ZfJnlZhWLGgj4Y0mw==
X-Received: by 2002:a62:8647:0:b029:302:4642:ae52 with SMTP id x68-20020a6286470000b02903024642ae52mr28776168pfd.7.1624952860375;
        Tue, 29 Jun 2021 00:47:40 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:1fca:2281:244f])
        by smtp.gmail.com with ESMTPSA id s7sm17454289pjr.11.2021.06.29.00.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 00:47:40 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5 3/3] adapter: set quality report feature
Date:   Tue, 29 Jun 2021 15:47:24 +0800
Message-Id: <20210629154652.BlueZ.v5.3.I5b72c623fb8b002a5e1f000149b362af3c01ab98@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210629154652.BlueZ.v5.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210629154652.BlueZ.v5.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
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
2.32.0.93.g670b81a890-goog

