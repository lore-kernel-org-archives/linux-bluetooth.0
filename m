Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E7370D49
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920764; cv=none; b=Qow3g0uPyTBL7WGt7fEQgGSl1jzFOv6cvJDR5FhjzgZ8UcfXoe4Av8qBxPPszgkDsxC5C3fbpnofK9zO4+n4iNORT0wKwAu4gE3wu6IyvU234oXdB/JVzFxLb/zCUXMV6xumflXIJ10TTtFV/Rh9VQtkmCDE4deBjU+KhWiVgrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920764; c=relaxed/simple;
	bh=mWvzznwdhlmOUjycIpwu4pHFeenv4OcqIkEYDR7sMIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmDhQ6yeBCW631CYbI9jjhsadtG1gkVzQ2ZhuTKRpupppLw8o9zsuoHlL0GvVEVqUGFsc/O1kJJefm2zjlcqy6tK6eBC9f6Ws9MDkdLPTq0Gq195OylanzurWH+GoUDBi1PUDC69xhkxfwz7ZmUlsVwuw6IaTwXxqVHotws/og8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=LfAq5S6t; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="LfAq5S6t"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b9318997so31044785e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 05:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780920759; x=1781525559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7DMZG4FD6tEFUI5Oolecj6vRXiLuLur7yoAOmyYa1Q=;
        b=LfAq5S6tjnCr0AVpR2F3c0oSxPn8cXEhPGV2PTd3MqULpPKXAIbFyta4DcYTiD3fC4
         MvXnLjySPURFnCTLr+ulzGvYFX0iBlzHFHoSzq9n8Hz//v0CMH1avsUZ1JWAC2Vxlbyi
         TDhpHl4RqxA/yRbqVVJefcHicGDgNLHSPxpBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920759; x=1781525559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7DMZG4FD6tEFUI5Oolecj6vRXiLuLur7yoAOmyYa1Q=;
        b=J4ser+O3V4EZoiLjhQbosb7ZdsB2lR1gT92IDsUNpDG5RSbBXal1YQaslHhFgeiAP1
         7IMr3cSFoifX7ewJzHcR/XhM8/71HAPNjJF/B9eP01sklWseZ+2PY5SP1JAuyfj0mO+B
         X9DTfz//H/sl3v9gHdB7gfTd3UkRB6v+q6EHSNVuTJONarwtCPCM9xAUN5E+wDzg9wZW
         KLPdHl+wA6LzJ1x7UzNWNcZbngXUEaOnrsS+6bfLH/eih3yewHVSYa60guEWZqNPYgxp
         E5qh3sy1U4ot8mQtAEEtokK8wz9aKcwtrbDw92GvNzn507aP3zCIr42rahHJ3KWgVqHk
         Wp3Q==
X-Gm-Message-State: AOJu0YxwyMh04KKtxVNd4VqRUKK8GccICEGatznIkM7Hu0bECq758STi
	eCH65QJhbBWhRSMbQHi6kd1TxdEWiCWP1BBEl1wtDph1D2YlS1Oqcw8MCe56EaUW6YrVpFuTBgY
	zTGiZ
X-Gm-Gg: Acq92OF9oQGUTPL+u4o54SPDYDBRaXhXhirwPcWFZMoD2gKhImLrgtp6Iii6M2P6gYT
	RdciZlm8DDwFO5mwQO2op4VFzlligA+vdLu5pyUfYyoyoTizaCkMhBQuqb2rx3WVplXFotOjC7F
	iNQTycXiIBmACkDzvwzNui7ooqM3L518jZ3zm3q5Lnq6Y/wf15h2QwTyVzFtS1KyDQh3rGai8o8
	r2SJk31pHVpojl7KpkPYW+7VR2eU+qJ8xPccWcNhZVsDkJQ28llvfcrSv1ZTqqk1zso1nP8maVx
	UtroTWtARMycAIH49b2pp+VCt9WKVf78e07Clrj342BD+r1N+ibV7MmyY2oZz43S1yeIJ0kuuq+
	O1WxtMiCMLv/nWPNqfqgbwNRhp41BHnK6Zcd/pHOiIjliXoRIdWFJD0pDtqm/tb5BTA6cWiV+vR
	Vo9PlX6rmVwk4u3o4xu6z4pZ4SeQ/welHRdHteXLkicADS20qNT5SqoHVbqvSGEOyg
