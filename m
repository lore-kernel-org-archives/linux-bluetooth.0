Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8A1C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 May 2023 23:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjE0XPR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 May 2023 19:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE0XPP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 May 2023 19:15:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D75B1
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 May 2023 16:15:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af225e5b4bso20238491fa.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 May 2023 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685229312; x=1687821312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L6xYUZJ8iVcW3BpQIbPt8WWQzk8DcOdbdHRGC/mMYeA=;
        b=Jlhlo7idKKu5KAnN4tARG5uVba0XztCxaCs1cPzemwXWz+3FG8qYED7aCRuysMp3l3
         D6NaFUvmMgxYOjjHaVBpFx+gJw6xt7c5gCCYHtF6PY8U6cADXlrZAoDDnPvJgC7H7s0Q
         PRi5D3fTCjISxN98jspoFv/EYpD2site9nPjsTHigvFjenn5NRMnrIxdj10uNYPrAZFw
         dqyD2Sez0qFyoo1U441oWYW7Y6Hmdsi+eSCwRFzEjHJlgtzwaLJttBb+ntlxkZTu+OjX
         nZJzAR7DGMM+pXL8kxmJiPMOFNOoC5Q5xvA7UMWNqopmb+A5Je3ABUK1ZNE9lkibmvpn
         YctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685229312; x=1687821312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6xYUZJ8iVcW3BpQIbPt8WWQzk8DcOdbdHRGC/mMYeA=;
        b=U00/gP+7QUGGzCvTE0IdbrYLgkinFwNurjme/YkEPoK5eMCFF/Np3oiM4uTEzJGouc
         oIHboSk889lQndsKblrTumROtghvl0OjPgUsNULgN0yBEnG4hRYifaquSBSvRW+YGxTb
         3HHGWj8cqtJHZ65j1GO/Yt+rArsOj0o3IfWD/bZW2XpVkSqMN5VzZPwB2OIJP5LZ18r9
         v/3leBJFGnxrF1HL01foFsI2Aj3fen5e9DvfdiFEzj1ou9ekhe/uxcZSLhq0OjGr09mh
         vRCPj00ysh9eylcCbLQv7TaYll+YrS3syvptmpiQJyS42EQSpZaEJM/k6ldpN7Vwn5RM
         fIwA==
X-Gm-Message-State: AC+VfDxkzVAD0iACbcSErsYF8oqFiC0t4W4tTcwtOsMMjdF5Lmlev49w
        yyibMndkI5c4Ude5sj6YxLwCoU+w75UMPA==
X-Google-Smtp-Source: ACHHUZ7HKoNC0Kj9GfU8edqyuq9Ahn/3ycWGHH5YVZ2Qk/zixr+r9WV7jspNpeCzJSghcP/rFavNKw==
X-Received: by 2002:a2e:894b:0:b0:2af:2826:b20d with SMTP id b11-20020a2e894b000000b002af2826b20dmr3257799ljk.13.1685229312079;
        Sat, 27 May 2023 16:15:12 -0700 (PDT)
Received: from localhost.localdomain (188.146.125.123.nat.umts.dynamic.t-mobile.pl. [188.146.125.123])
        by smtp.gmail.com with ESMTPSA id d17-20020a2e3611000000b002b0488ef239sm1649404lja.93.2023.05.27.16.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 16:15:11 -0700 (PDT)
From:   Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] media: Register app objects in proxy_added_cb()
Date:   Sun, 28 May 2023 01:14:58 +0200
Message-Id: <20230527231458.673167-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The proxy_added_cb() function is called every time a new client is added
to the application object manager. Registering media endpoint and player
in that proxy_added_cb() callback function will allow to register new
endpoints and players not only during the initial RegisterApplication
call, but also during the application lifetime. For instance, this might
allow to dynamically enable/disable support for additional codecs.
---
 profiles/audio/media.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 6ce668e31..4c42b7817 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -2821,9 +2821,6 @@ static void client_ready_cb(GDBusClient *client, void *user_data)
 		goto reply;
 	}
 
-	queue_foreach(app->proxies, app_register_endpoint, app);
-	queue_foreach(app->proxies, app_register_player, app);
-
 	if (app->err) {
 		if (app->err == -EPROTONOSUPPORT)
 			reply = btd_error_not_supported(app->reg);
@@ -2867,6 +2864,10 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 	path = g_dbus_proxy_get_path(proxy);
 
 	DBG("Proxy added: %s, iface: %s", path, iface);
+
+	app_register_endpoint(proxy, app);
+	app_register_player(proxy, app);
+
 }
 
 static bool match_endpoint_by_path(const void *a, const void *b)
-- 
2.30.2

