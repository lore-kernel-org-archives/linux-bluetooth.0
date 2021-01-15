Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85736C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 11:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E96C23877
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 11:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbhAOLwI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jan 2021 06:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbhAOLwH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jan 2021 06:52:07 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77056C061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 03:51:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m203so5941116ybf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 03:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/XIu1yF15XLDDCBtIKD5HIRHdICPE4XqWji3+k8jq2Y=;
        b=hr2stXiRUMxi7ghwM2ScROiGLI0ZgJHG3Qu8n4NpT9RnPgeV+oJrxyqzEUk+dmSH9C
         qkAdtcF+Pv+rr0UEjQmeWtoH/u7YPNkZnr/8Ed9Bow7vUXYRhlvSg9evg/S1YuG0US8a
         051tJglgOGwjIsJZNV/YILPaLxd2RftaxKsIFsGVc7UqWzEJAOz/1A0zKpc9TMKqVsae
         GwZDN/AmbY1OeUgaYdh28GUUisjQ+fm+xUXSR7PerBoF2S7ClB8yEC80khYaiyVeAYjE
         NLxnoBeb/H96GF+OJpVbyg4CE2jKIq1wTJkpxTg61lYefvY3FkW8MEscbewBa431lDfB
         P5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/XIu1yF15XLDDCBtIKD5HIRHdICPE4XqWji3+k8jq2Y=;
        b=TpGwK6rCsmn/HXsvJobirw0WUkSHrjc4LbyLJi6t4KX/hIs9iwbOn2DW3YKAmiRQjB
         YQB8mmWQDY/8zNxIDNEVjLNtNsb3jLLrHLrTIxnTSNzKG6naZSDORGyW8Xb7w2OWnCvx
         Dg/wkO7z7zYQ+9zNTmTLsKeSJrcCUsQWjZ76xmc6TDcrEOw4e1v9+X7LCzuCHFCb4eIq
         tBQ58hcZlk9ChgVmVwsr++UH/6hLdaG/lkvBITiFyPKyL3X7HrOYHMBUrKnD+97NRXVv
         zKT45AUZKOfAnzWPvcsu7LdsoDCYKbbSmq+5qTUeS2w2SRGOD8Na+pSi/cXjuy7ZsxU6
         fpUA==
X-Gm-Message-State: AOAM530mjZ2qZb4nYDbupbLFit6VP8uVWsnDgLT1eyCrEgO8UBV+kB7P
        lt7hE3KVQ6aS4Un9nf3LmvYf/YvbsQ/ergVehNCqFZHtyqZ9+QyDGvAAkpFJNyFIoieCz8Kvu0B
        xPxvtYgQd3yi4RvAoqDg4B70KmafxRw6lvV619G+IFncfCm+S1BbfgJxIQBVTpNpETsz0ZrVZgw
        k6
X-Google-Smtp-Source: ABdhPJxXSz3BEWMp0H7J0iiOIdZm2OAF1XxhBpYO0dk84PdA3MVG+Cd3ga44UXrhx51kDFD9+9CN67ZesSPi
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:5f06:: with SMTP id
 t6mr15336521ybb.136.1610711486689; Fri, 15 Jan 2021 03:51:26 -0800 (PST)
Date:   Fri, 15 Jan 2021 19:50:34 +0800
In-Reply-To: <20210115115036.3973761-1-apusaka@google.com>
Message-Id: <20210115194853.Bluez.v4.1.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
Mime-Version: 1.0
References: <20210115115036.3973761-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [Bluez PATCH v4 1/6] lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>,
        Manish Mandlik <mmandlik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

The new op is to utilize RSSI in advertisement monitor

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@google.com>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v2)

Changes in v2:
* Remove trailing period and fix order of mgmt parameter

 lib/mgmt.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index f37f7e6540..76a03c9c24 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -738,6 +738,21 @@ struct mgmt_rp_add_ext_adv_data {
 	uint8_t	instance;
 } __packed;
 
+struct mgmt_adv_rssi_thresholds {
+	int8_t   high_threshold;
+	uint16_t high_threshold_timeout;
+	int8_t   low_threshold;
+	uint16_t low_threshold_timeout;
+	uint8_t  sampling_period;
+} __packed;
+
+#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI	0x0056
+struct mgmt_cp_add_adv_patterns_monitor_rssi {
+	struct mgmt_adv_rssi_thresholds rssi;
+	uint8_t pattern_count;
+	struct mgmt_adv_pattern patterns[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
-- 
2.30.0.296.g2bfb1c46d8-goog

