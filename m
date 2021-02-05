Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C6BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Feb 2021 03:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7578964FBC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Feb 2021 03:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBEDsd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Feb 2021 22:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBEDsc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Feb 2021 22:48:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CFAC0613D6
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Feb 2021 19:47:51 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v17so5528690ybq.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Feb 2021 19:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=3pxdwMaEIMqf8h/jT0Lx1lurC2WXnjzXVKWgKhvw3R0=;
        b=bHaGzadC/SLuN5fZ652vqVLnkRw/+Njs/vGPhovyHadSg+rcQyVEziVYfzQomPUSmr
         wa/jIjXtf9GTIi0CxLOHqekojpEGaOritMmsDKN4J5DfajrFF1gtKDZ0pa/wMIAXAc2e
         Iih36BsZ4/8HO1NWYkRQIhBaBRXtUHTLe7/dJ0jqr7guiJCuxyLVg4wOK9HLo7R32TDh
         ZhoSfNiTNj1YLK/gprI0+unr9LnB3WuP/LgLmlaMXhHjTvEqoT2QuyeGzGNFX391tDhU
         tyitkkiEngcDU50cPYRv45F1gduP9MF/RFlhQLoefV/UcsCCG0B0YUC0kdufGRKL5tR5
         0zGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=3pxdwMaEIMqf8h/jT0Lx1lurC2WXnjzXVKWgKhvw3R0=;
        b=F5KQlk0xG5jXXFRxRNLe4QARvYJPtUtMs1OeSJZpb5H04msfhGxGd3F+km0lImjZCL
         xXwf4sczP9TM1mszQY6u/K5nKtPyq9huSSLZGJXx/pUaGch8fSJqoqJ5BPek6qibJTFx
         ossDW8+qKmoyEoFf6wrABWeOLPmRxQDygYHRtG3oAyJCQi8gdffWstUd32VeECoIYbWi
         BSCyRQylerJ4I2cJtgg3bRvb9Ku2pLat14teJZoA6zxCNJuwWaWo+SmOTtY55wqJRaWZ
         MSgjJ3bjq22mOnqmimJerSq7ioiO8QsGy0QTanmLkVkcM22EOwHd7Rdkq40pAUDyx08R
         GqlQ==
X-Gm-Message-State: AOAM530AZ2OaYWye7hZcwIk1c1ATfhIOdLEkfe/58Q28KCp7a9QDRsU2
        AhnXFSCwy0a+WrohbyehGw3eIsgLPmJOyPLMCxf5c/uU7tNWiB8qAtfB/J/GJno/4INEFWK4jxl
        iEPczzzM1tsvzMqBh/R4HVhJpryELCjxd5WZL86E416x8ZMJ7XUTH8h5qk5rPREaMoUtCVG+Rby
        qn
X-Google-Smtp-Source: ABdhPJz4BID8atr4ZvMwtCHr1YUNFJ30U2Lgme6CJ1PdaQ1cMUuA/n1duoQibH94FZBX29yEBujuXUWcJ3EA
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:2cf1:c203:61da:52ad])
 (user=apusaka job=sendgmr) by 2002:a25:1e42:: with SMTP id
 e63mr3636835ybe.270.1612496870937; Thu, 04 Feb 2021 19:47:50 -0800 (PST)
Date:   Fri,  5 Feb 2021 11:47:46 +0800
Message-Id: <20210205114735.Bluez.v1.1.I68cf9b7c0c0c3c0e069011976e3008ff11374a28@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [Bluez PATCH v1] a2dp: set session to NULL when freeing channel
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

There is a possibility that avdtp_channel is freed when avdtp_setup
is not yet freed. This could cause crashes because setup->chan will
then point to an invalid address.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Michael Sun <michaelfsun@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

 profiles/audio/a2dp.c   | 34 ++++++++++++++++++++++++++++------
 profiles/audio/a2dp.h   |  4 ++--
 profiles/audio/avdtp.c  |  6 ++++++
 profiles/audio/sink.c   |  5 ++++-
 profiles/audio/source.c |  5 ++++-
 5 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 624d0d42d2..98cae97b93 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -379,7 +379,8 @@ static void finalize_select(struct a2dp_setup *s)
 		if (!cb->select_cb)
 			continue;
 
-		cb->select_cb(s->session, s->sep, s->caps, cb->user_data);
+		cb->select_cb(s->session, s->sep, s->caps,
+					error_to_errno(s->err), cb->user_data);
 		setup_cb_free(cb);
 	}
 }
@@ -457,7 +458,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		int err;
 
 		setup = find_setup_by_stream(stream);
-		if (!setup || !setup->start)
+		if (!setup || !setup->start || setup->err)
 			return;
 
 		setup->start = FALSE;
