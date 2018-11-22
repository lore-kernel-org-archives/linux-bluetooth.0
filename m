Return-Path: <SRS0=H/dM=OB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E65CC43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Nov 2018 16:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B8420684
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Nov 2018 16:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH+McfoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B8420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395555AbeKWCmL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:42:11 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:36033 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388949AbeKWCmL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Nov 2018 21:42:11 -0500
Received: by mail-lf1-f44.google.com with SMTP id a16so6855431lfg.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Nov 2018 08:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=URddSxA3YP4F4WZjVlrgbEdbCWFEAmtBa0UDW4jCmuE=;
        b=cH+McfoS/jrhuliHIQmRXdx7cbZyNWYX8a8KYBdiMeQYRv8J2GZa8qnu3xV+1pfDFO
         XJgrnQhi6pOiXXFD6OGZsmbXsj8O/KSWiWtOpWJzEU93AAP8msNR5uD8viwQy/Ej1Qq5
         /xfErj/1QCC8Ef2/XOAAQAcAlS72LtfHpYgP3G1V01rrsjXlbbjc1pcASMJudvK6PFKe
         5lpkDiNQ8ylR3jw4yhf5Vh0Bmd5NTAD5pME+lIdeUrgDdgmI8AhPQ8QCSivuCR/B4cNw
         3b8hJYXp+dFHzp85hrHKWW4zJ9/gOGMsYvA2N8GzSo28fZua29Vezw3BgGrQLF/JTs3r
         LPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=URddSxA3YP4F4WZjVlrgbEdbCWFEAmtBa0UDW4jCmuE=;
        b=bwI9cIfvgw8Ghd9cIjanyCUTBIyvmZRn/0zkjZPcBD0rHbdTMw3KuJI+KANLx6JNOm
         qUdo4YS1VAOuasDa/AWj8RIDT6VgE5dev5PvZ+7tqHWdmPg2icrhnD3d5tvj+fuNVP0A
         ONFEvSMaW0os/hxAJA7s93YbobY9NPoBXUtEGUNXsEaz9k5j3lTzQ6v1xdfcWm0JUMqI
         AHnfVZfG7K7lJLt94Kwmww9EbBFDzlBdTPbSlUx3P7A0ZkSz+jTTRVP8ssyi4hPH/rF0
         xvUVzXCzbYTytJKFxCh8n8Hll11eEc5eMRUijoOl/792GEwfBNqqT8xfWfYDX9kutdvg
         r9Dw==
X-Gm-Message-State: AGRZ1gKZ+JkXuoEO08rhKxhnpuUSwtxObFGMosjovubXSui6uk8Cp8ux
        aZOqqWeB0o0CRMx32iWteuNMMETi
X-Google-Smtp-Source: AJdET5dXo/7W01VkO/jlrexc0aBBxpez+t4wuMUsXrgn92+uYz25mmiL1ISE9bECFRb3cPaDDg46fA==
X-Received: by 2002:a19:4ed9:: with SMTP id u86mr6691745lfk.78.1542902530597;
        Thu, 22 Nov 2018 08:02:10 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id h21sm7416815lfk.41.2018.11.22.08.02.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 08:02:09 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shell: Fix artifacts when asking for user input
Date:   Thu, 22 Nov 2018 18:02:08 +0200
Message-Id: <20181122160208.6933-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instead of printing a message use set the new prompt so it is carried
over when new lines are printed. Unfortunately this has some drawbacks
as apparently readline is not really able to redisplay properly if the
prompt contain colors.
---
 src/shared/shell.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 89a2e82bc..aabbc5d0e 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -562,6 +562,8 @@ void bt_shell_usage()
 void bt_shell_prompt_input(const char *label, const char *msg,
 			bt_shell_prompt_input_func func, void *user_data)
 {
+	char *str;
+
 	if (!data.init || data.mode)
 		return;
 
@@ -573,9 +575,11 @@ void bt_shell_prompt_input(const char *label, const char *msg,
 	data.saved_prompt = true;
 	data.saved_func = func;
 	data.saved_user_data = user_data;
+	asprintf(&str, "[%s] %s ", label, msg);
 
 	rl_save_prompt();
-	bt_shell_printf(COLOR_RED "[%s]" COLOR_OFF " %s ", label, msg);
+	bt_shell_set_prompt(str);
+	free(str);
 }
 
 int bt_shell_release_prompt(const char *input)
@@ -1209,7 +1213,7 @@ void bt_shell_set_prompt(const char *string)
 		return;
 
 	rl_set_prompt(string);
-	bt_shell_printf("\r");
+	rl_redisplay();
 }
 
 static bool input_read(struct io *io, void *user_data)
-- 
2.17.2

