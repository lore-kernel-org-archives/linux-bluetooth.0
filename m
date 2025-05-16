Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3A27D78A
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422647; cv=none; b=kF/i92DOTswgXgGprE+76hVMTAz2fTkaAd73XEK7YbF03pRR1v+8PjYn9DTRcpwbMFG8s3w8FgABrpVORBi3fWzNuKgjUsYz+7knVyhenw6nS6QUQMbxUc4nO8ZAnG1RFyl44XEeZgKE0Ew4t0Qik8rJ77WB5uUl0t0Z5PNuFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422647; c=relaxed/simple;
	bh=KvTFofGNc6RWq/gocjDm/liabdDvw+9TehlglmYn+gI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=se2ok7vdtBewnSR75Kqp/1lbIMAngxfxPyYVTg1thuZb08iW8KR8HdNl2+IFUIoIdRmJyALhMA2q6jFPWXwPA/Tf01PQaQ52Sd9ZOD6LEg+yCO24QqEW/yDdV9sMOUo5+dBZ/5cz+YGyORbkueE2lQfeLMXrHjONMJAkxOyBzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehsNYIBY; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehsNYIBY"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e1382f2b24so555163137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747422643; x=1748027443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXnKU4MRo5FfA1XHZD48IicZ6d5L2zAPlWyHaKzJRYQ=;
        b=ehsNYIBYHOcblFeGoKtFuCpY+lannuWiWqFsMwjqmSFXtZm5zIQBveT5Z4DiMYjUEK
         zntrQ6fz/h7wIrBUfsZTAD6kqq1z1+gCNXXbXD8UXS8S1wi29xLa9JCGv6wyBCFzdoLr
         yl68gQU5yYqDQ6r44KQ2CGmGEoaFNh82HrdPFDqp9le/5UIrYeCIX7cNBIE5O1UBmtVA
         1ET136rxge+o07d9Y9z478X8C39DTTikl6qpSk9hUmQuRSjCBzqw1YrkOwx8+kxyyfwn
         aa87aBOSU5cJae8KRJbwYG1NRQqafdA+lH4CiFU2m6y1+sT5w3rlxvRNWoVXgVqVGZm0
         mEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747422643; x=1748027443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXnKU4MRo5FfA1XHZD48IicZ6d5L2zAPlWyHaKzJRYQ=;
        b=q+iR6AyjMjg1aSk8T09mexDqq1+1Z8+q4pLJFzT5kbIMG8JNdtqhuLxZyoyrjDkoG7
         6Br2clZ66frVir0lZlD6ov4Mzb7Dl/O3GHgLLJfFPsMA6iqiDVfOXn8uaOfjO/Fp8yQc
         4wckatHCpBRC/kP3YxMP4uk5IObVirEOWrhYYZBToyKRfe2CeURsOfpVZdLg/APCypGr
         2rLwA8AkPPPe4kI7r9c80JNRqjPz3z4yegOFVuCNwqNduqyNJXaXmHOqGyedgnigcerc
         YOAtI1VgNhtDpj90XnBr7HiT5MP1jiM0C8gr2Btcp95QOmTWKyzFIvqewlp+ycNHTL6R
         n9gw==
X-Gm-Message-State: AOJu0YzTI8yo8gV6WqToj19mkOMYzE692bsbinGt7Vdsjx1KjKfudnfQ
	G29b+a3DnKrjI6VokjkKuRFkExCeH0QfNaf7k5IgFrXJ3FcWXBMbDfU6VdsZw8jvPmE=
X-Gm-Gg: ASbGnctOjqlWWbGU2K3ff20fY9i/zB6gbOtXy7sMrElp2q0X9mV9g+o62YJ6c/PkVfH
	wKEnEI/hPwINJowLo11dIv2dXWWhdQddVQAC4T847KKgTNqj+x48lmCXSiicy7ntI4md5w2Qawo
	o3NzuXB+NldmKbQU48oa0TpGutlEL7CWFKTz6x73B7e6JVXAmlMF0SqgbQc6wIJj0dostcKagH3
	776cw8bdSS5Tzga7Q6U/hQWSE9Jn6DAcoli/mLBENkxiquti1J9+pSSTsN4p+S076gjQMS8EioM
	pKGVn+FdAEd9kYMM9/FTOBVbbJWrA2bW7rVm19ikqPaP5SHp/so10Q+uUJRzjAkqYd/CuYabM5G
	Qp+B+YENommeCR2aMzFJN
