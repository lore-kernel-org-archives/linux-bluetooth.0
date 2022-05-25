Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819FBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 10:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiEYKur (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 06:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiEYKuo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 06:50:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F4F9588
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:50:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n8so18243326plh.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WgMfVFnH8jyFYZO3ukTuQ7o6AcL+561H2M0Rv8Ez+U=;
        b=ALxfFLlMcnd0XUiLYxhfqxG7+2r5kbxxca58hdl5c1U0l4hEiYIqtAowFOuv3+ZSTw
         E6KS2jxg7VWTzOuX+31ZxbM4/wmrtxodtTus4h3MvI0ohl2R58y1BcTdt1puDVZe7t/B
         qWqlNXfZsx5u+05GVceDcfv7Ovri9uHn8MOpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WgMfVFnH8jyFYZO3ukTuQ7o6AcL+561H2M0Rv8Ez+U=;
        b=7LUwfQSZ2xk6KWHqykpS634zRtiB9UjF/S76OkEaxFkHCi8nu84bMj5Xltu0VyHQOI
         E7oW4Qho4gMqNWuh9M2BJUKeqyiAE77CXKyihkEpK5547gpuR9akLYnJudIY9rc75UZv
         bqCEAdcBTa1E8h9Hia5NBaFfY/ZQDQrUDmqBKHhsgenciwo3pQjNYaigKb7uoH2IZHd9
         bSigweMgJ4Jn9TbVIckNC4DOwEHUBkEJ+RCQCxDK0ey+xgBk5AKgHpVzOIBSTNAm+RJm
         5RwnHW95iXefAsOkKgqXwtXuYEvYpIVGiVrXfhOmaCrbhlq7uMydnK4cWdEIP1KN/2Oa
         QS2w==
X-Gm-Message-State: AOAM5315OMU0IcAUiN0TKOVVJZLwGopnTQCaY1UWrg7s2639EAu5EMKl
        pvpjk55EUBK1Y1qJ3mvFlRIYh8PZMYre3g==
X-Google-Smtp-Source: ABdhPJw1TXXatUenZw29f1sc8cRqDMbq/7K1TUYqfHhoUN91+BzpwIietTsIbckbo9BF8ynfULX9oQ==
X-Received: by 2002:a17:90b:4a0f:b0:1e0:edc:c1f with SMTP id kk15-20020a17090b4a0f00b001e00edc0c1fmr9710691pjb.93.1653475842842;
        Wed, 25 May 2022 03:50:42 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id h9-20020aa786c9000000b0050dc7628196sm10955036pfo.112.2022.05.25.03.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 03:50:42 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v5 6/8] tools/btmgmt: fix quality report command
Date:   Wed, 25 May 2022 18:50:13 +0800
Message-Id: <20220525105015.2315987-4-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220525105015.2315987-1-josephsih@chromium.org>
References: <20220525105015.2315987-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The set quality report feature becomes a mgmt command and
is not included in the experimental features any more.

---

Changes in v5:
- Use quality_report instead of action in cmd_exp_quality().

Changes in v4:
- Add "quality-report" in settings_str.
- Print current_settings in quality_rsp.

Changes in v3:
- This is a new patch that fixes the quality on/off command in
  btmgmt.

 tools/btmgmt.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 8f63f12ba..bab67e63b 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -353,6 +353,7 @@ static const char *settings_str[] = {
 				"static-addr",
 				"phy-configuration",
 				"wide-band-speech",
+				"quality-report",
 };
 
 static const char *settings2str(uint32_t settings)
@@ -1842,26 +1843,28 @@ static void cmd_exp_privacy(int argc, char **argv)
 	}
 }
 
-static void exp_quality_rsp(uint8_t status, uint16_t len, const void *param,
+static void quality_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
-	if (status != 0)
+	const struct mgmt_rp_set_quality_report *rp = param;
+	uint32_t current_settings;
+
+	if (status != 0) {
 		error("Set Quality Report feature failed: 0x%02x (%s)",
 						status, mgmt_errstr(status));
-	else
-		print("Quality Report feature successfully set");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	current_settings = le32_to_cpu(rp->current_settings);
+	print("Quality Report feature successfully set");
+	print("\tcurrent settings: %s", settings2str(current_settings));
 
 	bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_exp_quality(int argc, char **argv)
 {
-	/* 330859bc-7506-492d-9370-9a6f0614037f */
-	static const uint8_t uuid[16] = {
-				0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
-				0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33,
-	};
-	struct mgmt_cp_set_exp_feature cp;
+	struct mgmt_cp_set_quality_report cp;
 	uint8_t val;
 
 	if (mgmt_index == MGMT_INDEX_NONE) {
@@ -1878,11 +1881,10 @@ static void cmd_exp_quality(int argc, char **argv)
 	}
 
 	memset(&cp, 0, sizeof(cp));
-	memcpy(cp.uuid, uuid, 16);
-	cp.action = val;
+	cp.quality_report = val;
 
-	if (mgmt_send(mgmt, MGMT_OP_SET_EXP_FEATURE, mgmt_index,
-			sizeof(cp), &cp, exp_quality_rsp, NULL, NULL) == 0) {
+	if (mgmt_send(mgmt, MGMT_OP_SET_QUALITY_REPORT, mgmt_index,
+			sizeof(cp), &cp, quality_rsp, NULL, NULL) == 0) {
 		error("Unable to send quality report feature cmd");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
@@ -5636,10 +5638,10 @@ static const struct bt_shell_menu main_menu = {
 		cmd_exp_debug,		"Set debug feature"		},
 	{ "exp-privacy",	"<on/off>",
 		cmd_exp_privacy,	"Set LL privacy feature"	},
-	{ "exp-quality",	"<on/off>", cmd_exp_quality,
-		"Set bluetooth quality report feature"			},
 	{ "exp-offload",		"<on/off>",
 		cmd_exp_offload_codecs,	"Toggle codec support"		},
+	{ "quality",		"<on/off>",
+		cmd_exp_quality, "Set bluetooth quality report feature"	},
 	{ "read-sysconfig",	NULL,
 		cmd_read_sysconfig,	"Read System Configuration"	},
 	{ "set-sysconfig",	"<-v|-h> [options...]",
-- 
2.36.1.124.g0e6072fb45-goog

