Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD83DC27C47
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Oct 2023 14:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjJ1Ojl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Oct 2023 10:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjJ1Ojk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Oct 2023 10:39:40 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3116ED
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Oct 2023 07:39:36 -0700 (PDT)
Received: from monolith.lan (unknown [185.77.218.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SHhxy5TyGz49Q53;
        Sat, 28 Oct 2023 17:39:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1698503974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PgupAMjxf3FZg7KbfgWCwoQzp7gmc4UrEkOyEJnGf4k=;
        b=KKl896c/XVuEUPis+8DHmFRiW1/Ty+ybQV/G4tHn+lmKApLxq0Y28rvOsI24q6mB+ReyQe
        y8r6o1bO+gTHoc0OzZki6A21nfvJB5rpZajn1hSurY8/GyUmrJvt0IYZEI7jrNumJvNltg
        AslPpo4HqY/QVty+5oit6eEbFOT5v5FeL8SkmxhWSjA8rO2b+NknAlYMdwwfrN+nFkCtYS
        Qvkj3B9d5HCpX5H1b8kz7Wnfsw/BRBIRKWqaGbam6wDuiGGQA073PUfp/G7cycHjm2kn6D
        LNDXNgfiN8km5MpGvX5BMjuw6RR/wzZPk6+k8M5tNcflZe54B8o1DnrE/5lgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1698503974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PgupAMjxf3FZg7KbfgWCwoQzp7gmc4UrEkOyEJnGf4k=;
        b=kJ1jxV7mv5FIVq6PRnl21phJ/li0ZWc21dkevLaiRFdoTYxP280K4JKGU9RJ7lzZRaC77k
        rDe59aiXgIFlXSbS78vTmcwj0lRXs18c80G3ib6UxRI5qlHRpmLnsgHsec444JxLFAyeAY
        ECBLf9TjCZwTLfi8d6Usf6MKaEwaZvIZ77DoFJRYDAe6ylhLEiQMw4SAPTolPRzjRYNiue
        RVJniMEkjbQUeeJPf1BSVri51+RRrFv+oxkpz/llDEgKtM3wdsD6pD5Vclw1CcsVP2su1n
        /HzZFxInJ8U6kw4dTIyUDyQEl4IV6dL0GAbnPCEcPA5Pk60W5JMyKrU+5Rs3Kg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1698503974; a=rsa-sha256;
        cv=none;
        b=vP7qVmBnVXQYuiPuzU79e2JhCbvZk82CVdq4enLF4bu/pcg85W4iiRmdi//e50jg4DB26e
        /d/EKIy6alZM8Lks9DuMH8Q1HihW3fWcWZB99XEiBWxZ+TCLEbU9C8EP390QsHMHXG9lTQ
        EaWMEEGMzNYrrUkoVXWpvUkgdhPXew0G5jDXYrCe8TNwQVVIl6t/YQWwJo2ZumkpjWAAZk
        FlLx2wYbnC+rgqLve7WRoOT6nOgaxo2472Y5ARevz8flpZNVnkv0c3aWYzNteaYQ9BfEBF
        FLmmJ/N0DOS5+jozF120jnjsVTQpaHqSUljlNWPxxLOHi7Gm+0BsneAfjZ9FGA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/4] bap: obtain BAP ucast client QoS via calling endpoint SelectQoS()
Date:   Sat, 28 Oct 2023 17:39:28 +0300
Message-ID: <f1d34641642d675a9e3259c91519a4caa7ffa3fe.1698503903.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <6f03ad1eaaa00f84db8cd6a4a4b88ee83078951d.1698503903.git.pav@iki.fi>
References: <6f03ad1eaaa00f84db8cd6a4a4b88ee83078951d.1698503903.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Enable the client endpoint to implement SelectQoS() to configure
the QoS as a second step in the configuration flow.

Remove the QoS parameter from SelectProperties(), as the values
are not actually know at that point of the configuration flow.

If the client does not implement SelectQoS() we will just use all the
QoS values returned by SelectProperties().  If they are one of the
mandatory configurations, then maybe devices will accept them.
---
 profiles/audio/bap.c   |  98 +++++++++++++-------
 profiles/audio/media.c | 201 +++++++++++++++++++++++++++++++++--------
 2 files changed, 225 insertions(+), 74 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b74498c4c..a289daf15 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -725,23 +725,17 @@ fail:
 	return -EINVAL;
 }
 
