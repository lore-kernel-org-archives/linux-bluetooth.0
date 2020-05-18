Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBFEC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8172083E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKy82HQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgERW3N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 18:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgERW3M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 18:29:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7595DC05BD09
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:29:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s69so467623pjb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tHIUr6OI2tzpztosBH4ZilMc0GllNIQQ/6Oyt/MLLiY=;
        b=SKy82HQdEPp6t1+7IT2aV6WZ+gR01Tkqpsugg2dgbE/MkWkoPntelW+RKrv3Dtu1Ix
         lXV1YCbfBGcOgYh6A3iBvbcQ7h9qT2n5GCeF1XoL9+eZa6+HrhYiIuIo0N6nB5k2ybGx
         oBukpinY2SmJUDRc/nPWId7oFkIlffxcwke/jCCWnC+qUCzWn/uD4T3JPWhvEArqtfxa
         Rxp1bVheD9cbn9ti1txistIj9+QTjbTM3WqQVrUa79IKOGLUm+A2yO4ETTKv10s7fVFO
         uFQFGjhw3BKyZUtxzXzkFmSMkSt8vkiOZVwoCwdBl1nNPY+DmuCjAUGOa7t8QGAXVdlF
         itgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHIUr6OI2tzpztosBH4ZilMc0GllNIQQ/6Oyt/MLLiY=;
        b=t02l93GwO5F/009px4664vmE4mYSUm/NFgQ6otueW8OOaC6mMaF+pJR6Dv1oFBCroy
         taDJxUga/G6YuB6aH8VvUxpHJdML0kBf2vHPgiGd6YnHKSvTzE6pAYifRMCX45U4CWK4
         +5vP6BVCiRC3FkpL+hu6TrxX0W8rdV8TXcqgbuDzdt6c1Ih/GhHltcRPWyWdvUO8M8MM
         QzyQSkiM77grLIZIzorWVHvS3KT7csHxwPfijyqAfJnveNablLLoXxTYyDjAS2fDwBqy
         wiDJAmJK7gk719+gPgZ0GzTHzwDluhnkLukApsznaaBa6umJjJ0grF+p0UTsaf/D112b
         ACrg==
X-Gm-Message-State: AOAM531L2YwcmeeB0rbcfvVjwzDWlXv3cGmwUYDjqQG8yGLF7iDoEcWj
        ryDijj5nC1jV1fICgpm1JU65G08l
X-Google-Smtp-Source: ABdhPJzNb8BtKCoFfi3xlO6sJi7h+55GnBpZYXN4QxbHhViDY95AcWPeFtfkIdl45D21VqZXEHl7mA==
X-Received: by 2002:a17:90a:d484:: with SMTP id s4mr1724537pju.206.1589840951682;
        Mon, 18 May 2020 15:29:11 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 5sm8291733pgl.4.2020.05.18.15.29.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 15:29:10 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] a2dp: Fix caching endpoints for unkown version
Date:   Mon, 18 May 2020 15:29:05 -0700
Message-Id: <20200518222908.146911-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200518222908.146911-1-luiz.dentz@gmail.com>
References: <20200518222908.146911-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Don't cache the capabilities of endpoints which the version is unkown
since so capabilities may not be available in such case.
---
 profiles/audio/a2dp.c  | 11 +++++++++--
 profiles/audio/avdtp.c |  7 ++++++-
 profiles/audio/avdtp.h |  1 +
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index a2ce3204d..15e211b95 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2667,15 +2667,22 @@ static void discover_cb(struct avdtp *session, GSList *seps,
 				struct avdtp_error *err, void *user_data)
 {
 	struct a2dp_setup *setup = user_data;
+	uint16_t version = avdtp_get_version(session);
 
-	DBG("err %p", err);
+	DBG("version 0x%04x err %p", version, err);
 
 	setup->seps = seps;
 	setup->err = err;
 
 	if (!err) {
 		g_slist_foreach(seps, register_remote_sep, setup->chan);
-		store_remote_seps(setup->chan);
+
+		/* Only store version has been initialized as features like
+		 * Delay Reporting may not be queried if the version in
+		 * unknown.
+		 */
+		if (version)
+			store_remote_seps(setup->chan);
 	}
 
 	finalize_discover(setup);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index b632e41c5..1fd2be051 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2256,7 +2256,7 @@ static uint16_t get_version(struct avdtp *session)
 	const sdp_record_t *rec;
 	sdp_list_t *protos;
 	sdp_data_t *proto_desc;
-	uint16_t ver = 0x0100;
+	uint16_t ver = 0x0000;
 
 	rec = btd_device_get_record(session->device, A2DP_SINK_UUID);
 	if (!rec)
@@ -2396,6 +2396,11 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
 	return session;
 }
 
+uint16_t avdtp_get_version(struct avdtp *session)
+{
+	return session->version;
+}
+
 static GIOChannel *l2cap_connect(struct avdtp *session)
 {
 	GError *err = NULL;
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index ad2cb9bcb..f1e51d4e3 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -310,3 +310,4 @@ struct avdtp_server *avdtp_get_server(struct avdtp_local_sep *lsep);
 
 struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
 							struct queue *lseps);
+uint16_t avdtp_get_version(struct avdtp *session);
-- 
2.25.3

