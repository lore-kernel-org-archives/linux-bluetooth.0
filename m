Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3F8C636CB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 12:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741F0613D8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 12:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhGQM6Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Jul 2021 08:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhGQM6Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Jul 2021 08:58:24 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A13C061762
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Jul 2021 05:55:28 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4GRp4G3hLPzQkBD;
        Sat, 17 Jul 2021 14:55:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1626526524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6Xh+i1Git8xxKRZevxT9ST02KYtC/+lZ9Ewh884Me0=;
        b=j/9NopIE4JTbVbal2m/bMrU392o2S8HKdh4k4ZRLZvakg2v9Q70phQjQiBQs3KN7xd+kdU
        Lo+ZS1r49H3nt6w/aSK2sRbpNVtr8wvStm5AVhc5DNNXx6pdINetTehypss7d1rzIByf7h
        UqpLgCi9Lmr7+LKJM5r9CDmdvWNNZEhUUIx3Rq+tPvkCOEhrWnTBk3wwnpzYyOzqRiTgvJ
        jhn7rK9xB4hkyU9eQuy5g1O0HrXPchx843DvJGXqqTYVeBFJwm1drqw1UDJPS/tUokLufp
        BMO92hf9dtZgXC51SLvO/OEEgK57LjK+R5KuyTi/0iPuOIuZENeTbk4hl86Xgw==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id F852yK8DEAyT; Sat, 17 Jul 2021 14:55:22 +0200 (CEST)
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     linux-bluetooth@vger.kernel.org
Cc:     Juho Hamalainen <juho.hamalainen@jolla.com>,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 2/4] configure.ac: specify phonebook plugin at build time
Date:   Sat, 17 Jul 2021 14:55:06 +0200
Message-Id: <20210717125508.29186-2-me@dylanvanassche.be>
In-Reply-To: <20210717125508.29186-1-me@dylanvanassche.be>
References: <20210717125508.29186-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 59D06182D
X-Rspamd-UID: dcd925
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Juho Hamalainen <juho.hamalainen@jolla.com>

Various phonebook plugins are available, by default
phonebook-dummy is always built. Allow to specify
which plugin to use at build time.

Cherry-picked from https://github.com/sailfishos/bluez5/commit/d39ed9e2db8d4f9ab239a859c777e5504459b9dd

Co-authored-by: Dylan Van Assche <me@dylanvanassche.be>
Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
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

