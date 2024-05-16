Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29137156F4A
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888333; cv=none; b=AHQTjGZDPogOozDLOER0vossmERVYBEAHxxa5gkKFN2M2prRPKDqqnsAUNLamsYDY1wpSULKHALWigacxbArQtCZhgWTWmdu2kmtG050od9ygAYaCEZqhz/9BlOU7alklk9UINRnpauyqDJFNLTQ2KoJGAiosvBETHLRdGtpMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888333; c=relaxed/simple;
	bh=4mfJ/Y8+Lpv9hU1EFM6MW4AOQKySgUUgSUum016YQYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZBlpPWv7pSbrcY03vBXM/xPwbVTF6Ha+gnS+c1GN0Utyf2Ex08Zs0HkvAzOw0qYvVqCJYYb8r2h+9/D4Gz1+qHJeDS89fuLvOFPaFrSnS9UMv62ERruA/1cB0AzOR6nursqBPTpOgoR2FWb4e9F5EqCIreq7kh3Af7Tbvn8z34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=C22SSxwv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="C22SSxwv"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572d2461001so4050463a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 12:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715888329; x=1716493129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7C6qDs2es+nU63p32PdeIbDvKSc8fcUaeVOWPjKxak=;
        b=C22SSxwv2PN4TH6l6B3li8RanEHNPSxUuCaCRmP6jD+mPnAUovtQpIgJCUZN6h0ZMY
         SCEnHU+2Z+BzbL9rtPJQBcMh/QUiuFxAoMrjLcG9QECTxfMUryXdcwW8/k7gPlppznwS
         /m2mTwmJptktxKM68YindcO5ZPalF+l5oceZ1RrzWquwGB9+s1dRgXb5v1HAijBrPmRs
         fbgPxAUU10i/yfvIqVHorPe/eaPevjR2V+9OKeVVPY4xVi61FAgvEnz0WGvCyldjXeDH
         gCrCP5ykVb4pcaa/NcKcx/XQNgkmS5exSmNhbRfzRptfADtAqJCOuHqsN+z8SPHNjw0M
         kpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715888329; x=1716493129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7C6qDs2es+nU63p32PdeIbDvKSc8fcUaeVOWPjKxak=;
        b=nzujg54z/th4u1XbtOYWLNkvfibpXv1p6JoGGzE6C4EmzNJpmdGPCxjihGcoqo5BpO
         TERFYPoMsFXTvy2/oolFlac9YU6jiPImTcbTCacZPfnN2QtjCpk5YqVkBpnV3evBdAFl
         3Py5Up4D0NCxxSfNjkbveV9OUVw0UjjT+dGZ85GvZssxhrGIA/LT/iIefAU7Kl1oe5h5
         yfki4FR8QI5FpboYxfCKoHgRIWrE2e7ynwh8305RC1sJaQxc3QwjntGsCCY2HQN/TDbI
         A3c08vzwYXKrU6hZefvwuIMH4BhnHlNWsQjTz83QwFe3x4zTac5dO7VLbwCF1zxmwecD
         CoDQ==
X-Gm-Message-State: AOJu0YwekV4UsOcFjTHdKMqx2+rzxFEqn83Voc2KlIPJbAQg+AABe11b
	kcXx6iMfGnABsiYPnYdrhKOxnXB/Gy3RfJuhNANv18x4ENRomTk6UTdDNZ7xzMGEVjVB/beEGt9
	r5kQ=
X-Google-Smtp-Source: AGHT+IHxwdM5Yk9TLvfn0QPWULzI1CNH9iUB5tX2a0Fcp8gf5aag5DpqlqcM2k/2GskPUKYPHUax7w==
X-Received: by 2002:a17:906:5393:b0:a59:bacc:b07f with SMTP id a640c23a62f3a-a5a2d672f6bmr1379174666b.52.1715888329116;
        Thu, 16 May 2024 12:38:49 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-19-74-15-47-99.dsl.bell.ca. [74.15.47.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cd85sm1031241766b.15.2024.05.16.12.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:38:48 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v6 2/5] profiles/audio: Add an ASHA plugin
Date: Thu, 16 May 2024 15:38:33 -0400
Message-ID: <20240516193836.228281-3-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516193836.228281-1-arun@asymptotic.io>
References: <20240516193836.228281-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This exposes the ASHA profile implementation in the previous commit as
an audio profile.

