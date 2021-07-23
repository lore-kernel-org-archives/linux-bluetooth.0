Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528EDC432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 13:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320A060EB4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 13:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhGWNSZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 09:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbhGWNSX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 09:18:23 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3F4C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 06:58:57 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4GWWBl6l9zzQkBs;
        Fri, 23 Jul 2021 15:58:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1627048734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c0GPxelqby7YufxBOEsKvHYMlKRcOobr61YmT/rUX2E=;
        b=nQbtfs5gmgTRlNhkjdAxXwlGJGmo45HZNgY9w8H/rs9WGYVwjDRbkFfiA2NT1hCrqctB1F
        f8VOKdK9M4cpYmFRXRuCoLQN122lOuOdm0XufUY0ciuM6Ym21sBWgq0u/VuM5l895t7Pd3
        /VmCcUy54k7J3z3MBCgtREZRQcdKWsg6rszH+MIWjj7Qpb3Y8Vn5HAH0fdwBw2g2AuHxEz
        tGuPuwKMa++jwfXl+HE5yQZYqxSc269BbfRQtUUB+Mo7BGzpZh05OHq/4KBchnoY005rmf
        cubjvqj2TJY8TD6cAjJ2A7TXsyk4Jw8sxTjKo8lIou2o7r2b1CxQB9KCIPxwXQ==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 31EJClwTXw0c; Fri, 23 Jul 2021 15:58:53 +0200 (CEST)
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH BlueZ 3/4] configure.ac: add libebook dependency
Date:   Fri, 23 Jul 2021 15:58:23 +0200
Message-Id: <20210723135824.8032-4-me@dylanvanassche.be>
In-Reply-To: <20210723135824.8032-1-me@dylanvanassche.be>
References: <20210723135824.8032-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2955918B5
X-Rspamd-UID: d946f0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Require libebook when phonebook-ebook plugin is built.
---
 Makefile.am    | 2 +-
 Makefile.obexd | 2 +-
 configure.ac   | 9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 497f05f06..0fd405e8c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -24,7 +24,7 @@ pkgincludedir = $(includedir)/bluetooth
 
 pkginclude_HEADERS =
 
-AM_CFLAGS = $(WARNING_CFLAGS) $(MISC_CFLAGS) $(UDEV_CFLAGS) $(ell_cflags)
+AM_CFLAGS = $(WARNING_CFLAGS) $(MISC_CFLAGS) $(UDEV_CFLAGS) $(LIBEBOOK_CFLAGS) $(LIBEDATASERVER_CFLAGS) $(ell_cflags)
 AM_LDFLAGS = $(MISC_LDFLAGS)
 
 if DATAFILES
diff --git a/Makefile.obexd b/Makefile.obexd
index 285a56197..2c0d19518 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -80,7 +80,7 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
 			obexd/src/map_ap.h
 obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
-			$(ICAL_LIBS) $(DBUS_LIBS) $(GLIB_LIBS) -ldl
+			$(ICAL_LIBS) $(DBUS_LIBS) $(LIBEBOOK_LIBS) $(LIBEDATASERVER_LIBS) $(GLIB_LIBS) -ldl
 
 obexd_src_obexd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic
 
diff --git a/configure.ac b/configure.ac
index 113ab0e0f..a5afaea6c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -422,6 +422,15 @@ AC_ARG_WITH([phonebook], AC_HELP_STRING([--with-phonebook=PLUGIN],
 if (test -z "${plugin_phonebook}"); then
 	plugin_phonebook=dummy
 fi
+
+if (test "${plugin_phonebook}" = "ebook"); then
+	PKG_CHECK_MODULES(LIBEBOOK, [libebook-1.2 >= 3.3], dummy=yes, AC_MSG_ERROR(libebook >= 3.3 is required))
+	AC_SUBST(LIBEBOOK_CFLAGS)
+	AC_SUBST(LIBEBOOK_LIBS)
+	PKG_CHECK_MODULES(LIBEDATESERVER, [libedataserver-1.2 >= 3.3], dummy=yes, AC_MSG_ERROR(libedataserver >= 3.3 is required))
+	AC_SUBST(LIBEDATESERVER_CFLAGS)
+	AC_SUBST(LIBEDATESERVER_LIBS)
+fi
 AC_SUBST(PLUGIN_PHONEBOOK, [${plugin_phonebook}])
 
 AC_OUTPUT(Makefile src/bluetoothd.rst lib/bluez.pc mesh/bluetooth-meshd.rst)
-- 
2.32.0

