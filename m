Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3F4282F1
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422645; cv=none; b=GxjwKcPTVj+xVzxAzOWnhd0fZLao17MgiyxHu6Vs6M773oCHpfQapu0XYfCg5iiFP/8tSDGjvCosMo34w9eJoEws+cq2N7hX2qLfMWKLTDBGdT6PvLkEZQ9G+9jpHDNWaEf9aX3y+kDYOFj4949PmLXH4oUNMDVR4IaFPMm+TCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422645; c=relaxed/simple;
	bh=v6NjcsTdpNtf5UD6NVX8Bl+kzvNaXuuUxnB3UqTvWUM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=D0M8N++BsKEb3HINBAIogHBxVuh2eIRNWQmLZ7vv0MyQms2kKv+rjrn39SjbTuApH2uAwmlOd8Bl5sDZy3DZg5PPNqIelHq6VJoWnFgNhV2RkwlC457cEJHauMib8UgBGzZibqm6sY0Fm0NgKwWBm70bhkjhBo6hoLCghODEtH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD0U1RpB; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD0U1RpB"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4def1dbfd50so781244137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747422641; x=1748027441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsTKtRqCESulGwm1UPIGPxcEW71zbbDoC88wKXe3/go=;
        b=VD0U1RpBfQ6LtJO9LACnM4HnEFLY9sNIWV9zrRA2AGNJX6Jl3zhY6Yay3SPXm0Ik7C
         /d+UvqDN4XHhgh1RywZu5wIQtserDSrsMUg8kHtP4+u/6fn4rEmMI8U/aUsOjzQtHuaq
         hWj3DmRfFKtJ7vJGD0FPIqLtDPX32JMZdJyFZVgaHvjojQWLCxd/EkpV7gdlXak2XOSb
         6aHDT8d+VnFQx58Li82mVfE9Xq7z5o8T7rOMSJ/sjEaIZjhYwh5UY/KRsuFJxm9Zkp/e
         VZy0R2/PzuyU2ERvrGLF4ziSTGpiYs/zNZGN5tEWULx4A+6VHxPuDdv8gXOYNzG37KWz
         T9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747422641; x=1748027441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsTKtRqCESulGwm1UPIGPxcEW71zbbDoC88wKXe3/go=;
        b=NtuWo2PUIEOT+AmrYqSvAWbXr90gFQpHX96Vw/Agn6GPm+KOcNgIb6yznHiBmrEvKb
         kIPkI3fwF1wcSopU2eMZu+ZzfC4ES//aYLHZxj6gh7oebcLVE0gJ1TBq75judmQY9Aif
         I2+p7fypm+3AVojfF8gPEln7B5O6cZ3TxJvKtbPG3TrwOgUNN1cZHmvg/py+BGe1zdAm
         6gXPFcvjjcLiYGgBnFByU/RsDhdVWvFk2ssC201HtvACIF6eUHbuvvvRnI/Nyso8M2/Q
         iYbONZcWibyiSY+Z0cct8b4qxOPpetY5x7CX5xboj8L5973jI+xEGBbP9Vfi5OGPcmSY
         SVfg==
X-Gm-Message-State: AOJu0YxRuWCzsD0KJycqPzIJlsJmBl1TwC13oxVZHJ5pi1YkBmjYCuer
	euk74cPEmtkdMdw/enO954HAi492FGr3fxv3JH/B7YS9LxFzI7F3UR0hZvO6rxJ5pxk=
X-Gm-Gg: ASbGncvNSC1Jl6h3bbXmPoJ08LapZve0beeN0ANQp2XsYZlErG9ECe8I76JOYoK3SEV
	t1fxPccd9haRs+XjOjfPrjDIXifcubTkUe5EaNo6gCYFPCjTScS1NF63o0+D+kIxg5CFOicV2c9
	FP6Q4IPrmaUxZkmHvLO09PAxK+4BUoqPWHb2ha5by/kzL3Z9jl3fvvL3RL/qP2kg2hCxGgmAqqd
	2eYj2JjnC46/tvCyLColg7wG2VHZdqSScg4RKlZHLPg/Lg0sQ9g+zvWhpHhrANvcG1SO4jiP3TK
	A2mLxKAagTazS58yfu058gVP6Ufm9U447NrRr0cTd5xq4WLK7TxMUnG5r+xtqnGBHwShO0IJoYl
	1f6mkHOewsQ/Y/fp98tcJ
