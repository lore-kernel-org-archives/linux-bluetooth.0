Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C414B965
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871323; cv=none; b=iX6uVTsRRdHoQ/zj8fy6hWzqyx94tEGjhVxFDp4EXAz/x0+LN7CjBOeVqV9YBKQtG7dx26tyLaA04njRB1BLqDHr6GmUUCEx6gH4AN1AEAGNSyXyC6YajitY+sZFwUyirmIr5WV1AurLKr4zxjmngV8Vh931M55g1WzOTWUSFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871323; c=relaxed/simple;
	bh=kPRqvrS1fQPfAsIcvSDx+b30AhKIEIdRO1PTvjks4Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wr3EduMcdzCNsh8rM/cO2oZaHEUadasPff928JCP0Mww0J+KSO/gSRi7X6HYCgISJEMlyr8UEGsdCj5mUzjDroNRc2Ruwq3bHh6LX9OOr5wSIzUvL8vxoaKY0OSrTghkmE4MDyrYYTJld1vVyLxOsJRCwoOCWS8DTR79adr9Jk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=hK/MKfGu; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="hK/MKfGu"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572d2461001so3655519a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715871319; x=1716476119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj3fQ6lonCcZcxh958qwO+m3waPBciwo6Q7d+/hYtRU=;
        b=hK/MKfGuv8NYweUTMJMQf+Tjt27KdAqicCY8WCPpPemnLR6jYAdOrqQ7Q6pcFaKI1H
         vQA8XXoD1o28DVS14lFjPmi+5h6Gw5uL/ZMfoh2SiiY8EkeZP9Llgtvn9LVQS8nv9tH3
         9Si1vEDtz7M3GxQhBj8dRixSc0iVPFqmc/B/Krd24+xGs7mNRSuBLYJPbIUtEmO1SiaS
         1/+Sl+58IXSZqTI0XCTdYTE1Yh+HcPWxoHmdBcfkVaoqZqdU07juCNUgSK5Z37LwVl7c
         rm/8s6sB+uuM13E+uL0wTGdqYt47x6eAhP4Ds+sJsNkPvzWmYI9cmT8w4S8XkrX1hvkz
         GgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871319; x=1716476119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bj3fQ6lonCcZcxh958qwO+m3waPBciwo6Q7d+/hYtRU=;
        b=hCXu54UvxQm0D2HsR69FAnWGB8dcw2JYelBqd0W9D70PlCDFbSZMOKDwdXokNz3gBz
         STG2xmN8NWwEpDI9ptD/NojyvjBzgGL+FdxPWWQqxhHLQcoL923AMARB5muQzyLuJrVs
         /VP4HvWaC1MNBDj+hbwKAGgVqJlA2LpZN+bJjJ+8Rxxti21Lg97yFZQhhqcecgSsg6bq
         ImcusY7oV8NzQo3V2xE5UwmVu2u24cjXqaJBRVzamnUXya7Y/ZEsn2ydb1GhnOJWiq1H
         ygpHBBQEq1JJYvTcz7OmbprEaOnJHOwDa3B4S8ey1HMV04G6RutDkwV2JxWK+qiuhBtB
         WB1g==
X-Gm-Message-State: AOJu0Yz3Jcc5rmebibA+1NWQXMKMYEc2RGSKe/RAp6U/ba2lonLKFFIn
	VlwiB8aKTjCORIciQONf4pT4ekRUwd6hqTQ9t+ITYt1pZSoOhw/SjPugjWlRrkFQownn5dOTt3T
	kCmY=
X-Google-Smtp-Source: AGHT+IGtZdin7jUTPCgd75lA8OhC5+Rb0dpqRHqy0Un3VixzCN+KBEJOwoymfvecimy3Lg6I6dJBig==
X-Received: by 2002:a50:8ac7:0:b0:572:4e6b:c31 with SMTP id 4fb4d7f45d1cf-5734d67ecc8mr12523236a12.34.1715871318829;
        Thu, 16 May 2024 07:55:18 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574b6f6c53asm7484372a12.16.2024.05.16.07.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 07:55:18 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v4 2/5] profiles/audio: Add an ASHA plugin
Date: Thu, 16 May 2024 10:54:58 -0400
Message-ID: <20240516145501.134118-3-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516145501.134118-1-arun@asymptotic.io>
References: <20240516145501.134118-1-arun@asymptotic.io>
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
 Makefile.plugins      |   5 +
 profiles/audio/asha.c | 336 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 341 insertions(+)
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
-- 
2.45.0

