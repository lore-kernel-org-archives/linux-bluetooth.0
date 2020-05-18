Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C853EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 20:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D67620756
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 20:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txADvoHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgERU4k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 16:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERU4k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 16:56:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D234EC061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 13:56:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a13so3177904pls.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHIUr6OI2tzpztosBH4ZilMc0GllNIQQ/6Oyt/MLLiY=;
        b=txADvoHoXFuTKvxxvUZ5uBhNuTrq8SfLGWeIsAnl5ZeEGvRwbEbmnJIL5URIN+Ixv4
         NfFJS/PXYaodm5kQUVm6SFdPy0enHC9Mr3Jxh1TswNfdYb6TdzuBkQNbuP8C322WC6Ep
         yjThoFVQTzGKov6cRQYtGNX4LV2mmSKwLJV7fXX39/49oIHb7iIRE2OtpigIxZ+coEjm
         Drs1djqI4FmQ9nOt7YlzYi8r5CwBCRCwcPMAo51d8FQC4YRNF1Mx8o65rSVIh5gPjoun
         oCrIH+HItOb9PsLi+C1T0TSAJ+/2nbKSypjO5opml1PGJBMOVnJwnjBHXnOQk8xc0AF0
         iIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHIUr6OI2tzpztosBH4ZilMc0GllNIQQ/6Oyt/MLLiY=;
        b=ImHeXXfJ1QrJNfb4pKpytp0E35m5MdFvrRZ2E2l1b1asL+XbLEsE6zfZpvAg1kxjmS
         7yaxWr84B6KDc8W+gOVMvznF/Hlr3WxROp5Jmh+Tt9HWEFXISr4CjUqff9RDvYVnekdZ
         6NdDetSVKo38sIGJRtDWIoyCRW7t60hkQdojip3+ierUY41L9V77U5nQsgMidjcOZl2B
         eHG8HSwffTaCBC0B76nc2baolGXEsqMl26HMdWbflqJHF4rNYeNXqPdi/Ef8E58/+30o
         DvGuQYhqQCxysqnTUKEe/4dn+9nzb6gB36/ZFWJm8TZB89LRDa46WTTCHvm4wrzk54jp
         TVvA==
X-Gm-Message-State: AOAM533lBS2x9KYQXFyqqkfmyRAUQs525i47i21IHicoZWenfzSkdXEq
        qGQNPtLbFEa+AxkFlSZTpUDs4lO7
X-Google-Smtp-Source: ABdhPJz9cEkXnP/W7K16qhppLqGdQ7eXvJ8MlCtc/TGdqQotr0YTwDUrZB3TGSBn2Wdbw2LbdWFYBw==
X-Received: by 2002:a17:902:d208:: with SMTP id t8mr18534109ply.324.1589835398309;
        Mon, 18 May 2020 13:56:38 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q18sm8519808pgn.34.2020.05.18.13.56.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 13:56:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] a2dp: Fix caching endpoints for unkown version
Date:   Mon, 18 May 2020 13:56:33 -0700
Message-Id: <20200518205636.139184-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
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

