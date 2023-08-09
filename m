Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507D2C41513
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 06:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjHIGwW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHIGwW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 02:52:22 -0400
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C1C1BF7
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 23:52:21 -0700 (PDT)
Received: from localhost.localdomain (dynamic-093-131-108-051.93.131.pool.telefonica.de [93.131.108.51])
        by mail.svario.it (Postfix) with ESMTPSA id 2611BDA0CC;
        Wed,  9 Aug 2023 08:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
        t=1691563940; bh=CJj/FZXr7sGlROQGB3/+5wCuhgHk2wvJX4FOfom/Y4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugWwVO4NUz8nhGXsl7PGh5LNn5AjTptJFwxGKuYT/EZI4Q3+e6tp8n7sNDj/rItf4
         0Fwr9z7a+UIXEDAfLv7LjkZn1aOAUm/t2FDQRpUHbu/+fs8yY6LUSl4an+5h7ro1B8
         r7y+B0MGubh2KW3RUFNb0woNPlZToZmhfODbiUFw3Lut8DIyNv+f64gdhh3TJjdfK/
         ohCrbufOKjc094X/NPrzqn9Sm2aODF7giP6j3ODb1800gilzn+L2mAQ0KvwXUJg2/Q
         M/wL6vOVAeWFcsbgjvWoRfSrvGnF1iln4uOJRDyDGSF8APCjvSD3aXS3Xg2PYvkO5q
         mFpKncrXy8Zkg==
From:   Gioele Barabucci <gioele@svario.it>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gioele Barabucci <gioele@svario.it>
Subject: [PATCH BlueZ v4 1/2] configure.ac: Bump minimum D-Bus version to 1.10
Date:   Wed,  9 Aug 2023 08:51:42 +0200
Message-Id: <20230809065143.2002324-2-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809065143.2002324-1-gioele@svario.it>
References: <20230809065143.2002324-1-gioele@svario.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

D-Bus 1.10, released in 2015, is the first version that supports reading
policy files from `/usr/share/dbus-1` in addition to `/etc/dbus-1`.

The previous minimum version, 1.6, was released in 2012.
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index bc7edfcd3..298b8cd59 100644
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

