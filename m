Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67544C04A6A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 20:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjHHUel (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbjHHUea (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 16:34:30 -0400
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A63F1E4F2
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 13:01:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [78.48.63.71])
        by mail.svario.it (Postfix) with ESMTPSA id 4DA57DA013;
        Tue,  8 Aug 2023 22:01:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
        t=1691524867; bh=aKf2TOJmaacSuzBmZ4NKTJRHGo/1g8DGxZfgBQyfHl8=;
        h=From:To:Cc:Subject:Date:From;
        b=lnla4hZ92noySepWEgujwFUSV8jlPb0gFqcOrEwsZziJGpPcZOq8xIQFDUFtcNrNt
         IVQDCa0FwenxstT/KzcXqQhYB+4BwjlCQ4FS5WnycdYjeCS3NLxATWf10BFO57wIGb
         aBrHUCcCDdibc5eO0cBp1Ah7p7qxUl3d2GVxxXKCQMK0nDIxC9hYZyEhFbRKM0HU1B
         GTz6pR1Chkana/N1oUqs8TO+GaQ3HdqOPRO9jFIAqgEF4YNaBhMzxbumihZe3K/LQ4
         /fdVWfqLlcmfRREIbsWcfm6eTuW49Ufarwo4GQ+P0HVBWROUx2PlO5JdoR0Pds9oAC
         dwv6mYPWPLfPA==
From:   Gioele Barabucci <gioele@svario.it>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gioele Barabucci <gioele@svario.it>
Subject: [PATCH BlueZ v2] configure.ac: Install D-Bus policy in /usr/share, not /etc
Date:   Tue,  8 Aug 2023 22:00:22 +0200
Message-Id: <20230808200022.2001329-1-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From https://bugs.debian.org/1006631:

> dbus supports policy files in both `/usr/share/dbus-1/system.d` and
> `/etc/dbus-1/systemd`. [The] recently released dbus 1.14.0, officially
> deprecates installing packages' default policies into
> `/etc/dbus-1/systemd`, instead reserving it for the sysadmin.
> This is the same idea as the difference between `/usr/lib/udev/rules.d`
> and `/etc/udev/rules.d`.
---
v2: bump D-Bus min version, derive DBUS_CONFDIR from datadir
---
 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index bc7edfcd3..ad864dea7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -82,23 +82,23 @@ if (test "${enable_threads}" = "yes"); then
 	PKG_CHECK_MODULES(GTHREAD, gthread-2.0 >= 2.16, dummy=yes,
 				AC_MSG_ERROR(GThread >= 2.16 is required))
 	GLIB_CFLAGS="$GLIB_CFLAGS $GTHREAD_CFLAGS"
 	GLIB_LIBS="$GLIB_LIBS $GTHREAD_LIBS"
 fi
 
-PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.6, dummy=yes,
-				AC_MSG_ERROR(D-Bus >= 1.6 is required))
+PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.10, dummy=yes,
+				AC_MSG_ERROR(D-Bus >= 1.10 is required))
 AC_SUBST(DBUS_CFLAGS)
 AC_SUBST(DBUS_LIBS)
 
 AC_ARG_WITH([dbusconfdir], AS_HELP_STRING([--with-dbusconfdir=DIR],
 				[path to D-Bus configuration directory]),
 					[path_dbusconfdir=${withval}])
 if (test -z "${path_dbusconfdir}"); then
 	AC_MSG_CHECKING([D-Bus configuration directory])
-	path_dbusconfdir="`$PKG_CONFIG --variable=sysconfdir dbus-1`"
+	path_dbusconfdir="`$PKG_CONFIG --variable=datadir dbus-1`"
 	if (test -z "${path_dbusconfdir}"); then
 		AC_MSG_ERROR([D-Bus configuration directory is required])
 	fi
 	AC_MSG_RESULT([${path_dbusconfdir}])
 fi
 AC_SUBST(DBUS_CONFDIR, [${path_dbusconfdir}])
-- 
2.39.2

