Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A0E369217
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791402739; cv=none; b=qBRr1uER8BhnwPcJkn1EGt14ZZmWpqeTlIiqgly3KkyRYYoRwHs1o4q9AwU+7sNBR0Asrh2zzKzaS85iTfNLEIx9AEawaGw9sSteYxcXEhrITNKpn0cnNbQRbsLRZdh71hFZKsC2AE4Jrih0Z+8nMASyGPRZFpZhSdozwwCJrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791402739; c=relaxed/simple;
	bh=Y+O9gJoJeWf8nY7C4+cHzipnCAOo2+ylXzHMA7PahBM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJHZ3IMBFILfdgR5F5xkpfOMEL+bd0d6SE8iRKLZ/XuTrAFDcIQBBVbaCzazNVqZjgJeN5e7vAQCok/1lEUs2W/3PLHqTgktE3nSU5GX+NNJCYKKaCKBqFVI8rqp5kwqY/SjAjjHVuhnhsFB76aiOfPR6ePtd7CPwpdSNlYrOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQOCjIRI; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQOCjIRI"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5d4d307fab6so1003823e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791402737; x=1792007537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=taNdpS4FdouBUmCDOkjNraG9Gx4iy3lfNX75omG/XKk=;
        b=MQOCjIRImpl/iYWhFwQSZJ2AtF1g54Jrzxf9I9Fo+nj+wUENwOf7a1JkU59qrQanfh
         pbAIzjBuDvtBWnQBqmqhJzzjTfeR42kQxsKEDbpaFvsLEfr35Zxg59ZX1N6FeYCzUg53
         QKt2crJCfGPqqfmC9dfjw/5/UkR+y/N9ML/hERIf7Bpk7QBjIIv59vPwEWAvxh38lNTR
         KGom1tZmoGsSEDqtOefhC4WEFpG05OtDBRyh9R49eHwx+f3yqetEit8edZ1+64H7VkwY
         oH0Y67EI4sKzBIRB9B3OeZj1AgxqYAbE218zHCggcp1FJI39QRq+ZbgHYc+wW7BL61ve
         8RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791402737; x=1792007537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=taNdpS4FdouBUmCDOkjNraG9Gx4iy3lfNX75omG/XKk=;
        b=mEOBL62VDZ0dIDcPQFepNB7JRCZPDvVYmWGb3OWtchx0coctBLD+5R79IDY0aOOhaV
         7PoxHln4m97a1BnBQX2Yov5anK2c8ahqFnxoYY5xHGxJGqFwY3VPD7MX33zq6mijeZ3d
         /cFmx5obBoQxbsmrb6oq+57A/Ryk0tU5FTs/TxPDY0r3Cti7KVzd9L5HHqpAsFhGxVi2
         t7Szb2+Sp9HILjBKPi0oLs4NG6/H1jqfQFwsagBQwHhNZgZ04okJ79yRFFjutO5tBMAW
         xi1A11H1MKiG10B8M1mkYezLLDtwbhku19aO17b9HbRg6DKAg+ZbbkjFD+DocZk+ilUk
         ixHA==
X-Gm-Message-State: AFuF++lTuIsSUL48tII3uOs8NcNq3qwoZShGZnaPqS9thFp5I4nYwgXg
	90TVQ8iuuwTsC1wcIPylG4N+BMyLin7ifL6/yyh/BDJ1Sykzex0LpsK1Ul7VKJrDg+r96w==
X-Gm-Gg: AYBFou0SR5sB9gUfY8YXk1ewYiW+WYoj4/GHqNMtEpjvQQcfJjvaD4TFIhFIUmqSfar
	fm7a5ThAKDIXGw0hzuJ7pUlL37x/mppQuBw2C2VeYGgD0O8RtPyj9i8ieP4CFfFqosafw4j3+r9
	mu3LhXgTpRyY0etpfXlzYZMpBzucY7LDu4skpmQ9jf5HnQuinygoShV31GYLNrvyXmhJe7dqehG
	UqSM1UT4UymwNmM5l9Pm/2k2FrXYoBj5WekB/2p5k+wwLMV4bX5ntPbgdTD34hRbPVL4Lm0wLLN
	GOWNyG+vqzDznqGRqRKBA7hVxBOi0CHUk7W55fx97fIydVjopupGxoPrWusJp+uwYjY+Mq9SrUD
	G8WE8cWpeLEpZFTaAjC5mKMX3FMMNNz4AcOYyJvNdDSqVppKSpW4dHlZzQvjc86WzQYk/cVJ5jz
	517K0808qFObphchN02CgVTCA+ajp7herke3NAB1qnM2tSl7rcK+grSTUdlICsFIbMRhVOt8fQI
	QGm8i9JVidT+tgyLE/ihFRIo6O8886ItwFBn8o5hpjvF3miZ/w/5KLyy8P8z5LG
