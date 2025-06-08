Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77702571D3
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418362; cv=pass; b=jcXOHNqFoF+tfJDAdjxRIKaLnyU+wn+ohNeqck4wSbbkoDasdm3udUIy2bTokHBcCpnM0Oz/tIe6fnw/6PiBtdu2HbOUPSs9NSc98JGf51DzKWs9pJcZhHQXIO8YaTrlBMDbhlqSXBr7J/MccfwlzxcepO/Lp/K8rbBdL7dY4kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418362; c=relaxed/simple;
	bh=wjeMxImG7C+0/4S16/iNKFzc9rQDTGQ0jsKBm7gcpGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHRL8BkdXfAWDSfKiWXkh6wxHCIaMYL4vZmD8DINYl/k80Di3vj2sWSz/2VhdBqLwjPbsUQs3CBIHY6+8tjOtFTv/rHnXEqpbilqiJAUFGGtFcOqA8dLwFxDK76Ow41zavbaOe9lAJDWBT88BVnpD+8FfwAw3HnFaPaWWDp+2Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=qcSwSG9/; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="qcSwSG9/"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bFpDk6mN2z49QDQ;
	Mon,  9 Jun 2025 00:32:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1749418359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HoJmzq7OhMpOGw2PKm4tHlv/psytaH8sFRggaR5pp8Q=;
	b=qcSwSG9/FTTatto/mVLgXIg6RLU/ZTIFdlsalRAh2BKYade24N8K93aRtZJa1OlBreLk5b
	W0jvXVWpQ9ZX0iQAaVsl9ryhKuT7R3bstXUvS6I3a+iB9lF48leTEeJazr6yWeXM4OiyDn
	vhVYkcFp+8cFQ5xB7dn45sOC92RWpkm7e3MgrhK/mueuqs3U6OaEoeKpw/MuJ4j2s902Lz
	eUpKwSYiHTfymUPHGdvU72kJJxQBtDn0Grx84PPxRDmfvIsD07fq8Is5MY+Kr/9EP5pjHH
	mfSRfkjunfHtw5iHrc09DGlWp6PWCHt/9GqGVEqY4VAbaqKp3gKuI4io7A93QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1749418359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HoJmzq7OhMpOGw2PKm4tHlv/psytaH8sFRggaR5pp8Q=;
	b=hFsYF0XRbJQ3bpydZlF4JxGAzD5o3KFlRG73z3yIG4ToTKLflRNpiDc0ziPZbqxhxd0nSM
	ct09colVsXkF9fTmqL84eOyFhgacVdxvpdupDY4M1UPqyGEHVYH/1w8tj7GtokUfJwNzav
	WWdRYkh2x2QO7JP+Uz6N8fRdSylpy1DBL0vpEZ+mrdlW8L5X6GnQOOhvh6t+7v5cmACSXv
	kjJkz14pK7W+qBmj9RKRP/XAGyeP/82NLmQfNxUw5P99JFZTNx/e1vaEnCdxijBBwP7Vt5
	NxtN6CtrBP/6uIzS9GDdsXyJNCla+xHjceSV7nuIfcXKfLUsY6fLTwEL92C1Wg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1749418359; a=rsa-sha256;
	cv=none;
	b=dcnzWHGssR1mMEaoE5j66jtkGpjOvDy8IPhGIZfaRVpzqdKmFakqJ9Dkxo2b3z3hfc9Pr7
	eoL/ua8RjnmOcf3i9+VzhXGKglccQYQ5YxxipTPiGbDAV8zAGHf7W5Mhz6TFVcYnIVo3rn
	7ef/bi/SM4Fp/fhZOAL4+GE2/uVq6bFO6Pb5TMIRURMyaYyyE4ErL+HBPnUWxAsvJP7WqN
	sfnYeE/5x0NJHhxYLEOhIusaRbXC7xO1BFvBHxR8jarOPE/bPYxoauAgq7IO9gsvWaP3XF
	iAtIoOlpiMHpLhmBh/LZSkWTfJ3D44thSWusfuzNmBraIPods7vXnc1dUBJQaw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 05/10] bap: add ready callback for setup configuration
Date: Mon,  9 Jun 2025 00:32:17 +0300
Message-ID: <78eb44f996c6a0f5729415beb989e494d3624738.1749418319.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749418319.git.pav@iki.fi>
References: <cover.1749418319.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Operations like SetConfiguration need to wait until setup configuration
finishes. Abstract this to a setup_config() callback emitted on QoS
completion or failure, instead of hardcoding DBus reply.
---
 profiles/audio/bap.c | 179 +++++++++++++++++++++++++++----------------
 1 file changed, 112 insertions(+), 67 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 6be6ff8fd..b39314fa9 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -63,6 +63,11 @@
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 #define MEDIA_INTERFACE "org.bluez.Media1"
 