X-Google-Smtp-Source: AGHT+IHwTyPtWgBN8ypLbvpHQtRwc9VdTeROd+WN7ehdqMi+8+W3w3pwVDxD8oxlC6qGriiqClAxkA==
X-Received: by 2002:a05:6102:524b:b0:4c1:83c4:8562 with SMTP id ada2fe7eead31-4dfa6ba6bcdmr6553951137.13.1747422643224;
        Fri, 16 May 2025 12:10:43 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec228c01sm2189381241.33.2025.05.16.12.10.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:10:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/2] a2dp: Fix a2dp_sep mapping to a single stream
Date: Fri, 16 May 2025 15:10:39 -0400
Message-ID: <20250516191039.1975460-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516191039.1975460-1-luiz.dentz@gmail.com>
References: <20250516191039.1975460-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes the assumption that only 1 stream can be configured per
local sep which prevents multipoint setups where different devices can
be using the same local endpoint.

Fixes: https://github.com/bluez/bluez/issues/1037
Fixes: https://github.com/bluez/bluez/issues/1064
Fixes: https://github.com/bluez/bluez/issues/597
---
 profiles/audio/a2dp.c      | 320 ++++++++++++++++++++++++++-----------
 profiles/audio/a2dp.h      |   7 +-
 profiles/audio/media.c     |  15 +-
 profiles/audio/transport.c |   3 +-
 4 files changed, 247 insertions(+), 98 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 2e68b1d6b65b..482de4a98773 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -63,19 +63,23 @@
 
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 
+struct a2dp_stream {
+	struct avdtp *session;
+	struct avdtp_stream *stream;
+	unsigned int suspend_timer;
+	gboolean locked;
+	gboolean suspending;
+	gboolean starting;
+};
+
 struct a2dp_sep {
 	struct a2dp_server *server;
 	struct a2dp_endpoint *endpoint;
 	uint8_t type;
 	uint8_t codec;
 	struct avdtp_local_sep *lsep;
-	struct avdtp *session;
-	struct avdtp_stream *stream;
-	unsigned int suspend_timer;
+	struct queue *streams;
 	gboolean delay_reporting;
-	gboolean locked;
-	gboolean suspending;
-	gboolean starting;
 	void *user_data;
 	GDestroyNotify destroy;
 };
@@ -513,6 +517,80 @@ static struct a2dp_setup *find_setup_by_stream(struct avdtp_stream *stream)
 	return NULL;
 }
 