@@ -606,7 +607,7 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 		DBG("Source %p: Set_Configuration_Ind", sep);
 
 	setup = a2dp_setup_get(session);
-	if (!session)
+	if (!setup)
 		return FALSE;
 
 	a2dp_sep->stream = stream;
@@ -715,7 +716,7 @@ static gboolean endpoint_getcap_ind(struct avdtp *session,
 
 static void endpoint_open_cb(struct a2dp_setup *setup, gboolean ret)
 {
-	int err;
+	int err = error_to_errno(setup->err);
 
 	if (ret == FALSE) {
 		setup->stream = NULL;
@@ -723,7 +724,9 @@ static void endpoint_open_cb(struct a2dp_setup *setup, gboolean ret)
 		goto done;
 	}
 
-	err = avdtp_open(setup->session, setup->stream);
+	if (err == 0)
+		err = avdtp_open(setup->session, setup->stream);
+
 	if (err == 0)
 		goto done;
 
@@ -1172,6 +1175,11 @@ static gboolean a2dp_reconfigure(gpointer data)
 
 	setup->id = 0;
 
+	if (setup->err) {
+		posix_err = error_to_errno(setup->err);
+		goto failed;
+	}
+
 	if (!sep->lsep) {
 		error("no valid local SEP");
 		posix_err = -EINVAL;
@@ -1510,6 +1518,7 @@ static void remove_remote_sep(void *data)
 static void channel_free(void *data)
 {
 	struct a2dp_channel *chan = data;
+	struct a2dp_setup *setup;
 
 	if (chan->auth_id > 0)
 		btd_cancel_authorization(chan->auth_id);
@@ -1526,6 +1535,15 @@ static void channel_free(void *data)
 
 	queue_destroy(chan->seps, remove_remote_sep);
 	free(chan->last_used);
+
+	setup = find_setup_by_session(chan->session);
+	if (setup) {
+		setup->chan = NULL;
+		avdtp_unref(setup->session);
+		setup->session = NULL;
+		finalize_setup_errno(setup, -ENOTCONN, NULL);
+	}
+
 	g_free(chan);
 }
 
@@ -2561,6 +2579,9 @@ static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 	struct avdtp_media_codec_capability *codec;
 	int err;
 
+	if (setup->err)
+		goto done;
+
 	if (size >= 0) {
 		caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
 		goto done;
@@ -2727,7 +2748,8 @@ static void discover_cb(struct avdtp *session, GSList *seps,
 	DBG("version 0x%04x err %p", version, err);
 
 	setup->seps = seps;
-	setup->err = err;
+	if (err)
+		setup->err = err;
 
 	if (!err) {
 		g_slist_foreach(seps, register_remote_sep, setup->chan);
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index b40bd47364..615b641c9a 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -42,8 +42,8 @@ struct a2dp_endpoint {
 
 typedef void (*a2dp_discover_cb_t) (struct avdtp *session, GSList *seps,
 						int err, void *user_data);
-typedef void (*a2dp_select_cb_t) (struct avdtp *session,
-					struct a2dp_sep *sep, GSList *caps,
+typedef void (*a2dp_select_cb_t) (struct avdtp *session, struct a2dp_sep *sep,
+					GSList *caps, int err,
 					void *user_data);
 typedef void (*a2dp_config_cb_t) (struct avdtp *session, struct a2dp_sep *sep,
 					struct avdtp_stream *stream, int err,
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index b8ef5f6824..fa72ef66a9 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3847,11 +3847,17 @@ uint8_t avdtp_sep_get_seid(struct avdtp_local_sep *sep)
 
 struct btd_adapter *avdtp_get_adapter(struct avdtp *session)
 {
+	if (!session)
+		return NULL;
+
 	return device_get_adapter(session->device);
 }
 
 struct btd_device *avdtp_get_device(struct avdtp *session)
 {
+	if (!session)
+		return NULL;
+
 	return session->device;
 }
 
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index d672670e25..56c4917780 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -183,13 +183,16 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 }
 
 static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
-			GSList *caps, void *user_data)
+			GSList *caps, int err, void *user_data)
 {
 	struct sink *sink = user_data;
 	int id;
 
 	sink->connect_id = 0;
 
+	if (err)
+		goto failed;
+
 	id = a2dp_config(session, sep, stream_setup_complete, caps, sink);
 	if (id == 0)
 		goto failed;
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index c706c928a7..c6009d0ea2 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -180,13 +180,16 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 }
 
 static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
-			GSList *caps, void *user_data)
+			GSList *caps, int err, void *user_data)
 {
 	struct source *source = user_data;
 	int id;
 
 	source->connect_id = 0;
 
+	if (err)
+		goto failed;
+
 	if (caps == NULL)
 		goto failed;
 
-- 
2.30.0.365.g02bc693789-goog

