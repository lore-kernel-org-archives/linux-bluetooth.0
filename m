Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3CADDBE
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228740; cv=none; b=VVpSCVpkYS/1CSQzCE65B+s1/c3hOp+/H1GM074Vc+UfIKEnkDe+U5J+3iMvy+nZBU6l0YpRgrDANXYZnEXLeOhIShzFP0S3NHhLhbOSUbEpdBE5OqAHWTgKK2cyKrJPvJ4r5Wp9GrwCH13bK/0L50uPS/GO0AAC1R/JUqLpm48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228740; c=relaxed/simple;
	bh=i+fQo5x6e7z5uhBKNpvCcPiJOOc3ivMc07rW8/219MA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNV0O3h7VxJfXb6oxlmOPv+KvOwX2hQxsoV3q7U9U20ooT3/UrBbR5uz1K5+IXnvYIVU2VIqtg3d8gnZzKWupFSyKjdAsF8EmyUBeXsK1fX8ELYmAj85zluwpC1nixnfaIMogPoEGq523YQydBJBOSgqdTBa2KT9kAXJ4Y8/Sn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOE8QX9+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOE8QX9+"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9709c9b0cso8156402a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730228736; x=1730833536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KnjR2Nl8KXDmBJ//ZJZ4OoZwyyD7OEMrz/HYEpIpQk=;
        b=KOE8QX9+Tl9Tqqgfyk8V/1BiFxWhkuAgqFLv3+wT6nB2kWDnAMwr5SuUOYu7dLiKTZ
         LjKR4MgjOKePj4dVo2FOWpsXk7n3p2hQ+w6jhzKdm0PmHZdtKLcFYIEFYB/N8/lFcaKG
         gQgVJsBYjxCuaSGZ4TqhXql8cGWPzq7NZwpau+JGZ1DL4xw4VuPxyR+h3l1qME+NhRqP
         b+9PO2GaSpAoEnl3kIHIGJq2c6e/ors6zvcJ/r8/tvcR3NpZXrqbjHMUatIv8HCL01Pi
         YluJwtUHCuEqKQsImZhLvv8vI3V2rUSvk1Ls/SlpdLe9X8gjbuk/IhDj0ctfar2Nof6V
         LdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730228736; x=1730833536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KnjR2Nl8KXDmBJ//ZJZ4OoZwyyD7OEMrz/HYEpIpQk=;
        b=UBzfAoAwK8HKZwl2v/f8TpVbGa9wexXpyjZgt8zCDCgI7ar+Vn1vHsU/E5+k2cCztx
         iRUMB53GPc8nyeXhrFnORLkcLWsFU1EBu21gqrUffRMVGnovG1hijT8A+ZLoIDLoW1r6
         6fpBEvixr2APn22dxure5WmHLwoYR/adWAUYKUK2+GTZMK5OZfaWGDGlwFqM3w4buh7m
         +faZRlct644KXcb3nsLtj9af8Z77R5kTbjTKJIOXRjCKkZ7mM6XwAXMqIv46r2/3Duxl
         zEJs9AGgP2XfPR8iBq5hogsSVzWspJDzkXBFDn3LqDWTAxs95rmFyXOli9vZIvlMmQIg
         1lGQ==
X-Gm-Message-State: AOJu0YwpZqMNiZgmgq2aGVoJROKRE53mhDLEygoSF4YQj12Vxp9KVPXW
	z/d40HboETMBpopCFwq3iu+qg2xajMWhVgQVvv0lIjUKgFShH3InmbhrtQ==
X-Google-Smtp-Source: AGHT+IFfsvKN8zzJBa16h8ORve3Qhcd1BpaHBtDRr2inhbCyTCmPAzWYpf+0X7PTita4uQii3RhN8Q==
X-Received: by 2002:a05:6402:d08:b0:5cb:b68d:8def with SMTP id 4fb4d7f45d1cf-5cd54b1db27mr279967a12.31.1730228734738;
        Tue, 29 Oct 2024 12:05:34 -0700 (PDT)
Received: from raspberrypi.home (46.205.194.156.nat.ftth.dynamic.t-mobile.pl. [46.205.194.156])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6257ba4sm4132557a12.5.2024.10.29.12.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 12:05:33 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ v2] transport: Allow to set A2DP transport delay property
Date: Tue, 29 Oct 2024 20:05:00 +0100
Message-Id: <20241029190500.578032-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAGFh025H4pK9ddaWoGF4CMwv88OTONjBb3U=Cgsb-DU5ZKo3Xg@mail.gmail.com>
References: <CAGFh025H4pK9ddaWoGF4CMwv88OTONjBb3U=Cgsb-DU5ZKo3Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to properly synchronize audio/video playback it is required
to report audio delay to the A2DP source. This commit allows connected
media application to update the Delay property of the A2DP transport
which will inform remote source about the playback delay.

