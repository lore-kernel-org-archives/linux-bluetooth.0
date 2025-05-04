Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A320A1DE4C3
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374543; cv=pass; b=jAL7c2hK37ueMPHZ2dS8MT/sB1ocPr+8KnNbEo/MtdqIL4VPGYqtLNjGqTQBsWhEu9lsn5wmVSeDVKLH3+KFOk1XveWJqdlw9LoAj1M6RDqiixL/TN6lZDl05VEliy8xYmP5PAvOcX2Ar7wwaRQEMrRR3BlLlAtf4sqpXZ1Apes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374543; c=relaxed/simple;
	bh=QvvS8q98VXG7s65wbCS5q/NtvsC/L66+sEXrKrH+bMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jS8io/p3FlUT2S5rjtX1B890q8FidP5su4gVfjw1UM9HrFADhRryQxIWHSt46OLY1l9xNy0yVxxC9GtzCGNPy54PD6IhRlmCld7uHOemzqtj/3XUfk0Y3RgVCwiqWfZbnsJDefXt8OHGwaIjQ/31jPXFKwl2AwUQMQQKK+gBd/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=q+5J2V2e; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="q+5J2V2e"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zr8Yd2K8HzyhK;
	Sun,  4 May 2025 19:02:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1746374533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bssVK4Ujy1bynopl6RC4C98wlF4R/1WwZP8kRyJLpk=;
	b=q+5J2V2eS3lLQP8GlBgUvALIxixHQcxACUqXwP+/pfO4MK20qT4K1ZedFOaQv7/0E9tIS/
	Ra+YRZ/EsFRRtAZAfafZlmslGeNbKYX3eqWqAG54xqbnV+54RL/N5zlBgEnaNP+689IgR9
	AAU+CKQL2AeGAiru38TInO+rCbrwdIg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1746374533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bssVK4Ujy1bynopl6RC4C98wlF4R/1WwZP8kRyJLpk=;
	b=YT8BXX34KLKEMoqQYOxCqU7Zfr3NtpVVS0NhHKoxMovbIUYRAwRR9jCc3Ot+tZdd+Ft9EZ
	4Sm9CBv9lcIeYIIPvUUPNY0AgsOBOm805CJ2wGAbZXlevNUGIsv6fwYVkBlpoTq90QLgWu
	Vq4nsrzWr9LFKcS3JNiWa1PataOkwIg=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1746374533; a=rsa-sha256; cv=none;
	b=dPrUWs62oe7g955aK5Ox5ueC3HqhNLTCHm9dCXo+z/j8TzJNi1+eEQqS9k+7jcGFsDwF0I
	LQ6wJXWTvS/nZTblF3T0Cr3zcBF0YSKXAg/ZsQtP3rxKf/fKlXscZSCArmcQvNBZWPP6hZ
	6eby24RV5NDHLvnqggIGQ7f9g0a9ktI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ v2 07/11] bap: add ready callback for setup configuration
Date: Sun,  4 May 2025 19:01:59 +0300
Message-ID: <bae19b94aff35eb487779cd3d3ac4d711c3c212d.1746374514.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
References: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
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
 profiles/audio/bap.c | 176 +++++++++++++++++++++++++++----------------
 1 file changed, 110 insertions(+), 66 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 9b3bd405f..64dee8f9d 100644
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
@@ -80,7 +85,8 @@ struct bap_setup {
 	struct iovec *metadata;
 	unsigned int id;
 	struct iovec *base;
-	DBusMessage *msg;
+	bap_setup_ready_func_t ready_cb;
+	void *ready_cb_data;
 	void (*destroy)(struct bap_setup *setup);
 };
 
@@ -116,6 +122,10 @@ struct bap_data {
 
 static struct queue *sessions;
 
+static int setup_config(struct bap_setup *setup, bap_setup_ready_func_t cb,
+							void *user_data);
+
+
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
 {
 	if (!data)
@@ -697,28 +707,28 @@ fail:
 	return -EINVAL;
 }
 
+static void setup_ready(struct bap_setup *setup, int code,
+							uint8_t reason)
+{
+	if (!setup->ready_cb)
+		return;
+
+	setup->ready_cb(setup, code, reason, setup->ready_cb_data);
+	setup->ready_cb = NULL;
+	setup->ready_cb_data = NULL;
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
@@ -766,26 +776,19 @@ static void config_cb(struct bt_bap_stream *stream,
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
@@ -864,22 +867,16 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
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
 
@@ -974,6 +971,34 @@ static bool setup_mismatch_qos(const void *data, const void *user_data)
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
+	if (!data->msg) {
+		free(data);
+		return;
+	}
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
@@ -981,6 +1006,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	struct bap_setup *setup;
 	const char *path;
 	DBusMessageIter args, props;
+	struct set_configuration_data *cbdata;
 
 	dbus_message_iter_init(msg, &args);
 
@@ -1015,35 +1041,22 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 			return btd_error_invalid_args(msg);
 		}
 
-	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
-						&setup->qos, setup->caps);
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
@@ -1421,11 +1434,17 @@ static struct bap_ep *ep_register(struct btd_service *service,
 	return ep;
 }
 
-static void setup_config(void *data, void *user_data)
+static int setup_config(struct bap_setup *setup, bap_setup_ready_func_t cb,
+								void *user_data)
 {
-	struct bap_setup *setup = data;
 	struct bap_ep *ep = setup->ep;
 
+	if (setup->ready_cb)
+		return -EBUSY;
+
+	setup->ready_cb = cb;
+	setup->ready_cb_data = user_data;
+
 	DBG("setup %p caps %p metadata %p", setup, setup->caps,
 						setup->metadata);
 
@@ -1437,27 +1456,45 @@ static void setup_config(void *data, void *user_data)
 						ep->rpac, &setup->qos,
 						setup->caps);
 
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
@@ -2223,11 +2260,18 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
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

