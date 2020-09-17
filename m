Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754CFC43464
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283FA20872
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BXsYk4jZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgIQWKj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIQWKj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 18:10:39 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84919C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:10:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k15so2090592pfc.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nuKbT2MkJWv7INdk0/k3X3j6IVsocXvyZrAPLLJg8Ys=;
        b=BXsYk4jZ3oZKfOInNKFKKn4yBUT1wWKiNMe4UXNzN/6bZ+l5LP2n+aV6hlZ0pfIKTd
         5ypNm+aS/v1zZNLGb2IUZY7ht9OAkRT+wM/GGz43ffsS++V9bqGWu4J2o4VL4h95314I
         jpuPHFcu0u1c+tLgu54sFs4bzgKuIaZggD4cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nuKbT2MkJWv7INdk0/k3X3j6IVsocXvyZrAPLLJg8Ys=;
        b=LXuDW6ur6u77IcWZaqJOYMNw4+WyRDZXLHLTw+HN9zLt9PE6cjwyMSrcdooMfQjXS/
         Jb2Xk+k7TINY90qlxN7gZTWR4tzLdZEZo251FtFROgmtBUMhEAk30i53vnldxOpaTi7Q
         cDn8ZOTD0jk485lJNzYWwRib3Io1D/r7HafV+UDLz6DdaaSn8vZzStGmAYC/v55fAM5t
         q8u65zfciIvkZ3OL+sWsmeDrrlAMmriyMrKrQdHG5aqBUz85t8JaETYSOfASvmMrRG2T
         z+o77G1yHn3RH9zGhAJx5WhJW6wZRhBQNc/E9MnGHR8krJT6/L++JGE7ZzvWpn3DnKzZ
         zyrg==
X-Gm-Message-State: AOAM53284nmWK1z83SNDhoU2q2nWMdEHl+BERWjf2jVUfg+PmWiaIIw0
        Po0uJt0Cr7ljFp/LFfyB4BC8g55amDdpTw==
X-Google-Smtp-Source: ABdhPJwPW5G/O6dfvfwgRAXR/Jc2NC28IgZDwHLrb2MBCYCFChRXaO8BwSqTEXDnBLTsgowcVrelxw==
X-Received: by 2002:aa7:9635:0:b029:142:2501:3980 with SMTP id r21-20020aa796350000b029014225013980mr13055500pfg.69.1600380638543;
        Thu, 17 Sep 2020 15:10:38 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id gd14sm650289pjb.0.2020.09.17.15.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 15:10:37 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH BlueZ v2] a2dp: Keep track of ref ownership of a2dp_setup
Date:   Thu, 17 Sep 2020 15:10:34 -0700
Message-Id: <20200917221034.154218-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently transport_cb and abort_cfm make assumption that they have an
a2dp_setup reference held as a result of open_ind invocation. In the
field this is not always true, for example when the peer device opens an
L2CAP channel for AVDTP transport channel without sending AVDTP_OPEN
request through the AVDTP signaling channel first. Although in this case
the peer device does not behave correctly, we should protect this
possible crash from happening by making sure that transport_cb and
abort_cfm are really holding a reference of a2dp_setup object before
trying to unref them.

After grabbing a reference, open_ind stores the pointer in
stream->user_data. If this field is set, that means there is a pending
AVDTP_OPEN command and it needs to be unref-fed later once and only
once: when the transport channel is created (transport_cb) or when the
AVDTP_OPEN command is aborted (abort_cfm). If this field is not set,
nothing should unref it. This enforces that the reference counting is
correct regardless of the behavior of the peer device.

A sample crash stack trace from Chrome OS:
* thread #1, stop reason = signal SIGSEGV
  * frame #0: 0x0c64f0e8 bluetoothd`queue_remove_all at queue.c:351
    frame #1: 0x0c64f086 bluetoothd`queue_destroy at queue.c:73
    frame #2: 0x0c6022b0 bluetoothd`setup_unref at a2dp.c:222
    frame #3: 0x0c604942 bluetoothd`transport_cb at a2dp.c:2229
    frame #4: 0x0c61e35c bluetoothd`accept_cb at btio.c:203
    frame #5: 0xf679523c libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3182
    frame #6: 0xf67954aa libglib-2.0.so.0`g_main_context_iterate at gmain.c:3920
    frame #7: 0xf679569a libglib-2.0.so.0`g_main_loop_run at gmain.c:4116
    frame #8: 0x0c65a5a0 bluetoothd`mainloop_run at mainloop-glib.c:79
    frame #9: 0x0c65a7ea bluetoothd`mainloop_run_with_signal at mainloop-notify.c:201
    frame #10: 0x0c6477ec bluetoothd`main at main.c:772
    frame #11: 0xf65bc0a2 libc.so.6`__libc_start_main at libc-start.c:308

Reviewed-by: Alain Michaud <alainm@chromium.org>

---
 profiles/audio/a2dp.c  | 34 ++++++++++++++++++++++++++--------
 profiles/audio/avdtp.c | 17 +++++++++++++++++
 profiles/audio/avdtp.h |  5 +++++
 3 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 2feea66c0..26147f96e 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -915,6 +915,11 @@ static void update_last_used(struct a2dp_channel *chan, struct a2dp_sep *lsep,
 					avdtp_get_seid(rsep));
 }
 