X-Google-Smtp-Source: AGHT+IGk4plp2a/v/nA5JoGymi54WsX07E8ip5g5C5RomL7Rz1L6wXtj5DF2LyiQZ+lkAdMNZ8i2dQ==
X-Received: by 2002:a05:6102:4b0f:b0:4cb:5d6c:9946 with SMTP id ada2fe7eead31-4e049e61cb9mr5297612137.10.1747422641327;
        Fri, 16 May 2025 12:10:41 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec228c01sm2189381241.33.2025.05.16.12.10.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:10:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/2] avdtp: Fix setting in_use flag for local seps
Date: Fri, 16 May 2025 15:10:38 -0400
Message-ID: <20250516191039.1975460-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
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
---
 profiles/audio/a2dp.c  |  18 +--
 profiles/audio/avdtp.c | 254 +++++++++++++++++++++++------------------
 profiles/audio/avdtp.h |   2 +-
 3 files changed, 149 insertions(+), 125 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 0eac151db29d..2e68b1d6b65b 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2366,7 +2366,6 @@ struct avdtp *a2dp_avdtp_get(struct btd_device *device)
 {
 	struct a2dp_server *server;
 	struct a2dp_channel *chan;
-	const struct queue_entry *entry;
 
 	server = find_server(servers, device_get_adapter(device));
 	if (server == NULL)
@@ -2383,13 +2382,8 @@ struct avdtp *a2dp_avdtp_get(struct btd_device *device)
 		return avdtp_ref(chan->session);
 
 	/* Check if there is any SEP available */
-	for (entry = queue_get_entries(server->seps); entry;
-					entry = entry->next) {
-		struct avdtp_local_sep *sep = entry->data;
-
-		if (avdtp_sep_get_state(sep) == AVDTP_STATE_IDLE)
-			goto found;
-	}
+	if (!queue_isempty(server->seps))
+		goto found;
 
 	DBG("Unable to find any available SEP");
 
@@ -3051,7 +3045,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 		setup->caps = g_slist_copy(caps);
 	}
 