+struct bap_setup;
+
+typedef void (*bap_setup_ready_func_t)(struct bap_setup *setup, int code,
+						uint8_t reason, void *data);
+
 struct bap_setup {
 	struct bap_ep *ep;
 	struct bap_data *data;
@@ -76,11 +81,13 @@ struct bap_setup {
 	bool cig_active;
 	uint8_t sid;
 	bool config_pending;
+	bool readying;
 	struct iovec *caps;
 	struct iovec *metadata;
 	unsigned int id;
 	struct iovec *base;
-	DBusMessage *msg;
+	bap_setup_ready_func_t ready_cb;
+	void *ready_cb_data;
 	void (*destroy)(struct bap_setup *setup);
 };
 
@@ -116,6 +123,10 @@ struct bap_data {
 
 static struct queue *sessions;
 
+static int setup_config(struct bap_setup *setup, bap_setup_ready_func_t cb,
+							void *user_data);
+
+
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
 {
 	if (!data)
@@ -697,28 +708,32 @@ fail:
 	return -EINVAL;
 }
 
+static void setup_ready(struct bap_setup *setup, int code,
+							uint8_t reason)
+{
+	if (!setup->readying)
+		return;
+
+	setup->readying = false;
+
+	if (setup->ready_cb) {
+		setup->ready_cb(setup, code, reason, setup->ready_cb_data);
+		setup->ready_cb = NULL;
+		setup->ready_cb_data = NULL;
+	}
+}
+
 static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
 					void *user_data)
 {
 	struct bap_setup *setup = user_data;
-	DBusMessage *reply;
 
 	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
 
 	setup->id = 0;
 
-	if (!setup->msg)
-		return;
-
-	if (!code)
-		reply = dbus_message_new_method_return(setup->msg);
-	else
-		reply = btd_error_failed(setup->msg, "Unable to configure");
-
-	g_dbus_send_message(btd_get_dbus_connection(), reply);
-
-	dbus_message_unref(setup->msg);
-	setup->msg = NULL;
+	if (code)
+		setup_ready(setup, code, reason);
 }
 
 static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
@@ -766,26 +781,19 @@ static void config_cb(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	struct bap_setup *setup = user_data;
-	DBusMessage *reply;
+	int err = 0;
 
 	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
 
 	setup->id = 0;
 
-	if (!code) {
-		if (!setup->config_pending)
-			setup_qos(setup);
-		return;
-	}
+	if (code)
+		err = code;
+	else if (!setup->config_pending)
+		err = setup_qos(setup);
 
-	if (!setup->msg)
-		return;
-
-	reply = btd_error_failed(setup->msg, "Unable to configure");
-	g_dbus_send_message(btd_get_dbus_connection(), reply);
-
-	dbus_message_unref(setup->msg);
-	setup->msg = NULL;
+	if (err)
+		setup_ready(setup, err, reason);
 }
 
 static void setup_io_close(void *data, void *user_data)
@@ -875,22 +883,16 @@ static void release_stream(struct bt_bap_stream *stream)
 static void setup_free(void *data)
 {
 	struct bap_setup *setup = data;
-	DBusMessage *reply;
 
 	DBG("%p", setup);
 
+	setup_ready(setup, -ECANCELED, 0);
+
 	if (setup->stream && setup->id) {
 		bt_bap_stream_cancel(setup->stream, setup->id);
 		setup->id = 0;
 	}
 
-	if (setup->msg) {
-		reply = btd_error_failed(setup->msg, "Canceled");
-		g_dbus_send_message(btd_get_dbus_connection(), reply);
-		dbus_message_unref(setup->msg);
-		setup->msg = NULL;
-	}
-
 	if (setup->ep)
 		queue_remove(setup->ep->setups, setup);
 
@@ -987,6 +989,29 @@ static bool setup_mismatch_qos(const void *data, const void *user_data)
 	return !match_bcast_qos(&setup->qos.bcast, &match->qos.bcast);
 }
 
+struct set_configuration_data {
+	struct bap_setup *setup;
+	DBusMessage *msg;
+};
+
+static void set_configuration_ready(struct bap_setup *setup, int code,
+						uint8_t reason, void *user_data)
+{
+	struct set_configuration_data *data = user_data;
+	DBusMessage *reply;
+
+	if (!code)
+		reply = dbus_message_new_method_return(data->msg);
+	else if (code == -ECANCELED)
+		reply = btd_error_failed(data->msg, "Canceled");
+	else
+		reply = btd_error_failed(data->msg, "Unable to configure");
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	dbus_message_unref(data->msg);
+	free(data);
+}
+
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -994,6 +1019,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	struct bap_setup *setup;
 	const char *path;
 	DBusMessageIter args, props;
+	struct set_configuration_data *cbdata;
 
 	dbus_message_iter_init(msg, &args);
 
@@ -1028,36 +1054,23 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 			return btd_error_invalid_args(msg);
 		}
 