X-Received: by 2002:a05:6123:2c6:b0:5dc:d0cb:7d6b with SMTP id 71dfb90a1353d-5e6d2d23866mr1143810e0c.14.1791402736715;
        Wed, 07 Oct 2026 12:52:16 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e6c409aa8fsm2775177e0c.4.2026.10.07.12.52.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:52:16 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] a2dp: Fix crash on NULL session in auto_config
Date: Wed,  7 Oct 2026 15:52:05 -0400
Message-ID: <20261007195206.350586-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007195206.350586-1-luiz.dentz@gmail.com>
References: <20261007195206.350586-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduardo Alves <eduardoalves8006@gmail.com>

If the AVDTP channel is disconnected while bluetoothd is still waiting
for the MediaEndpoint1 to reply to SetConfiguration, channel_free()
sets setup->session to NULL but the setup stays alive since the pending
endpoint request holds a reference to it. Once the endpoint replies, or
the call times out and the request is canceled, endpoint_setconf_cb()
calls auto_config() which passes the NULL session to avdtp_get_device()
and then dereferences the resulting NULL device:

  bluetoothd[820]: profiles/audio/media.c:endpoint_reply() Endpoint
    replied with an error: org.freedesktop.DBus.Error.NoReply
  kernel: bluetoothd[820]: segfault at 1a0 ip 00005633dd741323
    sp 00007ffe51923650 error 4 in bluetoothd

  #0  auto_config (data=0x56340361a120) at profiles/audio/a2dp.c:723
  #1  endpoint_setconf_cb (setup=...) at profiles/audio/a2dp.c:768
  #2  media_endpoint_cancel (request=...) at profiles/audio/media.c:208
  #3  media_endpoint_cancel_all () at profiles/audio/media.c:216
  #4  clear_endpoint () at profiles/audio/media.c:379
  #5  endpoint_reply (user_data=...) at profiles/audio/media.c:407

  (gdb) p *setup
  $1 = {chan = 0x0, session = 0x0, ...,
        setconf_cb = 0x5633dd74c780 <setconf_cb>, ..., ref = 2}

Commit 14750a2e48f4 ("audio/a2dp: Fix Access session device only when
its valid") fixed the same crash, but commit 77932f2dac1a
("profiles/audio: add nullity checks") moved avdtp_get_device() back
ahead of the checks. Just reordering is not enough though: the
a2dp_stream is still on sep->streams, so the aborted check passes and
setconf_cb() would then be called with a NULL session as well.

Fix it by making finalize_all() abort the pending Set Configuration
while the session is still valid: clearing the endpoint configuration
sends ClearConfiguration, removes the MediaTransport created for the
request and cancels the request, so auto_config() rejects the
configuration and frees the pending avdtp_stream and a2dp_stream, both
previously leaked together with the session reference held by the
latter. If no request is pending, the configuration is rejected
directly. auto_config() bails out when setup->session is NULL, as it
may still run from idle, and setconf_cb is cleared once called so it
cannot be called twice.

Removing a transport now cancels the endpoint requests pending for it,
so a late reply is ignored instead of leaving the transport registered,
which made the next connection fail with "Resource temporarily
unavailable".

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/a2dp.c  | 132 +++++++++++++++++++++++++++--------------
 profiles/audio/media.c |  20 ++++++-
 2 files changed, 106 insertions(+), 46 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 08a9e1c96e4f..37f6d4ae12ac 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -507,41 +507,6 @@ static void finalize_discover(struct a2dp_setup *s)
 	}
 }
 
-static gboolean finalize_all(gpointer data)
-{
-	struct a2dp_setup *s = data;
-	struct avdtp_stream *stream = s->err ? NULL : s->stream;
-	GSList *l;
-
-	for (l = s->cb; l != NULL; ) {
-		struct a2dp_setup_cb *cb = l->data;
-
-		l = l->next;
-
-		if (cb->discover_cb) {
-			cb->discover_cb(s->session, s->seps,
-					error_to_errno(s->err), cb->user_data);
-		} else if (cb->select_cb) {
-			cb->select_cb(s->session, s->sep, s->caps,
-					error_to_errno(s->err), cb->user_data);
-		} else if (cb->suspend_cb) {
-			cb->suspend_cb(s->session,
-					error_to_errno(s->err), cb->user_data);
-		} else if (cb->resume_cb) {
-			cb->resume_cb(s->session,
-					error_to_errno(s->err), cb->user_data);
-		} else if (cb->config_cb) {
-			cb->config_cb(s->session, s->sep, stream,
-					error_to_errno(s->err), cb->user_data);
-		} else
-			warn("setup_cb doesn't have any callback function");
-
-		setup_cb_free(cb);
-	}
-
-	return FALSE;
-}
-
 static struct a2dp_setup *find_setup_by_session(struct avdtp *session)
 {
 	GSList *l;
@@ -711,6 +676,86 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		sep->endpoint->clear_configuration(sep, dev, sep->user_data);
 }
 