In case when the transport is not acquired, everyone is allowed to set
the delay. However, when the transport is acquired only the owner can
modify the delay. This restriction is here to prevent interference
caused by 3rd party actors.

The functionality was tested by streaming audio between two hosts
running BlueZ Bluetooth stack.
---
 doc/org.bluez.MediaTransport.rst |   3 +-
 gdbus/gdbus.h                    |   1 +
 gdbus/object.c                   |  33 +++++++---
 profiles/audio/transport.c       | 103 ++++++++++++++++++++++++++++---
 4 files changed, 124 insertions(+), 16 deletions(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 4838d69d0..78789bc80 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -119,7 +119,8 @@ uint16 Delay [readwrite, optional]
 ``````````````````````````````````
 
 	Transport delay in 1/10 of millisecond, this property is only writeable
-	when the transport was acquired by the sender.
+	when the transport corresponds to a sink endpoint and it was acquired by
+	the sender.
 
 uint16 Volume [readwrite, optional]
 ```````````````````````````````````
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index d7be17661..c1b182adb 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -308,6 +308,7 @@ guint g_dbus_add_properties_watch(DBusConnection *connection,
 gboolean g_dbus_remove_watch(DBusConnection *connection, guint tag);
 void g_dbus_remove_all_watches(DBusConnection *connection);
 
+const char *g_dbus_pending_property_get_sender(GDBusPendingPropertySet id);
 void g_dbus_pending_property_success(GDBusPendingPropertySet id);
 void g_dbus_pending_property_error_valist(GDBusPendingReply id,
 			const char *name, const char *format, va_list args);
diff --git a/gdbus/object.c b/gdbus/object.c
index 72d2d46e3..e40c7c5bc 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -430,28 +430,45 @@ static gboolean check_privilege(DBusConnection *conn, DBusMessage *msg,
 static GDBusPendingPropertySet next_pending_property = 1;
 static GSList *pending_property_set;
 
+static int pending_property_data_compare_id(const void *data,
+						const void *user_data)
+{
+	const struct property_data *propdata = data;
+	const GDBusPendingPropertySet *id = user_data;
+	return propdata->id - *id;
+}
+
 static struct property_data *remove_pending_property_data(
 						GDBusPendingPropertySet id)
 {
 	struct property_data *propdata;
 	GSList *l;
 
-	for (l = pending_property_set; l != NULL; l = l->next) {
-		propdata = l->data;
-		if (propdata->id != id)
-			continue;
-
-		break;
-	}
-
+	l = g_slist_find_custom(pending_property_set, &id,
+				pending_property_data_compare_id);
 	if (l == NULL)
 		return NULL;
 
+	propdata = l->data;
 	pending_property_set = g_slist_delete_link(pending_property_set, l);
 
 	return propdata;
 }
 
+const char *g_dbus_pending_property_get_sender(GDBusPendingPropertySet id)
+{
+	struct property_data *propdata;
+	GSList *l;
+
+	l = g_slist_find_custom(pending_property_set, &id,
+					pending_property_data_compare_id);
+	if (l == NULL)
+		return NULL;
+
+	propdata = l->data;
+	return dbus_message_get_sender(propdata->message);
+}
+
 void g_dbus_pending_property_success(GDBusPendingPropertySet id)
 {
 	struct property_data *propdata;
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 0f7909a94..dad8604eb 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -116,6 +116,7 @@ struct media_transport_ops {
 	void *(*get_stream)(struct media_transport *transport);
 	int8_t (*get_volume)(struct media_transport *transport);
 	int (*set_volume)(struct media_transport *transport, int8_t level);
+	int (*set_delay)(struct media_transport *transport, uint16_t delay);
 	void (*update_links)(const struct media_transport *transport);
 	GDestroyNotify destroy;
 };
@@ -551,6 +552,36 @@ static int transport_a2dp_snk_set_volume(struct media_transport *transport,
 	return avrcp_set_volume(transport->device, level, notify);
 }
 
+static int transport_a2dp_snk_set_delay(struct media_transport *transport,
+					uint16_t delay)
+{
+	struct a2dp_transport *a2dp = transport->data;
+	struct avdtp_stream *stream;
+
+	if (a2dp->delay == delay)
+		return 0;
+
+	if (a2dp->session == NULL) {
+		a2dp->session = a2dp_avdtp_get(transport->device);
+		if (a2dp->session == NULL)
+			return -EIO;
+	}
+
+	stream = media_transport_get_stream(transport);
+	if (stream == NULL)
+		return -EIO;
+
+	if (a2dp->watch) {
+		a2dp->delay = delay;
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"Delay");
+	}
+
+	return avdtp_delay_report(a2dp->session, stream, delay);
+}
+
 static void media_owner_exit(DBusConnection *connection, void *user_data)
 {
 	struct media_owner *owner = user_data;
@@ -873,7 +904,7 @@ static gboolean delay_reporting_exists(const GDBusPropertyTable *property,
 	return avdtp_stream_has_delay_reporting(stream);
 }
 
-static gboolean get_delay_reporting(const GDBusPropertyTable *property,
+static gboolean get_delay_report(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_transport *transport = data;
@@ -884,6 +915,61 @@ static gboolean get_delay_reporting(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static int media_transport_set_delay(struct media_transport *transport,
+					uint16_t delay)
+{
+	DBG("Transport %s delay %d", transport->path, delay);
+
+	if (transport->ops && transport->ops->set_delay)
+		return transport->ops->set_delay(transport, delay);
+
+	return 0;
+}
+
+static void set_delay_report(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, GDBusPendingPropertySet id,
+				void *data)
+{
+	struct media_transport *transport = data;
+	struct media_owner *owner = transport->owner;
+	const char *sender;
+	uint16_t arg;
+	int err;
+
+	if (owner != NULL) {
+		/* If the transport is acquired, do not allow to modify
+		 * the delay anyone but the owner. */
+		sender = g_dbus_pending_property_get_sender(id);
+		if (g_strcmp0(owner->name, sender) != 0) {
+			g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".NotAuthorized",
+					"Operation Not Authorized");
+			return;
+		}
+	}
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16) {
+		g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".InvalidArguments",
+				"Expected UINT16");
+		return;
+	}
+
+	dbus_message_iter_get_basic(iter, &arg);
+
+	err = media_transport_set_delay(transport, arg);
+	if (err) {
+		error("Unable to set delay: %s (%d)", strerror(-err), err);
+		g_dbus_pending_property_error(id,
+						ERROR_INTERFACE ".Failed",
+						"Internal error %s (%d)",
+						strerror(-err), err);
+		return;
+	}
+
+	g_dbus_pending_property_success(id);
+}
+
 static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_transport *transport = data;
@@ -1019,7 +1105,7 @@ static const GDBusPropertyTable transport_a2dp_properties[] = {
 	{ "Codec", "y", get_codec },
 	{ "Configuration", "ay", get_configuration },
 	{ "State", "s", get_state },
-	{ "Delay", "q", get_delay_reporting, NULL, delay_reporting_exists },
+	{ "Delay", "q", get_delay_report, set_delay_report, delay_reporting_exists },
 	{ "Volume", "q", get_volume, set_volume, volume_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists,
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
@@ -2170,7 +2256,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 
 #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
 		      _resume, _suspend, _cancel, _set_state, _get_stream, \
-		      _get_volume, _set_volume, _update_links, _destroy) \
+		      _get_volume, _set_volume, _set_delay, _update_links, _destroy) \
 { \
 	.uuid = _uuid, \
 	.properties = _props, \
@@ -2184,16 +2270,17 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 	.get_stream = _get_stream, \
 	.get_volume = _get_volume, \
 	.set_volume = _set_volume, \
+	.set_delay = _set_delay, \
 	.update_links = _update_links, \
 	.destroy = _destroy \
 }
 
-#define A2DP_OPS(_uuid, _init, _set_volume, _destroy) \
+#define A2DP_OPS(_uuid, _init, _set_volume, _set_delay, _destroy) \
 	TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, NULL, _init, \
 			transport_a2dp_resume, transport_a2dp_suspend, \
 			transport_a2dp_cancel, NULL, \
 			transport_a2dp_get_stream, transport_a2dp_get_volume, \
-			_set_volume, NULL, _destroy)
+			_set_volume, _set_delay, NULL, _destroy)
 
 #define BAP_OPS(_uuid, _props, _set_owner, _remove_owner, _update_links, \
 		_set_state) \
@@ -2201,7 +2288,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_bap_init, \
 			transport_bap_resume, transport_bap_suspend, \
 			transport_bap_cancel, _set_state, \
-			transport_bap_get_stream, NULL, NULL, _update_links, \
+			transport_bap_get_stream, NULL, NULL, NULL, _update_links, \
 			transport_bap_destroy)
 
 #define BAP_UC_OPS(_uuid) \
@@ -2219,14 +2306,16 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_asha_resume, transport_asha_suspend, \
 			transport_asha_cancel, NULL, NULL, \
 			transport_asha_get_volume, transport_asha_set_volume, \
-			NULL, NULL)
+			NULL, NULL, NULL)
 
 static const struct media_transport_ops transport_ops[] = {
 	A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
 			transport_a2dp_src_set_volume,
+			NULL,
 			transport_a2dp_src_destroy),
 	A2DP_OPS(A2DP_SINK_UUID, transport_a2dp_snk_init,
 			transport_a2dp_snk_set_volume,
+			transport_a2dp_snk_set_delay,
 			transport_a2dp_snk_destroy),
 	BAP_UC_OPS(PAC_SOURCE_UUID),
 	BAP_UC_OPS(PAC_SINK_UUID),
-- 
2.39.5

