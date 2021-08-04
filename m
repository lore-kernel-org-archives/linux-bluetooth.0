Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A3AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CD66056C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhHDEU3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhHDEU2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:20:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965DDC0613D5
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:20:15 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j1so1184639pjv.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=24rKoN35shEfSfUWzChcfRDBywZRGp0tab/6keL4F/Q=;
        b=XDdP7AIpIGjnOTUJV7R6nHnyPsB1OPGoh7eIHzaDrgRU02VgTS3GUDztW3A5jioK9S
         o+o4652KLxQviMw3X9Zc5+su8NKrPDRd1RG1NBUYYj4Ck31ORlh7o3UWnYsNIlflr3s+
         ZidQ6z/1LYPReQOTBgIb5b07IVeDDJVb/G6fJqZkERfSvQXlVdZIDAU1pUmKrCRDQtYM
         +jyatbLG6hpI3o4PJJIGUayrPB1fmATyOcnUU1tSf4S5bZToV0W8raFfDuZC8AGNm0C9
         sIlYq2/rThKxR8iSWDhUfY4Ev/F2GZY0I31lHPaXJv2WtQoOSJf4aWiL+dD7wL0oQ3yl
         CzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=24rKoN35shEfSfUWzChcfRDBywZRGp0tab/6keL4F/Q=;
        b=Qmouaz1luyOzFrmHoF3F3PcOv6PfwBnFHO63EwM//6UNKQyu7P9sRs+My/y5bm5tM3
         sHsQ01pX/K8WuoLgzsduDFnAWG/RbKqY5G9KRFkS2CFmph73CQgFy5U4yV5bYJubCpZr
         l/DL8SlO0BX27XldpqaAYbRF4izqP1SEvo6fl4I6mRD0/fIxUivLtqH+HHl9ijQZPmxB
         QhBBlM7xZ1C63zDS33KLkwBm5hRBvqG1rFYEXLufwMI8klGqfKB1Ik0q7aPam5bxSysG
         y3tjLt1lVvdhgvHB7i4CvjqLrC2Ml8DY5lFghbqriqErZUT9JdpBhnvg8phQgfVVnz+O
         O6Kg==
X-Gm-Message-State: AOAM530QOcZ8hx1wJmj+caEqOlpuF7dq32IvmWmYU3to0f/Xo0X3caGt
        FC+S6WQcqnFbWQHxizuE+sb0PmG36o/T4Q==
X-Google-Smtp-Source: ABdhPJwnO44SQEuNIe4Pa18RWsjBVvoXzbS0+rE/TxzETI6BLMXEv+c2WlFIe1jTPvSVhiWYGZybVA==
X-Received: by 2002:a17:90a:9514:: with SMTP id t20mr7826894pjo.154.1628050814777;
        Tue, 03 Aug 2021 21:20:14 -0700 (PDT)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id j13sm885472pgp.29.2021.08.03.21.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:20:14 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     linux-bluetooth@vger.kernel.org, eramoto.masaya@jp.fujitsu.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH bluez] btmgmt: Fix misspellings of "Toggle"
Date:   Tue,  3 Aug 2021 22:20:08 -0600
Message-Id: <20210804042008.42404-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/btmgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 7d9082381..02dc249f2 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -5484,7 +5484,7 @@ static const struct bt_shell_menu main_menu = {
 	{ "ssp",		"<on/off>",
 		cmd_ssp,		"Toggle SSP mode"		},
 	{ "sc",			"<on/off/only>",
-		cmd_sc,			"Toogle SC support"		},
+		cmd_sc,			"Toggle SC support"		},
 	{ "hs",			"<on/off>",
 		cmd_hs,			"Toggle HS support"		},
 	{ "le",			"<on/off>",
@@ -5546,7 +5546,7 @@ static const struct bt_shell_menu main_menu = {
 	{ "ext-config",		"<on/off>",
 		cmd_ext_config,		"External configuration"	},
 	{ "debug-keys",		"<on/off>",
-		cmd_debug_keys,		"Toogle debug keys"		},
+		cmd_debug_keys,		"Toggle debug keys"		},
 	{ "conn-info",		"[-t type] <remote address>",
 		cmd_conn_info,		"Get connection information"	},
 	{ "io-cap",		"<cap>",
-- 
2.32.0

