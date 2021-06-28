Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FDFC2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 08:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C141861C2F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 08:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhF1IYd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhF1IYb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 04:24:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B50C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 01:22:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ce18-20020a17090aff12b0290170a3e3eb07so258067pjb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Pol7EU6cLeB9bzs3xLMxd7uFMdBT25dp4ht2BBEEjg=;
        b=CePD/aQ44iKLoZD6Sgr4f6wOk5sdH3IVihHU9FfUg7WfBXZeG8IEseazRTXzC+aQTf
         gCjl6BAZAGNLRcN330eba2/GZgb9L2Xvl9evl1fD//S3/5z6kfSWeXeR6f7H/UrRSDPJ
         WjY9WQGKGidxvf7hxbd2KzXrYXr6W4ACL8c4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Pol7EU6cLeB9bzs3xLMxd7uFMdBT25dp4ht2BBEEjg=;
        b=MxpjEdFb/6zIfMyJ8RZN7cKoRTI4RYoqD9lJR/4vXBU4jqt3WloVmjeOsrDS5W5iiF
         oxuJw/nLqcpflS4rjr1h47yujdqsW4TH0DAQGQ5fI+1mS6FAzayiboD7ogUvXvJ003TX
         bkw2nNVy5/LztDu3WxCbHzc25LMVC8RySRZYBcDnqLYIUTir3Y4JL3Cy70i5pTAlykro
         PSjF5Sgrg/I5JtjH2POiPozPuB7Kw7dZJGl+sn9LKtOalb7GNPnx0as5YIMhw5nVj8bM
         ZwUkM9O6WTy3sD1igRyukkJAzifkuqSzdvwGoPWXRDv5bfVMDOzwH4HO8AzD1O5EQmzS
         XLUA==
X-Gm-Message-State: AOAM531cJPOnTrpJLnq7EzVTzRrk3ms3LN/pjaojhxfGAcu+2oCz2Yk/
        DnUmoAeVzIDSuGIDqsyM9TXba0UdlOh5eQ==
X-Google-Smtp-Source: ABdhPJwQm9vlruG4PCeRq1YdAbLNaMAVBw0CukbbMmaM5OWYKi2AnmbXqYkySdde7jNtALlO4xVnMg==
X-Received: by 2002:a17:902:be0d:b029:f9:c913:821f with SMTP id r13-20020a170902be0db02900f9c913821fmr21785788pls.2.1624868526177;
        Mon, 28 Jun 2021 01:22:06 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:d73e:91da:d7c7:57a])
        by smtp.gmail.com with ESMTPSA id b22sm5381125pfp.20.2021.06.28.01.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 01:22:05 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3 3/3] adapter: set quality report feature
Date:   Mon, 28 Jun 2021 16:21:50 +0800
Message-Id: <20210628162107.BlueZ.v3.3.I5b72c623fb8b002a5e1f000149b362af3c01ab98@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210628162107.BlueZ.v3.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210628162107.BlueZ.v3.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
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

