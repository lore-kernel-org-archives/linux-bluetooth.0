Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D2DC001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 06:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjHIGqD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjHIGqC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 02:46:02 -0400
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D610CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 23:46:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-093-131-108-051.93.131.pool.telefonica.de [93.131.108.51])
        by mail.svario.it (Postfix) with ESMTPSA id B58F5DA0CA;
        Wed,  9 Aug 2023 08:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
        t=1691563560; bh=S5Ari7JOoRk4et698Nm1gLH0vc1LRoskNWbFHENZJIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VsifFiTYHw+HGVJR159LJjQwu3gTcbiO/algKsThc3MF6ouARIybSCHrOA1unEoab
         xR1GhHIaPuGy4bNWMgC9Z2XGdaF79t+Xh9MYK4puv54b/t23WVneTMhCdMZWcagCSh
         8jHhB9Rad7cqq8Bao1n+AmzCRMAZJTryfSSbfHvQ8kPZhKBc1Ow4k5NtbjBW15UVNZ
         nSbqLc46WTyM8tYmXaekWUl+8WeYSPZH+A2ZXcRiehPK8rOZH0Dz3jqabQLpXmc5j3
         lklOYBKPcumKWE/PHJlyiuQy8ZuxspCBQ62YxLmLnaO326QYg/HkZLoJi4CQ/14VvY
         5zghbmLBlW5eQ==
From:   Gioele Barabucci <gioele@svario.it>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gioele Barabucci <gioele@svario.it>
Subject: [PATCH BlueZ v3 2/2] configure.ac: Install D-Bus policy in /usr/share, not /etc
Date:   Wed,  9 Aug 2023 08:44:41 +0200
Message-Id: <20230809064441.2002194-3-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809064441.2002194-1-gioele@svario.it>
References: <20230809064441.2002194-1-gioele@svario.it>
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
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5348bf3c2..ad864dea7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -85,8 +85,8 @@ if (test "${enable_threads}" = "yes"); then
 	GLIB_LIBS="$GLIB_LIBS $GTHREAD_LIBS"
 fi
 
-PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.6, dummy=yes,
-				AC_MSG_ERROR(D-Bus >= 1.6 is required))
+PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.10, dummy=yes,
+				AC_MSG_ERROR(D-Bus >= 1.10 is required))
 AC_SUBST(DBUS_CFLAGS)
 AC_SUBST(DBUS_LIBS)
 
-- 
2.39.2