+static void destroy_setup(void *data)
+{
+	setup_unref(data);
+}
+
 static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				struct avdtp_stream *stream, uint8_t *err,
 				void *user_data)
@@ -927,10 +932,21 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	else
 		DBG("Source %p: Open_Ind", sep);
 
+	if (avdtp_stream_get_user_data(stream)) {
+		warn("setup already exists");
+		return FALSE;
+	}
+
 	setup = a2dp_setup_get(session);
 	if (!setup)
 		return FALSE;
 
+	/*
+	 * Use avdtp_stream's user_data to keep the reference ownership of the
+	 * setup object. This ensures that this reference will be unref-ed
+	 * exactly once.
+	 */
+	avdtp_stream_set_user_data(stream, setup, destroy_setup);
 	setup->stream = stream;
 
 	if (!err && setup->chan)
@@ -1285,14 +1301,13 @@ static void abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
-	struct a2dp_setup *setup;
+	struct a2dp_setup *setup = avdtp_stream_get_user_data(stream);
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Abort_Cfm", sep);
 	else
 		DBG("Source %p: Abort_Cfm", sep);
 
-	setup = find_setup_by_session(session);
 	if (!setup)
 		return;
 
@@ -1302,6 +1317,7 @@ static void abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	}
 
 	setup_unref(setup);
+	avdtp_stream_set_user_data(stream, NULL, NULL);
 }
 
 static gboolean reconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
@@ -2216,11 +2232,12 @@ fail:
 
 static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
-	struct a2dp_setup *setup = user_data;
+	struct avdtp_stream *stream = user_data;
+	struct a2dp_setup *setup = avdtp_stream_get_user_data(stream);
 	uint16_t omtu, imtu;
 
-	if (!g_slist_find(setups, setup)) {
-		warn("bt_io_accept: setup %p no longer valid", setup);
+	if (!setup) {
+		warn("transport_cb: setup does not exist");
 		g_io_channel_shutdown(io, TRUE, NULL);
 		return;
 	}
@@ -2238,8 +2255,7 @@ static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
 		goto drop;
 	}
 
-	if (!avdtp_stream_set_transport(setup->stream,
-					g_io_channel_unix_get_fd(io),
+	if (!avdtp_stream_set_transport(stream, g_io_channel_unix_get_fd(io),
 					imtu, omtu))
 		goto drop;
 
@@ -2249,6 +2265,7 @@ static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
 	setup->io = NULL;
 
 	setup_unref(setup);
+	avdtp_stream_set_user_data(stream, NULL, NULL);
 
 	return;
 
@@ -2297,7 +2314,8 @@ static void confirm_cb(GIOChannel *io, gpointer data)
 			goto drop;
 		}
 
-		if (!bt_io_accept(io, transport_cb, setup, NULL, &err)) {
+		if (!bt_io_accept(io, transport_cb, setup->stream, NULL,
+				  &err)) {
 			error("bt_io_accept: %s", err->message);
 			g_error_free(err);
 			goto drop;
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 782268c08..76d06f47c 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -366,6 +366,8 @@ struct avdtp_stream {
 	GSList *caps;
 	GSList *callbacks;
 	struct avdtp_service_capability *codec;
+	void *user_data;
+	avdtp_stream_user_data_destroy_t user_data_destroy;
 	guint io_id;		/* Transport GSource ID */
 	guint timer;		/* Waiting for other side to close or open
 				 * the transport channel */
@@ -727,6 +729,9 @@ static void stream_free(void *data)
 	g_slist_free_full(stream->callbacks, g_free);
 	g_slist_free_full(stream->caps, g_free);
 
+	if (stream->user_data && stream->user_data_destroy)
+		stream->user_data_destroy(stream->user_data);
+
 	g_free(stream);
 }
 
@@ -3147,6 +3152,18 @@ struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
 	return NULL;
 }
 
+void avdtp_stream_set_user_data(struct avdtp_stream *stream, void *data,
+				avdtp_stream_user_data_destroy_t destroy)
+{
+	stream->user_data = data;
+	stream->user_data_destroy = destroy;
+}
+
+void *avdtp_stream_get_user_data(struct avdtp_stream *stream)
+{
+	return stream->user_data;
+}
+
 gboolean avdtp_stream_set_transport(struct avdtp_stream *stream, int fd,
 						size_t imtu, size_t omtu)
 {
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 011fea89e..247e9df75 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -133,6 +133,8 @@ typedef void (*avdtp_set_configuration_cb) (struct avdtp *session,
 						struct avdtp_stream *stream,
 						struct avdtp_error *err);
 
+typedef void (*avdtp_stream_user_data_destroy_t)(void *data);
+
 /* Callbacks for when a reply is received to a command that we sent */
 struct avdtp_sep_cfm {
 	void (*set_configuration) (struct avdtp *session,
@@ -260,6 +262,9 @@ gboolean avdtp_stream_has_capabilities(struct avdtp_stream *stream,
 					GSList *caps);
 struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
 						struct avdtp_stream *stream);
+void avdtp_stream_set_user_data(struct avdtp_stream *stream, void *data,
+				avdtp_stream_user_data_destroy_t destroy);
+void *avdtp_stream_get_user_data(struct avdtp_stream *stream);
 
 unsigned int avdtp_add_state_cb(struct btd_device *dev,
 				avdtp_session_state_cb cb, void *user_data);
-- 
2.26.2

