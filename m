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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A13C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD7A233A2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbhAMJuF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbhAMJuF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 04:50:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E376EC061786
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:49:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 203so1790687ybz.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=R+wTHO6wnLf9gNyvcUqHBZvSDHE9qaSnSvUAn6jHyrE=;
        b=UUNdC0eJbk5PSKOo06sQnVYr+THs4/lW8BxtW09Pi180edQJKFYFEol0Kh52kbwWe9
         4TjgyFo0PROjTARhcQHxi5NfV+QFSThBfnd2jreLZ7kJbUCIT7M4dw48JuP/xJNxvJC7
         cfgBGKC07YegFPqmyGg3QdUgquAnJ8IR3M0A1d7nzZn2+0QoQOZRmPY/IAI8jTfd9GXj
         vPZgy5LbZFPSY8i3kqBnDBQa6oemLxso60rO/6hR1VhhkQJSdq3ew26ExyQr7TLqXQ25
         pPO8qNsuENgyYCRX8kXw8f7J00pkael37hdJrtEFGnkilrB4pIUaA9aB316FSrKxhZCb
         oD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R+wTHO6wnLf9gNyvcUqHBZvSDHE9qaSnSvUAn6jHyrE=;
        b=B0I40EMY1SsjAhFakgNLPFiDmbxTs7OCRjLZVcE23cOkxcLKuql8n1651EdvkwqeoN
         Gg+iKNo5zFmTGZk+OWqWWbsfqFXtNqTMW5fjUVHzQbqhRZhpRYHcG5m+yGIAb1BnQcjy
         3x10Rc90vm1tAM+CVbHJpl6Yfgn3QEWYKXD9vf9/JiVV8dws7cHDRF0CB6rw1zLa2EJn
         cFLw0TrOI/KS7nHi++iRY1CwgR9GXSo0/Pyu0Kgx0UHnYs0vaFu2AlHl6WJpCZcF37za
         T9nYp1ZMCvJw0QTNwJwqIt7Q9i99fK95jYfr+Iizz6UN1Zo0FhfJWueW/tY424PcaisW
         Tz0w==
X-Gm-Message-State: AOAM532fOkagqrukTevDNubrnBpS0l8dYWCkgXsIS4rJfbfyr16Zc3+L
        t3BseAY0KLBIsXdAtsWGAGz5xKnn8P3yA6PvwXHq1t7pszN/3e171TIShx0xeLjAJ7PUMnL+BQR
        w8AYNw2xu5Rat3KZlZV7HiR+E4Su4yMUpuyLtclmC/FiCP3+BKOJJcbUKi8Zd3UOygCRs+IBudi
        Hu
X-Google-Smtp-Source: ABdhPJzO0joIA5dnsG3DMfohDYOenrmRo2vS6TwuLNeyld8B66nALCXjbCxB7KHuBIgXDPlokNyJkHrXZjmS
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:6755:: with SMTP id
 b82mr609821ybc.232.1610531364069; Wed, 13 Jan 2021 01:49:24 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:49:01 +0800
In-Reply-To: <20210113094905.2787919-1-apusaka@google.com>
Message-Id: <20210113174829.Bluez.v2.1.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
Mime-Version: 1.0
References: <20210113094905.2787919-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [Bluez PATCH v2 1/5] lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode
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

Changes in v2:
Remove trailing period and fix order of mgmt parameter

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
2.30.0.284.gd98b1dd5eaa7-goog

