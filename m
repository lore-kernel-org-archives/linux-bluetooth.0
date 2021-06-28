Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D46C49361
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 10:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C5B61208
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 10:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhF1KCw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 06:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhF1KCw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 06:02:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F45C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 03:00:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mn20-20020a17090b1894b02901707fc074e8so1325869pjb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Pol7EU6cLeB9bzs3xLMxd7uFMdBT25dp4ht2BBEEjg=;
        b=EasfcQ1k7npcludDjnMCNv539VbR6VT+SDxrwbLD1GW0IAZOHmo1Tqy6ZIR1IdeO6p
         xcDNLLLQ1wDz2DzIf04vuVHNG6bjEUmDIVhStNZ6M5/Dpnun/n2X/ayKYNYpYGfrjEO/
         N5Dr/Wss7F9Rzls0zLx1EUOs7w8/Hg7j4jEDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Pol7EU6cLeB9bzs3xLMxd7uFMdBT25dp4ht2BBEEjg=;
        b=kT0L2Mqpacf5XkdNE6BhBky7eWruLLJ8w8HMqe42Y86b8SlvkRkCHtU7AteGwjXAS2
         ARhlox+StxApiL40+Fri4rcCPBgdPlBOu2bhKxOkHMC/W3eVXfKrpu1PnKVwQvmKzzly
         uAEBGZq8p7gx/ygm/l9J55yIa1E8dUZcFasDzWACK2sbLzZjO64f7/Bszq5CDqf3Psyt
         UEOX59/3uqcSMuPCqUpHgDhvljco4o1AghkQhaXxmliaFZiaFTbVJS+7Eh9Q+bml77W7
         VpYP/22lJM04vqlapn3rlwizj666DzVVjrQelOLjTBefH+9DqvdPI4puMvH47DtLdejA
         RBjw==
X-Gm-Message-State: AOAM5330Ydyb84JHPQ5r6mnayeLmGYQSH1AijmcsGuN5BeJ7RSQYaDBL
        /y7LDUgrtg0ZXIDB2S/9DfELTdKZowApQA==
X-Google-Smtp-Source: ABdhPJzhTUH5SCnOOu70G+RYo2OeTavUW8rXImw037Y4RDE+2gN2mLS64W5X55LGoQXYaa2eXPzAYw==
X-Received: by 2002:a17:90b:1c06:: with SMTP id oc6mr25864671pjb.112.1624874426201;
        Mon, 28 Jun 2021 03:00:26 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:d73e:91da:d7c7:57a])
        by smtp.gmail.com with ESMTPSA id y80sm14003834pfb.204.2021.06.28.03.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 03:00:25 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v4 3/3] adapter: set quality report feature
Date:   Mon, 28 Jun 2021 18:00:16 +0800
Message-Id: <20210628175942.BlueZ.v4.3.I5b72c623fb8b002a5e1f000149b362af3c01ab98@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210628175942.BlueZ.v4.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210628175942.BlueZ.v4.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
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