X-Received: by 2002:a05:600c:4e09:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-490c259a003mr281360405e9.6.1780920758941;
        Mon, 08 Jun 2026 05:12:38 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d6c65sm381234765e9.12.2026.06.08.05.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:12:38 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/2] avdtp: Add GetConfiguration DBus function
Date: Mon,  8 Jun 2026 14:12:24 +0200
Message-ID: <20260608121226.3727101-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change avdtp_get_configuration to accept remote SEP instead of stream a
and add an async callback for response/reject handling; the old function
was not used anywhere (unit-test just copied signature), so it was
changed in place.

Add a GetConfiguration async D-Bus method to the remote SEP interface that
returns the retrieved configuration as a byte array.

This can be used to pass: AVDTP/SRC/INT/SIG/SMG/BV-11-C
---
 profiles/audio/a2dp.c  | 63 ++++++++++++++++++++++++++++++++++
 profiles/audio/avdtp.c | 76 ++++++++++++++++++++++++++++++++++++++++--
 profiles/audio/avdtp.h |  9 ++++-
 3 files changed, 144 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c7e0fc75c..8dcf510ca 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2168,11 +2168,74 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static void get_configuration_cb(struct avdtp *session, GSList *caps,
+				struct avdtp_error *err, void *user_data)
+{
+	DBusMessage *msg = user_data;
+	DBusMessage *reply;
+	DBusMessageIter iter, array;
+	GSList *l;
+
+	if (err) {
+		reply = btd_error_failed(msg, "GetConfiguration rejected");
+		goto done;
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	for (l = caps; l; l = g_slist_next(l)) {
+		struct avdtp_service_capability *cap = l->data;
+		uint8_t *ptr = (uint8_t *) cap;
+		int i;
+
+		for (i = 0; i < cap->length + 2; i++)
+			dbus_message_iter_append_basic(&array,
+							DBUS_TYPE_BYTE,
+							&ptr[i]);
+	}
+
+	dbus_message_iter_close_container(&iter, &array);
+
+done:
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	dbus_message_unref(msg);
+	g_slist_free_full(caps, g_free);
+}
+
+static DBusMessage *get_configuration(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct a2dp_remote_sep *rsep = data;
+	struct a2dp_channel *chan = rsep->chan;
+	int err;
+
+	if (chan->session == NULL)
+		return btd_error_not_available(msg);
+
+	err = avdtp_get_configuration(chan->session, rsep->sep,
+					get_configuration_cb,
+					dbus_message_ref(msg));
+	if (err < 0) {
+		dbus_message_unref(msg);
+		return btd_error_failed(msg, strerror(-err));
+	}
+
+	return NULL;
+}
+
 static const GDBusMethodTable sep_methods[] = {
 	{ GDBUS_ASYNC_METHOD("SetConfiguration",
 					GDBUS_ARGS({ "endpoint", "o" },
 						{ "properties", "a{sv}" } ),
 					NULL, set_configuration) },
+	{ GDBUS_ASYNC_METHOD("GetConfiguration",
+					NULL,
+					GDBUS_ARGS({ "configuration", "ay" }),
+					get_configuration) },
 	{ },
 };
 
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index d475a545e..5f0424c81 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -348,6 +348,11 @@ struct discover_callback {
 	void *user_data;
 };
 
+struct getconf_callback {
+	avdtp_get_configuration_cb_t cb;
+	void *user_data;
+};
+
 struct avdtp_stream {
 	GIOChannel *io;
 	uint16_t imtu;
@@ -406,6 +411,7 @@ struct avdtp {
 	char *buf;
 
 	struct discover_callback *discover;
+	struct getconf_callback *getconf;
 	struct pending_req *req;
 
 	unsigned int dc_timer;
@@ -1093,6 +1099,24 @@ static void finalize_discovery(struct avdtp *session, int err)
 	session->discover = NULL;
 }
 
+static void finalize_getconf(struct avdtp *session, int err)
+{
+	struct getconf_callback *getconf = session->getconf;
+	struct avdtp_error avdtp_err;
+
+	if (!getconf)
+		return;
+
+	session->getconf = NULL;
+
+	avdtp_error_init(&avdtp_err, AVDTP_ERRNO, err);
+
+	if (getconf->cb)
+		getconf->cb(session, NULL, &avdtp_err, getconf->user_data);
+
+	g_free(getconf);
+}
+
 static void release_stream(struct avdtp_stream *stream, struct avdtp *session)
 {
 	struct avdtp_local_sep *sep = stream->lsep;
@@ -1144,6 +1168,7 @@ static void avdtp_free(void *data)
 	g_slist_free_full(session->seps, sep_free);
 
 	g_free(session->buf);
+	g_free(session->getconf);
 
 	btd_device_unref(session->device);
 	g_free(session);
@@ -1162,6 +1187,7 @@ static void connection_lost(struct avdtp *session, int err)
 	session->streams = NULL;
 
 	finalize_discovery(session, err);
+	finalize_getconf(session, err);
 
 	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
 
@@ -3008,6 +3034,20 @@ static gboolean avdtp_parse_resp(struct avdtp *session,
 				next->signal_id == AVDTP_GET_ALL_CAPABILITIES)))
 			finalize_discovery(session, 0);
 		return TRUE;
+	case AVDTP_GET_CONFIGURATION:
+		DBG("GET_CONFIGURATION request succeeded");
+		if (session->getconf) {
+			struct getconf_callback *cb = session->getconf;
+			GSList *caps;
+
+			session->getconf = NULL;
+			caps = caps_to_list(((struct getcap_resp *) buf)->caps,
+					size - sizeof(struct getcap_resp),
+					NULL, NULL, NULL);
+			cb->cb(session, caps, NULL, cb->user_data);
+			g_free(cb);
+		}
+		return TRUE;
 	}
 
 	/* The remaining commands require an existing stream so bail out
@@ -3115,6 +3155,19 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 		error("GET_CAPABILITIES request rejected: %s (%d)",
 				avdtp_strerror(&err), err.err.error_code);
 		return TRUE;
+	case AVDTP_GET_CONFIGURATION:
+		if (!seid_rej_to_err(buf, size, &err))
+			return FALSE;
+		error("GET_CONFIGURATION request rejected: %s (%d)",
+				avdtp_strerror(&err), err.err.error_code);
+		if (session->getconf) {
+			struct getconf_callback *cb = session->getconf;
+
+			session->getconf = NULL;
+			cb->cb(session, NULL, &err, cb->user_data);
+			g_free(cb);
+		}
+		return TRUE;
 	case AVDTP_OPEN:
 		if (!seid_rej_to_err(buf, size, &err))
 			return FALSE;
@@ -3536,18 +3589,35 @@ unsigned int avdtp_stream_add_cb(struct avdtp *session,
 	return stream_cb->id;
 }
 
-int avdtp_get_configuration(struct avdtp *session, struct avdtp_stream *stream)
+int avdtp_get_configuration(struct avdtp *session,
+					struct avdtp_remote_sep *rsep,
+					avdtp_get_configuration_cb_t cb,
+					void *user_data)
 {
 	struct seid_req req;
+	int err;
 
 	if (session->state < AVDTP_SESSION_STATE_CONNECTED)
 		return -EINVAL;
 
+	if (session->getconf)
+		return -EBUSY;
+
 	memset(&req, 0, sizeof(req));
-	req.acp_seid = stream->rseid;
+	req.acp_seid = rsep->seid;
 
-	return send_request(session, FALSE, stream, AVDTP_GET_CONFIGURATION,
+	err = send_request(session, FALSE, NULL, AVDTP_GET_CONFIGURATION,
 							&req, sizeof(req));
+	if (err < 0)
+		return err;
+
+	if (cb) {
+		session->getconf = g_new0(struct getconf_callback, 1);
+		session->getconf->cb = cb;
+		session->getconf->user_data = user_data;
+	}
+
+	return 0;
 }
 
 static void copy_capabilities(gpointer data, gpointer user_data)
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 10c8f496b..45c54086f 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -267,8 +267,15 @@ int avdtp_set_configuration(struct avdtp *session,
 				GSList *caps,
 				struct avdtp_stream **stream);
 
+typedef void (*avdtp_get_configuration_cb_t)(struct avdtp *session,
+						GSList *caps,
+						struct avdtp_error *err,
+						void *user_data);
+
 int avdtp_get_configuration(struct avdtp *session,
-				struct avdtp_stream *stream);
+				struct avdtp_remote_sep *rsep,
+				avdtp_get_configuration_cb_t cb,
+				void *user_data);
 
 int avdtp_open(struct avdtp *session, struct avdtp_stream *stream);
 int avdtp_start(struct avdtp *session, struct avdtp_stream *stream);
-- 
2.43.0

