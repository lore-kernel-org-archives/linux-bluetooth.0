Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4E1E285A
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844681; cv=pass; b=UETDuDzY6tuJ4lqx9vZZIglMIvPbudarirlK8UbW3vkzmJxv/WqkZj7Tjv/gbM+zBCLtnS/9os2ayEPmVAH3roMtdnCDF21ufioK3DiphDInJBA/dxT+oBddYCxt2EMsNlbMW5/jacvQsHqWMeUzTAAOjsgPWvjWBgs3sKCU2rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844681; c=relaxed/simple;
	bh=vIg5Wo2MwRmGMKyYqZxwYahlHiwW3HGGanheFgL4WtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0BcieEyECTmDak2oq8PUy6TPEt0WroInlZ1ddnwktAZnoQBRlSlkdZ8UIXvI8+1Poe9yK6YACMXA2kIAIDYDO/xgN5bakBXLP6I2O4vwiJib9aH4MXmCRMglHdx+05inoKr/2e9liyC1Wlumi4ora+OuW7ZbiIfZjpj0RtMqSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=thCTmmgI; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="thCTmmgI"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z4qV90C44z4BKHF;
	Sat,  1 Mar 2025 17:57:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740844673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+nOXp3SXEFlsKyjS0lckZ0r6L7Oib3YPvbadYF+QJ8=;
	b=thCTmmgIn/lWV3rcO/Tl1qWaIHsHU7c5dIobw9USJu41DvvOEoO0Jc2iXZ8hR5KuPwvSOo
	fEt63CmZdUFYHHbkN8msQeukSu40YwqQJ6gImD/yPTXKOwJI6LjaOd5cf84peUiMO4kViQ
	WJJRokAOtAGFkLXwaTVGcxXQ8/E++9AGuKuYZ3pErJ0hTsl9qsVQUAzAcpKh6cDpphBT2g
	lOvmhig1nPhDhBXnZQtlughfEGl9ipmvvONUMyvt7oOqKANxXX9jVIbP6I5Bh4nfr7pcip
	LYxZp5Wz1xLeIubP1y1LoNGr3PZCrT8hBoqAJb7XGAIVcEW08BvqB/nplJTfaw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740844673; a=rsa-sha256;
	cv=none;
	b=sKNGKRGhQk3L2K+jpw5Z09Hq7ashOkg6Z/EYcaPFm5NwPzrFDgkjbqsgDXIstTccY1NLLF
	U0z5cglHDa3LfL4jkU2GMUGQOQMKspeHtdsgyn/q2dqRYvEzGUjpgAHnMa1uZkIW7pu1AN
	N/KAiIfLqFwSFP1rdlaDtOSzbv7QY1mam37jRQ2AOpRoeNmbFYz90rKmjQiUtOsqSh9coS
	7fiaobZhsnUbTOZam5bIbfai8EhpfUxa2WllaIDB0+Mbk5wZ6Zh4ziriHmaTM4kv3rJ/EM
	3PAjBFkHLQRXKgnFaWqU8ZXDZKGR8J12DsH6TeShvmg1jBfPpWCYJ/kBlft/jA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740844673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+nOXp3SXEFlsKyjS0lckZ0r6L7Oib3YPvbadYF+QJ8=;
	b=o7dBVWlfw/MEZw6LBfElB48CtV9a+BnV2mxqOAOtzy/ljkxDyvui9PBrAdMACiDnhEzsqG
	PE7izY5qiYjmA7lWblXjL64trbV6UCX1qHKcPnSvHWP7SU4tolE6fdOm0J4aAFyWeQ/5dE
	REMvCMYrP3t2N9PX1Nx24ifF7j+LqDGlVGXGrN6n0Iyz86Vqs3Zqe5paFCNdLx0xVREbTn
	ztQehK3g6bOKLfUVx1fHmt56S6oSNW034DZ/Dk3qTAgsBvYh5nY90XmLrLg7Jpz2LzkN/e
	TrhvFah15Pgl9XlX2k9UP3R+FRAvPGWahyk06h0p2WEGV1dz5NOHFz+BxeuFRQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 9/9] bap: implement client role SelectProperties()
Date: Sat,  1 Mar 2025 17:57:40 +0200
Message-ID: <29374a3f670ddd80af0f87a2ecc27b5d3e64f03c.1740844617.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740844616.git.pav@iki.fi>
References: <cover.1740844616.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SelectProperties() on a BAP unicast endpoint, which triggers its
reconfiguration or marks it for reconfiguration.

