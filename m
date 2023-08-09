Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2C8C001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 06:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjHIGwX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHIGwW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 02:52:22 -0400
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B482D1BFB
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 23:52:21 -0700 (PDT)
Received: from localhost.localdomain (dynamic-093-131-108-051.93.131.pool.telefonica.de [93.131.108.51])
        by mail.svario.it (Postfix) with ESMTPSA id 5647BDA0CE;
        Wed,  9 Aug 2023 08:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
        t=1691563940; bh=jO11Vmz2bohC4/Z9GnAvRwGYI5QFy8hHRKJHetlBVhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pddXeeFePTOmhRGUr2gJOBP+uShCFdTGV2MpiqCrPvK2Li5Xss6fGNOyhEzB9OReo
         E8Gbcn5E0AM1i93fG2G4ce+unXA4jQ1TtkIlrnVJQnls0JB0JGhldP9RfHIfosjSbb
         17ZxW3xdVLkkco1mUAKTCNt/u0EguIkSAYGxWR9GSwLjJQpvZbFvkL4wyiSy0H6WSH
         uWI0vno3r/tGjiVPwmxLTdJYBjrTjdbkOUHqom06oTOyfwng9sQninbu0f1aSsHc8C
         1TpEdDvHVCm92K1rsMzS3n9oKq8+knGIVIbvIivA1bezEnvS4H0yO61Yh6HnM41PvX
         bHU2FMpE2vE7A==
From:   Gioele Barabucci <gioele@svario.it>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gioele Barabucci <gioele@svario.it>
Subject: [PATCH BlueZ v4 2/2] configure.ac: Install D-Bus policy in /usr/share, not /etc
Date:   Wed,  9 Aug 2023 08:51:43 +0200
Message-Id: <20230809065143.2002324-3-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809065143.2002324-1-gioele@svario.it>
References: <20230809065143.2002324-1-gioele@svario.it>
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
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 298b8cd59..ad864dea7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -95,7 +95,7 @@ AC_ARG_WITH([dbusconfdir], AS_HELP_STRING([--with-dbusconfdir=DIR],
 					[path_dbusconfdir=${withval}])
 if (test -z "${path_dbusconfdir}"); then
 	AC_MSG_CHECKING([D-Bus configuration directory])
-	path_dbusconfdir="`$PKG_CONFIG --variable=sysconfdir dbus-1`"
+	path_dbusconfdir="`$PKG_CONFIG --variable=datadir dbus-1`"
 	if (test -z "${path_dbusconfdir}"); then
 		AC_MSG_ERROR([D-Bus configuration directory is required])
 	fi
-- 
2.39.2

