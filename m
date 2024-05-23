Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A0A13D53F
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460184; cv=none; b=K/Xo4yfXzVclSAbnQE79JgyZT01bYTqDtcbkKpIaJcJz0cCpu9EjXIUxdhltCvcaJfr0x77Vw/0qnkAKnkXE7rUpx7tKgZ0M/D2WU/7ufNWFjihNUTBlDrbMr56BeWHoWe+cl1bTi3wKdvVO26kmzqFHrznmQ01fQUJ3dwFFpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460184; c=relaxed/simple;
	bh=hpYZwcnEBBX6g6DNAXdWokLi7hBEsaC/et5P5RYaKuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cH4dsCqkkjC5MUq8BlmvSsbwRXpbgtatxzJnBnGN097ILdI2sEBHAXQ2fPFLg/fiL0djZqB/e6RZEXB3gyt4aPEi/scN/FWiFCWjPdMAJk7F7a0YUj5zLrN4SU7IYGQ+xL+WpLQiOpPJY28K9vnrmIPsKzn+Ox+SxPG/NhThue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=F/MufB3F; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="F/MufB3F"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso15691633a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 03:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1716460179; x=1717064979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZEB1JX6NvrkM0kwNP1CuKlYj9V5ucmYwrZiGC09sjY=;
        b=F/MufB3Ffcap15Dg3bxM/yzY9aD+f8aag3jRIH8KTUS2/aZbBwUK85KYaePTONudW7
         vHb0knw4lqYV8GOaSlSE/YgZh+E7881YFwFJkf50lYWaaFpUGdT15Z8WYg1PTGQ+S5En
         z9zd6XOQJwpn5A947f2Qa/V8Jkeyt/IMs0UmYPf0dQSiMhm1PxcSp9tceQI3sLXv93Hy
         mO7cFwtWZ/fCakZiYVFJ84Tb5At2zWTId+NLqMY2CfZQb6SMUkc32KeGjNCnUXM5fsIV
         vcnT18fGjw+8S1ZHsp7D/NVXf4vjsRIPFVIj5wI1FCjw5fdOO/LKUiYGu7bHMGcU5Zc/
         vb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716460179; x=1717064979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZEB1JX6NvrkM0kwNP1CuKlYj9V5ucmYwrZiGC09sjY=;
        b=bIrbdaZ8lhjk+G2c9sLmVXh19A19lFzPcgaOGA9JhJiVpLlCo3+FzlQ8iNw5Gr7P+V
         fCYqDe4B5xvkHNficA7C/yjpTnJHQ3JpYIm1QgBqVDvEGJegwO8smt+Ap2sBej45dQy8
         lZ4s4OBAj+DTZCiK7tY2rFCyBtCVTvMQ5baS90+2o6YMfLVIAgvnyqN7E7nFoW9r4nGV
         OYlNQgCu0ou/JdqNSAP6oiWAp4yoGCn7yxODU5lgwLcAkdcdkps2Ed8WNLSBjJF49/Fa
         1QdG+GFCyBguazOI2AptOdVL658otPDc7qLH9vhG+5/bhlBA6dO2Hvn7EQB3cYsO95EG
         4Gcg==
X-Gm-Message-State: AOJu0YzxuwqDQzhVwN8YkhOZMWTx46OQaczwESWQHBO+3AJdkAXolZVK
	joFI1NXfT97VN0mPVSpje+qty5Kbd0aKfe09173miLm0d+u4AA07BXwgI8aP0R/8StbCE1MHrqY
	1
X-Google-Smtp-Source: AGHT+IHc0ksoZw9A/7XesUmxCMDjy5BhCWOhwGybsQn1gTqO3l2TVyqoq+EU7Ba3JVXmw0yHSoL0Kw==
X-Received: by 2002:a17:906:f852:b0:a5a:3b95:c263 with SMTP id a640c23a62f3a-a622808460emr260026466b.21.1716460178490;
        Thu, 23 May 2024 03:29:38 -0700 (PDT)