First, all associated streams are closed. After that, endpoints marked
for reconfiguration are reconfigured using the same flow as in the
initial configuration.
---
 profiles/audio/bap.c | 180 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 166 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index da1f9feb1..0590067eb 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -96,8 +96,10 @@ struct bap_ep {
 	uint16_t supported_context;
 	uint16_t context;
 	struct queue *setups;
+	struct future *setup_done;
 	struct future *select_done;
 	int selecting;
+	bool reconfigure;
 };
 
 struct bap_data {
@@ -170,7 +172,8 @@ struct bt_iso_qos bap_sink_pa_qos = {
 	}
 };
 
-static void pac_select_all(struct bap_data *data);
+static void pac_select_all(struct bap_data *data, bool reconfigure,
+							struct future *done);
 
 static void future_clear(struct future **p, int err, const char *err_msg)
 {
@@ -849,7 +852,8 @@ static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
 
 	setup->id = 0;
 
-	future_clear(&setup->qos_done, code ? EIO : 0, "Unable to configure");
+	if (code)
+		future_clear(&setup->qos_done, EIO, "Unable to configure");
 }
 
 static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
@@ -1227,6 +1231,120 @@ static DBusMessage *clear_configuration(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static void ep_close_if_reconfigure(void *obj, void *user_data)
+{
+	struct bap_ep *ep = obj;
+	struct future *done = user_data;
+
+	if (ep->reconfigure)
+		ep_close(ep, done);
+}
+
+static int select_properties_parse(DBusMessageIter *props, bool *defer)
+{
+	const char *key;
+
+	if (dbus_message_iter_get_arg_type(props) != DBUS_TYPE_DICT_ENTRY)
+		return -EINVAL;
+
+	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(props, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+
+		if (!strcasecmp(key, "Defer")) {
+			dbus_bool_t flag;
+
+			if (var != DBUS_TYPE_BOOLEAN)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &flag);
+			*defer = flag;
+		}
+
+		dbus_message_iter_next(props);
+	}
+
+	return 0;
+
+fail:
+	DBG("Failed parsing %s", key);
+
+	return -EINVAL;
+}
+
+struct select_properties_data {
+	struct bap_data *data;
+	DBusMessage *msg;
+};
+
+static void select_properties_reconfig(int err, const char *err_msg, void *data)
+{
+	struct select_properties_data *info = data;
+	struct future *done = NULL;
+
+	future_init_dbus_reply(&done, "select_properties_reconfig", info->msg);
+	dbus_message_unref(info->msg);
+
+	/* Reconfigure endpoints using the same flow as for initial config */
+	if (!err)
+		pac_select_all(info->data, true, done);
+
+	future_clear(&done, err, err_msg);
+
+	free(info);
+}
+
+static DBusMessage *select_properties(DBusConnection *conn, DBusMessage *msg,
+								void *user_data)
+{
+	struct bap_ep *ep = user_data;
+	struct bap_data *data = ep->data;
+	struct select_properties_data *info;
+	struct future *done = NULL;
+	bool defer = false;
+	DBusMessageIter args, props;
+
+	switch (bt_bap_pac_get_type(ep->lpac)) {
+	case BT_BAP_SOURCE:
+	case BT_BAP_SINK:
+		break;
+	default:
+		return btd_error_invalid_args(msg);
+	}
+
+	dbus_message_iter_init(msg, &args);
+	dbus_message_iter_recurse(&args, &props);
+	if (select_properties_parse(&props, &defer))
+		return btd_error_invalid_args(msg);
+
+	DBG("%s defer %d", ep->path, (int)defer);
+
+	ep->reconfigure = true;
+	if (defer)
+		return dbus_message_new_method_return(msg);
+
+	info = new0(struct select_properties_data, 1);
+	info->data = ep->data;
+	info->msg = dbus_message_ref(msg);
+
+	future_init(&done, "select_properties", select_properties_reconfig,
+									info);
+
+	queue_foreach(data->snks, ep_close_if_reconfigure, done);
+	queue_foreach(data->srcs, ep_close_if_reconfigure, done);
+
+	future_clear(&done, 0, NULL);
+	return NULL;
+}
+
 static bool stream_io_unset(const void *data, const void *user_data)
 {
 	struct bt_bap_stream *stream = (struct bt_bap_stream *)data;
@@ -1451,6 +1569,10 @@ static const GDBusMethodTable ep_methods[] = {
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ClearConfiguration",
 					GDBUS_ARGS({ "transport", "o" }),
 					NULL, clear_configuration) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("SelectProperties",
+					GDBUS_ARGS(
+						{ "Properties", "a{sv}" }),
+					NULL, select_properties) },
 	{ },
 };
 
