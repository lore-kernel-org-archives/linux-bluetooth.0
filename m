Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEE7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 11:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347150AbiEZLZT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 07:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347157AbiEZLZQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 07:25:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FE2606F2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:25:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w3so1170949plp.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iGlj04Mi5nngiygdPdb7T+B1GHVKoXZjOQpzbPK0PSY=;
        b=Aj6HPlfPIleBeN8vZn+q38/k4/SzIWN/ZdsA42R9BvyxlA6JBDAadGoaFRyvDm8HGs
         8hfT1xRVB8hSm+4kQmDxyc+LyaW5EamwAiEguSWZX53W3xhnkkbKAv2EkRl7x2MjyeCF
         ph8idBJrFCOITK9wO0BMiAxGIp6JrZlchWIXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGlj04Mi5nngiygdPdb7T+B1GHVKoXZjOQpzbPK0PSY=;
        b=JSJZ8K3CTVrQ2uveQofyjm8jzkYdK9H8eYeIGgT+3n/Pyq/LrZAxXJ1yFrMzUoBw8z
         QDdpcDc89CIQ7thDIWjFYgMz7EgqWNAhzn7RPNdOnir3eIfQqIUdV3p0CkxEYQAbB9GI
         UbskVa7TCdaLgQ8Zvbmaocanru07A2zmUIvFeBYR4FQ15T4/0HaN93U395DyyrCj9P1Y
         z3UtfshqbPgHl6wWBzt6F5aseIREl/e1vHTouYfMZtPuBg4tUd5tH1UVQAYvECCN6SgF
         wJJbhq20CQc9c9Qkm24pMd7btCKyznnR1WPkoi/9xbK+LFvKVjEfoMP55gmWtZcA48bs
         w4AQ==
X-Gm-Message-State: AOAM531g9wnakAdvi1aRdYXZb7I8AhfNFqsBdBWSKodRk66b4Lr2TcQY
        /adu8j4et64obH8d18MHmhpj5qsBh7jfog==
X-Google-Smtp-Source: ABdhPJwaRrANQ8ZvCENVaAWiktcrRO6+Ownib9BLV3vbuGmvCe1vvz+7gPrcIcoGgY14yRvgSLGHlA==
X-Received: by 2002:a17:90a:ee96:b0:1e0:ce34:a1ed with SMTP id i22-20020a17090aee9600b001e0ce34a1edmr2150665pjz.26.1653564314865;
        Thu, 26 May 2022 04:25:14 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id p20-20020a17090a931400b001e077dca3fasm1238326pjo.40.2022.05.26.04.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 04:25:14 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v6 6/8] tools/btmgmt: fix quality report command
Date:   Thu, 26 May 2022 19:24:54 +0800
Message-Id: <20220526112456.2488536-4-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220526112456.2488536-1-josephsih@chromium.org>
References: <20220526112456.2488536-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The set quality report feature becomes a mgmt command and
is not included in the experimental features any more.

---

(no changes since v5)

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