Received: from andromeda.llama-bortle.ts.net (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a50365669sm1673515666b.193.2024.05.23.03.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:29:37 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v7 2/6] profiles/audio: Add an ASHA plugin
Date: Thu, 23 May 2024 06:29:25 -0400
Message-ID: <20240523102929.37761-3-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523102929.37761-1-arun@asymptotic.io>
References: <20240523102929.37761-1-arun@asymptotic.io>
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
 configure.ac               |   4 +
 profiles/audio/asha.c      | 347 +++++++++++++++++++++++++++++++++++++
 profiles/audio/media.c     |  30 ++++
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c | 198 ++++++++++++++++++++-
 6 files changed, 584 insertions(+), 2 deletions(-)
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
diff --git a/configure.ac b/configure.ac
index ac9de6ec4..1d88daa0b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -216,6 +216,10 @@ AC_ARG_ENABLE(csip, AS_HELP_STRING([--disable-csip],
 		[disable CSIP profile]), [enable_csip=${enableval}])
 AM_CONDITIONAL(CSIP, test "${enable_csip}" != "no")
 
+AC_ARG_ENABLE(asha, AS_HELP_STRING([--disable-asha],
+		[disable ASHA support]), [enable_asha=${enableval}])
+AM_CONDITIONAL(ASHA, test "${enable_asha}" != "no")
+
 AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
