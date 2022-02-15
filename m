Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FCBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 13:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbiBONhH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 08:37:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiBONhG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 08:37:06 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB9265179
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:36:56 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id y5so34921419pfe.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J48r90Vm72k/4dumF504U76cCOox1c/Fx02dPurFxlQ=;
        b=hk3IYT1a+N+/pTexWbG5uA+YAEZ7gIi0/BTXtT3jNwBsRImUoaVPboET3D253+b6ij
         SgTT/A5csABOkb2I9r9yDdplvMTsawQBMOEPhk5F5He27eUjJGwhbzEkH2+os7dVPf/B
         V+wecdjg5EVbOWrodCINhRG5sl2Mnus+dibdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J48r90Vm72k/4dumF504U76cCOox1c/Fx02dPurFxlQ=;
        b=feEWmVTn/dthvMRlaQG4Ey8/RSQqJSQJWBU6Xt9jaJ6b5riJqzJvbb++ggby4HOIGI
         fkQ5zcXNifNdZuqyOtFaLDt4zGP+J6NkeBQGTGPkukA96GrQJWyNd6wIzv9bym9ZI3Sn
         MTjyLy4jOBC1pEt9WlO1xsBQIblRFOPu6t2I1WoxWDnyQgjsF2teft6tiIfYnnBWLpOp
         1HQYl3kyhy0QOCSlBTlOOU8zt0QrYrXVo3Qq3pD3kntGK+F9398aDSWwKvL7fTotj2Gt
         Be3/S/JvUf02YVbCutD7YS9+V9glhKywfMEQBjUcn/c+UrOyfcyF230o3gK8PTDct4af
         /LsQ==
X-Gm-Message-State: AOAM530rd9bzSns9LaaSPl+B+/BEBwfrgD8UnAsP1U0Czel6WpLrNLge
        sveHrj/FZQLYfEND1zyGZGkqcuGjoitixw==
X-Google-Smtp-Source: ABdhPJx6ip/hQqjhcwJE+Y4/IOJ+inb+hTLRo21m+fmzaVccdOZJpfLvdgYcJTcnT0KOLSkzVn41LA==
X-Received: by 2002:a65:42c4:: with SMTP id l4mr3473181pgp.505.1644932215899;
        Tue, 15 Feb 2022 05:36:55 -0800 (PST)
Received: from localhost (208.158.221.35.bc.googleusercontent.com. [35.221.158.208])
        by smtp.gmail.com with UTF8SMTPSA id k21sm40633811pff.33.2022.02.15.05.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 05:36:55 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v4 6/8] tools/btmgmt: fix quality report command
Date:   Tue, 15 Feb 2022 21:36:34 +0800
Message-Id: <20220215133636.2827039-4-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220215133636.2827039-1-josephsih@chromium.org>
References: <20220215133636.2827039-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The set quality report feature becomes a mgmt command and
is not included in the experimental features any more.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v4:
- Add "quality-report" in settings_str.
- Print current_settings in quality_rsp.

Changes in v3:
- This is a new patch that fixes the quality on/off command in
  btmgmt.

 tools/btmgmt.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 42ef9acef..14efe37db 100644
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
 	cp.action = val;
 
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
2.35.1.265.g69c8d7142f-goog