-	switch (avdtp_sep_get_state(sep->lsep)) {
+	switch (avdtp_stream_get_state(sep->stream)) {
 	case AVDTP_STATE_IDLE:
 		if (sep->type == AVDTP_SEP_TYPE_SOURCE)
 			l = server->sources;
@@ -3139,7 +3133,7 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 	setup->sep = sep;
 	setup->stream = sep->stream;
 
-	switch (avdtp_sep_get_state(sep->lsep)) {
+	switch (avdtp_stream_get_state(sep->stream)) {
 	case AVDTP_STATE_IDLE:
 		goto failed;
 		break;
@@ -3200,7 +3194,7 @@ unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 	setup->sep = sep;
 	setup->stream = sep->stream;
 
-	switch (avdtp_sep_get_state(sep->lsep)) {
+	switch (avdtp_stream_get_state(sep->stream)) {
 	case AVDTP_STATE_IDLE:
 		error("a2dp_suspend: no stream to suspend");
 		goto failed;
@@ -3277,7 +3271,7 @@ gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session)
 	avdtp_state_t state;
 	GSList *l;
 
-	state = avdtp_sep_get_state(sep->lsep);
+	state = avdtp_stream_get_state(sep->stream);
 
 	sep->locked = FALSE;
 
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 17b8850ea9aa..17671a1bafb1 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -320,8 +320,6 @@ struct avdtp_remote_sep {
 };
 
 struct avdtp_local_sep {
-	avdtp_state_t state;
-	struct avdtp_stream *stream;
 	struct seid_info info;
 	uint8_t codec;
 	gboolean delay_reporting;
@@ -370,6 +368,7 @@ struct avdtp_stream {
 	gboolean delay_reporting;
 	uint16_t delay;		/* AVDTP 1.3 Delay Reporting feature */
 	gboolean starting;	/* only valid while sep state == OPEN */
+	avdtp_state_t state;
 };
 
 /* Structure describing an AVDTP connection between two devices */
@@ -417,6 +416,7 @@ struct avdtp {
 };
 
 static GSList *state_callbacks = NULL;
+static struct queue *streams = NULL;
 
 static int send_request(struct avdtp *session, gboolean priority,
 			struct avdtp_stream *stream, uint8_t signal_id,
@@ -430,9 +430,8 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 					uint8_t transaction, uint8_t signal_id,
 					void *buf, int size);
 static int process_queue(struct avdtp *session);
-static void avdtp_sep_set_state(struct avdtp *session,
-				struct avdtp_local_sep *sep,
-				avdtp_state_t state);
+static void avdtp_stream_set_state(struct avdtp_stream *stream,
+					avdtp_state_t state);
 
 static const char *avdtp_statestr(avdtp_state_t state)
 {
@@ -728,9 +727,6 @@ static void stream_free(void *data)
 	struct avdtp_stream *stream = data;
 	struct avdtp_remote_sep *rsep;
 
-	stream->lsep->info.inuse = 0;
-	stream->lsep->stream = NULL;
-
 	rsep = find_remote_sep(stream->session->seps, stream->rseid);
 	if (rsep)
 		rsep->stream = NULL;
@@ -747,6 +743,7 @@ static void stream_free(void *data)
 	g_slist_free_full(stream->callbacks, g_free);
 	g_slist_free_full(stream->caps, g_free);
 
+	queue_remove(streams, stream);
 	g_free(stream);
 }
 
@@ -765,7 +762,7 @@ static void transport_cb(int cond, void *data)
 	stream->io_id = 0;
 
 	if (!stream->abort_int)
-		avdtp_sep_set_state(stream->session, sep, AVDTP_STATE_IDLE);
+		avdtp_stream_set_state(stream, AVDTP_STATE_IDLE);
 }
 
 static int get_send_buffer_size(int sk)
@@ -862,7 +859,7 @@ proceed:
 	if (!stream->open_acp && sep->cfm && sep->cfm->open)
 		sep->cfm->open(session, sep, stream, NULL, sep->user_data);
 
-	avdtp_sep_set_state(session, sep, AVDTP_STATE_OPEN);
+	avdtp_stream_set_state(stream, AVDTP_STATE_OPEN);
 
 	stream->io_id = io_glib_add_err_watch(io, transport_cb, stream);
 
@@ -966,11 +963,10 @@ static void handle_unanswered_req(struct avdtp *session,
 	pending_req_free(req);
 }
 
-static void avdtp_sep_set_state(struct avdtp *session,
-				struct avdtp_local_sep *sep,
-				avdtp_state_t state)
+static void avdtp_stream_set_state(struct avdtp_stream *stream,
+					avdtp_state_t state)
 {
-	struct avdtp_stream *stream = sep->stream;
+	struct avdtp *session;
 	avdtp_state_t old_state;
 	struct avdtp_error err, *err_ptr = NULL;
 	GSList *l;
@@ -980,23 +976,25 @@ static void avdtp_sep_set_state(struct avdtp *session,
 		return;
 	}
 
-	if (sep->state == state) {
+	session = stream->session;
+
+	if (stream->state == state) {
 		avdtp_error_init(&err, AVDTP_ERRNO, EIO);
 		DBG("stream state change failed: %s", avdtp_strerror(&err));
 		err_ptr = &err;
 	} else {
 		err_ptr = NULL;
 		DBG("stream state changed: %s -> %s",
-				avdtp_statestr(sep->state),
+				avdtp_statestr(stream->state),
 				avdtp_statestr(state));
 	}
 
-	old_state = sep->state;
-	sep->state = state;
+	old_state = stream->state;
+	stream->state = state;
 
 	switch (state) {
 	case AVDTP_STATE_CONFIGURED:
-		if (sep->info.type == AVDTP_SEP_TYPE_SINK)
+		if (stream->lsep->info.type == AVDTP_SEP_TYPE_SINK)
 			avdtp_delay_report(session, stream, stream->delay);
 		break;
 	case AVDTP_STATE_OPEN:
@@ -1098,11 +1096,11 @@ static void release_stream(struct avdtp_stream *stream, struct avdtp *session)
 	struct avdtp_local_sep *sep = stream->lsep;
 
 	if (sep->cfm && sep->cfm->abort &&
-				(sep->state != AVDTP_STATE_ABORTING ||
+				(stream->state != AVDTP_STATE_ABORTING ||
 							stream->abort_int))
 		sep->cfm->abort(session, sep, stream, NULL, sep->user_data);
 
-	avdtp_sep_set_state(session, sep, AVDTP_STATE_IDLE);
+	avdtp_stream_set_state(stream, AVDTP_STATE_IDLE);
 }
 
 static void remove_disconnect_timer(struct avdtp *session)
@@ -1266,14 +1264,38 @@ static struct avdtp_local_sep *find_local_sep_by_seid(struct avdtp *session,
 	return queue_find(session->lseps, match_by_seid, INT_TO_PTR(seid));
 }
 
+static struct avdtp_stream *find_stream_by_lsep(struct avdtp *session,
+						struct avdtp_local_sep *sep)
+{
+	GSList *l;
+
+	for (l = session->streams; l != NULL; l = g_slist_next(l)) {
+		struct avdtp_stream *stream = l->data;
+
+		if (stream->lsep == sep)
+			return stream;
+	}
+
+	return NULL;
+}
+
+static struct avdtp_stream *find_stream_by_lseid(struct avdtp *session,
+								uint8_t type)
+{
+	struct avdtp_local_sep *sep;
+
+	sep = find_local_sep_by_seid(session, type);
+	if (!sep)
+		return NULL;
+
+	return find_stream_by_lsep(session, sep);
+}
+
 struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 						struct avdtp_local_sep *lsep)
 {
 	GSList *l;
 
-	if (lsep->info.inuse)
-		return NULL;
-
 	for (l = session->seps; l != NULL; l = g_slist_next(l)) {
 		struct avdtp_remote_sep *sep = l->data;
 		struct avdtp_service_capability *cap;
@@ -1470,7 +1492,6 @@ static void setconf_cb(struct avdtp *session, struct avdtp_stream *stream,
 						struct avdtp_error *err)
 {
 	struct conf_rej rej;
-	struct avdtp_local_sep *sep;
 
 	if (err != NULL) {
 		rej.error = AVDTP_UNSUPPORTED_CONFIGURATION;
@@ -1489,12 +1510,28 @@ static void setconf_cb(struct avdtp *session, struct avdtp_stream *stream,
 		return;
 	}
 
-	sep = stream->lsep;
-	sep->stream = stream;
-	sep->info.inuse = 1;
 	session->streams = g_slist_append(session->streams, stream);
 
-	avdtp_sep_set_state(session, sep, AVDTP_STATE_CONFIGURED);
+	avdtp_stream_set_state(stream, AVDTP_STATE_CONFIGURED);
+}
+
+static struct avdtp_stream *stream_new(struct avdtp *session,
+					struct avdtp_local_sep *lsep,
+					uint8_t rseid)
+{
+	struct avdtp_stream *stream;
+
+	stream = new0(struct avdtp_stream, 1);
+	stream->session = session;
+	stream->lsep = lsep;
+	stream->rseid = rseid;
+
+	if (!streams)
+		streams = queue_new();
+
+	queue_push_tail(streams, stream);
+
+	return stream;
 }
 
 static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
@@ -1517,11 +1554,6 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	if (sep->stream) {
-		err = AVDTP_SEP_IN_USE;
-		goto failed;
-	}
-
 	switch (sep->info.type) {
 	case AVDTP_SEP_TYPE_SOURCE:
 		service = btd_device_get_service(session->device,
@@ -1553,10 +1585,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		break;
 	}
 
-	stream = g_new0(struct avdtp_stream, 1);
-	stream->session = session;
-	stream->lsep = sep;
-	stream->rseid = req->int_seid;
+	stream = stream_new(session, sep, req->int_seid);
 	stream->caps = caps_to_list(req->caps,
 					size - sizeof(struct setconf_req),
 					&stream->codec,
@@ -1590,11 +1619,9 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 			return FALSE;
 		}
 
-		sep->stream = stream;
-		sep->info.inuse = 1;
 		session->streams = g_slist_append(session->streams, stream);
 
-		avdtp_sep_set_state(session, sep, AVDTP_STATE_CONFIGURED);
+		avdtp_stream_set_state(stream, AVDTP_STATE_CONFIGURED);
 	}
 
 	return TRUE;
@@ -1613,6 +1640,7 @@ static gboolean avdtp_getconf_cmd(struct avdtp *session, uint8_t transaction,
 {
 	GSList *l;
 	struct avdtp_local_sep *sep = NULL;
+	struct avdtp_stream *stream;
 	int rsp_size;
 	uint8_t err;
 	uint8_t buf[1024];
@@ -1625,17 +1653,18 @@ static gboolean avdtp_getconf_cmd(struct avdtp *session, uint8_t transaction,
 
 	memset(buf, 0, sizeof(buf));
 
-	sep = find_local_sep_by_seid(session, req->acp_seid);
+	stream = find_stream_by_lseid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
 	}
-	if (!sep->stream || !sep->stream->caps) {
+
+	if (!stream->caps) {
 		err = AVDTP_UNSUPPORTED_CONFIGURATION;
 		goto failed;
 	}
 
-	for (l = sep->stream->caps, rsp_size = 0; l != NULL; l = g_slist_next(l)) {
+	for (l = stream->caps, rsp_size = 0; l != NULL; l = g_slist_next(l)) {
 		struct avdtp_service_capability *cap = l->data;
 
 		if (rsp_size + cap->length + 2 > (int) sizeof(buf))
@@ -1741,19 +1770,17 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session, req->acp_seid);
-	if (!sep) {
+	stream = find_stream_by_lseid(session, req->acp_seid);
+	if (!stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
 	}
 
-	if (sep->state != AVDTP_STATE_CONFIGURED) {
+	if (stream->state != AVDTP_STATE_CONFIGURED) {
 		err = AVDTP_BAD_STATE;
 		goto failed;
 	}
 
-	stream = sep->stream;
-
 	/* Check if the stream is pending and there is an IO set already */
 	if (stream == session->pending_open && session->pending_open_io) {
 		handle_transport_connect(session, session->pending_open_io,
@@ -1762,6 +1789,7 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 							AVDTP_OPEN, NULL, 0);
 	}
 
+	sep = stream->lsep;
 	if (sep->ind && sep->ind->open && !session->pending_open) {
 		if (!sep->ind->open(session, sep, stream, &err,
 					sep->user_data))
@@ -1805,19 +1833,19 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 
 		failed_seid = seid.seid;
 
-		sep = find_local_sep_by_seid(session, seid.seid);
-		if (!sep || !sep->stream) {
+		stream = find_stream_by_lseid(session, seid.seid);
+		if (!stream) {
 			err = AVDTP_BAD_ACP_SEID;
 			goto failed;
 		}
 
-		stream = sep->stream;
-
 		/* Also reject start cmd if state is not open */
-		if (sep->state != AVDTP_STATE_OPEN) {
+		if (stream->state != AVDTP_STATE_OPEN) {
 			err = AVDTP_BAD_STATE;
 			goto failed;
 		}
+
+		sep = stream->lsep;
 		stream->starting = TRUE;
 
 		if (sep->ind && sep->ind->start) {
@@ -1828,7 +1856,7 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 
 		avdtp_check_collision(session, AVDTP_START, stream);
 
-		avdtp_sep_set_state(session, sep, AVDTP_STATE_STREAMING);
+		avdtp_stream_set_state(stream, AVDTP_STATE_STREAMING);
 	}
 
 	return avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
@@ -1855,20 +1883,19 @@ static gboolean avdtp_close_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session, req->acp_seid);
-	if (!sep || !sep->stream) {
+	stream = find_stream_by_lseid(session, req->acp_seid);
+	if (!stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
 	}
 
-	if (sep->state != AVDTP_STATE_OPEN &&
-			sep->state != AVDTP_STATE_STREAMING) {
+	if (stream->state != AVDTP_STATE_OPEN &&
+			stream->state != AVDTP_STATE_STREAMING) {
 		err = AVDTP_BAD_STATE;
 		goto failed;
 	}
 
-	stream = sep->stream;
-
+	sep = stream->lsep;
 	if (sep->ind && sep->ind->close) {
 		if (!sep->ind->close(session, sep, stream, &err,
 					sep->user_data))
@@ -1877,7 +1904,7 @@ static gboolean avdtp_close_cmd(struct avdtp *session, uint8_t transaction,
 
 	avdtp_check_collision(session, AVDTP_CLOSE, stream);
 
-	avdtp_sep_set_state(session, sep, AVDTP_STATE_CLOSING);
+	avdtp_stream_set_state(stream, AVDTP_STATE_CLOSING);
 
 	session->dc_timeout = DISCONNECT_TIMEOUT;
 
@@ -1916,19 +1943,18 @@ static gboolean avdtp_suspend_cmd(struct avdtp *session, uint8_t transaction,
 		struct seid seid = req->seids[i];
 		failed_seid = seid.seid;
 
-		sep = find_local_sep_by_seid(session, seid.seid);
-		if (!sep || !sep->stream) {
+		stream = find_stream_by_lseid(session, seid.seid);
+		if (!stream) {
 			err = AVDTP_BAD_ACP_SEID;
 			goto failed;
 		}
 
-		stream = sep->stream;
-
-		if (sep->state != AVDTP_STATE_STREAMING) {
+		if (stream->state != AVDTP_STATE_STREAMING) {
 			err = AVDTP_BAD_STATE;
 			goto failed;
 		}
 
+		sep = stream->lsep;
 		if (sep->ind && sep->ind->suspend) {
 			if (!sep->ind->suspend(session, sep, stream, &err,
 						sep->user_data))
@@ -1937,7 +1963,7 @@ static gboolean avdtp_suspend_cmd(struct avdtp *session, uint8_t transaction,
 
 		avdtp_check_collision(session, AVDTP_SUSPEND, stream);
 
-		avdtp_sep_set_state(session, sep, AVDTP_STATE_OPEN);
+		avdtp_stream_set_state(stream, AVDTP_STATE_OPEN);
 	}
 
 	return avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
@@ -1955,6 +1981,7 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
 				struct seid_req *req, unsigned int size)
 {
 	struct avdtp_local_sep *sep;
+	struct avdtp_stream *stream;
 	uint8_t err;
 	gboolean ret;
 
@@ -1963,20 +1990,20 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session, req->acp_seid);
-	if (!sep || !sep->stream)
+	stream = find_stream_by_lseid(session, req->acp_seid);
+	if (!stream)
 		return TRUE;
 
+	sep = stream->lsep;
 	if (sep->ind && sep->ind->abort)
-		sep->ind->abort(session, sep, sep->stream, &err,
-							sep->user_data);
+		sep->ind->abort(session, sep, stream, &err, sep->user_data);
 
-	avdtp_check_collision(session, AVDTP_ABORT, sep->stream);
+	avdtp_check_collision(session, AVDTP_ABORT, stream);
 
 	ret = avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
 						AVDTP_ABORT, NULL, 0);
 	if (ret) {
-		avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
+		avdtp_stream_set_state(stream, AVDTP_STATE_ABORTING);
 		session->dc_timeout = DISCONNECT_TIMEOUT;
 	}
 
@@ -2003,21 +2030,20 @@ static gboolean avdtp_delayreport_cmd(struct avdtp *session,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session, req->acp_seid);
-	if (!sep || !sep->stream) {
+	stream = find_stream_by_lseid(session, req->acp_seid);
+	if (!stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
 	}
 
-	stream = sep->stream;
-
-	if (sep->state != AVDTP_STATE_CONFIGURED &&
-					sep->state != AVDTP_STATE_OPEN &&
-					sep->state != AVDTP_STATE_STREAMING) {
+	if (stream->state != AVDTP_STATE_CONFIGURED &&
+				stream->state != AVDTP_STATE_OPEN &&
+				stream->state != AVDTP_STATE_STREAMING) {
 		err = AVDTP_BAD_STATE;
 		goto failed;
 	}
 
+	sep = stream->lsep;
 	stream->delay = ntohs(req->delay);
 
 	if (sep->ind && sep->ind->delayreport) {
@@ -2432,7 +2458,7 @@ failed:
 		handle_transport_connect(session, NULL, 0, 0);
 
 		if (avdtp_abort(session, stream) < 0)
-			avdtp_sep_set_state(session, stream->lsep,
+			avdtp_stream_set_state(stream,
 						AVDTP_STATE_IDLE);
 	} else
 		connection_lost(session, err_no);
@@ -2845,7 +2871,7 @@ static gboolean avdtp_set_configuration_resp(struct avdtp *session,
 		sep->cfm->set_configuration(session, sep, stream, NULL,
 						sep->user_data);
 
-	avdtp_sep_set_state(session, sep, AVDTP_STATE_CONFIGURED);
+	avdtp_stream_set_state(stream, AVDTP_STATE_CONFIGURED);
 
 	return TRUE;
 }
@@ -2860,12 +2886,11 @@ static gboolean avdtp_reconfigure_resp(struct avdtp *session,
 static gboolean avdtp_open_resp(struct avdtp *session, struct avdtp_stream *stream,
 				struct seid_rej *resp, int size)
 {
-	struct avdtp_local_sep *sep = stream->lsep;
 	BtIOMode mode = btd_opts.avdtp.stream_mode;
 
 	stream->io = l2cap_connect(session, mode);
 	if (!stream->io) {
-		avdtp_sep_set_state(session, sep, AVDTP_STATE_IDLE);
+		avdtp_stream_set_state(stream, AVDTP_STATE_IDLE);
 		return FALSE;
 	}
 
@@ -2885,8 +2910,8 @@ static gboolean avdtp_start_resp(struct avdtp *session,
 
 	/* We might be in STREAMING already if both sides send START_CMD at the
 	 * same time and the one in SNK role doesn't reject it as it should */
-	if (sep->state != AVDTP_STATE_STREAMING)
-		avdtp_sep_set_state(session, sep, AVDTP_STATE_STREAMING);
+	if (stream->state != AVDTP_STATE_STREAMING)
+		avdtp_stream_set_state(stream, AVDTP_STATE_STREAMING);
 
 	return TRUE;
 }
@@ -2895,9 +2920,7 @@ static gboolean avdtp_close_resp(struct avdtp *session,
 					struct avdtp_stream *stream,
 					struct seid_rej *resp, int size)
 {
-	struct avdtp_local_sep *sep = stream->lsep;
-
-	avdtp_sep_set_state(session, sep, AVDTP_STATE_CLOSING);
+	avdtp_stream_set_state(stream, AVDTP_STATE_CLOSING);
 
 	close_stream(stream);
 
@@ -2910,7 +2933,7 @@ static gboolean avdtp_suspend_resp(struct avdtp *session,
 {
 	struct avdtp_local_sep *sep = stream->lsep;
 
-	avdtp_sep_set_state(session, sep, AVDTP_STATE_OPEN);
+	avdtp_stream_set_state(stream, AVDTP_STATE_OPEN);
 
 	if (sep->cfm && sep->cfm->suspend)
 		sep->cfm->suspend(session, sep, stream, NULL, sep->user_data);
@@ -2924,12 +2947,12 @@ static gboolean avdtp_abort_resp(struct avdtp *session,
 {
 	struct avdtp_local_sep *sep = stream->lsep;
 
-	avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
+	avdtp_stream_set_state(stream, AVDTP_STATE_ABORTING);
 
 	if (sep->cfm && sep->cfm->abort)
 		sep->cfm->abort(session, sep, stream, NULL, sep->user_data);
 
-	avdtp_sep_set_state(session, sep, AVDTP_STATE_IDLE);
+	avdtp_stream_set_state(stream, AVDTP_STATE_IDLE);
 
 	return TRUE;
 }
@@ -3549,9 +3572,6 @@ int avdtp_set_configuration(struct avdtp *session,
 	if (!(lsep && rsep))
 		return -EINVAL;
 
-	if (lsep->stream)
-		return -EBUSY;
-
 	DBG("%p: int_seid=%u, acp_seid=%u", session,
 			lsep->info.seid, rsep->seid);
 
@@ -3595,8 +3615,6 @@ int avdtp_set_configuration(struct avdtp *session,
 	if (err < 0)
 		stream_free(new_stream);
 	else {
-		lsep->info.inuse = 1;
-		lsep->stream = new_stream;
 		rsep->stream = new_stream;
 		session->streams = g_slist_append(session->streams, new_stream);
 		if (stream)
@@ -3616,7 +3634,7 @@ int avdtp_open(struct avdtp *session, struct avdtp_stream *stream)
 	if (!g_slist_find(session->streams, stream))
 		return -EINVAL;
 
-	if (stream->lsep->state > AVDTP_STATE_CONFIGURED)
+	if (stream->state > AVDTP_STATE_CONFIGURED)
 		return -EINVAL;
 
 	memset(&req, 0, sizeof(req));
@@ -3649,7 +3667,7 @@ int avdtp_start(struct avdtp *session, struct avdtp_stream *stream)
 	if (!g_slist_find(session->streams, stream))
 		return -EINVAL;
 
-	if (stream->lsep->state != AVDTP_STATE_OPEN)
+	if (stream->state != AVDTP_STATE_OPEN)
 		return -EINVAL;
 
 	/* Recommendation 12:
@@ -3697,7 +3715,7 @@ int avdtp_close(struct avdtp *session, struct avdtp_stream *stream,
 	if (!g_slist_find(session->streams, stream))
 		return -EINVAL;
 
-	if (stream->lsep->state < AVDTP_STATE_OPEN)
+	if (stream->state < AVDTP_STATE_OPEN)
 		return -EINVAL;
 
 	if (stream->close_int == TRUE) {
@@ -3728,7 +3746,7 @@ int avdtp_suspend(struct avdtp *session, struct avdtp_stream *stream)
 	if (!g_slist_find(session->streams, stream))
 		return -EINVAL;
 
-	if (stream->lsep->state <= AVDTP_STATE_OPEN || stream->close_int)
+	if (stream->state <= AVDTP_STATE_OPEN || stream->close_int)
 		return -EINVAL;
 
 	memset(&req, 0, sizeof(req));
@@ -3753,10 +3771,10 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 	if (!g_slist_find(session->streams, stream))
 		return -EINVAL;
 
-	if (stream->lsep->state == AVDTP_STATE_ABORTING)
+	if (stream->state == AVDTP_STATE_ABORTING)
 		return -EINVAL;
 
-	avdtp_sep_set_state(session, stream->lsep, AVDTP_STATE_ABORTING);
+	avdtp_stream_set_state(stream, AVDTP_STATE_ABORTING);
 
 	if (session->req && stream == session->req->stream)
 		return cancel_request(session, ECANCELED);
@@ -3782,9 +3800,9 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 	if (!g_slist_find(session->streams, stream))
 		return -EINVAL;
 
-	if (stream->lsep->state != AVDTP_STATE_CONFIGURED &&
-				stream->lsep->state != AVDTP_STATE_OPEN &&
-				stream->lsep->state != AVDTP_STATE_STREAMING)
+	if (stream->state != AVDTP_STATE_CONFIGURED &&
+				stream->state != AVDTP_STATE_OPEN &&
+				stream->state != AVDTP_STATE_STREAMING)
 		return -EINVAL;
 
 	if (!stream->delay_reporting || session->version < 0x0103)
@@ -3818,7 +3836,6 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps,
 
 	sep = g_new0(struct avdtp_local_sep, 1);
 
-	sep->state = AVDTP_STATE_IDLE;
 	sep->info.seid = seid;
 	sep->info.type = type;
 	sep->info.media_type = media_type;
@@ -3841,14 +3858,24 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps,
 	return sep;
 }
 
+static void release_stream_by_lsep(void *data, void *user_data)
+{
+	struct avdtp_stream *stream = data;
+	struct avdtp_local_sep *sep = user_data;
+
+	if (stream->lsep != sep)
+		return;
+
+	release_stream(stream, stream->session);
+}
+
 int avdtp_unregister_sep(struct queue *lseps, uint64_t *seid_pool,
 						struct avdtp_local_sep *sep)
 {
 	if (!sep)
 		return -EINVAL;
 
-	if (sep->stream)
-		release_stream(sep->stream, sep->stream->session);
+	queue_foreach(streams, release_stream_by_lsep, sep);
 
 	DBG("SEP %p unregistered: type:%d codec:%d seid_pool:%p seid:%d", sep,
 			sep->info.type, sep->codec, seid_pool,
@@ -3906,9 +3933,12 @@ const char *avdtp_strerror(struct avdtp_error *err)
 	}
 }
 
-avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep)
+avdtp_state_t avdtp_stream_get_state(struct avdtp_stream *stream)
 {
-	return sep->state;
+	if (!stream)
+		return AVDTP_STATE_IDLE;
+
+	return stream->state;
 }
 
 uint8_t avdtp_sep_get_seid(struct avdtp_local_sep *sep)
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 500b814ac499..10c8f496b44e 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -296,7 +296,7 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 int avdtp_unregister_sep(struct queue *lseps, uint64_t *seid_pool,
 						struct avdtp_local_sep *sep);
 
-avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep);
+avdtp_state_t avdtp_stream_get_state(struct avdtp_stream *stream);
 uint8_t avdtp_sep_get_seid(struct avdtp_local_sep *sep);
 
 void avdtp_error_init(struct avdtp_error *err, uint8_t type, int id);
-- 
2.49.0