The implementation registers a remote endpoint using a subset of the
MediaEndpoint1 interface, without any mechanism for setting/selecting a
configuration, as this is all static in the spec for now. Also exposed
on connection is a MediaTransport1 object, which can be used to obtain
an fd to stream to the device.
---
 Makefile.plugins           |   5 +
 profiles/audio/asha.c      | 336 +++++++++++++++++++++++++++++++++++++
 profiles/audio/media.c     |  30 ++++
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c | 174 ++++++++++++++++++-
 5 files changed, 545 insertions(+), 2 deletions(-)
 create mode 100644 profiles/audio/asha.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 4aa2c9c92..e196e1d2e 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -147,3 +147,8 @@ if CSIP
 builtin_modules += csip
 builtin_sources += profiles/audio/csip.c
 endif
+
+if ASHA
+builtin_modules += asha
+builtin_sources += profiles/audio/asha.c
+endif
diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
new file mode 100644
index 000000000..40871d707
--- /dev/null
+++ b/profiles/audio/asha.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024  Asymptotic Inc.
+ *
+ *  Author: Arun Raghavan <arun@asymptotic.io>
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+
+#include <stdbool.h>
+#include <stdint.h>
+
+#include <dbus/dbus.h>
+#include <glib.h>
+
+#include "gdbus/gdbus.h"
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+
+#include "src/dbus-common.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/log.h"
+#include "src/plugin.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/shared/asha.h"
+#include "src/shared/util.h"
+
+#include "profiles/audio/media.h"
+#include "profiles/audio/transport.h"
+
+#define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
+
+static char *make_endpoint_path(struct bt_asha_device *asha)
+{
+	char *path;
+	int err;
+
+	err = asprintf(&path, "%s/asha", device_get_path(asha->device));
+	if (err < 0) {
+		error("Could not allocate path for remote %s",
+				device_get_path(asha->device));
+		return NULL;
+	}
+
+	return path;
+
+}
+
+static gboolean get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	const char *uuid;
+
+	uuid = ASHA_PROFILE_UUID;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+
+	return TRUE;
+}
+
+static gboolean get_side(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bt_asha_device *asha = data;
+	const char *side = asha->right_side ? "right" : "left";
+
+	/* Use a string in case we want to support more types in the future */
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &side);
+
+	return TRUE;
+}
+
+
+static gboolean get_binaural(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bt_asha_device *asha = data;
+	dbus_bool_t binaural = asha->binaural;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &binaural);
+
+	return TRUE;
+}
+
+static gboolean get_hisyncid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bt_asha_device *asha = data;
+	DBusMessageIter array;
+	uint8_t *hisyncid = asha->hisyncid;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+			&hisyncid, sizeof(asha->hisyncid));
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static gboolean get_codecs(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bt_asha_device *asha = data;
+	dbus_uint16_t codecs = asha->codec_ids;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &codecs);
+
+	return TRUE;
+}
+
+static gboolean get_device(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bt_asha_device *asha = data;
+	const char *path;
+
+	path = device_get_path(asha->device);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
+
+static gboolean get_transport(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bt_asha_device *asha = data;
+	const char *path;
+
+	path = media_transport_get_path(asha->transport);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
+
+static int asha_source_device_probe(struct btd_service *service)
+{
+	struct bt_asha_device *asha;
+	struct btd_device *device = btd_service_get_device(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("Probing ASHA device %s", addr);
+
+	asha = bt_asha_device_new();
+	asha->device = device;
+
+	btd_service_set_user_data(service, asha);
+
+	return 0;
+}
+
+static void asha_source_device_remove(struct btd_service *service)
+{
+	struct bt_asha_device *asha;
+	struct btd_device *device = btd_service_get_device(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("Removing ASHA device %s", addr);
+
+	asha = btd_service_get_user_data(service);
+	if (!asha) {
+		/* Can this actually happen? */
+		DBG("Not handlihng ASHA profile");
+		return;
+	}
+
+	bt_asha_device_free(asha);
+}
+
+static const GDBusMethodTable asha_ep_methods[] = {
+	{ },
+};
+
+static const GDBusPropertyTable asha_ep_properties[] = {
+	{ "UUID", "s", get_uuid, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Side", "s", get_side, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Binaural", "b", get_binaural, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "HiSyncId", "ay", get_hisyncid, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Codecs", "q", get_codecs, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Device", "o", get_device, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Transport", "o", get_transport, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ }
+};
+
+static void asha_source_endpoint_register(struct bt_asha_device *asha)
+{
+	char *path;
+	const struct media_endpoint *asha_ep;
+
+	path = make_endpoint_path(asha);
+	if (!path)
+		goto error;
+
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+				path, MEDIA_ENDPOINT_INTERFACE,
+				asha_ep_methods, NULL,
+				asha_ep_properties,
+				asha, NULL) == FALSE) {
+		error("Could not register remote ep %s", path);
+		goto error;
+	}
+
+	asha_ep = media_endpoint_get_asha();
+	asha->transport = media_transport_create(asha->device, path, NULL, 0,
+						(void *) asha_ep, asha);
+
+error:
+	if (path)
+		free(path);
+}
+
+static void asha_source_endpoint_unregister(struct bt_asha_device *asha)
+{
+	char *path;
+
+	path = make_endpoint_path(asha);
+	if (!path)
+		goto error;
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				path, MEDIA_ENDPOINT_INTERFACE);
+
+	if (asha->transport) {
+		media_transport_destroy(asha->transport);
+		asha->transport = NULL;
+	}
+
+error:
+	if (path)
+		free(path);
+}
+
+static int asha_source_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_asha_device *asha = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("Accepting ASHA connection on %s", addr);
+
+	if (!asha) {
+		/* Can this actually happen? */
+		DBG("Not handling ASHA profile");
+		return -1;
+	}
+
+	if (!bt_asha_device_probe(asha))
+		return -1;
+
+	asha_source_endpoint_register(asha);
+
+	btd_service_connecting_complete(service, 0);
+
+	return 0;
+}
+
+static int asha_source_disconnect(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_asha_device *asha = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("Disconnecting ASHA on %s", addr);
+
+	if (!asha) {
+		/* Can this actually happen? */
+		DBG("Not handlihng ASHA profile");
+		return -1;
+	}
+
+	asha_source_endpoint_unregister(asha);
+	bt_asha_device_reset(asha);
+
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
+static struct btd_profile asha_source_profile = {
+	.name		= "asha-source",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.remote_uuid	= ASHA_PROFILE_UUID,
+	.experimental	= true,
+
+	.device_probe	= asha_source_device_probe,
+	.device_remove	= asha_source_device_remove,
+
+	.auto_connect	= true,
+	.accept		= asha_source_accept,
+	.disconnect	= asha_source_disconnect,
+};
+
+static int asha_init(void)
+{
+	int err;
+
+	err = btd_profile_register(&asha_source_profile);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void asha_exit(void)
+{
+	btd_profile_unregister(&asha_source_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(asha, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							asha_init, asha_exit)
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 4bbd584de..b5644736a 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -38,6 +38,7 @@
 #include "src/log.h"
 #include "src/error.h"
 #include "src/gatt-database.h"
+#include "src/shared/asha.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
@@ -88,6 +89,7 @@ struct endpoint_request {
 struct media_endpoint {
 	struct a2dp_sep		*sep;
 	struct bt_bap_pac	*pac;
+	struct bt_asha_device	*asha;
 	char			*sender;	/* Endpoint DBus bus id */
 	char			*path;		/* Endpoint object path */
 	char			*uuid;		/* Endpoint property UUID */
@@ -1330,6 +1332,12 @@ static bool endpoint_init_broadcast_sink(struct media_endpoint *endpoint,
 	return endpoint_init_pac(endpoint, BT_BAP_BCAST_SINK, err);
 }
 
+static bool endpoint_init_asha(struct media_endpoint *endpoint,
+						int *err)
+{
+	return true;
+}
+
 static bool endpoint_properties_exists(const char *uuid,
 						struct btd_device *dev,
 						void *user_data)
@@ -1454,6 +1462,11 @@ static bool experimental_bcast_sink_ep_supported(struct btd_adapter *adapter)
 	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 }
 
+static bool experimental_asha_supported(struct btd_adapter *adapter)
+{
+	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
+}
+
 static const struct media_endpoint_init {
 	const char *uuid;
 	bool (*func)(struct media_endpoint *endpoint, int *err);
@@ -1471,6 +1484,8 @@ static const struct media_endpoint_init {
 			experimental_broadcaster_ep_supported },
 	{ BAA_SERVICE_UUID, endpoint_init_broadcast_sink,
 			experimental_bcast_sink_ep_supported },
+	{ ASHA_PROFILE_UUID, endpoint_init_asha,
+			experimental_asha_supported },
 };
 
 static struct media_endpoint *
@@ -3393,3 +3408,18 @@ bool media_endpoint_is_broadcast(struct media_endpoint *endpoint)
 
 	return false;
 }
+
+const struct media_endpoint *media_endpoint_get_asha(void)
+{
+	/*
+	 * Because ASHA does not require the application to register an
+	 * endpoint, we need a minimal media_endpoint for transport creation to
+	 * work, so let's create one
+	 */
+	static struct media_endpoint asha_endpoint =  {
+		.uuid = ASHA_PROFILE_UUID,
+		.codec = 0x2, /* Currently on G.722 is defined by the spec */
+	};
+
+	return &asha_endpoint;
+}
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 2b579877b..2b2e8e157 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -24,3 +24,5 @@ struct btd_adapter *media_endpoint_get_btd_adapter(
 					struct media_endpoint *endpoint);
 bool media_endpoint_is_broadcast(struct media_endpoint *endpoint);
 int8_t media_player_get_device_volume(struct btd_device *device);
+
+const struct media_endpoint *media_endpoint_get_asha(void);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 159fbd575..0d10f82b3 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -32,6 +32,7 @@
 
 #include "src/log.h"
 #include "src/error.h"
+#include "src/shared/asha.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/bap.h"
@@ -90,6 +91,10 @@ struct bap_transport {
 	guint			resume_id;
 };
 
+struct asha_transport {
+	uint16_t		delay;
+};
+
 struct media_transport_ops {
 	const char *uuid;
 	const GDBusPropertyTable *properties;
@@ -115,7 +120,7 @@ struct media_transport {
 	char			*path;		/* Transport object path */
 	struct btd_device	*device;	/* Transport device */
 	struct btd_adapter	*adapter;	/* Transport adapter bcast*/
-	const char		*remote_endpoint; /* Transport remote SEP */
+	char			*remote_endpoint; /* Transport remote SEP */
 	struct media_endpoint	*endpoint;	/* Transport endpoint */
 	struct media_owner	*owner;		/* Transport owner */
 	uint8_t			*configuration; /* Transport configuration */
@@ -219,6 +224,9 @@ void media_transport_destroy(struct media_transport *transport)
 	g_dbus_unregister_interface(btd_get_dbus_connection(), path,
 						MEDIA_TRANSPORT_INTERFACE);
 
+	if (transport->remote_endpoint)
+		g_free(transport->remote_endpoint);
+
 	g_free(path);
 }
 
@@ -1199,6 +1207,32 @@ static const GDBusPropertyTable transport_bap_bc_properties[] = {
 	{ }
 };
 
+static gboolean get_asha_delay(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bt_asha_device *asha = transport->data;
+	uint16_t delay;
+
+	// Delay property is in 1/10ths of ms, while ASHA RenderDelay is in ms
+	delay = bt_asha_device_get_render_delay(asha) * 10;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &delay);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable transport_asha_properties[] = {
+	{ "Device", "o", get_device },
+	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
+	{ "UUID", "s", get_uuid },
+	{ "Codec", "y", get_codec },
+	{ "State", "s", get_state },
+	{ "Delay", "q", get_asha_delay },
+	{ "Volume", "q", get_volume, set_volume, volume_exists },
+	{ }
+};
+
 static void transport_a2dp_destroy(void *data)
 {
 	struct a2dp_transport *a2dp = data;
@@ -1713,6 +1747,133 @@ static void *transport_bap_init(struct media_transport *transport, void *stream)
 	return bap;
 }
 
+static void asha_transport_sync_state(struct media_transport *transport,
+		struct bt_asha_device *asha)
+{
+	switch (bt_asha_device_get_state(asha)) {
+	case ASHA_STOPPED:
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+		break;
+	case ASHA_STARTING:
+		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
+		break;
+	case ASHA_STARTED:
+		transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
+		break;
+	case ASHA_STOPPING:
+		transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
+		break;
+	}
+}
+
+static void asha_transport_state_cb(int status, void *user_data)
+{
+	struct media_owner *owner = user_data;
+	struct media_transport *transport = owner->transport;
+	struct bt_asha_device *asha = transport->data;
+	enum bt_asha_state_t state;
+
+	state = bt_asha_device_get_state(asha);
+
+	if (state == ASHA_STARTED) {
+		int fd;
+		uint16_t imtu, omtu;
+		gboolean ret;
+
+		fd = bt_asha_device_get_fd(asha);
+		imtu = bt_asha_device_get_imtu(asha);
+		omtu = bt_asha_device_get_omtu(asha);
+
+		media_transport_set_fd(transport, fd, imtu, omtu);
+
+		owner->pending->id = 0;
+		ret = g_dbus_send_reply(btd_get_dbus_connection(),
+				owner->pending->msg,
+				DBUS_TYPE_UNIX_FD, &fd,
+				DBUS_TYPE_UINT16, &imtu,
+				DBUS_TYPE_UINT16, &omtu,
+				DBUS_TYPE_INVALID);
+		if (!ret) {
+			media_transport_remove_owner(transport);
+			return;
+		}
+
+		media_owner_remove(owner);
+	} else if (state == ASHA_STOPPED) {
+		if (owner->pending) {
+			owner->pending->id = 0;
+			media_request_reply(owner->pending, 0);
+			media_owner_remove(owner);
+		}
+
+		media_transport_remove_owner(transport);
+	}
+
+	asha_transport_sync_state(transport, asha);
+}
+
+static guint transport_asha_resume(struct media_transport *transport,
+				struct media_owner *owner)
+{
+	struct bt_asha_device *asha = transport->data;
+	guint ret;
+
+	ret = bt_asha_device_start(asha, asha_transport_state_cb, owner);
+	asha_transport_sync_state(transport, asha);
+
+	return ret;
+}
+
+static guint transport_asha_suspend(struct media_transport *transport,
+				struct media_owner *owner)
+{
+	struct bt_asha_device *asha = transport->data;
+	guint ret = 0;
+
+	if (owner) {
+		ret = bt_asha_device_stop(asha, asha_transport_state_cb, owner);
+		asha_transport_sync_state(transport, asha);
+	} else {
+		ret = bt_asha_device_stop(asha, NULL, NULL);
+		/* We won't have a callback to set the final state */
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	}
+
+	return ret;
+}
+
+static int8_t transport_asha_get_volume(struct media_transport *transport)
+{
+	struct bt_asha_device *asha = transport->data;
+	int8_t volume;
+	int scaled_volume;
+
+	volume = bt_asha_device_get_volume(asha);
+
+	/* Convert -128-0 to 0-127 */
+	scaled_volume = ((((int) volume) + 128) * 127) / 128;
+
+	return scaled_volume;
+}
+
+static int transport_asha_set_volume(struct media_transport *transport,
+					int8_t volume)
+{
+	struct bt_asha_device *asha = transport->data;
+	int scaled_volume;
+
+	/* Convert 0-127 to -128-0 */
+	scaled_volume = ((((int) volume) * 128) / 127) - 128;
+
+	return bt_asha_device_set_volume(asha, scaled_volume) ? 0 : -EIO;
+}
+
+static void *transport_asha_init(struct media_transport *transport, void *data)
+{
+	/* We just store the struct asha_device on the transport */
+	return data;
+}
+
 #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
 		      _resume, _suspend, _cancel, _set_state, _get_stream, \
 		      _get_volume, _set_volume, _destroy) \
@@ -1754,6 +1915,14 @@ static void *transport_bap_init(struct media_transport *transport, void *stream)
 #define BAP_BC_OPS(_uuid) \
 	BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL)
 
+#define ASHA_OPS(_uuid) \
+	TRANSPORT_OPS(_uuid, transport_asha_properties, NULL, NULL, \
+			transport_asha_init, \
+			transport_asha_resume, transport_asha_suspend, \
+			NULL, NULL, NULL, \
+			transport_asha_get_volume, transport_asha_set_volume, \
+			NULL)
+
 static const struct media_transport_ops transport_ops[] = {
 	A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
 			transport_a2dp_src_set_volume,
@@ -1765,6 +1934,7 @@ static const struct media_transport_ops transport_ops[] = {
 	BAP_UC_OPS(PAC_SINK_UUID),
 	BAP_BC_OPS(BCAA_SERVICE_UUID),
 	BAP_BC_OPS(BAA_SERVICE_UUID),
+	ASHA_OPS(ASHA_PROFILE_UUID),
 };
 
 static const struct media_transport_ops *
@@ -1802,7 +1972,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 	transport->endpoint = endpoint;
 	transport->configuration = util_memdup(configuration, size);
 	transport->size = size;
-	transport->remote_endpoint = remote_endpoint;
+	transport->remote_endpoint = g_strdup(remote_endpoint);
 
 	if (device)
 		transport->path = g_strdup_printf("%s/fd%d",
-- 
2.45.0