-	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
-						&setup->qos, setup->caps);
-	bt_bap_stream_lock(setup->stream);
-	bt_bap_stream_set_user_data(setup->stream, ep->path);
-	setup->config_pending = true;
-	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
-						setup->caps, config_cb, setup);
-	if (!setup->id) {
+	cbdata = new0(struct set_configuration_data, 1);
+	cbdata->setup = setup;
+
+	if (setup_config(setup, set_configuration_ready, cbdata)) {
 		DBG("Unable to config stream");
 		setup_free(setup);
+		free(cbdata);
 		return btd_error_invalid_args(msg);
 	}
 
-	if (setup->metadata && setup->metadata->iov_len)
-		bt_bap_stream_metadata(setup->stream, setup->metadata, NULL,
-								NULL);
+	cbdata->msg = dbus_message_ref(msg);
 
 	switch (bt_bap_stream_get_type(setup->stream)) {
-	case BT_BAP_STREAM_TYPE_UCAST:
-		setup->msg = dbus_message_ref(msg);
-		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
-		/* No message sent over the air for broadcast */
-		setup->id = 0;
-		setup->config_pending = false;
-
 		if (ep->data->service)
 			service_set_connecting(ep->data->service);
-
-		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+		break;
 	}
 
 	return NULL;
@@ -1436,11 +1449,14 @@ static struct bap_ep *ep_register(struct btd_service *service,
 	return ep;
 }
 
-static void setup_config(void *data, void *user_data)
+static int setup_config(struct bap_setup *setup, bap_setup_ready_func_t cb,
+								void *user_data)
 {
-	struct bap_setup *setup = data;
 	struct bap_ep *ep = setup->ep;
 
+	if (setup->readying)
+		return -EBUSY;
+
 	DBG("setup %p caps %p metadata %p", setup, setup->caps,
 						setup->metadata);
 
@@ -1454,27 +1470,49 @@ static void setup_config(void *data, void *user_data)
 		bt_bap_stream_lock(setup->stream);
 	}
 
-	setup->config_pending = true;
+	bt_bap_stream_set_user_data(setup->stream, ep->path);
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
 						setup->caps, config_cb, setup);
-	if (!setup->id) {
-		DBG("Unable to config stream");
-		setup_free(setup);
-		return;
+	if (!setup->id)
+		return -EINVAL;
+
+	switch (bt_bap_stream_get_type(setup->stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		setup->config_pending = true;
+		break;
+	case BT_BAP_STREAM_TYPE_BCAST:
+		/* Broadcast does not call the callback */
+		setup->id = 0;
+		break;
 	}
 
 	if (setup->metadata && setup->metadata->iov_len)
 		bt_bap_stream_metadata(setup->stream, setup->metadata, NULL,
 								NULL);
 
-	bt_bap_stream_set_user_data(setup->stream, ep->path);
+	setup->readying = true;
+	setup->ready_cb = cb;
+	setup->ready_cb_data = user_data;
+
+	return 0;
+}
+
+static void bap_config_setup(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+
+	if (setup_config(setup, NULL, NULL)) {
+		DBG("Unable to config stream");
+		setup_free(setup);
+		return;
+	}
 }
 
 static void bap_config(void *data, void *user_data)
 {
 	struct bap_ep *ep = data;
 
-	queue_foreach(ep->setups, setup_config, NULL);
+	queue_foreach(ep->setups, bap_config_setup, NULL);
 }
 
 static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
@@ -2240,11 +2278,18 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (setup) {
 			setup->config_pending = false;
-			setup_qos(setup);
+			if (!setup->id) {
+				int err = setup_qos(setup);
+
+				if (err)
+					setup_ready(setup, err, 0);
+			}
 		}
 		break;
 	case BT_BAP_STREAM_STATE_QOS:
-			setup_create_io(data, setup, stream, true);
+		setup_create_io(data, setup, stream, true);
+		if (setup)
+			setup_ready(setup, 0, 0);
 		break;
 	case BT_BAP_STREAM_STATE_ENABLING:
 		if (setup)
-- 
2.49.0

