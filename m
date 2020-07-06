Return-Path: <SRS0=7cy9=AR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508ADC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308E820674
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jl6M085M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgGFUZe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFUZc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 16:25:32 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678BCC061755
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 13:25:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j7so2425530plk.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYYU0UwoMy/TrOAen5MS1rO2nahTd7K1yKosFEDdKU4=;
        b=jl6M085MpXP1jNgwTQeo0D4rx7tqf7+So3lf9DO2o6/fQBK65YQRh/3hRUJPDCo2O7
         W1Z8eEJ7wvst4shvHxUXR5VJTON3x3k0cF9NZuXX4K8BxmQhSwyH7zBGmv7HnvQDH/ro
         HJZR32kRCu3TZkkt8/tvp7o3f0tBKZpvgWp4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYYU0UwoMy/TrOAen5MS1rO2nahTd7K1yKosFEDdKU4=;
        b=CfPwOGxSZCZHsNhJBP/GyHLZWfidZRmXIUyh/pWpCiTUcuyin5YXOq3NDMqsgjp7y2
         w6ORPyD8+HIehpQSAEse+heIMlrMuQyHb+jIzgdOdrce5tAuCO/gYxDsXbc+NY2QDd0/
         BbLXQwZFWfiOiiNuGMwtEgWWb7db1HM14CWh6WJzVevbHW1Zj9p6ln4vAfKBofilcZUd
         cY4e6JAW9zpzuWKRooPycawuQC1DOOxi7rQkT4tCV2jE3edTcnwONXSsybgGzc4UF1x2
         3P66UonE0pYjQFBkWXShujp9FXC9ppkLgwWunOcafXQ3w/SctQfBPpQxazI27p0jXrj5
         V4aw==
X-Gm-Message-State: AOAM531Mp1o/Pu08egPQV+A0IKL/AFDNQzEKt6AVzP5wAEohgaClGKeA
        Gn+xYqNPml67gjlZDMICkWuJSJBEjM0=
X-Google-Smtp-Source: ABdhPJyuoptO/FAMSNzibYd5ThR3oaPC+Yge5n1u9otcN+O2F+n8WgqyWAAzG+Fz7f2ExGO65NSicA==
X-Received: by 2002:a17:902:9a47:: with SMTP id x7mr25498158plv.90.1594067131894;
        Mon, 06 Jul 2020 13:25:31 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id n25sm3320226pff.51.2020.07.06.13.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:25:31 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v7 1/6] mgmt: Add mgmt op and events for device flags
Date:   Mon,  6 Jul 2020 13:25:13 -0700
Message-Id: <20200706132503.BlueZ.v7.1.I3a6c238b09e1a0fad69e69cc2e6f4063af989b37@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200706202518.1153647-1-abhishekpandit@chromium.org>
References: <20200706202518.1153647-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add Get Device Flags, Set Device Flags and Device Flags Changed.

---

Changes in v7: None
Changes in v6: None
Changes in v5:
- Use device_flags mgmt op

Changes in v4: None
Changes in v3: None
Changes in v2: None

 lib/mgmt.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index fad1f3dfe..525c4dd62 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -654,6 +654,27 @@ struct mgmt_cp_set_default_runtime_config {
 	uint8_t parameters[0]; /* mgmt_tlv */
 } __packed;
 
+#define MGMT_OP_GET_DEVICE_FLAGS	0x004F
+#define MGMT_GET_DEVICE_FLAGS_SIZE	7
+struct mgmt_cp_get_device_flags {
+	struct mgmt_addr_info addr;
+} __packed;
+struct mgmt_rp_get_device_flags {
+	struct mgmt_addr_info addr;
+	uint32_t supported_flags;
+	uint32_t current_flags;
+} __packed;
+
+#define MGMT_OP_SET_DEVICE_FLAGS	0x0050
+#define MGMT_SET_DEVICE_FLAGS_SIZE	11
+struct mgmt_cp_set_device_flags {
+	struct mgmt_addr_info addr;
+	uint32_t current_flags;
+} __packed;
+struct mgmt_rp_set_device_flags {
+	struct mgmt_addr_info addr;
+} __packed;
+
 #define MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS	(1 << 0)
 
 #define MGMT_OP_READ_ADV_MONITOR_FEATURES	0x0051
@@ -919,6 +940,13 @@ struct mgmt_ev_exp_feature_changed {
 	uint32_t flags;
 } __packed;
 
+#define MGMT_EV_DEVICE_FLAGS_CHANGED		0x002a
+struct mgmt_ev_device_flags_changed {
+	struct mgmt_addr_info addr;
+	uint32_t supported_flags;
+	uint32_t current_flags;
+} __packed;
+
 #define MGMT_EV_ADV_MONITOR_ADDED	0x002b
 struct mgmt_ev_adv_monitor_added {
 	uint16_t monitor_handle;
@@ -1007,6 +1035,8 @@ static const char *mgmt_op[] = {
 	"Set Experimental Feature",
 	"Read Default System Configuration",
 	"Set Default System Configuration",
+	"Get Device Flags",
+	"Set Device Flags",				/* 0x0050 */
 	"Read Advertisement Monitor Features",
 	"Add Advertisement Patterns Monitor",
 	"Remove Advertisement Monitor",
@@ -1053,6 +1083,7 @@ static const char *mgmt_ev[] = {
 	"Extended Controller Information Changed",
 	"PHY Configuration Changed",
 	"Experimental Feature Changed",
+	"Device Flags Changed",
 	"Advertisement Monitor Added",			/* 0x002b */
 	"Advertisement Monitor Removed",
 };
-- 
2.27.0.212.ge8ba1cc988-goog

