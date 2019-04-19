Return-Path: <SRS0=AkUh=SV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A944CC282DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 19:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEF920663
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 19:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="Qe+bNI5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfDSTqW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:46:22 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:34364 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfDSTqW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Apr 2019 15:46:22 -0400
Received: by mail-lf1-f45.google.com with SMTP id h5so4718926lfm.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2019 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y7JaleO6PEFNWQBR76zy6Alcg1i3m7o3IdB4Ltmp080=;
        b=Qe+bNI5vd8j/9yQyRw+wa2cXYnmaBhkkEl8qxHZ+4UjP47SFTHoo+vmIB9IZQKx/xh
         zK5WIG2Rc+jXC1jE/vZO3TymAu0Y0tWE7VWAna9PbgZs+PGYIqghUvZRNL6pCo5WmC9B
         LtUmmuZQ+bYsva3GhcIIuXP6aqH42GdSKC4zN200Jx3TTotkcjqGk1zO/3V0cftmJuRR
         S0t0KJqh8CeVIMdxMvmZQsu7/Id83m9TfQtMsMNG4Rps88RimIphog7kzPN1uMsTbBrt
         EUUvvaFmrL0tsMBNc70qXTI4hSesjOtK648XUwgA3/kPVkG2cINIwMKP2AwdxVexp6Z0
         0V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y7JaleO6PEFNWQBR76zy6Alcg1i3m7o3IdB4Ltmp080=;
        b=okURXzOi4E+eGf0KlCQqYcqlxd2ZT0/0K3lNXlBZHaToM6RkQJ6uDeGrER923sXL3Q
         5baxhlgvnQwIJNWRrVAFgwXOgqizn8LcqXvlUClbiJNeO1AHHg3qAV2rwbiHSFChmcq1
         thS7tsaxZRhIbOIi7nA9iKcu2rBd9GNHkNREnWelGu8GZNlHSE7UuD59wjQAHvp58hxd
         tcc1Jbz/cYg833KP4Mf6FAzjefM3a3JUdcjHpWRcJgdFh5BgNb+PSTVfUoG6OLKvUnwS
         JVgoJ3qwFfFvK6WkdUWbYBW6eIigkxI95yxFeSAdErg7Svo6ESfXLNkr318k08JclhsB
         q9RA==
X-Gm-Message-State: APjAAAXg0VjWvf3jkpvtShroh/bTMPSN129p+/btqrrXwihzjZBtC/8/
        6pF/DbPpWJ83hA8mVdzMllRJw9kS1BY=
X-Google-Smtp-Source: APXvYqwSkhh2KUImRwv8pCRKPk33cnF+i9h1iItOJX59mG59Vq3cuuQrveRrrYtEVeqtsEo+qYX1Zw==
X-Received: by 2002:ac2:5315:: with SMTP id c21mr2051232lfh.25.1555671110162;
        Fri, 19 Apr 2019 03:51:50 -0700 (PDT)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id s2sm1047332lfp.20.2019.04.19.03.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 03:51:49 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] build: Bump glib dependency to 2.32
Date:   Fri, 19 Apr 2019 12:51:46 +0200
Message-Id: <20190419105146.29272-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

make --no-print-directory all-am
  CC       client/main.o
In file included from /usr/include/glib-2.0/glib/gasyncqueue.h:32,
                 from /usr/include/glib-2.0/glib.h:32,
                 from client/main.c:36:
/usr/include/glib-2.0/glib/gthread.h: In function ‘g_rec_mutex_locker_new’:
/usr/include/glib-2.0/glib/gthread.h:390:3: error: ‘g_rec_mutex_lock’ is deprecated: Not available before 2.32 [-Werror=deprecated-declarations]
   g_rec_mutex_lock (rec_mutex);
   ^~~~~~~~~~~~~~~~
/usr/include/glib-2.0/glib/gthread.h:196:17: note: declared here
 void            g_rec_mutex_lock                (GRecMutex      *rec_mutex);
                 ^~~~~~~~~~~~~~~~
/usr/include/glib-2.0/glib/gthread.h: In function ‘g_rec_mutex_locker_free’:
/usr/include/glib-2.0/glib/gthread.h:405:3: error: ‘g_rec_mutex_unlock’ is deprecated: Not available before 2.32 [-Werror=deprecated-declarations]
   g_rec_mutex_unlock ((GRecMutex *) locker);
   ^~~~~~~~~~~~~~~~~~
/usr/include/glib-2.0/glib/gthread.h:200:17: note: declared here
 void            g_rec_mutex_unlock              (GRecMutex      *rec_mutex);
                 ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[1]: *** [Makefile:6579: client/main.o] Error 1
---
 acinclude.m4 | 4 ++--
 configure.ac | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index bc39c6d73..4565f77e3 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -23,8 +23,8 @@ AC_DEFUN([COMPILER_FLAGS], [
 		with_cflags="$with_cflags -Wswitch-enum"
 		with_cflags="$with_cflags -Wformat -Wformat-security"
 		with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
-		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
-		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_28"
+		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_32"
+		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_32"
 	fi
 	AC_SUBST([WARNING_CFLAGS], $with_cflags)
 ])
diff --git a/configure.ac b/configure.ac
index 0afe1e6db..1b4ef77f7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -62,8 +62,8 @@ AC_CHECK_LIB(dl, dlopen, dummy=yes,
 
 AC_CHECK_HEADERS(linux/types.h linux/if_alg.h)
 
-PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28, dummy=yes,
-				AC_MSG_ERROR(GLib >= 2.28 is required))
+PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.32, dummy=yes,
+				AC_MSG_ERROR(GLib >= 2.32 is required))
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)
 
-- 
2.20.1

