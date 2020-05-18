Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD24C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D6020829
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIfE3swS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgERW3L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 18:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgERW3L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 18:29:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58473C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:29:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f4so5477584pgi.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/drnTK7oqzlA6HKd0xsBjyJ4zbDkXGVCB4bLg2dxp8=;
        b=gIfE3swSar8R7ZYDrxsEzUITRoLiTvGaSmjxvlL6H3I/7Lg+1503PuBZHCTaX/AQ06
         r4MJrv4TUqjurzM06IwbgNVvnzSTesWuCP3pPN8OWfK4/eQdT5unPKbxD6eXx4blExX1
         BQwigWIHWW2pGE0l5ZmAYQ+B65k0cwcoL04DGpg2t2eTlmwcFf9iGDYqrOzcl+lnKAjW
         QsxWDPqMdtH60J4aJRZPU8gCDNZjMVcue44adUir1Cj4EUsbebM0dPw78BK/TVYDn0Z5
         CNiwC72Bb4otrsI7rEMfWs+YuZSPnq3T8H+Mq1r/+zIyrpI/aVLLb09nJ/LDOanEgMKX
         5Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/drnTK7oqzlA6HKd0xsBjyJ4zbDkXGVCB4bLg2dxp8=;
        b=C3CQvMRrp7UiS6r9S+L2CORXeS2WCA/9SPbmoy6P35teZK108u4Csd8CbqAky9+WUN
         cgerWcuVaxtppkp+l6U/FFhaz7/Y4R7Ixa47p4iB1MvZjIIaN3gRPAGrUmOmQSmC7R/p
         aKhVKPzT0TVEb880Ds+qwowp3E4XpPNkDc5NuBR+x5jJB0erXiSxI+5T6GymtYHL1VhS
         FN6hzGs/iSgyo91XydXfjqPa7Xez3QTcviKNz+JLL9X+Ub6M71Va9RDNOhMzybG+p2qz
         Hobfzw3qJlhDyPzr2BfJGzCmySouB4l+50jX6Y8qq4j7p9hHsku9OUcNeZ2be0cx3L/R
         UUjw==
X-Gm-Message-State: AOAM533eWBekV+vw4kOrDmk96NMzV4DnQGgSsKQMiogdUN1vaWqrpz4X
        IfyAv4ML7Nogtq+T326jsIhT8QXN
X-Google-Smtp-Source: ABdhPJyXsDipd7QbfEJ4bxxFwBKx0YM3C/20sCWlYf72LUXjfCBzJzvbY05r1ICkBnGNyJK8PNigLw==
X-Received: by 2002:a62:1e84:: with SMTP id e126mr2439643pfe.67.1589840950337;
        Mon, 18 May 2020 15:29:10 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 5sm8291733pgl.4.2020.05.18.15.29.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 15:29:09 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] a2dp: Fix caching endpoints for unknown version
Date:   Mon, 18 May 2020 15:29:04 -0700
Message-Id: <20200518222908.146911-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Don't cache the capabilities of endpoints which the version is unknown
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