+static void setup_setconf_reply(struct a2dp_setup *setup,
+					struct avdtp_error *err)
+{
+	avdtp_set_configuration_cb cb = setup->setconf_cb;
+
+	if (!cb)
+		return;
+
+	setup->setconf_cb = NULL;
+
+	/* Rejecting the configuration frees the avdtp_stream */
+	if (err)
+		a2dp_stream_destroy(setup->sep, setup->stream);
+
+	cb(setup->session, setup->stream, err);
+
+	if (err)
+		setup->stream = NULL;
+}
+
+/* Reject a pending Set Configuration while setup->session is still valid */
+static void setup_abort_setconf(struct a2dp_setup *setup)
+{
+	struct a2dp_sep *sep = setup->sep;
+	struct avdtp_error err;
+
+	if (!setup->setconf_cb)
+		return;
+
+	/* Clearing the endpoint configuration cancels its pending request
+	 * which rejects the configuration via auto_config().
+	 */
+	if (sep->endpoint && sep->endpoint->clear_configuration)
+		sep->endpoint->clear_configuration(sep,
+					avdtp_get_device(setup->session),
+					sep->user_data);
+
+	/* Reject it if it was not pending on the endpoint */
+	avdtp_error_init(&err, AVDTP_MEDIA_CODEC,
+					AVDTP_UNSUPPORTED_CONFIGURATION);
+	setup_setconf_reply(setup, &err);
+}
+
+static gboolean finalize_all(gpointer data)
+{
+	struct a2dp_setup *s = data;
+	struct avdtp_stream *stream = s->err ? NULL : s->stream;
+	GSList *l;
+
+	for (l = s->cb; l != NULL; ) {
+		struct a2dp_setup_cb *cb = l->data;
+
+		l = l->next;
+
+		if (cb->discover_cb) {
+			cb->discover_cb(s->session, s->seps,
+					error_to_errno(s->err), cb->user_data);
+		} else if (cb->select_cb) {
+			cb->select_cb(s->session, s->sep, s->caps,
+					error_to_errno(s->err), cb->user_data);
+		} else if (cb->suspend_cb) {
+			cb->suspend_cb(s->session,
+					error_to_errno(s->err), cb->user_data);
+		} else if (cb->resume_cb) {
+			cb->resume_cb(s->session,
+					error_to_errno(s->err), cb->user_data);
+		} else if (cb->config_cb) {
+			cb->config_cb(s->session, s->sep, stream,
+					error_to_errno(s->err), cb->user_data);
+		} else
+			warn("setup_cb doesn't have any callback function");
+
+		setup_cb_free(cb);
+	}
+
+	setup_abort_setconf(s);
+
+	return FALSE;
+}
+
 static gboolean auto_config(gpointer data)
 {
 	struct a2dp_setup *setup = data;
@@ -718,6 +763,12 @@ static gboolean auto_config(gpointer data)
 	struct btd_service *service;
 	struct a2dp_stream *stream;
 
+	/* Check if the channel has been disconnected, in which case
+	 * channel_free() has already rejected the configuration.
+	 */
+	if (!setup->session)
+		goto done;
+
 	dev = avdtp_get_device(setup->session);
 
 	if (setup->sep->type == AVDTP_SEP_TYPE_SOURCE)
@@ -748,16 +799,7 @@ static gboolean auto_config(gpointer data)
 	}
 
 done:
-	if (setup->setconf_cb) {
-		/* Rejecting the configuration frees the avdtp_stream */
-		if (setup->err)
-			a2dp_stream_destroy(setup->sep, setup->stream);
-
-		setup->setconf_cb(setup->session, setup->stream, setup->err);
-
-		if (setup->err)
-			setup->stream = NULL;
-	}
+	setup_setconf_reply(setup, setup->err);
 
 	finalize_config(setup);
 
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index e8418280e60b..34ff251c7ef2 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -359,12 +359,26 @@ static struct media_adapter *find_adapter(struct btd_device *device)
 	return NULL;
 }
 
+static int request_transport_cmp(gconstpointer data, gconstpointer user_data)
+{
+	const struct endpoint_request *request = data;
+
+	return request->transport == user_data ? 0 : -1;
+}
+
 static void endpoint_remove_transport(struct media_endpoint *endpoint,
 					struct media_transport *transport)
 {
+	GSList *l;
+
 	if (!endpoint || !transport)
 		return;
 
+	/* Cancel pending requests for the transport */
+	while ((l = g_slist_find_custom(endpoint->requests, transport,
+						request_transport_cmp)))
+		media_endpoint_cancel(l->data);
+
 	endpoint->transports = g_slist_remove(endpoint->transports, transport);
 	media_transport_destroy(transport);
 }
@@ -431,7 +445,11 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 		if (dbus_message_is_method_call(request->msg,
 					MEDIA_ENDPOINT_INTERFACE,
 					"SetConfiguration")) {
-			endpoint_remove_transport(endpoint, request->transport);
+			struct media_transport *transport = request->transport;
+
+			/* Detach so the request is not canceled */
+			request->transport = NULL;
+			endpoint_remove_transport(endpoint, transport);
 			error_code = a2dp_parse_config_error(err.name);
 			ret = &error_code;
 			size = 1;
-- 
2.55.0

