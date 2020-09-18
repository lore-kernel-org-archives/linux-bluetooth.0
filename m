Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A89C43463
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 17:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1C321734
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 17:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdQ4G8Wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIRRek (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRRek (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 13:34:40 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7924C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 10:34:39 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 34so3866858pgo.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=497rb4WJT/kTaT9XLSWECcXtCLYhvkXiX7i51B/vhLw=;
        b=tdQ4G8Wyw8QiJjvyy9oHJdrGRn7AYwrzzvqCav2W87Nmxe4F6KaiWurIv0KY5YS2Ku
         6/63J1UFasmO9dn+j3ZoKh8K7ylylQ4YoAREIMGrFJh/uCPhpIEgHX3P3KpBcGMdUQ6+
         GdOvBU8jdpIY/pC9TrFGyyLnhF1bcwOeXJCd/UINyuYT1jiEyq54KFiFO8rvlbPPNLun
         VuDkAsRQ/q8bU3iGDYnXCcysllJWqHcO1UBHXZVwvadcbNQdj0WgFVM9AmrXaE8i3nAF
         RFQoGhcd5hUuU199+v2e6MDz+k+wA7ZNIXYIU5I/UGBnINaXU9VGDYluZ1Nn8Py7cXzb
         lUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=497rb4WJT/kTaT9XLSWECcXtCLYhvkXiX7i51B/vhLw=;
        b=fR8rqkmTNVuh2oKH/zamohfS7jyx6oHp64GkMvj/3YB5lD3/qY6xLP9jBDUgE44d3x
         KPyL4ZzPHluhHD79Oge1L+vPhGWaajem67o1wL/Cq5a4+zostT/vhqWtLvBoYMxN2FHO
         C07A6210A+v+hNCnNdgaJlx/Iy4gVtvLBnB2kSVVciowiJs68xV0z7nZI1vca5J++rgL
         LjbIW4xvlGa6OvKRqSV8iP6AHY825b0bTgTlH9dxP5h23SthF+kiCBUsr0BImcxhDKSV
         UQTpwqZCBYCOoOHl7TYmJxrOIPXK4FlBa61XM03m02LpDMODhv2qfeFU2lGMIx2dnNDJ
         ZyxA==
X-Gm-Message-State: AOAM530WQvGonchpZ4OV2TjuvwONN3kgl4pmNd8w+huSi0gNltTZgzFf
        t277+nrqsFhGlptQL//DTjN5bQKIXyA=
X-Google-Smtp-Source: ABdhPJxWJL4CljxjQ8ztbLEoW1MH0CSBNJPAgk5eWBUZjlX32GXB2sq/decVlpsAWWUYkYVmKqNHow==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr10309440pgp.45.1600450478906;
        Fri, 18 Sep 2020 10:34:38 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 5sm3780965pgf.21.2020.09.18.10.34.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 10:34:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] avdtp: Fix not checking if stream is already set as pending open
Date:   Fri, 18 Sep 2020 10:34:36 -0700
Message-Id: <20200918173436.3184738-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When receiving a Open command the stream will be set as pending_open but
the remote may attempt to send yet another Open command in the meantime
resulting in another setup and yet another timer leaving the old timer
active which will likely cause a crash when it expires.
---
 profiles/audio/avdtp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 782268c08..e0c6f44f0 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1687,7 +1687,7 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 
 	stream = sep->stream;
 
-	if (sep->ind && sep->ind->open) {
+	if (sep->ind && sep->ind->open && !session->pending_open) {
 		if (!sep->ind->open(session, sep, stream, &err,
 					sep->user_data))
 			goto failed;
@@ -1699,11 +1699,13 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 						AVDTP_OPEN, NULL, 0))
 		return FALSE;
 
-	stream->open_acp = TRUE;
-	session->pending_open = stream;
-	stream->timer = g_timeout_add_seconds(REQ_TIMEOUT,
+	if (!session->pending_open) {
+		stream->open_acp = TRUE;
+		session->pending_open = stream;
+		stream->timer = g_timeout_add_seconds(REQ_TIMEOUT,
 						stream_open_timeout,
 						stream);
+	}
 
 	return TRUE;
 
-- 
2.26.2