-static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
-					void *user_data)
+static void ep_reply_msg(struct bap_ep *ep, const char *error)
 {
-	struct bap_ep *ep = user_data;
 	DBusMessage *reply;
 
-	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
-
-	ep->id = 0;
-
 	if (!ep->msg)
 		return;
 
-	if (!code)
+	if (!error)
 		reply = dbus_message_new_method_return(ep->msg);
 	else
-		reply = btd_error_failed(ep->msg, "Unable to configure");
+		reply = btd_error_failed(ep->msg, error);
 
 	g_dbus_send_message(btd_get_dbus_connection(), reply);
 
@@ -749,28 +743,30 @@ static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
 	ep->msg = NULL;
 }
 
-static void config_cb(struct bt_bap_stream *stream,
-					uint8_t code, uint8_t reason,
+static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
 					void *user_data)
 {
 	struct bap_ep *ep = user_data;
-	DBusMessage *reply;
 
 	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
 
 	ep->id = 0;
 
-	if (!code)
-		return;
+	ep_reply_msg(ep, code ? "Unable to configure" : NULL);
+}
 
-	if (!ep->msg)
-		return;
+static void config_cb(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	struct bap_ep *ep = user_data;
 
-	reply = btd_error_failed(ep->msg, "Unable to configure");
-	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
 
-	dbus_message_unref(ep->msg);
-	ep->msg = NULL;
+	ep->id = 0;
+
+	if (code)
+		ep_reply_msg(ep, "Unable to configure");
 }
 
 static void bap_io_close(struct bap_ep *ep)
@@ -1202,7 +1198,7 @@ static void bap_config(void *data, void *user_data)
 	bt_bap_stream_set_user_data(ep->stream, ep->path);
 }
 
-static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
+static void select_codec_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 				struct iovec *metadata, struct bt_bap_qos *qos,
 				void *user_data)
 {
@@ -1252,7 +1248,7 @@ static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 
 	/* TODO: Cache LRU? */
 	if (btd_service_is_initiator(service)) {
-		if (!bt_bap_select(lpac, rpac, select_cb, ep))
+		if (!bt_bap_select_codec(lpac, rpac, select_codec_cb, ep))
 			ep->data->selecting++;
 	}
 
@@ -1877,6 +1873,36 @@ static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
 	}
 }
 
+static void select_qos_cb(struct bt_bap_stream *stream, int err,
+					struct bt_bap_qos *qos, void *user_data)
+{
+	struct bap_ep *ep = user_data;
+
+	DBG("stream %p err %d qos %p", stream, err, qos);
+
+	if (err || ep->id)
+		goto fail;
+
+	if (qos)
+		ep->qos = *qos;
+
+	bap_create_io(ep->data, ep, stream, true);
+	if (!ep->io) {
+		error("Unable to create io");
+		goto fail;
+	}
+
+	ep->id = bt_bap_stream_qos(stream, &ep->qos, qos_cb, ep);
+	if (!ep->id)
+		goto fail;
+
+	return;
+
+fail:
+	error("Failed to Configure QoS");
+	ep_reply_msg(ep, "Unable to configure");
+}
+
 static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
