Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93E0C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4DD20872
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuC8/aMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgESUDt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 16:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgESUDs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 16:03:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A38C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:03:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so336191plr.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/drnTK7oqzlA6HKd0xsBjyJ4zbDkXGVCB4bLg2dxp8=;
        b=cuC8/aMnjTo9zfERyXUIvA0FultotjL2l0UTnk+fDihFYj6TixFThmf+SOADgTdbtL
         P0J7PqsyHWdak4sdtBnY6r45jX/FUyo9f87a6yDvqc3p4gBq4cP9Nf2ZuX2OVQIm2z//
         daPhfE4M2O3EA4fuG9wb3KkJutdLttiiVpq5TwinEVrjKhpNo7/n7jnllVaiBpBFTAgA
         LAfynRL7FPteSkCqQfvXK9yERcR2/uDT9Dtq9E0HRzyJSc85IUGMq7kAFzQYmSM6sxAB
         UVkvUbiGzUY/7hgyaxLZ0+rVm9TSwIfhlBAyIHQAt4JDlwLLFHIdroZLHP6qJpYTLjdZ
         Iq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/drnTK7oqzlA6HKd0xsBjyJ4zbDkXGVCB4bLg2dxp8=;
        b=Mpu/yPafPsIFnI/+rQaM+n295cQKvQwTIosC7PakiKOuicOLgLPM75Lr71dhbs9rqp
         SCHxGoztBTOkxE7SdXcBkXOEm0aelahIa2TWVheXKY7mGUplRH3ABnvt4m0GzhBWxmBD
         fgOCH2/OTX2hsaZI9fCboPg9ZyJscPu9q6YbveTd4WgF43sb5FIyXOICC0kZYYdI6QF7
         jogY3wPyRygP6zRYy2yiPaJIu5EEew9bK9DjC4ZmVxHP8nLmfqXSHAckxrNBVnqxVD36
         lQy8H/rxgcf90+RrmgwqQnM+GSPp5AQ+jDwFDoP2fHi3wnW7ggkTcSsO3R43KUSkvnBf
         tuMg==
X-Gm-Message-State: AOAM531/8vSoNTgm+MBdTO6xI6olduhndTCxW9aAVLS8yzb1EIJ5sHYI
        7qzNmi/P8k+g+7jQGLIE5ardBwq5
X-Google-Smtp-Source: ABdhPJyJPVDAlB/VHIJPjjLcxeYBPBYS38piZ7x0OJaA4opEAvWCj5nnOgL8LpR9Iuz02JHGQNlc8A==
X-Received: by 2002:a17:90a:e016:: with SMTP id u22mr1320038pjy.28.1589918627489;
        Tue, 19 May 2020 13:03:47 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i98sm302003pje.37.2020.05.19.13.03.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 13:03:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/4] a2dp: Fix caching endpoints for unknown version
Date:   Tue, 19 May 2020 13:03:42 -0700
Message-Id: <20200519200345.217345-1-luiz.dentz@gmail.com>
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

