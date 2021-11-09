Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28779C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 21:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA7F611AD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 21:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245344AbhKIV4Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 16:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245133AbhKIV4N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 16:56:13 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D54C06120C
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 13:53:24 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x64so677110pfd.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Nov 2021 13:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bxQPvhRFPKwhsD3z26Zu+DsYo3Eo8DFghWYUx0qySqw=;
        b=Rv1vaXkBZwdhCol4Vt8PVxXkt4DbwUTGWEr5p3WsHpDrs2dz7JvIarqOntqNtr2I2A
         r3FgLVmigZy5WCcz5n0xVOfHuNDxzUxGFosSouWk6toWCSs6t1rybMQ70PGms17roctK
         jscPWGSXjX5bZzngHSzwTYIlz9Km8w11QWNy3QnnwFdEU/3E7tnxsPH9vbyiy4x1m3uq
         X52zX4tWSRL5bLiyF2M7JMorFjSHmFycfSVsf9z6uG4gdqMNV6ldW0BoqfOYUAEzmDWR
         XyBlciJmZWyvYiQKALOrF1WQzYXcHZ1N3lsORC2oGh3x/gHWVJVFXqTA69Pz3nyTz/Ce
         PPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bxQPvhRFPKwhsD3z26Zu+DsYo3Eo8DFghWYUx0qySqw=;
        b=fVllmwMNZ3LgpI1DWqUqZucTOAu0znwXaL9OyzngQJBFjfTapIz7cY5mwZW98C1O9A
         SXck2ETQP+yIXSU3bCOEw+d645HWZDNAzO5Au20CALolvONIxhHmIcTfsP4Ysxgwlxov
         T1QPaS1AIjKFLEjmKOHA8LurcSQDVjIG3VH44gTYt6xdRTvsU+iAmN75obZZ0ZRMJPJ0
         pjpGeZ4qpUqlpkOnRXcJetVC5X/5QuFmkl8gBovcgQZMbY4W7WX7GrTGpy8+PsyqHNQP
         xIw5V7JYi1ZrchvVNNzya3ls8sLqEwyt30MY8yPaHBSd6oQgG04zsJz1IqHTnn5V4XpC
         cnZg==
X-Gm-Message-State: AOAM530LX1lr7XOF5cMeJZee0pAwUrRiWLYymZw5l8bma72TID1vfk1v
        /IcSY4WwePm+fe0p/nE9ON/Ke+rbzqE=
X-Google-Smtp-Source: ABdhPJxe+vPODbOpA8mHgc4hzfgZplMbPHZfzR0jnjVI/anDnGN2mgoo65JAXOHsPDG53kK1+jPyWg==
X-Received: by 2002:a62:5b47:0:b0:480:69a9:29cd with SMTP id p68-20020a625b47000000b0048069a929cdmr11377762pfb.40.1636494803337;
        Tue, 09 Nov 2021 13:53:23 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id j8sm21809563pfu.27.2021.11.09.13.53.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 13:53:23 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] media: Fix memory leak
Date:   Tue,  9 Nov 2021 13:53:22 -0800
Message-Id: <20211109215322.1124566-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following memory leak as a result of not freeing
app->proxies:

160 (32 direct, 128 indirect) bytes in 1 blocks are definitely lost in
loss record 218 of 261
   at 0x484086F: malloc (vg_replace_malloc.c:381)
   by 0x1CF80E: btd_malloc (util.c:33)
   by 0x1CF24D: queue_new (queue.c:47)
   by 0x144DB9: create_app (media.c:2262)
   by 0x144DB9: register_app (media.c:2322)
   by 0x1CC148: process_message (object.c:246)
---
 profiles/audio/media.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 521902ed8..edefedc90 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1910,6 +1910,7 @@ static void app_free(void *data)
 {
 	struct media_app *app = data;
 
+	queue_destroy(app->proxies, NULL);
 	queue_destroy(app->endpoints, media_endpoint_remove);
 	queue_destroy(app->players, media_player_remove);
 
-- 
2.31.1

