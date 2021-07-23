Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B27C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 13:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989BE60EFD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 13:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhGWNSY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 09:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbhGWNSX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 09:18:23 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40129C061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 06:58:57 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4GWWBl3F5TzQk8x;
        Fri, 23 Jul 2021 15:58:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1627048733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ItoljjU9olhXYnPeHhYDqZkjzBSH2FEO3akZAxBYXT0=;
        b=CESz7/DwYkMxcDh5JB08LyLMBxOtQIDUNngPu6+XyXcBsvAH+3H5/lUIFvZGhvAOa21hv/
        RyuEcWxtsdq/xT6C4/RSCgavInRJc0frnK8sabSGFflRcH76wgrThT0pLtpbDa0+WBDnq2
        /LmFDpg3oWELTKa8reLaN+J0a+hQikL1gqDqK3EWz6i8Y4H4orzoSMPMg6SLHFWsJz14z5
        yHNhwNBP8X+g8Pyah0j+dIpGhjRe3EYwYB2c6EG0PxcdZRxU4Ux5P3Rl3LwLY1jjdXdp7j
        gtTLgjVgyDgE3nNoMMMseRFIkPbPD6vEnPhuhJ1eLsna0BWpWVcMYQWaqmDlug==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id vWRYvLLj_AJi; Fri, 23 Jul 2021 15:58:52 +0200 (CEST)
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     linux-bluetooth@vger.kernel.org
Cc:     Juho Hamalainen <juho.hamalainen@jolla.com>
Subject: [PATCH BlueZ 2/4] configure.ac: specify phonebook plugin at build time
Date:   Fri, 23 Jul 2021 15:58:22 +0200
Message-Id: <20210723135824.8032-3-me@dylanvanassche.be>
In-Reply-To: <20210723135824.8032-1-me@dylanvanassche.be>
References: <20210723135824.8032-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 77DEB18CA
X-Rspamd-UID: ac0dc6
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Juho Hamalainen <juho.hamalainen@jolla.com>

Various phonebook plugins are available, by default
phonebook-dummy is always built. Allow to specify
which plugin to use at build time.
---
 Makefile.obexd | 2 +-
 configure.ac   | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 6f5dc04c0..285a56197 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -41,7 +41,7 @@ obexd_builtin_modules += pbap
 obexd_builtin_sources += obexd/plugins/pbap.c \
 				obexd/plugins/vcard.h obexd/plugins/vcard.c \
 				obexd/plugins/phonebook.h \
-				obexd/plugins/phonebook-dummy.c
+				obexd/plugins/phonebook-@PLUGIN_PHONEBOOK@.c
 
 obexd_builtin_modules += mas
 obexd_builtin_sources += obexd/plugins/mas.c obexd/src/map_ap.h \
diff --git a/configure.ac b/configure.ac
index be32782a6..113ab0e0f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -416,4 +416,12 @@ fi
 AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
 			[Directory for the Android daemon storage files])
 
+AC_ARG_WITH([phonebook], AC_HELP_STRING([--with-phonebook=PLUGIN],
+				[obexd phonebook plugin (default=dummy)]),
+					[plugin_phonebook=${withval}])
+if (test -z "${plugin_phonebook}"); then
+	plugin_phonebook=dummy
+fi
+AC_SUBST(PLUGIN_PHONEBOOK, [${plugin_phonebook}])
+
 AC_OUTPUT(Makefile src/bluetoothd.rst lib/bluez.pc mesh/bluetooth-meshd.rst)
-- 
2.32.0

