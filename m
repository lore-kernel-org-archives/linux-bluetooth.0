Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 18:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DEC36103C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 18:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbhJZSUm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 14:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhJZSUl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 14:20:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE946C061745
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 11:18:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e65so332276pgc.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 11:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NIeNnJ5W6b4+YeAyS5Pxz8PSsVa7R+WTUVg6MGAyzWE=;
        b=cxmDUdNPaBnisTfw1z8G5mHMD5Y7sFvmOQaeQ3mHr25bTXC1x4lo55GDpLAXTKRNYb
         kmHW68KPU6vtNm4g8ebEzC5CCJjF30+fcq0aUXYywnhuW1QKsVvHX1gXqOYp13fnfvSs
         GXWUbSxpWbYXbEOO5wVzZvwV8EYFH29hzYOUHLPa2egsFprUQn4fBS6B4fVHiaqNJGS/
         eh8vtHfgLXizcvkqPilpHUSK4LU1+cZVyFRNkou5ZkuZPoVTsM12FXMhRpfAGUwC3/BB
         42A5TpBMuV6UzPfJjJlzrzn3Q3SOyvC9tfAreZdb9qGphpjMkkHZm4KWjzxYocBhkz+S
         XGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NIeNnJ5W6b4+YeAyS5Pxz8PSsVa7R+WTUVg6MGAyzWE=;
        b=8RxIEkdxSjgYQjYLlZzrWH8MiSiJryGCk7RAoGd8tBAhuYBlKMS/XpSeTGXQvlg/yi
         BM+hudxV9PxqqDRARiAHv9VhUzx54nEZhMra/6oCZ2KG1acKB53jHeyp168At1AlxWMV
         Wb8TWn+Tb1LGYUPooz/YcbEfkeKV4MRgnGwiVR28cY42QjbaprJKDZVAXGG3K9ecrGpS
         33PAVE6WBTeGJkbrD0A21BBjJotbahCOBWCTL1BkM/mFwHO7oSxHa2pWvuUnrA+b8vEq
         LpPKh3Ovc6NWP2GwU/RJCQBTVqMbIFJXaBdWH0jNaPiNFnLCB2NMRN+nubUGGMm9uwHy
         uBhA==
X-Gm-Message-State: AOAM5330rUZmes2bErySNfdSUdfyWcyT9ATSgG88pLQ9VmeesH+brPE4
        Fi9Rm5wQNAiKgq6Y86jVgvJ0qURy4ks=
X-Google-Smtp-Source: ABdhPJwx1LI+FwRf5a3ofMSr4ECJZUIK0rWMwVocdwsM+YfmbkqwqL+stz7NHf21PIHu/nrKZk1Gxg==
X-Received: by 2002:a63:8c14:: with SMTP id m20mr11678871pgd.109.1635272296819;
        Tue, 26 Oct 2021 11:18:16 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x202sm7677983pfc.170.2021.10.26.11.18.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:18:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] Makefile: Fix code style
Date:   Tue, 26 Oct 2021 11:18:14 -0700
Message-Id: <20211026181815.1305602-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix lines going over 80 columns.
---
 Makefile.am    |  3 ++-
 Makefile.obexd |  3 ++-
 configure.ac   | 20 ++++++++++++--------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index a9439588a..7985db090 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -24,7 +24,8 @@ pkgincludedir = $(includedir)/bluetooth
 
 pkginclude_HEADERS =
 
-AM_CFLAGS = $(WARNING_CFLAGS) $(MISC_CFLAGS) $(UDEV_CFLAGS) $(LIBEBOOK_CFLAGS) $(LIBEDATASERVER_CFLAGS) $(ell_cflags)
+AM_CFLAGS = $(WARNING_CFLAGS) $(MISC_CFLAGS) $(UDEV_CFLAGS) $(LIBEBOOK_CFLAGS) \
+				$(LIBEDATASERVER_CFLAGS) $(ell_cflags)
 AM_LDFLAGS = $(MISC_LDFLAGS)
 
 if DATAFILES
diff --git a/Makefile.obexd b/Makefile.obexd
index 2c0d19518..b9fbc9b3b 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -80,7 +80,8 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
 			obexd/src/map_ap.h
 obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