@@ -1902,25 +1928,27 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-		if (ep && !ep->id) {
+		if (!ep || ep->id)
+			break;
+
+		switch (bt_bap_stream_get_type(stream)) {
+		case BT_BAP_STREAM_TYPE_UCAST:
+			if (bt_bap_stream_select_qos(stream,
+							select_qos_cb, ep)) {
+				error("Failed to Configure QoS");
+				bt_bap_stream_release(stream,
+						NULL, NULL);
+				return;
+			}
+			break;
+		case BT_BAP_STREAM_TYPE_BCAST:
 			bap_create_io(data, ep, stream, true);
 			if (!ep->io) {
 				error("Unable to create io");
 				bt_bap_stream_release(stream, NULL, NULL);
 				return;
 			}
-
-			if (bt_bap_stream_get_type(stream) ==
-					BT_BAP_STREAM_TYPE_UCAST) {
-				/* Wait QoS response to respond */
-				ep->id = bt_bap_stream_qos(stream, &ep->qos,
-								qos_cb,	ep);
-				if (!ep->id) {
-					error("Failed to Configure QoS");
-					bt_bap_stream_release(stream,
-								NULL, NULL);
-				}
-			}
+			break;
 		}
 		break;
 	case BT_BAP_STREAM_STATE_QOS:
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 4d9a6aa03..42bc21386 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -318,6 +318,17 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 
 	dbus_error_init(&err);
 	if (dbus_set_error_from_message(&err, reply)) {
+		/* Endpoint is not required to implement SelectQoS */
+		if (dbus_error_has_name(&err, DBUS_ERROR_UNKNOWN_METHOD) &&
+		    dbus_message_is_method_call(request->msg,
+				    MEDIA_ENDPOINT_INTERFACE, "SelectQoS")) {
+			dbus_error_free(&err);
+			value = FALSE;
+			size = sizeof(value);
+			ret = &value;
+			goto done;
+		}
+
 		error("Endpoint replied with an error: %s",
 				err.name);
 
@@ -358,6 +369,13 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 		dbus_message_iter_recurse(&args, &props);
 		ret = &props;
 		goto done;
+	} else if (dbus_message_is_method_call(request->msg,
+						MEDIA_ENDPOINT_INTERFACE,
+						"SelectQoS")) {
+		dbus_message_iter_init(reply, &args);
+		dbus_message_iter_recurse(&args, &props);
+		ret = &props;
+		goto done;
 	} else if (!dbus_message_get_args(reply, &err, DBUS_TYPE_INVALID)) {
 		error("Wrong reply signature: %s", err.message);
 		dbus_error_free(&err);
@@ -725,9 +743,9 @@ static bool endpoint_init_a2dp_sink(struct media_endpoint *endpoint, int *err)
 	return true;
 }
 
-struct pac_select_data {
+struct pac_select_codec_data {
 	struct bt_bap_pac *pac;
-	bt_bap_pac_select_t cb;
+	bt_bap_pac_select_codec_t cb;
 	void *user_data;
 };
 
@@ -881,10 +899,10 @@ fail:
 	return -EINVAL;
 }
 
-static void pac_select_cb(struct media_endpoint *endpoint, void *ret, int size,
-							void *user_data)
+static void pac_select_codec_cb(struct media_endpoint *endpoint, void *ret,
+						int size, void *user_data)
 {
-	struct pac_select_data *data = user_data;
+	struct pac_select_codec_data *data = user_data;
 	DBusMessageIter *iter = ret;
 	int err;
 	struct iovec caps, meta;
@@ -920,15 +938,15 @@ done:
 	data->cb(data->pac, err, &caps, &meta, &qos, data->user_data);
 }
 
-static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-			struct bt_bap_pac_qos *qos,
-			bt_bap_pac_select_t cb, void *cb_data, void *user_data)
+static int pac_select_codec(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			bt_bap_pac_select_codec_t cb, void *cb_data,
+			void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
 	struct iovec *caps;
 	struct iovec *metadata;
 	const char *endpoint_path;
-	struct pac_select_data *data;
+	struct pac_select_codec_data *data;
 	DBusMessage *msg;
 	DBusMessageIter iter, dict;
 	const char *key = "Capabilities";
@@ -946,7 +964,7 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		return -ENOMEM;
 	}
 
-	data = new0(struct pac_select_data, 1);
+	data = new0(struct pac_select_codec_data, 1);
 	data->pac = lpac;
 	data->cb = cb;
 	data->user_data = cb_data;
@@ -977,47 +995,151 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 						metadata->iov_len);
 	}
 
-	if (qos && qos->phy) {
-		DBusMessageIter entry, variant, qos_dict;
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return media_endpoint_async_call(msg, endpoint, NULL,
+					pac_select_codec_cb, data, free);
+}
+
+struct pac_select_qos_data {
+	struct bt_bap_stream *stream;
+	bt_bap_pac_select_qos_t cb;
+	void *user_data;
+};
+
+static void pac_select_qos_cb(struct media_endpoint *endpoint, void *ret,
+						int size, void *user_data)
+{
+	struct pac_select_qos_data *data = user_data;
+	DBusMessageIter *iter = ret;
+	int err;
+	struct bt_bap_qos qos;
+
+	if (!ret) {
+		data->cb(data->stream, -EPERM, NULL, data->user_data);
+		return;
+	} else if (size > 0) {
+		/* Endpoint doesn't implement the method, use old values */
+		data->cb(data->stream, 0, NULL, data->user_data);
+		return;
+	}
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_DICT_ENTRY) {
+		DBG("Unexpected argument type: %c != %c",
+			    dbus_message_iter_get_arg_type(iter),
+			    DBUS_TYPE_DICT_ENTRY);
+		data->cb(data->stream, -EINVAL, NULL, data->user_data);
+		return;
+	}
+
+	memset(&qos, 0, sizeof(qos));
+
+	/* Mark CIG and CIS to be auto assigned */
+	qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
+	qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
+
+	err = parse_select_properties(iter, NULL, NULL, &qos);
+	if (err < 0)
+		DBG("Unable to parse properties");
+
+	data->cb(data->stream, err, &qos, data->user_data);
+}
 
