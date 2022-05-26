Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDA0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 11:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347156AbiEZLZU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 07:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245265AbiEZLZT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 07:25:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CDB5C75B
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:25:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gz24so1494665pjb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQyL9hl58hb4vBidS+w324Rh2XQfFyfi08875p0ZLPg=;
        b=WLXPXgIJX3xvBTUQuKVSEKPGh2wJxUPPuHbODQkDjjNNdWkUrjX5Au+GqN4FCSJTV5
         Og8T10RYl390Ky/z08zRwCui5dmfGQVYb25NclFuo6jWPg0X2uHDI2VzAG0MjnhtPoau
         B7ULeDobUAg36D0o0zkLBT3+ED0qjXpo+3ZQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQyL9hl58hb4vBidS+w324Rh2XQfFyfi08875p0ZLPg=;
        b=KmfG75iVkgcsj/8daC8tO0++uPL0Ytmt/EX46UmM5+2d9ddNSEvTAQjKW3nHywNmlU
         DQwSkUikwL5MuAC06eTDhNaTCgUl/n7I8guRiYAAT/WpO7Ht37XF7naJuOFyIh1Tih1K
         jhNQAo3QXE1qwfO172K4nH2zW8uf059K+XC4en16Nur425srcTVoq2QXa4mgLoPahe0Q
         UZeebFigKMYrJLGvbYsx4/DnxiZMsDAQwQjS01tJ8VJxuoIDFYbDHtoKzQLjjDdoazt1
         C7pzRloq4fZxz8L48Hu77fy+cW48+yr4uziLh3PHHrms6yVQlmENj6X3er/QQyoismXW
         YWuQ==
X-Gm-Message-State: AOAM532k0CyVJhFgVsjyXKvIxeBgTeEB0gGS3KmX+4QMh55ZxNh+Yl8E
        A4pVKRYdrzMZ5JlQo21VvADVR6QOOIFJPw==
X-Google-Smtp-Source: ABdhPJwSbGbxjgeSguwP3RnhyhZXrhOSdRoHX7J/CzjmarskMCPSZEfa/A9todHRLI/U+qQreHcVYA==
X-Received: by 2002:a17:90a:149:b0:1df:3da1:3549 with SMTP id z9-20020a17090a014900b001df3da13549mr2131852pje.90.1653564318050;
        Thu, 26 May 2022 04:25:18 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id u9-20020aa78489000000b0050dc76281a4sm1233530pfn.126.2022.05.26.04.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 04:25:17 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v6 7/8] monitor: print quality report cmd
Date:   Thu, 26 May 2022 19:24:55 +0800
Message-Id: <20220526112456.2488536-5-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220526112456.2488536-1-josephsih@chromium.org>
References: <20220526112456.2488536-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch prints the set quality command properly.

---

(no changes since v4)

Changes in v4:
- Use get_u8() to replace *(uint8_t *).
- Use mgmt_new_settings_rsp as the rsp_func in mgmt_command_table
  for Set Quality Report.

Changes in v3:
- This is a new patch that prints the set quality command.

 monitor/packet.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index e854c1a8e..851296ee6 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12552,6 +12552,7 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 15, "Static Address"		},
 	{ 16, "PHY Configuration"	},
 	{ 17, "Wideband Speech"		},
+	{ 18, "Quality Report"		},
 	{ }
 };
 
@@ -14148,6 +14149,13 @@ static void mgmt_remove_adv_monitor_patterns_rsp(const void *data,
 	print_field("Handle: %d", handle);
 }
 
+static void mgmt_set_quality_report_cmd(const void *data, uint16_t size)
+{
+	uint8_t action = get_u8(data);
+
+	print_field("Set Quality Report %u", action);
+}
+
 struct mgmt_data {
 	uint16_t opcode;
 	const char *str;
@@ -14405,6 +14413,9 @@ static const struct mgmt_data mgmt_command_table[] = {
 				mgmt_add_adv_monitor_patterns_rssi_cmd, 8,
 									false,
 				mgmt_add_adv_monitor_patterns_rsp, 2, true},
+	{ 0x0057, "Set Quality Report",
+				mgmt_set_quality_report_cmd, 1, true,
+				mgmt_new_settings_rsp, 4, true },
 	{ }
 };
 
-- 
2.36.1.124.g0e6072fb45-goog

