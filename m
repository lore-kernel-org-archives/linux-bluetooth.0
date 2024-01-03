Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641EB1D54E
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRDgFGSM"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5e7bb1e0db8so86223877b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 12:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704315088; x=1704919888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rd2b6WtBWynbDtawF7eRNdVNwjMiWbpY3nxgkeSaQzo=;
        b=NRDgFGSMC7cHcZqstr2PbdgBO5TSVH4HKGcN4pQlfTaWyA/GiJrGe4K9SpQpafjbXz
         eYSrIKyInn/1BqNblKVaUfkLQeJWSis4ARkr8ZWpQhr1uz/owCLQDooGRzoTihjL9sQE
         6EMJlwvHqFC201EcqPHfqV0VYf+1dSfevtxqq3EWPIupKOk/0OObwyftRd3jPGOUEVn7
         ziSRA3WYaJxLkrkTJ7TSkSB9CiJ53f59/IR37dcGCIZlFjpNoKiRXEy1K3j8s7L9ctl5
         X++TD9wHBGqMVz+zC7Pcm3M4EL/npGccUlI4V9ikDW+yfWUdWYOxTWLNzkckrsDEOORU
         uDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315088; x=1704919888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rd2b6WtBWynbDtawF7eRNdVNwjMiWbpY3nxgkeSaQzo=;
        b=eyARTxUAsEuIPTDBj/RhL/9VC0P2FQX/vEQvblAPLzn+rg59+2SVUOGz32jsd+JqPf
         LbfyCoJIZJpnynrVlnJEG1A585p6aRY5WX+T3P5DGtlTCjnt+Yj3mvx4nQcZdOvtGpJ7
         7b8HLgDHdMjDKW3Vjwe+pOYyqyu0t5hex1b3DWGJHfh0GbrkF4pcGNFmqQa2m7K7QF+b
         R+SSlpxh6ZVt+XcXSdH8F8V7ZxHHIJA6ZHqztfdi16q2acsHi2To1EETTfrcCTi5gaiD
         p425Lk242ImPD2xJwVwvYMiIaIMb9/R7rrow8uLThCySPf5MPNxcaYs386CkFiVZKw+I
         zDZw==
X-Gm-Message-State: AOJu0Yzn0WCRr3XgQ2WAeOidwhU00Td6A+08iPfew0hnOSk+kJCB6fgN
	B6QmQ+xHQXsGQF870JGxi1ISnGLoKPk=
X-Google-Smtp-Source: AGHT+IEqWXOkcLe+ftFAOBKUC22ZQG43ijCqAZyuKQW8Gk4YHT0fCEFxeR1sL7TbHueirTe9D+N1Jw==
X-Received: by 2002:a0d:e284:0:b0:5e8:298c:aae5 with SMTP id l126-20020a0de284000000b005e8298caae5mr14573616ywe.35.1704315088308;
        Wed, 03 Jan 2024 12:51:28 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id d13-20020a81ab4d000000b005e71fbbc661sm12997084ywk.143.2024.01.03.12.51.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:51:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] audio/transport: Refactor transport operations