new file mode 100644
index 000000000..b624fb21f
--- /dev/null
+++ b/profiles/audio/asha.c
@@ -0,0 +1,347 @@
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
+struct bt_asha_device {
+	struct bt_asha *asha;
+	struct btd_device *device;
+	struct media_transport *transport;
+};
+
+static char *make_endpoint_path(struct bt_asha_device *asha_dev)
+{
+	char *path;
+	int err;
+
+	err = asprintf(&path, "%s/asha", device_get_path(asha_dev->device));
+	if (err < 0) {
+		error("Could not allocate path for remote %s",
+				device_get_path(asha_dev->device));
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
+	struct bt_asha_device *asha_dev = data;
+	const char *side = asha_dev->asha->right_side ? "right" : "left";
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
+	struct bt_asha_device *asha_dev = data;
+	dbus_bool_t binaural = asha_dev->asha->binaural;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &binaural);
+
+	return TRUE;
+}
+
+static gboolean get_hisyncid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bt_asha_device *asha_dev = data;
+	DBusMessageIter array;
+	uint8_t *hisyncid = asha_dev->asha->hisyncid;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+			&hisyncid, sizeof(asha_dev->asha->hisyncid));
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static gboolean get_codecs(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bt_asha_device *asha_dev = data;
+	dbus_uint16_t codecs = asha_dev->asha->codec_ids;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &codecs);
+
+	return TRUE;
+}
+
+static gboolean get_device(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bt_asha_device *asha_dev = data;
+	const char *path;
+
+	path = device_get_path(asha_dev->device);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
+
+static gboolean get_transport(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bt_asha_device *asha_dev = data;
+	const char *path;
+
+	path = media_transport_get_path(asha_dev->transport);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
+
+static int asha_source_device_probe(struct btd_service *service)
+{
+	struct bt_asha_device *asha_dev;
+	struct btd_device *device = btd_service_get_device(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("Probing ASHA device %s", addr);
+
+	asha_dev = g_new0(struct bt_asha_device, 1);
+
+	asha_dev->device = device;
+	asha_dev->asha = bt_asha_new(device_get_address(device));
+
+	btd_service_set_user_data(service, asha_dev);
+
+	return 0;
+}
+
+static void asha_source_device_remove(struct btd_service *service)
+{
+	struct bt_asha_device *asha_dev;
+	struct btd_device *device = btd_service_get_device(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("Removing ASHA device %s", addr);
+
+	asha_dev = btd_service_get_user_data(service);
+	if (!asha_dev) {
+		/* Can this actually happen? */
+		DBG("Not handlihng ASHA profile");
+		return;
+	}
+
+	bt_asha_free(asha_dev->asha);
+	g_free(asha_dev);
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
+static void asha_source_endpoint_register(struct bt_asha_device *asha_dev)
+{
+	char *path;
+	const struct media_endpoint *asha_ep;
+
+	path = make_endpoint_path(asha_dev);
+	if (!path)
+		goto error;
+
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+				path, MEDIA_ENDPOINT_INTERFACE,
+				asha_ep_methods, NULL,
+				asha_ep_properties,
+				asha_dev, NULL) == FALSE) {
+		error("Could not register remote ep %s", path);
+		goto error;
+	}
+
+	asha_ep = media_endpoint_get_asha();
+	asha_dev->transport = media_transport_create(asha_dev->device, path,
+			NULL, 0, (void *) asha_ep, asha_dev->asha);
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
+	struct gatt_db *db = btd_device_get_gatt_db(device);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct bt_asha_device *asha_dev = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("Accepting ASHA connection on %s", addr);
+
+	if (!asha_dev) {
+		/* Can this actually happen? */
+		DBG("Not handling ASHA profile");
+		return -1;
+	}
+
+	if (!bt_asha_probe(asha_dev->asha,db, client))
+		return -1;
+
+	asha_source_endpoint_register(asha_dev);
+
+	btd_service_connecting_complete(service, 0);
+
+	return 0;
+}
+
+static int asha_source_disconnect(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_asha_device *asha_dev = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("Disconnecting ASHA on %s", addr);
+
+	if (!asha_dev) {
+		/* Can this actually happen? */
+		DBG("Not handlihng ASHA profile");
+		return -1;
+	}
+
+	asha_source_endpoint_unregister(asha_dev);
+	bt_asha_reset(asha_dev->asha);
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
index 159fbd575..7ed633e1c 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -32,6 +32,7 @@
 
 #include "src/log.h"
 #include "src/error.h"
+#include "src/shared/asha.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/bap.h"
@@ -115,7 +116,7 @@ struct media_transport {
 	char			*path;		/* Transport object path */
 	struct btd_device	*device;	/* Transport device */
 	struct btd_adapter	*adapter;	/* Transport adapter bcast*/
-	const char		*remote_endpoint; /* Transport remote SEP */
+	char			*remote_endpoint; /* Transport remote SEP */
 	struct media_endpoint	*endpoint;	/* Transport endpoint */
 	struct media_owner	*owner;		/* Transport owner */
 	uint8_t			*configuration; /* Transport configuration */
@@ -219,6 +220,9 @@ void media_transport_destroy(struct media_transport *transport)
 	g_dbus_unregister_interface(btd_get_dbus_connection(), path,
 						MEDIA_TRANSPORT_INTERFACE);
 
+	if (transport->remote_endpoint)
+		g_free(transport->remote_endpoint);
+
 	g_free(path);
 }
 
@@ -1199,6 +1203,32 @@ static const GDBusPropertyTable transport_bap_bc_properties[] = {
 	{ }
 };
 
+static gboolean get_asha_delay(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bt_asha *asha = transport->data;
+	uint16_t delay;
+
+	// Delay property is in 1/10ths of ms, while ASHA RenderDelay is in ms
+	delay = bt_asha_get_render_delay(asha) * 10;
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
@@ -1713,6 +1743,161 @@ static void *transport_bap_init(struct media_transport *transport, void *stream)
 	return bap;
 }
 
+static void asha_transport_sync_state(struct media_transport *transport,
+						struct bt_asha *asha)
+{
+	switch (bt_asha_get_state(asha)) {
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
+	struct bt_asha *asha = transport->data;
+	enum bt_asha_state_t state;
+
+	state = bt_asha_get_state(asha);
+
+	if (state == ASHA_STARTED) {
+		int fd;
+		uint16_t imtu, omtu;
+		gboolean ret;
+
+		fd = bt_asha_get_fd(asha);
+		imtu = bt_asha_get_imtu(asha);
+		omtu = bt_asha_get_omtu(asha);
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
+						struct media_owner *owner)
+{
+	struct bt_asha *asha = transport->data;
+	guint ret;
+
+	ret = bt_asha_connect_socket(asha);
+	if (ret < 0)
+		return ret;
+
+	ret = bt_asha_start(asha, asha_transport_state_cb, owner);
+	asha_transport_sync_state(transport, asha);
+
+	return ret;
+}
+
+static guint transport_asha_suspend(struct media_transport *transport,
+						struct media_owner *owner)
+{
+	struct bt_asha *asha = transport->data;
+	guint ret = 0;
+
+	if (owner) {
+		ret = bt_asha_stop(asha, asha_transport_state_cb, owner);
+		asha_transport_sync_state(transport, asha);
+	} else {
+		ret = bt_asha_stop(asha, NULL, NULL);
+		/* We won't have a callback to set the final state */
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	}
+
+	return ret;
+}
+
+static void transport_asha_cancel(struct media_transport *transport, guint id)
+{
+	struct bt_asha *asha = transport->data;
+	enum bt_asha_state_t state = bt_asha_get_state(asha);
+
+	if (id != asha->resume_id) {
+		/* Not current, ignore */
+		DBG("Ignoring cancel request for id %d", id);
+		return;
+	}
+
+	if (state == ASHA_STARTING || state == ASHA_STARTED) {
+		DBG("Cancel requested, stopping");
+		bt_asha_stop(asha, NULL, NULL);
+		/* We won't have a callback to set the final state */
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	} else if (state == ASHA_STOPPING) {
+		DBG("Cancel requested, resetting transport state");
+		/* We already dispatched a stop, just reset our state */
+		bt_asha_state_reset(asha);
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	}
+}
+
+static int8_t transport_asha_get_volume(struct media_transport *transport)
+{
+	struct bt_asha *asha = transport->data;
+	int8_t volume;
+	int scaled_volume;
+
+	volume = bt_asha_get_volume(asha);
+
+	/* Convert -128-0 to 0-127 */
+	scaled_volume = ((((int) volume) + 128) * 127) / 128;
+
+	return scaled_volume;
+}
+
+static int transport_asha_set_volume(struct media_transport *transport,
+								int8_t volume)
+{
+	struct bt_asha *asha = transport->data;
+	int scaled_volume;
+
+	/* Convert 0-127 to -128-0 */
+	scaled_volume = ((((int) volume) * 128) / 127) - 128;
+
+	return bt_asha_set_volume(asha, scaled_volume) ? 0 : -EIO;
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
@@ -1754,6 +1939,14 @@ static void *transport_bap_init(struct media_transport *transport, void *stream)
 #define BAP_BC_OPS(_uuid) \
 	BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL)
 
+#define ASHA_OPS(_uuid) \
+	TRANSPORT_OPS(_uuid, transport_asha_properties, NULL, NULL, \
+			transport_asha_init, \
+			transport_asha_resume, transport_asha_suspend, \
+			transport_asha_cancel, NULL, NULL, \
+			transport_asha_get_volume, transport_asha_set_volume, \
+			NULL)
+
 static const struct media_transport_ops transport_ops[] = {
 	A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
 			transport_a2dp_src_set_volume,
@@ -1765,6 +1958,7 @@ static const struct media_transport_ops transport_ops[] = {
 	BAP_UC_OPS(PAC_SINK_UUID),
 	BAP_BC_OPS(BCAA_SERVICE_UUID),
 	BAP_BC_OPS(BAA_SERVICE_UUID),
+	ASHA_OPS(ASHA_PROFILE_UUID),
 };
 
 static const struct media_transport_ops *
@@ -1802,7 +1996,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 	transport->endpoint = endpoint;
 	transport->configuration = util_memdup(configuration, size);
 	transport->size = size;
-	transport->remote_endpoint = remote_endpoint;
+	transport->remote_endpoint = g_strdup(remote_endpoint);
 
 	if (device)
 		transport->path = g_strdup_printf("%s/fd%d",
-- 
2.45.1

