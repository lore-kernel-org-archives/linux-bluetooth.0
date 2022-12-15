Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74CBC4167B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Dec 2022 21:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLOVK5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiLOVKn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Dec 2022 16:10:43 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21C410B6
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 13:10:41 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 21so460717pfw.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 13:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dk4rLbDdNGWPnvC7kri4rqAgpOPPYTq/B4Hcvj14rhk=;
        b=UrVuo5UBwk3FFGlu8ZD0pBTckYfmCdK3nKDJ2XNw9Iwwry5gbzLcBzPZjXml0bbu6H
         lLoI39fbyLmh1owGVHUcUgDDrJ0luEO+75IAZudUUPb0Uo/gz8gYljs9gf8GN3oXod5R
         8by8zBkmg8QQ4G0RHluW2kQUo/DfdokIiMW6g+LNorpromJd2SasRDDWgEhRWIacPK9y
         2t4JNlAw/cl/qgYDeH25+csGv64OKB/Bb30FCXOkmQcCCSbcxCByjWlsyd37qo93dTVM
         ayn/49lvai7oUbiyFFBbLyP0j47K32A/+wdDN4Xp0xWptKJcu4408biKgoCEedMT0N/D
         gsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dk4rLbDdNGWPnvC7kri4rqAgpOPPYTq/B4Hcvj14rhk=;
        b=kjGwCtzmsAdoPiM9KDkRLjpzWxaWMWp8vh/xVkZOxeYYosX3ItX51fm7Pxp5Un3Yh8
         OfimmkkBSfRsR/22hmQky6mUSa2N76SEXvsmAkPpo/1IGRXu9AKVV+TH8otzLQlVIGal
         qdG6sDVgQMlClK65vpe+prITQ/tgUcBdidu3xaLNTXTsQYCMWqc83qHy7GW6gAs/xpUD
         Slrs4ye+CMEUMQssMP+S8UoswVqlbsm43lZcwvt3GDHuq2rICeN/Yr5AZnBIp5RBh+g1
         YSXoVsgTywpank+/mZH3MWl1GNp/eDszXVwCuZohqP2xpzq6ZspGQz1EURjcFBSIq9sP
         Uvfg==
X-Gm-Message-State: ANoB5plfdMrRp8+uR4xY5v+6sLloSqNYqsJmnUGryTvOU9gSoPADz4V6
        ua3cx9FCQgcfNbJ0sbku5blVVM1GaCjOwFOa
X-Google-Smtp-Source: AA0mqf4I+HV3orQLleTvbAjIM0TQk/N+/kjXcEbv6Z8AxfrxdSA2O83BR1mUb4fCpfcFEAYbmkjDPA==
X-Received: by 2002:a05:6a00:1696:b0:566:94d0:8c96 with SMTP id k22-20020a056a00169600b0056694d08c96mr38971495pfc.26.1671138640775;
        Thu, 15 Dec 2022 13:10:40 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c20-20020aa79534000000b005779110635asm54908pfp.51.2022.12.15.13.10.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:10:40 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] shared/shell: Add bt_shell_echo
Date:   Thu, 15 Dec 2022 13:10:34 -0800
Message-Id: <20221215211037.2686489-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221215211037.2686489-1-luiz.dentz@gmail.com>
References: <20221215211037.2686489-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_shell_echo which can be used to print messages on the echo
area.
---
 src/shared/shell.c | 20 ++++++++++++++++++++
 src/shared/shell.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 0639c786d983..3c0e61dbc414 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -576,6 +576,26 @@ void bt_shell_printf(const char *fmt, ...)
 	}
 }
 
+void bt_shell_echo(const char *fmt, ...)
+{
+	va_list args;
+	char *str;
+	int err;
+
+	va_start(args, fmt);
+	err = vasprintf(&str, fmt, args);
+	if (!err)
+		err = asprintf(&str, COLOR_HIGHLIGHT "%s#" COLOR_OFF, str);
+	va_end(args);
+
+	if (err)
+		return;
+
+	rl_save_prompt();
+	bt_shell_set_prompt(str);
+	rl_restore_prompt();
+}
+
 static void print_string(const char *str, void *user_data)
 {
 	bt_shell_printf("%s\n", str);
diff --git a/src/shared/shell.h b/src/shared/shell.h
index 8baa2854a250..87fb5c415f20 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -70,6 +70,8 @@ void bt_shell_set_prompt(const char *string);
 
 void bt_shell_printf(const char *fmt,
 				...) __attribute__((format(printf, 1, 2)));
+void bt_shell_echo(const char *fmt,
+				...) __attribute__((format(printf, 1, 2)));
 void bt_shell_hexdump(const unsigned char *buf, size_t len);
 void bt_shell_usage(void);
 
-- 
2.37.3

