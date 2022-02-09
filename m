Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FC6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 09:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiBIJ0I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:26:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiBIJ0H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 04:26:07 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF36AE058254
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 01:26:01 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y17so1691019plg.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 01:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZUO0cqlNRIJarZJPiafFiE07Tp9QCPY4gWT3QTXXvQ=;
        b=MuP0BGrWdMzNenvaMZIVRsd7fdvLFy+WKwRFeYpCEQR3pedG07OBNa03n3XKM2UoX4
         /jmjbqvWlxIvP74qXsU0ZH9VmYRzmExVHKvn2F5a4fFw3r3H9c6ctIzzBTpsH6a/zMLZ
         xqlaSN0U/3UiW1bGy9Ewy+dxl5zNXE47dFwx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZUO0cqlNRIJarZJPiafFiE07Tp9QCPY4gWT3QTXXvQ=;
        b=NHoUBcs5qwwDchZHdo6VMUzuXCmECm2c7CG/dfiWxo5LDYErPi1LHTul9n9oJcdE9H
         LgXKSCMg4i8U6d8IfNXUb6FrG3oCT+GvU1wcW4EuNhwnUuDm4Vt/+sGEHC9KDFGXpdgM
         cbhDLJuR8upnBhXiK0TLVJ+0Ut0vL2q7059hJDAqNUBTaAXXEblDIX0lOp4VjwlVgKDv
         C5RbBIASjc5BqnYKYXaXyl+4uz74pfrUDZD6icTrQ3obIdrQhjToxJTE1i3e3ibXgzhz
         XudEjf6XKchDUmdlPu5qyLEv4tymUoXcc6yFZYIFG899V2nF2IO+2OkagheFlTCSYTf4
         e6NA==
X-Gm-Message-State: AOAM532nBUVWyOZtHjPhiZfkxL7BVhNUlFd2VHp62o0d6QVSYpUprvdZ
        4HHcwNKXZAsg3X5/YtWtigy9SH64r9QUjw==
X-Google-Smtp-Source: ABdhPJymZi6xfZg5ANX0bNcNcrr+a/ey0sWRCVKDH1VMNkZR4JMgczTsZKwu2trJ6cSsM0JMD92K4g==
X-Received: by 2002:a17:903:2d2:: with SMTP id s18mr1519335plk.56.1644398680996;
        Wed, 09 Feb 2022 01:24:40 -0800 (PST)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id g12sm18050158pfm.119.2022.02.09.01.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 01:24:40 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v3 8/9] tools/btmgmt: fix quality report command
Date:   Wed,  9 Feb 2022 17:24:13 +0800
Message-Id: <20220209092414.751642-6-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220209092414.751642-1-josephsih@chromium.org>
References: <20220209092414.751642-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The set quality report feature becomes a mgmt command and
is not included in the experimental features any more.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v3:
- This is a new patch that fixes the quality on/off command in
  btmgmt.

 tools/btmgmt.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 42ef9acef..4f215b4af 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1842,7 +1842,7 @@ static void cmd_exp_privacy(int argc, char **argv)
 	}
 }
 
-static void exp_quality_rsp(uint8_t status, uint16_t len, const void *param,
+static void quality_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
 	if (status != 0)
@@ -1856,12 +1856,7 @@ static void exp_quality_rsp(uint8_t status, uint16_t len, const void *param,
 
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
@@ -1878,11 +1873,10 @@ static void cmd_exp_quality(int argc, char **argv)
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
@@ -5636,10 +5630,10 @@ static const struct bt_shell_menu main_menu = {
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
2.35.0.263.gb82422642f-goog