@@ -1684,13 +1806,6 @@ static void setup_config(void *data, void *user_data)
 	bt_bap_stream_set_user_data(setup->stream, ep->path);
 }
 
-static void bap_config(void *data, void *user_data)
-{
-	struct bap_ep *ep = data;
-
-	queue_foreach(ep->setups, setup_config, NULL);
-}
-
 static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 				struct iovec *metadata, struct bt_bap_qos *qos,
 				void *user_data)
@@ -1707,13 +1822,16 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 	setup->caps = util_iov_dup(caps, 1);
 	setup->metadata = util_iov_dup(metadata, 1);
 	setup->qos = *qos;
+	future_init_chain(&setup->qos_done, ep->setup_done);
 
 done:
 	DBG("ep %p selecting %d", ep, ep->selecting);
 
 	ep->selecting--;
-	if (!ep->selecting)
+	if (!ep->selecting) {
+		future_clear(&ep->setup_done, 0, NULL);
 		future_clear(&ep->select_done, 0, NULL);
+	}
 }
 
 static bool pac_register(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -1734,6 +1852,8 @@ static bool pac_register(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 struct pac_select_data {
 	struct bap_data *data;
 	struct future *select_done;
+	struct future *setup_done;
+	bool reconfigure;
 };
 
 static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -1763,12 +1883,21 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		return true;
 	}
 
+	if (select_data->reconfigure) {
+		if (!ep->reconfigure)
+			return true;
+		ep->reconfigure = false;
+	}
+
 	/* TODO: Cache LRU? */
 	if (btd_service_is_initiator(service)) {
 		bt_bap_select(lpac, rpac, &ep->selecting, select_cb, ep);
-		if (ep->selecting)
+		if (ep->selecting) {
 			future_init_chain(&ep->select_done,
 						select_data->select_done);
+			future_init_chain(&ep->setup_done,
+						select_data->setup_done);
+		}
 	}
 
 	return true;
@@ -1788,6 +1917,7 @@ static void ep_cancel_select(struct bap_ep *ep)
 {
 	struct bt_bap *bap = ep->data->bap;
 
+	future_clear(&ep->setup_done, ECANCELED, NULL);
 	future_clear(&ep->select_done, ECANCELED, NULL);
 
 	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_cancel_select, ep);
@@ -1817,6 +1947,21 @@ static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return true;
 }
 
+static void setup_ensure_stream(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+
+	if (!setup->stream)
+		setup_config(setup, user_data);
+}
+
+static void bap_config(void *data, void *user_data)
+{
+	struct bap_ep *ep = data;
+
+	queue_foreach(ep->setups, setup_ensure_stream, NULL);
+}
+
 static void select_complete_cb(int err, const char *err_msg, void *user_data)
 {
 	struct bap_data *data = user_data;
@@ -1828,10 +1973,13 @@ static void select_complete_cb(int err, const char *err_msg, void *user_data)
 	queue_foreach(data->snks, bap_config, NULL);
 }
 
-static void pac_select_all(struct bap_data *data)
+static void pac_select_all(struct bap_data *data, bool reconfigure,
+							struct future *done)
 {
 	struct pac_select_data select_data = {
 		.data = data,
+		.reconfigure = reconfigure,
+		.setup_done = done,
 	};
 
 	future_init(&select_data.select_done, "pac_select_all",
@@ -1856,7 +2004,7 @@ static void bap_ready(struct bt_bap *bap, void *user_data)
 	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_register, service);
 	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_register, service);
 
-	pac_select_all(data);
+	pac_select_all(data, false, NULL);
 }
 
 static bool match_setup_stream(const void *data, const void *user_data)
@@ -2499,7 +2647,11 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		}
 		break;
 	case BT_BAP_STREAM_STATE_QOS:
+		if (setup) {
 			setup_create_io(data, setup, stream, true);
+			future_clear(&setup->qos_done, setup->io ? 0 : EIO,
+							"Unable to configure");
+		}
 		break;
 	case BT_BAP_STREAM_STATE_ENABLING:
 		if (setup)
@@ -2806,7 +2958,7 @@ static void pac_added(struct bt_bap_pac *pac, void *user_data)
 	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_register, service);
 	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_register, service);
 
-	pac_select_all(data);
+	pac_select_all(data, false, NULL);
 }
 
 static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
-- 
2.48.1