+static bool match_stream_session(const void *data, const void *user_data)
+{
+	const struct a2dp_stream *stream = data;
+	const struct avdtp *session = user_data;
+
+	return stream->session == session;
+}
+
+static struct a2dp_stream *a2dp_stream_new(struct a2dp_sep *sep,
+						struct avdtp *session)
+{
+	struct a2dp_stream *stream;
+
+	if (!sep->streams)
+		sep->streams = queue_new();
+
+	stream = new0(struct a2dp_stream, 1);
+	stream->session = avdtp_ref(session);
+	queue_push_tail(sep->streams, stream);
+
+	return stream;
+}
+
+static struct a2dp_stream *a2dp_stream_get(struct a2dp_sep *sep,
+						struct avdtp *session)
+{
+	struct a2dp_stream *stream;
+
+	DBG("sep %p session %p", sep, session);
+
+	stream = queue_find(sep->streams, match_stream_session, session);
+	if (stream)
+		return stream;
+
+	return a2dp_stream_new(sep, session);
+}
+
+static void a2dp_stream_starting(struct a2dp_sep *sep, struct avdtp *session)
+{
+	struct a2dp_stream *stream;
+
+	stream = a2dp_stream_get(sep, session);
+	if (!stream)
+		return;
+
+	stream->starting = TRUE;
+}
+
+static void a2dp_stream_free(struct a2dp_stream *stream)
+{
+	avdtp_unref(stream->session);
+	free(stream);
+}
+
+static bool match_stream(const void *data, const void *user_data)
+{
+	const struct a2dp_stream *astream = data;
+	const struct avdtp_stream *stream = user_data;
+
+	return astream->stream == stream;
+}
+
+static void a2dp_stream_destroy(struct a2dp_sep *sep,
+				struct avdtp_stream *stream)
+{
+	struct a2dp_stream *astream;
+
+	DBG("sep %p stream %p", sep, stream);
+
+	astream = queue_remove_if(sep->streams, match_stream, stream);
+	if (astream)
+		a2dp_stream_free(astream);
+}
+
 static void stream_state_changed(struct avdtp_stream *stream,
 					avdtp_state_t old_state,
 					avdtp_state_t new_state,
@@ -520,6 +598,8 @@ static void stream_state_changed(struct avdtp_stream *stream,
 					void *user_data)
 {
 	struct a2dp_sep *sep = user_data;
+	struct a2dp_stream *a2dp_stream;
+	struct btd_device *dev = NULL;
 
 	if (new_state == AVDTP_STATE_OPEN) {
 		struct a2dp_setup *setup;
@@ -539,7 +619,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 			return;
 		}
 
-		sep->starting = TRUE;
+		a2dp_stream_starting(sep, setup->session);
 
 		return;
 	}
@@ -547,20 +627,14 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	if (new_state != AVDTP_STATE_IDLE)
 		return;
 
-	if (sep->suspend_timer) {
-		timeout_remove(sep->suspend_timer);
-		sep->suspend_timer = 0;
+	a2dp_stream = queue_find(sep->streams, match_stream, stream);
+	if (a2dp_stream) {
+		dev = avdtp_get_device(a2dp_stream->session);
+		a2dp_stream_destroy(sep, stream);
 	}
 
-	if (sep->session) {
-		avdtp_unref(sep->session);
-		sep->session = NULL;
-	}
-
-	sep->stream = NULL;
-
 	if (sep->endpoint && sep->endpoint->clear_configuration)
-		sep->endpoint->clear_configuration(sep, sep->user_data);
+		sep->endpoint->clear_configuration(sep, dev, sep->user_data);
 }
 
 static gboolean auto_config(gpointer data)
@@ -568,9 +642,11 @@ static gboolean auto_config(gpointer data)
 	struct a2dp_setup *setup = data;
 	struct btd_device *dev = NULL;
 	struct btd_service *service;
+	struct a2dp_stream *stream;
 
 	/* Check if configuration was aborted */
-	if (setup->sep->stream == NULL)
+	stream = queue_find(setup->sep->streams, match_stream, setup->stream);
+	if (!stream)
 		return FALSE;
 
 	if (setup->err != NULL)
@@ -663,17 +739,22 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 {
 	struct a2dp_sep *a2dp_sep = user_data;
 	struct a2dp_setup *setup;
+	struct a2dp_stream *a2dp_stream;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Set_Configuration_Ind", sep);
 	else
 		DBG("Source %p: Set_Configuration_Ind", sep);
 
+	a2dp_stream = a2dp_stream_get(a2dp_sep, session);
+	if (!a2dp_stream)
+		return FALSE;
+
 	setup = a2dp_setup_get(session);
 	if (!setup)
 		return FALSE;
 
-	a2dp_sep->stream = stream;
+	a2dp_stream->stream = stream;
 	setup->sep = a2dp_sep;
 	setup->stream = stream;
 	setup->setconf_cb = cb;
@@ -907,6 +988,7 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 {
 	struct a2dp_sep *a2dp_sep = user_data;
 	struct a2dp_setup *setup;
+	struct a2dp_stream *a2dp_stream;
 	struct btd_device *dev;
 	struct btd_service *service;
 	int ret;
@@ -932,7 +1014,10 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	}
 
 	avdtp_stream_add_cb(session, stream, stream_state_changed, a2dp_sep);
-	a2dp_sep->stream = stream;
+
+	a2dp_stream = a2dp_stream_get(a2dp_sep, session);
+	if (a2dp_stream)
+		a2dp_stream->stream = stream;
 
 	if (!setup)
 		return;
@@ -1138,15 +1223,12 @@ static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	return;
 }
 
-static bool suspend_timeout(struct a2dp_sep *sep)
+static bool suspend_timeout(struct a2dp_stream *stream)
 {
-	if (avdtp_suspend(sep->session, sep->stream) == 0)
-		sep->suspending = TRUE;
+	if (avdtp_suspend(stream->session, stream->stream) == 0)
+		stream->suspending = TRUE;
 
-	sep->suspend_timer = 0;
-
-	avdtp_unref(sep->session);
-	sep->session = NULL;
+	stream->suspend_timer = 0;
 
 	return FALSE;
 }
@@ -1156,6 +1238,7 @@ static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_stream *a2dp_stream;
 	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
@@ -1163,17 +1246,20 @@ static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	else
 		DBG("Source %p: Start_Ind", sep);
 
-	if (!a2dp_sep->locked) {
-		a2dp_sep->session = avdtp_ref(session);
-		a2dp_sep->suspend_timer = timeout_add_seconds(SUSPEND_TIMEOUT,
-					(timeout_func_t) suspend_timeout,
-					a2dp_sep, NULL);
-	}
+	a2dp_stream = queue_find(a2dp_sep->streams, match_stream, stream);
+	if (!a2dp_stream)
+		return FALSE;
 
-	if (!a2dp_sep->starting)
+	if (!a2dp_stream->locked)
+		a2dp_stream->suspend_timer = timeout_add_seconds(
+					SUSPEND_TIMEOUT,
+					(timeout_func_t) suspend_timeout,
+					a2dp_stream, NULL);
+
+	if (!a2dp_stream->starting)
 		return TRUE;
 
-	a2dp_sep->starting = FALSE;
+	a2dp_stream->starting = FALSE;
 
 	setup = find_setup_by_session(session);
 	if (setup)
@@ -1187,6 +1273,7 @@ static void start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_stream *a2dp_stream;
 	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
@@ -1194,7 +1281,11 @@ static void start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	else
 		DBG("Source %p: Start_Cfm", sep);
 
-	a2dp_sep->starting = FALSE;
+	a2dp_stream = queue_find(a2dp_sep->streams, match_stream, stream);
+	if (!a2dp_stream)
+		return;
+
+	a2dp_stream->starting = FALSE;
 
 	setup = find_setup_by_session(session);
 	if (!setup)
@@ -1213,6 +1304,7 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_stream *a2dp_stream;
 	struct a2dp_setup *setup;
 	gboolean start;
 	int start_err;
@@ -1222,17 +1314,19 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	else
 		DBG("Source %p: Suspend_Ind", sep);
 
-	if (a2dp_sep->suspend_timer) {
-		timeout_remove(a2dp_sep->suspend_timer);
-		a2dp_sep->suspend_timer = 0;
-		avdtp_unref(a2dp_sep->session);
-		a2dp_sep->session = NULL;
+	a2dp_stream = queue_find(a2dp_sep->streams, match_stream, stream);
+	if (!a2dp_stream)
+		return FALSE;
+
+	if (a2dp_stream->suspend_timer) {
+		timeout_remove(a2dp_stream->suspend_timer);
+		a2dp_stream->suspend_timer = 0;
 	}
 
-	if (!a2dp_sep->suspending)
+	if (!a2dp_stream->suspending)
 		return TRUE;
 
-	a2dp_sep->suspending = FALSE;
+	a2dp_stream->suspending = FALSE;
 
 	setup = find_setup_by_session(session);
 	if (!setup)
@@ -1246,7 +1340,7 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (!start)
 		return TRUE;
 
-	start_err = avdtp_start(session, a2dp_sep->stream);
+	start_err = avdtp_start(session, a2dp_stream->stream);
 	if (start_err < 0 && start_err != -EINPROGRESS) {
 		error("avdtp_start: %s (%d)", strerror(-start_err),
 								-start_err);
@@ -1261,6 +1355,7 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_stream *a2dp_stream;
 	struct a2dp_setup *setup;
 	gboolean start;
 	int start_err;
@@ -1270,7 +1365,11 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	else
 		DBG("Source %p: Suspend_Cfm", sep);
 
-	a2dp_sep->suspending = FALSE;
+	a2dp_stream = queue_find(a2dp_sep->streams, match_stream, stream);
+	if (!a2dp_stream)
+		return;
+
+	a2dp_stream->suspending = FALSE;
 
 	setup = find_setup_by_session(session);
 	if (!setup)
@@ -1294,7 +1393,7 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 		return;
 	}
 
-	start_err = avdtp_start(session, a2dp_sep->stream);
+	start_err = avdtp_start(session, a2dp_stream->stream);
 	if (start_err < 0 && start_err != -EINPROGRESS) {
 		error("avdtp_start: %s (%d)", strerror(-start_err), -start_err);
 		finalize_setup_errno(setup, start_err, finalize_suspend, NULL);
@@ -1455,7 +1554,7 @@ static void abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	else
 		DBG("Source %p: Abort_Ind", sep);
 
-	a2dp_sep->stream = NULL;
+	a2dp_stream_destroy(a2dp_sep, stream);
 
 	setup = find_setup_by_session(session);
 	if (!setup)
@@ -1854,14 +1953,13 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 			uint8_t *caps, int size, void *user_data)
 {
 	struct a2dp_setup *setup;
+	struct a2dp_stream *stream;
 	struct a2dp_setup_cb *cb_data;
 	GSList *l;
 	int err;
 
-	/* Check SEP not used by a different session */
-	if (lsep->stream && chan->session &&
-	    !avdtp_has_stream(chan->session, lsep->stream))
-		return -EBUSY;
+	if (!chan->session)
+		return -ENOTCONN;
 
 	setup = a2dp_setup_get(chan->session);
 	if (!setup)
@@ -1888,7 +1986,9 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 		struct a2dp_sep *tmp = l->data;
 
 		/* Attempt to reconfigure if a stream already exists */
-		if (tmp->stream) {
+		stream = queue_find(tmp->streams, match_stream_session,
+							chan->session);
+		if (stream) {
 			/* Only allow switching sep from the same sender */
 			if (strcmp(sender, tmp->endpoint->get_name(tmp,
 							tmp->user_data))) {
@@ -1897,12 +1997,13 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 			}
 
 			/* Check if stream is for the channel */
-			if (!avdtp_has_stream(chan->session, tmp->stream))
+			if (!avdtp_has_stream(chan->session, stream->stream))
 				continue;
 
-			err = avdtp_close(chan->session, tmp->stream, FALSE);
+			err = avdtp_close(chan->session, stream->stream, FALSE);
 			if (err < 0) {
-				err = avdtp_abort(chan->session, tmp->stream);
+				err = avdtp_abort(chan->session,
+							stream->stream);
 				if (err < 0) {
 					error("avdtp_abort: %s",
 							strerror(-err));
@@ -2752,6 +2853,13 @@ add:
 	return sep;
 }
 
+static bool match_locked(const void *data, const void *user_data)
+{
+	const struct a2dp_stream *stream = data;
+
+	return stream->locked;
+}
+
 void a2dp_remove_sep(struct a2dp_sep *sep)
 {
 	struct a2dp_server *server = sep->server;
@@ -2776,7 +2884,7 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
 		}
 	}
 
-	if (sep->locked)
+	if (queue_find(sep->streams, match_locked, NULL))
 		return;
 
 	a2dp_unregister_sep(sep);
@@ -3001,7 +3109,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	GSList *l;
 	struct a2dp_server *server;
 	struct a2dp_setup *setup;
-	struct a2dp_sep *tmp;
+	struct a2dp_stream *stream;
 	struct avdtp_service_capability *cap;
 	struct avdtp_media_codec_capability *codec_cap = NULL;
 	int posix_err;
@@ -3036,8 +3144,10 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	cb_data->config_cb = cb;
 	cb_data->user_data = user_data;
 
+	stream = queue_find(sep->streams, match_stream_session, session);
+
 	setup->sep = sep;
-	setup->stream = sep->stream;
+	setup->stream = stream ? stream->stream : NULL;
 
 	/* Copy given caps if they are different than current caps */
 	if (setup->caps != caps) {
@@ -3045,7 +3155,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 		setup->caps = g_slist_copy(caps);
 	}
 
-	switch (avdtp_stream_get_state(sep->stream)) {
+	switch (avdtp_stream_get_state(setup->stream)) {
 	case AVDTP_STATE_IDLE:
 		if (sep->type == AVDTP_SEP_TYPE_SOURCE)
 			l = server->sources;
@@ -3053,16 +3163,22 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 			l = server->sinks;
 
 		for (; l != NULL; l = l->next) {
-			tmp = l->data;
-			if (avdtp_has_stream(session, tmp->stream))
+			struct a2dp_sep *tmp = l->data;
+
+			stream = queue_find(tmp->streams, match_stream_session,
+								session);
+			if (!stream)
+				continue;
+
+			if (avdtp_has_stream(session, stream->stream))
 				break;
 		}
 
 		if (l != NULL) {
-			if (tmp->locked)
+			if (stream->locked)
 				goto failed;
 			setup->reconfigure = TRUE;
-			if (avdtp_close(session, tmp->stream, FALSE) < 0) {
+			if (avdtp_close(session, stream->stream, FALSE) < 0) {
 				error("avdtp_close failed");
 				goto failed;
 			}
@@ -3092,7 +3208,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 								setup);
 		} else if (!setup->reconfigure) {
 			setup->reconfigure = TRUE;
-			if (avdtp_close(session, sep->stream, FALSE) < 0) {
+			if (avdtp_close(session, setup->stream, FALSE) < 0) {
 				error("avdtp_close failed");
 				goto failed;
 			}
@@ -3118,6 +3234,7 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 {
 	struct a2dp_setup_cb *cb_data;
 	struct a2dp_setup *setup;
+	struct a2dp_stream *stream;
 
 	setup = a2dp_setup_get(session);
 	if (!setup)
@@ -3130,31 +3247,30 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 	if (setup->reconfigure)
 		goto failed;
 
-	setup->sep = sep;
-	setup->stream = sep->stream;
+	stream = queue_find(sep->streams, match_stream_session, session);
 
-	switch (avdtp_stream_get_state(sep->stream)) {
+	setup->sep = sep;
+	setup->stream = stream ? stream->stream : NULL;
+
+	switch (avdtp_stream_get_state(setup->stream)) {
 	case AVDTP_STATE_IDLE:
 		goto failed;
-		break;
 	case AVDTP_STATE_CONFIGURED:
 		setup->start = TRUE;
 		break;
 	case AVDTP_STATE_OPEN:
-		if (avdtp_start(session, sep->stream) < 0) {
+		if (avdtp_start(session, setup->stream) < 0) {
 			error("avdtp_start failed");
 			goto failed;
 		}
-		sep->starting = TRUE;
+		stream->starting = TRUE;
 		break;
 	case AVDTP_STATE_STREAMING:
-		if (!sep->suspending && sep->suspend_timer) {
-			timeout_remove(sep->suspend_timer);
-			sep->suspend_timer = 0;
-			avdtp_unref(sep->session);
-			sep->session = NULL;
+		if (!stream->suspending && stream->suspend_timer) {
+			timeout_remove(stream->suspend_timer);
+			stream->suspend_timer = 0;
 		}
-		if (sep->suspending)
+		if (stream->suspending)
 			setup->start = TRUE;
 		else
 			cb_data->source_id = g_idle_add(finalize_resume,
@@ -3179,6 +3295,7 @@ unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 {
 	struct a2dp_setup_cb *cb_data;
 	struct a2dp_setup *setup;
+	struct a2dp_stream *stream;
 
 	setup = a2dp_setup_get(session);
 	if (!setup)
@@ -3191,10 +3308,12 @@ unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 	if (setup->reconfigure)
 		goto failed;
 
-	setup->sep = sep;
-	setup->stream = sep->stream;
+	stream = queue_find(sep->streams, match_stream_session, session);
 
-	switch (avdtp_stream_get_state(sep->stream)) {
+	setup->sep = sep;
+	setup->stream = stream ? stream->stream : NULL;
+
+	switch (avdtp_stream_get_state(setup->stream)) {
 	case AVDTP_STATE_IDLE:
 		error("a2dp_suspend: no stream to suspend");
 		goto failed;
@@ -3203,11 +3322,11 @@ unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 		cb_data->source_id = g_idle_add(finalize_suspend, setup);
 		break;
 	case AVDTP_STATE_STREAMING:
-		if (avdtp_suspend(session, sep->stream) < 0) {
+		if (avdtp_suspend(session, setup->stream) < 0) {
 			error("avdtp_suspend failed");
 			goto failed;
 		}
-		sep->suspending = TRUE;
+		stream->suspending = TRUE;
 		break;
 	case AVDTP_STATE_CONFIGURED:
 	case AVDTP_STATE_CLOSING:
@@ -3256,11 +3375,14 @@ gboolean a2dp_cancel(unsigned int id)
 
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session)
 {
-	if (sep->locked)
+	struct a2dp_stream *stream;
+
+	stream = queue_find(sep->streams, match_stream_session, session);
+	if (!stream || stream->locked)
 		return FALSE;
 
-	DBG("SEP %p locked", sep->lsep);
-	sep->locked = TRUE;
+	DBG("stream %p locked", sep->lsep);
+	stream->locked = TRUE;
 
 	return TRUE;
 }
@@ -3268,14 +3390,19 @@ gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session)
 gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session)
 {
 	struct a2dp_server *server = sep->server;
+	struct a2dp_stream *stream;
 	avdtp_state_t state;
 	GSList *l;
 
-	state = avdtp_stream_get_state(sep->stream);
+	stream = queue_find(sep->streams, match_stream_session, session);
+	if (!stream)
+		return FALSE;
 
-	sep->locked = FALSE;
+	state = avdtp_stream_get_state(stream->stream);
 
-	DBG("SEP %p unlocked", sep->lsep);
+	stream->locked = FALSE;
+
+	DBG("stream %p unlocked", stream);
 
 	if (sep->type == AVDTP_SEP_TYPE_SOURCE)
 		l = server->sources;
@@ -3288,7 +3415,7 @@ gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session)
 		return TRUE;
 	}
 
-	if (!sep->stream || state == AVDTP_STATE_IDLE)
+	if (!stream->stream || state == AVDTP_STATE_IDLE)
 		return TRUE;
 
 	switch (state) {
@@ -3296,8 +3423,8 @@ gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session)
 		/* Set timer here */
 		break;
 	case AVDTP_STATE_STREAMING:
-		if (avdtp_suspend(session, sep->stream) == 0)
-			sep->suspending = TRUE;
+		if (avdtp_suspend(session, stream->stream) == 0)
+			stream->suspending = TRUE;
 		break;
 	case AVDTP_STATE_IDLE:
 	case AVDTP_STATE_CONFIGURED:
@@ -3310,9 +3437,16 @@ gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session)
 	return TRUE;
 }
 
-struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep)
+struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep,
+						struct avdtp *session)
 {
-	return sep->stream;
+	struct a2dp_stream *stream;
+
+	stream = queue_find(sep->streams, match_stream_session, session);
+	if (stream)
+		return stream->stream;
+
+	return NULL;
 }
 
 struct btd_device *a2dp_setup_get_device(struct a2dp_setup *setup)
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index 615b641c9a0b..c698bc983749 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -35,7 +35,9 @@ struct a2dp_endpoint {
 						struct a2dp_setup *setup,
 						a2dp_endpoint_config_t cb,
 						void *user_data);
-	void (*clear_configuration) (struct a2dp_sep *sep, void *user_data);
+	void (*clear_configuration) (struct a2dp_sep *sep,
+						struct btd_device *device,
+						void *user_data);
 	void (*set_delay) (struct a2dp_sep *sep, uint16_t delay,
 							void *user_data);
 };
@@ -76,7 +78,8 @@ gboolean a2dp_cancel(unsigned int id);
 
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session);
 gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session);
-struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep);
+struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep,
+						struct avdtp *session);
 struct btd_device *a2dp_setup_get_device(struct a2dp_setup *setup);
 const char *a2dp_setup_remote_path(struct a2dp_setup *setup);
 struct avdtp *a2dp_avdtp_get(struct btd_device *device);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index a18ddc9fee40..8e62dca17070 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -692,11 +692,22 @@ static int set_config(struct a2dp_sep *sep, uint8_t *configuration,
 	return -ENOMEM;
 }
 
-static void clear_config(struct a2dp_sep *sep, void *user_data)
+static void clear_config(struct a2dp_sep *sep, struct btd_device *device,
+				void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
+	struct media_transport *transport;
 
-	clear_endpoint(endpoint);
+	if (!device) {
+		clear_endpoint(endpoint);
+		return;
+	}
+
+	transport = find_device_transport(endpoint, device);
+	if (!transport)
+		return;
+
+	clear_configuration(endpoint, transport);
 }
 
 static void set_delay(struct a2dp_sep *sep, uint16_t delay, void *user_data)
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 153515191e40..a1fdf948bda8 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -398,12 +398,13 @@ static gboolean media_transport_set_fd(struct media_transport *transport,
 #ifdef HAVE_A2DP
 static void *transport_a2dp_get_stream(struct media_transport *transport)
 {
+	struct a2dp_transport *a2dp = transport->data;
 	struct a2dp_sep *sep = media_endpoint_get_sep(transport->endpoint);
 
 	if (!sep)
 		return NULL;
 
-	return a2dp_sep_get_stream(sep);
+	return a2dp_sep_get_stream(sep, a2dp->session);
 }
 
 static void a2dp_suspend_complete(struct avdtp *session, int err,
-- 
2.49.0

