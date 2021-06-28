Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDE7C49361
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 10:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F40611B0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 10:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhF1KCu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 06:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhF1KCt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 06:02:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78B6C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 03:00:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso10370258pjx.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVlFgFCxaWRw37gYpSX+JcptxmlyyJYMOHEGZTzQPAM=;
        b=gnW2C6zGgwudemJGN7z5cIXe1Xeu7NcUnAdq4iv6XqwNNAJoF0aUYXkfyeGS+DdBtC
         INORydznhcsy/25G0t1nj4MV+fcs7sHTgmmAdILlD7mwqvzsC2/TnqF7peM2vhPqSl9u
         OBrO3E4ao2WodbbjXJMuUP33RTWpOWIEFMCMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVlFgFCxaWRw37gYpSX+JcptxmlyyJYMOHEGZTzQPAM=;
        b=h8CJA5cWUoIpvZ5jj+DH42+Ur+OgKyynFa09tZyr+kR2pOoB8lz9p8wXccXM3aZi6P
         4yypjbeZtBXCX4Q/OOggsXp/T7yeHRjLxP5gVrn158bLuBSZ+5CzDCCvyBotKMS1SA8P
         +uBACWLiBgu4K6iIy56TrmmVlUULJsd0OU/G+46UHYHf+OH+fbAJxPKPZUtl7tjJ+t0R
         jNfkmikEVuYIa7PFuVpHzBgv7Gbwlr9T5SLReoGmIQIntNjbau8xB0mM446a2SNTtJ2f
         zeeEzUFUWsHHXcgF8XAVQURcEOrczZnYl//sxmyigviMwprKYoHrZ6KV5Z87soiU1ZtO
         Uueg==
X-Gm-Message-State: AOAM530d8KPW8YCzNhYi7Kd+SVzFgR+0drKoVlWOwmqkPyoK/QAZzCl3
        XSILv07kQnVlC8Uyr7BDJ5mjmul99qBs5A==
X-Google-Smtp-Source: ABdhPJyl7o2ajMmX6tKSzwEiSbcT2fEG8P9UQhxCGKUx/G/BBgsjQ2ofNAG9KBRhDa/DqBKTxCXbVw==
X-Received: by 2002:a17:90a:3844:: with SMTP id l4mr4938280pjf.137.1624874424116;
        Mon, 28 Jun 2021 03:00:24 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:d73e:91da:d7c7:57a])
        by smtp.gmail.com with ESMTPSA id y80sm14003834pfb.204.2021.06.28.03.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 03:00:23 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v4 2/3] adapter: read quality report feature
Date:   Mon, 28 Jun 2021 18:00:15 +0800
Message-Id: <20210628175942.BlueZ.v4.2.I7d16f055bc51ac86915c114c671743f49a1fc226@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210628175942.BlueZ.v4.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210628175942.BlueZ.v4.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds a new UUID for the quality report experimental
feature. When reading the experimental features, it checks if
the new feature is supported by the controller and stores the
value in the quality_report_supported flag of the adapter.

The quality_report_supported flag could be used by the bluetoothd
to determine if the quality report feature can be enabled.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 src/adapter.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 98fc78f1e..e2873de46 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -284,6 +284,7 @@ struct btd_adapter {
 	bool is_default;		/* true if adapter is default one */
 
 	bool le_simult_roles_supported;
+	bool quality_report_supported;
 };
 
 typedef enum {
@@ -9234,6 +9235,12 @@ static const uint8_t le_simult_central_peripheral_uuid[16] = {
 	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
 };
 
+/* 330859bc-7506-492d-9370-9a6f0614037f */
+static const uint8_t quality_report_uuid[16] = {
+	0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
+	0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33,
+};
+
 /* 15c0a148-c273-11ea-b3de-0242ac130004 */
 static const uint8_t rpa_resolution_uuid[16] = {
 	0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
@@ -9276,6 +9283,14 @@ static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
 	adapter->le_simult_roles_supported = flags & 0x01;
 }
 
+static void quality_report_func(struct btd_adapter *adapter, uint32_t flags)
+{
+	adapter->quality_report_supported = le32_to_cpu(flags) & 0x01;
+
+	btd_info(adapter->dev_id, "quality_report_supported %d",
+			adapter->quality_report_supported);
+}
+
 static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
@@ -9313,6 +9328,7 @@ static const struct exp_feat {
 	EXP_FEAT(debug_uuid, exp_debug_func),
 	EXP_FEAT(le_simult_central_peripheral_uuid,
 		 le_simult_central_peripheral_func),
+	EXP_FEAT(quality_report_uuid, quality_report_func),
 	EXP_FEAT(rpa_resolution_uuid, rpa_resolution_func),
 };
 
-- 
2.32.0.93.g670b81a890-goog

