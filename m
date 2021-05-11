Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48CBC43460
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 20:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95345613AF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 20:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhEKUJy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 16:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEKUJy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 16:09:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB7EC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 13:08:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id i14so16562892pgk.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 13:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kqbM3kWuOznR/ZIgxhkTbOwibb3NYp28QJ/EMs1kcFc=;
        b=m8hr+/CnmSHY/Y7veQFi7ung9gjDGbpSyQopyuPr7/tqRVlg947hIwThBbnX4xI/1D
         eIV6BYdJSHIB/EhvnXf1BWAqViCGnSLy3O6slSoj0ZRSfVTPaoKgDBHPUljfszZE3TVn
         Ozo11w5+F5kqrHOf09oFdCWvP3Spj0DxCLTnxbrvfNo73q+/Ck6dsNISN1pjlY8ldNpU
         tAO9NNA8+pGDQuAU/EKXWJ+TldmcnzBNtlIMuZgrR2TX5ZyfxYemZ7JeC34XrFEXd/e6
         2LV54FprSkr6wiPRlZC8L2vzEBCg4ZoatdcXaV38dcGqxsh6voXPgsUQc7W81q2TjHRO
         qYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqbM3kWuOznR/ZIgxhkTbOwibb3NYp28QJ/EMs1kcFc=;
        b=UsA1gPDvGEDLCOQMowNVndkAH3j5NBEXuvBiYKKxbX7JBzj/NiQH6PUhGHSIINo2cJ
         oi9FRcygGy9bAenzsxXxojxJF5Eg1jO0yoOOSf4WZUlRT+SgF2UXLJtLukoipv6Svgyr
         wV0iW6nO0E6/Cj6KGdhH+4M26Yg6G0EB4/uKiS0+zSG19q8gC6PKRyTBegdlaDttlL4c
         RoPPOpftMMuD//O3T3kmyb1USL/olhZvKaI8Q1J+NqRioCBNbcIXmkrVntwRt1UHNooy
         GtnUQymy09WaytUebW9A5zVJVEbz2Du2C137P7H4tFrwzIslj04qDaEHK4iKtG1B8rl3
         PEZw==
X-Gm-Message-State: AOAM531Vx8AOLf8pyFlBefr6Fq6GNFll6vZzw5+h0koiCBgqSsve/OE4
        IaYlzjLsRaujKqJhS752ysDdcghkN/BdNg==
X-Google-Smtp-Source: ABdhPJzVzxcI2LPDwnSiHFaVtK+CnIiMsZBZ/vW5dblhaEqkFlCq81UcbeHfVdN5MRrChQ/TZwK92w==
X-Received: by 2002:a63:eb10:: with SMTP id t16mr33430860pgh.393.1620763726065;
        Tue, 11 May 2021 13:08:46 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id u15sm2835224pju.44.2021.05.11.13.08.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:08:45 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 2/2] config: Change the config option for manpages
Date:   Tue, 11 May 2021 13:08:43 -0700
Message-Id: <20210511200843.1741595-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210511200843.1741595-1-hj.tedd.an@gmail.com>
References: <20210511200843.1741595-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

The current config option for manpages provided by the configure.ac
alwasys enables the manpages whether 'enable-manpages' option is
specified or not. To clarify the expected behavior, this patch changes
the manpages option to 'disable-manpages' so the manpages are alwasy
enabled unless the '--disable-manpages' option is specified.
---
 configure.ac | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2b044f8e5..5157da1b5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -323,8 +323,8 @@ AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-datafiles],
 					[enable_datafiles=${enableval}])
 AM_CONDITIONAL(DATAFILES, test "${enable_datafiles}" != "no")
 
-AC_ARG_ENABLE(manpages, AC_HELP_STRING([--enable-manpages],
-			[enable building of manual pages]),
+AC_ARG_ENABLE(manpages, AC_HELP_STRING([--disable-manpages],
+			[disable building of manual pages]),
 					[enable_manpages=${enableval}])
 if (test "${enable_manpages}" != "no"); then
 	AC_CHECK_PROGS(RST2MAN, [rst2man rst2man.py], "no")
@@ -332,8 +332,8 @@ if (test "${enable_manpages}" != "no"); then
 		AC_MSG_ERROR([rst2man is required])
 	fi
 fi
-AM_CONDITIONAL(MANPAGES, test "${enable_manpages}" = "yes")
-AM_CONDITIONAL(RUN_RST2MAN, test "${enable_manpages}" = "yes" && test "${RST2MAN}" != "no")
+AM_CONDITIONAL(MANPAGES, test "${enable_manpages}" != "no")
+AM_CONDITIONAL(RUN_RST2MAN, test "${enable_manpages}" != "no" && test "${RST2MAN}" != "no")
 
 AC_ARG_ENABLE(testing, AC_HELP_STRING([--enable-testing],
 			[enable testing tools]),
-- 
2.26.3