-			$(ICAL_LIBS) $(DBUS_LIBS) $(LIBEBOOK_LIBS) $(LIBEDATASERVER_LIBS) $(GLIB_LIBS) -ldl
+			$(ICAL_LIBS) $(DBUS_LIBS) $(LIBEBOOK_LIBS) \
+			$(LIBEDATASERVER_LIBS) $(GLIB_LIBS) -ldl
 
 obexd_src_obexd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic
 
diff --git a/configure.ac b/configure.ac
index 0c0418452..0329095ee 100644
--- a/configure.ac
+++ b/configure.ac
@@ -242,7 +242,7 @@ AM_CONDITIONAL(MIDI, test "${enable_midi}" = "yes")
 
 if (test "${enable_midi}" = "yes"); then
 	PKG_CHECK_MODULES(ALSA, alsa, dummy=yes,
-				AC_MSG_ERROR(ALSA lib is required for MIDI support))
+			AC_MSG_ERROR(ALSA lib is required for MIDI support))
 	AC_SUBST(ALSA_CFLAGS)
 	AC_SUBST(ALSA_LIBS)
 fi
@@ -333,7 +333,8 @@ if (test "${enable_manpages}" != "no"); then
 	fi
 fi
 AM_CONDITIONAL(MANPAGES, test "${enable_manpages}" != "no")
-AM_CONDITIONAL(RUN_RST2MAN, test "${enable_manpages}" != "no" && test "${RST2MAN}" != "no")
+AM_CONDITIONAL(RUN_RST2MAN, test "${enable_manpages}" != "no" &&
+				test "${RST2MAN}" != "no")
 
 AC_ARG_ENABLE(testing, AC_HELP_STRING([--enable-testing],
 			[enable testing tools]),
@@ -405,14 +406,14 @@ AM_CONDITIONAL(ANDROID, test "${enable_android}" = "yes")
 
 if (test "${enable_android}" = "yes"); then
 	PKG_CHECK_MODULES(SBC, sbc >= 1.2, dummy=yes,
-					AC_MSG_ERROR(SBC library >= 1.2 is required))
+			AC_MSG_ERROR(SBC library >= 1.2 is required))
 	AC_SUBST(SBC_CFLAGS)
 	AC_SUBST(SBC_LIBS)
 fi
 
 if (test "${enable_android}" = "yes"); then
 	PKG_CHECK_MODULES(SPEEXDSP, speexdsp >= 1.2, dummy=yes,
-					AC_MSG_ERROR(SPEEXDSP library >= 1.2 is required))
+			AC_MSG_ERROR(SPEEXDSP library >= 1.2 is required))
 	AC_SUBST(SPEEXDSP_CFLAGS)
 	AC_SUBST(SPEEXDSP_LIBS)
 fi
@@ -421,17 +422,20 @@ AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
 			[Directory for the Android daemon storage files])
 
 AC_ARG_WITH([phonebook], AC_HELP_STRING([--with-phonebook=PLUGIN],
-				[obexd phonebook plugin (default=dummy)]),
-					[plugin_phonebook=${withval}])
+			[obexd phonebook plugin (default=dummy)]),
+			[plugin_phonebook=${withval}])
 if (test -z "${plugin_phonebook}"); then
 	plugin_phonebook=dummy
 fi
 
 if (test "${plugin_phonebook}" = "ebook"); then
-	PKG_CHECK_MODULES(LIBEBOOK, [libebook-1.2 >= 3.3], dummy=yes, AC_MSG_ERROR(libebook >= 3.3 is required))
+	PKG_CHECK_MODULES(LIBEBOOK, [libebook-1.2 >= 3.3], dummy=yes,
+			AC_MSG_ERROR(libebook >= 3.3 is required))
 	AC_SUBST(LIBEBOOK_CFLAGS)
 	AC_SUBST(LIBEBOOK_LIBS)
-	PKG_CHECK_MODULES(LIBEDATESERVER, [libedataserver-1.2 >= 3.3], dummy=yes, AC_MSG_ERROR(libedataserver >= 3.3 is required))
+	PKG_CHECK_MODULES(LIBEDATESERVER, [libedataserver-1.2 >= 3.3],
+			dummy=yes,
+			AC_MSG_ERROR(libedataserver >= 3.3 is required))
 	AC_SUBST(LIBEDATESERVER_CFLAGS)
 	AC_SUBST(LIBEDATESERVER_LIBS)
 fi
-- 
2.31.1

