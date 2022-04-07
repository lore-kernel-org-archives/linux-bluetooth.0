Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCD7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Apr 2022 23:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiDHABy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Apr 2022 20:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiDHABx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Apr 2022 20:01:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A731519A546
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Apr 2022 16:59:52 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n18so6456877plg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Apr 2022 16:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zTCuH7DRWeA6y3m792VByCbnJCSD5d8sPofyL9x7kQk=;
        b=jJlMefiwH9XgG6NLbjd89JJtvufWluZRXvvlazq9GvdKI6O6a9lz7943d9lgqklf0N
         /9ly+qeTAsWGUFEZDzraRV5SUNUohgG07btIL/vpC3RVtCzb6YYFlUOGsYuVj4hiqsTg
         ij8o4B51z8gse8Hu/aMz/PbhKhQKsfMWQvNBSmy9N7g/91N0ISnsih2CGABcCYfGtd4/
         2G0DRlQc9WbjU/hmRgnGq2Qzv4cTexassnb8jluNUY6SoKou2ZJQhQzSwGCEORJF73pt
         MFGvCyRj6SrzEBznx+9GH3d4bQM8ST2ArRXVCsxRpBc3fr544iu+SJSl4LCiP6hc4aqx
         ImOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTCuH7DRWeA6y3m792VByCbnJCSD5d8sPofyL9x7kQk=;
        b=hYLax5OmW3y/3UHRQy/5Tiobxh++B9Kqm6URmENL49+ECQ/1/FCbOWn2YMHrcVEOGs
         N3ivMt4HdrGN1Be0F26uED44HltCzh7QL5vEkzhAbJxFkLV669QcFliupj2NrGz49Ach
         TP9IfAwjSTOElfNuFiQRwXmrLnRy4dhVzGJVtbKczBaasK978Q6M21xEhGk1I7Xi4rSR
         47mlo0lKLxUYX6f3VyeEPWcg+XQIA0QbcR1vMwb6ZZBHiQHQXvXV9KeLAoZjRdVaS+5M
         CrzH5IZkERte2s4npCNU2FbCldmHxY9Dv3OMZWj///tyUBlpqsQSoWM+ZNx1o0rRrCtt
         ObbA==
X-Gm-Message-State: AOAM530T1Lq5Jr+wZgqylixfaNzLgAkespou+bj75v+BAXUYBCc+fhDU
        wePB4yX9kdRVimzW15C+ns086y+B6EA=
X-Google-Smtp-Source: ABdhPJwbci7dgNjYet1+vQ59lGJg2xtf7fy/Fj7f8jR8vIY6KaZQJ99LGaUc2Y+FPw8Yap5BIbLXqg==
X-Received: by 2002:a17:902:ce04:b0:156:3be:8a7f with SMTP id k4-20020a170902ce0400b0015603be8a7fmr16029825plg.149.1649375991962;
        Thu, 07 Apr 2022 16:59:51 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id bg13-20020a17090b0d8d00b001caa8f51098sm9770532pjb.9.2022.04.07.16.59.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 16:59:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shell: Fix not able to auto complete commands with submenu prefix
Date:   Thu,  7 Apr 2022 16:59:49 -0700
Message-Id: <20220407235949.2428708-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407235949.2428708-1-luiz.dentz@gmail.com>
References: <20220407235949.2428708-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the command was given with submenu prefix the code wasn't able to
detect the command to be able to generate the auto complete for its
arguments.
---
 src/shared/shell.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 72232f7c0..dfda8128a 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -911,6 +911,26 @@ static char **menu_completion(const struct bt_shell_menu_entry *entry,
 	return matches;
 }
 
+static char **submenu_completion(const char *text, int argc, char *input_cmd)
+{
+	const struct bt_shell_menu *menu;
+	char *cmd;
+
+	if (data.main != data.menu)
+		return NULL;
+
+	cmd = strrchr(input_cmd, '.');
+	if (!cmd)
+		return NULL;
+
+	menu = find_menu(input_cmd, cmd - input_cmd, NULL);
+	if (!menu)
+		return NULL;
+
+	return menu_completion(menu->entries, text, argc,
+				input_cmd + strlen(menu->name) + 1);
+}
+
 static char **shell_completion(const char *text, int start, int end)
 {
 	char **matches = NULL;
@@ -928,10 +948,14 @@ static char **shell_completion(const char *text, int start, int end)
 
 		matches = menu_completion(default_menu, text, w.we_wordc,
 							w.we_wordv[0]);
-		if (!matches)
+		if (!matches) {
 			matches = menu_completion(data.menu->entries, text,
 							w.we_wordc,
 							w.we_wordv[0]);
+			if (!matches)
+				matches = submenu_completion(text, w.we_wordc,
+								w.we_wordv[0]);
+		}
 
 		wordfree(&w);
 	} else {
-- 
2.35.1