Date: Wed,  3 Jan 2024 15:51:23 -0500
Message-ID: <20240103205124.3839768-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103205124.3839768-1-luiz.dentz@gmail.com>
References: <20240103205124.3839768-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This creates a struct to hold the profile specific operations to avoid
having to check UUID, etc, to determine how to proceed with each
operation, it also attempts to decouple volume logic from A2DP
transports since it should be possible to support it on devices
implementing LE Audio as well.
---
 profiles/audio/transport.c | 428 ++++++++++++++++++++++++-------------
 profiles/audio/transport.h |   3 +-
 2 files changed, 283 insertions(+), 148 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 0c60f06eef36..64b6ec694eb8 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -79,6 +79,7 @@ struct a2dp_transport {
 	struct avdtp		*session;
 	uint16_t		delay;
 	int8_t			volume;
+	guint			watch;
 };
 
 struct bap_transport {
@@ -89,6 +90,23 @@ struct bap_transport {
 	guint			resume_id;
 };
 
+struct media_transport_ops {
+	const char *uuid;
+	const GDBusPropertyTable *properties;
+	void *(*init)(struct media_transport *transport, void *stream);
+	guint (*resume)(struct media_transport *transport,
+				struct media_owner *owner);
+	guint (*suspend)(struct media_transport *transport,
+				struct media_owner *owner);
+	void (*cancel)(struct media_transport *transport, guint id);
+	void (*set_state)(struct media_transport *transport,
+				transport_state_t state);
+	void *(*get_stream)(struct media_transport *transport);
+	int8_t (*get_volume)(struct media_transport *transport);
+	int (*set_volume)(struct media_transport *transport, int8_t level);
+	GDestroyNotify destroy;
+};
+
 struct media_transport {
 	char			*path;		/* Transport object path */
 	struct btd_device	*device;	/* Transport device */
@@ -102,20 +120,7 @@ struct media_transport {
 	uint16_t		imtu;		/* Transport input mtu */
 	uint16_t		omtu;		/* Transport output mtu */
 	transport_state_t	state;
-	guint			hs_watch;
-	guint			source_watch;
-	guint			sink_watch;
-	guint			(*resume) (struct media_transport *transport,
-					struct media_owner *owner);
-	guint			(*suspend) (struct media_transport *transport,
-					struct media_owner *owner);
-	void			(*cancel) (struct media_transport *transport,
-								guint id);
-	void			(*set_state) (struct media_transport *transport,
-						transport_state_t state);
-	void			*(*get_stream)
-					(struct media_transport *transport);
-	GDestroyNotify		destroy;
+	struct media_transport_ops *ops;
 	void			*data;
 };
 
@@ -198,20 +203,14 @@ static void transport_set_state(struct media_transport *transport,
 						"State");
 
 	/* Update transport specific data */
-	if (transport->set_state)
-		transport->set_state(transport, state);
+	if (transport->ops && transport->ops->set_state)
+		transport->ops->set_state(transport, state);
 }
 
 void media_transport_destroy(struct media_transport *transport)
 {
 	char *path;
 
-	if (transport->sink_watch)
-		sink_remove_state_cb(transport->sink_watch);
-
-	if (transport->source_watch)
-		source_remove_state_cb(transport->source_watch);
-
 	path = g_strdup(transport->path);
 	g_dbus_unregister_interface(btd_get_dbus_connection(), path,
 						MEDIA_TRANSPORT_INTERFACE);
@@ -261,8 +260,8 @@ static void media_owner_remove(struct media_owner *owner)
 	DBG("Owner %s Request %s", owner->name,
 					dbus_message_get_member(req->msg));
 
-	if (req->id)
-		transport->cancel(transport, req->id);
+	if (req->id && transport->ops && transport->ops->cancel)
+		transport->ops->cancel(transport, req->id);
 
 	owner->pending = NULL;
 	if (req->msg)
@@ -297,6 +296,20 @@ static void linked_transport_remove_owner(void *data, void *user_data)
 	transport->owner = NULL;
 }
 
+static guint media_transport_suspend(struct media_transport *transport,
+					struct media_owner *owner)
+{
+	if (!state_in_use(transport->state))
+		return 0;
+
+	DBG("Transport %s Owner %s", transport->path, owner ? owner->name : "");
+
+	if (transport->ops && transport->ops->suspend)
+		return transport->ops->suspend(transport, owner);
+
+	return 0;
+}
+
 static void media_transport_remove_owner(struct media_transport *transport)
 {
 	struct media_owner *owner = transport->owner;
@@ -312,7 +325,7 @@ static void media_transport_remove_owner(struct media_transport *transport)
 		media_request_reply(owner->pending, EIO);
 
 	transport->owner = NULL;
-	if (bap->linked) {
+	if (bap && bap->linked) {
 		struct bt_bap_stream *link;
 
 		link = bt_bap_stream_io_get_link(bap->stream);
@@ -324,8 +337,7 @@ static void media_transport_remove_owner(struct media_transport *transport)
 
 	media_owner_free(owner);
 
-	if (state_in_use(transport->state))
-		transport->suspend(transport, NULL);
+	media_transport_suspend(transport, NULL);
 }
 
 static gboolean media_transport_set_fd(struct media_transport *transport,
@@ -388,7 +400,7 @@ fail:
 	media_transport_remove_owner(transport);
 }
 
-static guint resume_a2dp(struct media_transport *transport,
+static guint transport_a2dp_resume(struct media_transport *transport,
 				struct media_owner *owner)
 {
 	struct a2dp_transport *a2dp = transport->data;
@@ -442,7 +454,7 @@ static void a2dp_suspend_complete(struct avdtp *session, int err,
 	media_transport_remove_owner(transport);
 }
 
-static guint suspend_a2dp(struct media_transport *transport,
+static guint transport_a2dp_suspend(struct media_transport *transport,
 						struct media_owner *owner)
 {
 	struct a2dp_transport *a2dp = transport->data;
@@ -459,11 +471,49 @@ static guint suspend_a2dp(struct media_transport *transport,
 	return 0;
 }
 
-static void cancel_a2dp(struct media_transport *transport, guint id)
+static void transport_a2dp_cancel(struct media_transport *transport, guint id)
 {
 	a2dp_cancel(id);
 }
 
+static int8_t transport_a2dp_get_volume(struct media_transport *transport)
+{
+	struct a2dp_transport *a2dp = transport->data;
+	return a2dp->volume;
+}
+
+static int transport_a2dp_src_set_volume(struct media_transport *transport,
+					int8_t level)
+{
+	struct a2dp_transport *a2dp = transport->data;
+
+	if (a2dp->volume == level)
+		return 0;
+
+	return avrcp_set_volume(transport->device, level, false);
+}
+
+static int transport_a2dp_snk_set_volume(struct media_transport *transport,
+					int8_t level)
+{
+	struct a2dp_transport *a2dp = transport->data;
+	bool notify;
+
+	if (a2dp->volume == level)
+		return 0;
+
+	notify = a2dp->watch ? true : false;
+	if (notify) {
+		a2dp->volume = level;
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"Volume");
+	}
+
+	return avrcp_set_volume(transport->device, level, notify);
+}
+
 static void media_owner_exit(DBusConnection *connection, void *user_data)
 {
 	struct media_owner *owner = user_data;
@@ -534,13 +584,24 @@ static void media_owner_add(struct media_owner *owner,
 	owner->pending = req;
 }
 
-static void *get_stream_bap(struct media_transport *transport)
+static void *transport_bap_get_stream(struct media_transport *transport)
 {
 	struct bap_transport *bap = transport->data;
 
 	return bap->stream;
 }
 
+static guint media_transport_resume(struct media_transport *transport,
+					struct media_owner *owner)
+{
+	DBG("Transport %s Owner %s", transport->path, owner ? owner->name : "");
+
+	if (transport->ops && transport->ops->resume)
+		return transport->ops->resume(transport, owner);
+
+	return 0;
+}
+
 static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -566,7 +627,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 		media_transport_set_owner(transport, owner);
 	}
 
-	id = transport->resume(transport, owner);
+	id = media_transport_resume(transport, owner);
 	if (id == 0) {
 		media_owner_free(owner);
 		return btd_error_not_authorized(msg);
@@ -599,7 +660,7 @@ static DBusMessage *try_acquire(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_not_available(msg);
 
 	owner = media_owner_create(msg);
-	id = transport->resume(transport, owner);
+	id = media_transport_resume(transport, owner);
 	if (id == 0) {
 		media_owner_free(owner);
 		return btd_error_not_authorized(msg);
@@ -617,8 +678,13 @@ static void bap_stop_complete(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	struct media_owner *owner = user_data;
-	struct media_request *req = owner->pending;
-	struct media_transport *transport = owner->transport;
+	struct media_request *req;
+	struct media_transport *transport;
+
+	if (!owner)
+		return;
+
+	req = owner->pending;
 
 	/* Release always succeeds */
 	if (req) {
@@ -627,8 +693,12 @@ static void bap_stop_complete(struct bt_bap_stream *stream,
 		media_owner_remove(owner);
 	}
 
-	transport_set_state(transport, TRANSPORT_STATE_IDLE);
-	media_transport_remove_owner(transport);
+	transport = owner->transport;
+
+	if (transport) {
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+		media_transport_remove_owner(transport);
+	}
 }
 
 static void bap_disable_complete(struct bt_bap_stream *stream,
@@ -665,7 +735,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 
 	transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
 
-	id = transport->suspend(transport, owner);
+	id = media_transport_suspend(transport, owner);
 	if (id == 0) {
 		media_transport_remove_owner(transport);
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
@@ -767,32 +837,59 @@ static gboolean get_delay_reporting(const GDBusPropertyTable *property,
 static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_transport *transport = data;
-	struct a2dp_transport *a2dp = transport->data;
+	int8_t volume;
 
-	return a2dp->volume >= 0;
+	if (media_transport_get_volume(transport, &volume))
+		return FALSE;
+
+	return volume >= 0;
+}
+
+int media_transport_get_volume(struct media_transport *transport,
+					int8_t *volume)
+{
+	if (transport->ops && transport->ops->get_volume) {
+		*volume = transport->ops->get_volume(transport);
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static gboolean get_volume(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_transport *transport = data;
-	struct a2dp_transport *a2dp = transport->data;
-	uint16_t volume = (uint16_t)a2dp->volume;
+	int8_t level;
+	uint16_t volume;
+
+	if (media_transport_get_volume(transport, &level))
+		return FALSE;
+
+	volume = level;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &volume);
 
 	return TRUE;
 }
 
+static int media_transport_set_volume(struct media_transport *transport,
+					int8_t level)
+{
+	DBG("Transport %s level %d", transport->path, level);
+
+	if (transport->ops && transport->ops->set_volume)
+		return transport->ops->set_volume(transport, level);
+
+	return 0;
+}
+
 static void set_volume(const GDBusPropertyTable *property,
 			DBusMessageIter *iter, GDBusPendingPropertySet id,
 			void *data)
 {
 	struct media_transport *transport = data;
-	struct a2dp_transport *a2dp = transport->data;
 	uint16_t arg;
-	int8_t volume;
-	bool notify;
 	int err;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16) {
@@ -810,26 +907,13 @@ static void set_volume(const GDBusPropertyTable *property,
 		return;
 	}
 
-	volume = (int8_t)arg;
-	if (a2dp->volume == volume)
-		return;
-
-	notify = transport->source_watch ? true : false;
-	if (notify) {
-		a2dp->volume = volume;
-		g_dbus_emit_property_changed(btd_get_dbus_connection(),
-						transport->path,
-						MEDIA_TRANSPORT_INTERFACE,
-						"Volume");
-	}
-
-	err = avrcp_set_volume(transport->device, volume, notify);
+	err = media_transport_set_volume(transport, arg);
 	if (err) {
-		error("avrcp_set_volume returned %s (%d)", strerror(-err), err);
+		error("Unable to set volume: %s (%d)", strerror(-err), err);
 		g_dbus_pending_property_error(id,
-				ERROR_INTERFACE ".Failed",
-				"Internal error %s (%d)",
-				strerror(-err), err);
+						ERROR_INTERFACE ".Failed",
+						"Internal error %s (%d)",
+						strerror(-err), err);
 		return;
 	}
 
@@ -869,7 +953,7 @@ static const GDBusMethodTable transport_methods[] = {
 	{ },
 };
 
-static const GDBusPropertyTable a2dp_properties[] = {
+static const GDBusPropertyTable transport_a2dp_properties[] = {
 	{ "Device", "o", get_device },
 	{ "UUID", "s", get_uuid },
 	{ "Codec", "y", get_codec },
@@ -1008,7 +1092,7 @@ static gboolean qos_ucast_exists(const GDBusPropertyTable *property, void *data)
 	return bap->qos.ucast.io_qos.phy != 0x00;
 }
 
-static const GDBusPropertyTable bap_ucast_properties[] = {
+static const GDBusPropertyTable transport_bap_uc_properties[] = {
 	{ "Device", "o", get_device },
 	{ "UUID", "s", get_uuid },
 	{ "Codec", "y", get_codec },
@@ -1078,7 +1162,7 @@ static gboolean qos_bcast_exists(const GDBusPropertyTable *property, void *data)
 	return bap->qos.bcast.io_qos.phy != 0x00;
 }
 
-static const GDBusPropertyTable bap_bcast_properties[] = {
+static const GDBusPropertyTable transport_bap_bc_properties[] = {
 	{ "Device", "o", get_device },
 	{ "UUID", "s", get_uuid },
 	{ "Codec", "y", get_codec },
@@ -1091,14 +1175,34 @@ static const GDBusPropertyTable bap_bcast_properties[] = {
 	{ }
 };
 
-static void destroy_a2dp(void *data)
+static void transport_a2dp_destroy(void *data)
 {
 	struct a2dp_transport *a2dp = data;
 
 	if (a2dp->session)
 		avdtp_unref(a2dp->session);
 
-	g_free(a2dp);
+	free(a2dp);
+}
+
+static void transport_a2dp_src_destroy(void *data)
+{
+	struct a2dp_transport *a2dp = data;
+
+	if (a2dp->watch)
+		sink_remove_state_cb(a2dp->watch);
+
+	transport_a2dp_destroy(data);
+}
+
+static void transport_a2dp_snk_destroy(void *data)
+{
+	struct a2dp_transport *a2dp = data;
+
+	if (a2dp->watch)
+		source_remove_state_cb(a2dp->watch);
+
+	transport_a2dp_destroy(data);
 }
 
 static void media_transport_free(void *data)
@@ -1110,8 +1214,8 @@ static void media_transport_free(void *data)
 	if (transport->owner)
 		media_transport_remove_owner(transport);
 
-	if (transport->destroy != NULL)
-		transport->destroy(transport->data);
+	if (transport->ops && transport->ops->destroy)
+		transport->ops->destroy(transport->data);
 
 	g_free(transport->configuration);
 	g_free(transport->path);
@@ -1162,53 +1266,39 @@ static void source_state_changed(struct btd_service *service,
 		transport_update_playing(transport, FALSE);
 }
 
-static int media_transport_init_source(struct media_transport *transport)
+static void *transport_a2dp_src_init(struct media_transport *transport,
+					void *stream)
 {
 	struct btd_service *service;
 	struct a2dp_transport *a2dp;
 
 	service = btd_device_get_service(transport->device, A2DP_SINK_UUID);
-	if (service == NULL)
-		return -EINVAL;
-
-	a2dp = g_new0(struct a2dp_transport, 1);
-
-	transport->resume = resume_a2dp;
-	transport->suspend = suspend_a2dp;
-	transport->cancel = cancel_a2dp;
-	transport->data = a2dp;
-	transport->destroy = destroy_a2dp;
+	if (!service)
+		return NULL;
 
+	a2dp = new0(struct a2dp_transport, 1);
 	a2dp->volume = -1;
-	transport->sink_watch = sink_add_state_cb(service, sink_state_changed,
-								transport);
+	a2dp->watch = sink_add_state_cb(service, sink_state_changed, transport);
 
-	return 0;
+	return a2dp;
 }
 
-static int media_transport_init_sink(struct media_transport *transport)
+static void *transport_a2dp_snk_init(struct media_transport *transport,
+					void *stream)
 {
 	struct btd_service *service;
 	struct a2dp_transport *a2dp;
 
 	service = btd_device_get_service(transport->device, A2DP_SOURCE_UUID);
-	if (service == NULL)
-		return -EINVAL;
-
-	a2dp = g_new0(struct a2dp_transport, 1);
-
-	transport->resume = resume_a2dp;
-	transport->suspend = suspend_a2dp;
-	transport->cancel = cancel_a2dp;
-	transport->data = a2dp;
-	transport->destroy = destroy_a2dp;
+	if (!service)
+		return NULL;
 
+	a2dp = new0(struct a2dp_transport, 1);
 	a2dp->volume = 127;
-	transport->source_watch = source_add_state_cb(service,
-							source_state_changed,
-							transport);
+	a2dp->watch = source_add_state_cb(service, source_state_changed,
+						transport);
 
-	return 0;
+	return a2dp;
 }
 
 static void bap_enable_complete(struct bt_bap_stream *stream,
@@ -1369,7 +1459,7 @@ static void bap_update_bcast_qos(const struct media_transport *transport)
 			"Configuration");
 }
 
-static guint resume_bap(struct media_transport *transport,
+static guint transport_bap_resume(struct media_transport *transport,
 				struct media_owner *owner)
 {
 	struct bap_transport *bap = transport->data;
@@ -1405,7 +1495,7 @@ static guint resume_bap(struct media_transport *transport,
 	return id;
 }
 
-static guint suspend_bap(struct media_transport *transport,
+static guint transport_bap_suspend(struct media_transport *transport,
 				struct media_owner *owner)
 {
 	struct bap_transport *bap = transport->data;
@@ -1432,7 +1522,7 @@ static guint suspend_bap(struct media_transport *transport,
 	return id;
 }
 
-static void cancel_bap(struct media_transport *transport, guint id)
+static void transport_bap_cancel(struct media_transport *transport, guint id)
 {
 	struct bap_transport *bap = transport->data;
 
@@ -1463,7 +1553,7 @@ static void link_set_state(void *data, void *user_data)
 	transport_set_state(transport, state);
 }
 
-static void set_state_bap(struct media_transport *transport,
+static void transport_bap_set_state(struct media_transport *transport,
 					transport_state_t state)
 {
 	struct bap_transport *bap = transport->data;
@@ -1571,7 +1661,7 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 	bap_update_links(transport);
 }
 
-static void free_bap(void *data)
+static void transport_bap_destroy(void *data)
 {
 	struct bap_transport *bap = data;
 
@@ -1580,8 +1670,7 @@ static void free_bap(void *data)
 	free(bap);
 }
 
-static int media_transport_init_bap(struct media_transport *transport,
-							void *stream)
+static void *transport_bap_init(struct media_transport *transport, void *stream)
 {
 	struct bt_bap_qos *qos;
 	struct bap_transport *bap;
@@ -1596,15 +1685,71 @@ static int media_transport_init_bap(struct media_transport *transport,
 						bap_connecting,
 						transport, NULL);
 
-	transport->data = bap;
-	transport->resume = resume_bap;
-	transport->suspend = suspend_bap;
-	transport->cancel = cancel_bap;
-	transport->set_state = set_state_bap;
-	transport->get_stream = get_stream_bap;
-	transport->destroy = free_bap;
+	return bap;
+}
 
-	return 0;
+#define TRANSPORT_OPS(_uuid, _props, _init, _resume, _suspend, _cancel, \
+		      _set_state, _get_stream, _get_volume, _set_volume, \
+		      _destroy) \
+{ \
+	.uuid = _uuid, \
+	.properties = _props, \
+	.init = _init, \
+	.resume = _resume, \
+	.suspend = _suspend, \
+	.cancel = _cancel, \
+	.set_state = _set_state, \
+	.get_stream = _get_stream, \
+	.get_volume = _get_volume, \
+	.set_volume = _set_volume, \
+	.destroy = _destroy \
+}
+
+#define A2DP_OPS(_uuid, _init, _set_volume, _destroy) \
+	TRANSPORT_OPS(_uuid, transport_a2dp_properties, _init, \
+			transport_a2dp_resume, transport_a2dp_suspend, \
+			transport_a2dp_cancel, NULL, NULL, \
+			transport_a2dp_get_volume, _set_volume, \
+			_destroy)
+
+#define BAP_OPS(_uuid, _props) \
+	TRANSPORT_OPS(_uuid, _props, transport_bap_init, \
+			transport_bap_resume, transport_bap_suspend, \
+			transport_bap_cancel, transport_bap_set_state, \
+			transport_bap_get_stream, NULL, NULL, \
+			transport_bap_destroy)
+
+#define BAP_UC_OPS(_uuid) \
+	BAP_OPS(_uuid, transport_bap_uc_properties)
+
+#define BAP_BC_OPS(_uuid) \
+	BAP_OPS(_uuid, transport_bap_bc_properties)
+
+static struct media_transport_ops transport_ops[] = {
+	A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
+			transport_a2dp_src_set_volume,
+			transport_a2dp_src_destroy),
+	A2DP_OPS(A2DP_SINK_UUID, transport_a2dp_snk_init,
+			transport_a2dp_snk_set_volume,
+			transport_a2dp_snk_destroy),
+	BAP_UC_OPS(PAC_SOURCE_UUID),
+	BAP_UC_OPS(PAC_SINK_UUID),
+	BAP_BC_OPS(BCAA_SERVICE_UUID),
+	BAP_BC_OPS(BAA_SERVICE_UUID),
+};
+
+static struct media_transport_ops *media_transport_find_ops(const char *uuid)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(transport_ops); i++) {
+		struct media_transport_ops *ops = &transport_ops[i];
+
+		if (!strcasecmp(uuid, ops->uuid))
+			return ops;
+	}
+
+	return NULL;
 }
 
 struct media_transport *media_transport_create(struct btd_device *device,
@@ -1615,9 +1760,8 @@ struct media_transport *media_transport_create(struct btd_device *device,
 {
 	struct media_endpoint *endpoint = data;
 	struct media_transport *transport;
-	const char *uuid;
+	struct media_transport_ops *ops;
 	static int fd = 0;
-	const GDBusPropertyTable *properties;
 
 	transport = g_new0(struct media_transport, 1);
 	if (device)
@@ -1642,31 +1786,21 @@ struct media_transport *media_transport_create(struct btd_device *device,
 					fd++);
 	transport->fd = -1;
 
-	uuid = media_endpoint_get_uuid(endpoint);
-	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0) {
-		if (media_transport_init_source(transport) < 0)
-			goto fail;
-		properties = a2dp_properties;
-	} else if (strcasecmp(uuid, A2DP_SINK_UUID) == 0) {
-		if (media_transport_init_sink(transport) < 0)
-			goto fail;
-		properties = a2dp_properties;
-	} else if (!strcasecmp(uuid, PAC_SINK_UUID) ||
-				!strcasecmp(uuid, PAC_SOURCE_UUID)) {
-		if (media_transport_init_bap(transport, stream) < 0)
-			goto fail;
-		properties = bap_ucast_properties;
-	} else if (!strcasecmp(uuid, BCAA_SERVICE_UUID) ||
-				!strcasecmp(uuid, BAA_SERVICE_UUID)) {
-		if (media_transport_init_bap(transport, stream) < 0)
-			goto fail;
-		properties = bap_bcast_properties;
-	} else
+	ops = media_transport_find_ops(media_endpoint_get_uuid(endpoint));
+	if (!ops)
 		goto fail;
 
+	transport->ops = ops;
+
+	if (ops->init) {
+		transport->data = ops->init(transport, stream);
+		if (!transport->data)
+			goto fail;
+	}
+
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 				transport->path, MEDIA_TRANSPORT_INTERFACE,
-				transport_methods, NULL, properties,
+				transport_methods, NULL, ops->properties,
 				transport, media_transport_free) == FALSE) {
 		error("Could not register transport %s", transport->path);
 		goto fail;
@@ -1688,8 +1822,8 @@ const char *media_transport_get_path(struct media_transport *transport)
 
 void *media_transport_get_stream(struct media_transport *transport)
 {
-	if (transport->get_stream)
-		return transport->get_stream(transport);
+	if (transport->ops && transport->ops->get_stream)
+		return transport->ops->get_stream(transport);
 
 	return NULL;
 }
@@ -1715,12 +1849,6 @@ struct btd_device *media_transport_get_dev(struct media_transport *transport)
 	return transport->device;
 }
 
-int8_t media_transport_get_volume(struct media_transport *transport)
-{
-	struct a2dp_transport *a2dp = transport->data;
-	return a2dp->volume;
-}
-
 void media_transport_update_volume(struct media_transport *transport,
 								int8_t volume)
 {
@@ -1754,8 +1882,14 @@ int8_t media_transport_get_device_volume(struct btd_device *dev)
 			continue;
 
 		/* Volume is A2DP only */
-		if (media_endpoint_get_sep(transport->endpoint))
-			return media_transport_get_volume(transport);
+		if (media_endpoint_get_sep(transport->endpoint)) {
+			int8_t volume;
+
+			if (!media_transport_get_volume(transport, &volume))
+				return volume;
+
+			return -1;
+		}
 	}
 
 	/* If transport volume doesn't exists use device_volume */
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index 5ca9b8f9eca9..b46bc8025418 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -21,7 +21,8 @@ void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
 void *media_transport_get_stream(struct media_transport *transport);
 struct btd_device *media_transport_get_dev(struct media_transport *transport);
-int8_t media_transport_get_volume(struct media_transport *transport);
+int media_transport_get_volume(struct media_transport *transport,
+					int8_t *volume);
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
 void media_transport_update_volume(struct media_transport *transport,
-- 
2.43.0

