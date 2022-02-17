Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E81C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 09:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiBQJ5v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 04:57:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbiBQJ5t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 04:57:49 -0500
Received: from mail.heine.tech (mail.heine.tech [IPv6:2a01:4f8:1c0c:5073::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45285E0F9
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 01:57:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 974561814B9;
        Thu, 17 Feb 2022 10:57:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heine.tech; s=dkim;
        t=1645091849; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=TX0dzGVLMyX+VT7inAw5wwGEMfBwJGJDaQIbu7ouyJQ=;
        b=qwhs10UNbjXDdDKCbc7/u8DYcU17RFcpQeIiDObHv9Sp0xYRryMQwCn0PuvveXv6TTptNJ
        SCNtOZj24TpmJwjkJ77vpLGQAzALRkdk+Hk6VyLzjb+3xS8xFXHx9Q2HtYgGOOTe25y63a
        YL3w0ixFj7rF3jCXuANCvYozpEk75OQ=
From:   Michael Nosthoff <bluez@heine.tech>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Nosthoff <bluez@heine.tech>
Subject: [PATCH BlueZ] Makefile.tools: remove duplicate link entry
Date:   Thu, 17 Feb 2022 10:56:48 +0100
Message-Id: <20220217095647.2693176-1-bluez@heine.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 Makefile.tools | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 51199b20a..bd902fd83 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -463,8 +463,7 @@ tools_bluetooth_player_LDADD = gdbus/libgdbus-internal.la \
 
 tools_obexctl_SOURCES = tools/obexctl.c
 tools_obexctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
-			src/libshared-glib.la $(GLIB_LIBS) $(DBUS_LIBS) \
-			-lreadline
+			$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
 
 tools_btmgmt_SOURCES = tools/btmgmt.c src/uuid-helper.c client/display.c
 tools_btmgmt_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la \
-- 
2.25.1