-		key = "QoS";
-		dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
-								NULL, &entry);
-		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
-		dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
-							"a{sv}", &variant);
-		dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
-							"{sv}", &qos_dict);
+static int pac_select_qos(struct bt_bap_stream *stream,
+			struct bt_bap_pac_qos *qos, bt_bap_pac_select_qos_t cb,
+			void *cb_data, void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+	struct bt_bap_pac *rpac;
+	const char *endpoint_path;
+	struct pac_select_qos_data *data;
+	struct iovec *caps, *metadata;
+	DBusMessage *msg;
+	DBusMessageIter iter, dict;
+	DBusMessageIter entry, variant, qos_dict;
+	const char *key = "Capabilities";
+
+	rpac = bt_bap_stream_get_rpac(stream);
+	if (!rpac)
+		return -EINVAL;
 
-		g_dbus_dict_append_entry(&qos_dict, "Framing", DBUS_TYPE_BYTE,
-							&qos->framing);
+	caps = bt_bap_stream_get_config(stream);
+	if (!caps)
+		return -EINVAL;
 
-		g_dbus_dict_append_entry(&qos_dict, "PHY", DBUS_TYPE_BYTE,
-							&qos->phy);
+	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
+						MEDIA_ENDPOINT_INTERFACE,
+						"SelectQoS");
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return -ENOMEM;
+	}
 
-		g_dbus_dict_append_entry(&qos_dict, "MaximumLatency",
-					DBUS_TYPE_UINT16, &qos->latency);
+	data = new0(struct pac_select_qos_data, 1);
+	data->stream = stream;
+	data->cb = cb;
+	data->user_data = cb_data;
 
-		g_dbus_dict_append_entry(&qos_dict, "MinimumDelay",
-					DBUS_TYPE_UINT32, &qos->pd_min);
+	dbus_message_iter_init_append(msg, &iter);
 
-		g_dbus_dict_append_entry(&qos_dict, "MaximumDelay",
-					DBUS_TYPE_UINT32, &qos->pd_max);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
-		g_dbus_dict_append_entry(&qos_dict, "PreferredMinimumDelay",
-					DBUS_TYPE_UINT32, &qos->ppd_min);
+	endpoint_path = bt_bap_pac_get_user_data(rpac);
+	if (endpoint_path)
+		g_dbus_dict_append_entry(&dict, "Endpoint",
+					DBUS_TYPE_OBJECT_PATH, &endpoint_path);
 
-		g_dbus_dict_append_entry(&qos_dict, "PreferredMaximumDelay",
-					DBUS_TYPE_UINT32, &qos->ppd_max);
+	key = "Capabilities";
+	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
+						DBUS_TYPE_BYTE, &caps->iov_base,
+						caps->iov_len);
 
-		dbus_message_iter_close_container(&variant, &qos_dict);
-		dbus_message_iter_close_container(&entry, &variant);
-		dbus_message_iter_close_container(&dict, &entry);
+	metadata = bt_bap_stream_get_metadata(stream);
+	if (metadata) {
+		key = "Metadata";
+		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
+						DBUS_TYPE_BYTE,
+						&metadata->iov_base,
+						metadata->iov_len);
 	}
 
+	key = "QoS";
+	dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
+			NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+			"a{sv}", &variant);
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+			"{sv}", &qos_dict);
+
+	g_dbus_dict_append_entry(&qos_dict, "Framing", DBUS_TYPE_BYTE,
+			&qos->framing);
+
+	g_dbus_dict_append_entry(&qos_dict, "PHY", DBUS_TYPE_BYTE,
+			&qos->phy);
+
+	g_dbus_dict_append_entry(&qos_dict, "MaximumLatency",
+			DBUS_TYPE_UINT16, &qos->latency);
+
+	g_dbus_dict_append_entry(&qos_dict, "MinimumDelay",
+			DBUS_TYPE_UINT32, &qos->pd_min);
+
+	g_dbus_dict_append_entry(&qos_dict, "MaximumDelay",
+			DBUS_TYPE_UINT32, &qos->pd_max);
+
+	g_dbus_dict_append_entry(&qos_dict, "PreferredMinimumDelay",
+			DBUS_TYPE_UINT32, &qos->ppd_min);
+
+	g_dbus_dict_append_entry(&qos_dict, "PreferredMaximumDelay",
+			DBUS_TYPE_UINT32, &qos->ppd_max);
+
+	dbus_message_iter_close_container(&variant, &qos_dict);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(&dict, &entry);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
-	return media_endpoint_async_call(msg, endpoint, NULL, pac_select_cb,
+	return media_endpoint_async_call(msg, endpoint, NULL, pac_select_qos_cb,
 								data, free);
 }
 
@@ -1187,8 +1309,9 @@ static void pac_clear(struct bt_bap_stream *stream, void *user_data)
 }
 
 static struct bt_bap_pac_ops pac_ops = {
-	.select = pac_select,
+	.select_codec = pac_select_codec,
 	.config = pac_config,
+	.select_qos = pac_select_qos,
 	.clear = pac_clear,
 };
 
-- 
2.41.0

