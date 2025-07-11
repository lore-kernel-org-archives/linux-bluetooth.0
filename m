Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C102F2726
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263459; cv=none; b=ZTBg+Cezc+rcgfs4r7CJ+j21xoj1cAs+k5kAngj9q5jEXm1NIhpjWGsO3MuhIOEqvuYLG2QgvuNVehdURQTsj0uVmAVVBXvG9ieW/zrnXyIC2OW4z0P9EWzGrhzbAQ/A0vZwYcVyO8b+T8AJcqRfdQOiq0uxmTbEIqxKUk9y4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263459; c=relaxed/simple;
	bh=u8021iGpj873YtER7AJWXdQzi9nYGfCS4UpbA1jNYjo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IM/WvgDOfI17uLPJ6lvEsI03IMfoYx6zhL1gzGmSpalOmlw7HSr7uFIcPm/BPwcVy+W4umXywlsIhEntyreT9rYFDygO3Ju2vrmCQEVBWbfsIUnlXMdBTcgrqvEazvEIK2ueqoPYXqRCO70k5jr3z2lgsMaqmEZq+bFRq0fjnVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHQE6ts2; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHQE6ts2"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-532d498eb95so1074050e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 12:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752263456; x=1752868256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVdf94A7/2yJIoBhurH7C/bQW5hVqNr7BEJDB57hkVQ=;
        b=SHQE6ts2eRVrjatFdFPuUvI0R1WTkhqjc+7u7R6KZ+j+sY7J2HioTYSH/mytIjBsLP
         ykU4eeqYqpeJnYz9Z3qLWYulIoroQy1URYeG0xjSlrl3yituQC4raK2NBDa6tFTpyeb7
         Ww8UknCwbS9zAVC/zxj4JOvUJEaNq8iYSRuBFNTObrjLLhe/zBZMPzPowEfbQzDSwiOs
         NwVOzxqyv/1B2GZrlk22ZjQkL4Q4XVa1fXwrBJEGM7fFN2H4NI+z7oFDsQ4X6dJKqG6Q
         MyvxFuGrGWml2AyqyrCubMJn7NLDtskXSRUFJPw2V8hFpYRmXQAxHfNWf5lEbqyQcjeo
         oPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263456; x=1752868256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVdf94A7/2yJIoBhurH7C/bQW5hVqNr7BEJDB57hkVQ=;
        b=otPZf9ZVpmHbFgNlACWBT3GK0RW3zm3y777LMRHmXclsZD6ByLdLcst6FflNGE4f75
         9F/sizDuilpAGlLhvlAKlG60VTDe/5TQpDEd7TiiNqI2GeOrRE16pLDe2yqxHC7suQM1
         L7dJHhxAhKglFhL4+zeE7T59ukZ7YeJH4SXCH0jPVYGv1GVp0/+9nC6Zslxohu0c2uVi
         YjRptgGKlqSt0RA1bmA2856IL8kMHjvtF5RMGbk4vXfF0sCsLuQNLPudMRpjuvAk/VF7
         baZ4iAqKMOuO0M6NBlLGLZfewluPmJhILTBfeVGLQPwNY3Uqh7w20/fCo+jvZleS33cD
         dTgw==
X-Gm-Message-State: AOJu0YwntHKhL4NTrsOlAOV9qj+KG332Gu8k9GwR9N3XL+7oxSfyBu48
	QQIk0Y7j4rSNYjbdURpkZQUPWkVip+sPdcm6XcVoxIcEhhwZIa1/En7bO8lKYw==
X-Gm-Gg: ASbGncuTEerUHOJo94A/w33Mf6k/gLpfjlpha1O8q+9Af1fCeKwQmImtygycJBqzU2D
	3gAQYvUmGMRCaQZi/Kw/JjnxISBl389J/7IBga5QGFJqFU0Am03pPsfygXZKgCaOITKVsUPArqi
	KuMKHq40gNOyzYAUCeawYcVwD9820cdk1YWyPw0V2sYy6xn/J+cchgYhPCK6gEBwviC98yjt1JI
	5fM2CypdPd0X4U7XlcfOC6Ca9SWRCZdOu5wQBPUJ7RTDq4K4q0v2H6dcGr/Vw4WVoKYtKQUBguo
	rFClmpayrRAnGPajJomoeC3Mvw+jdJ0UtEtJ+lNELYCMmQQ1gR31qdQrUQ9znBO3WuKl+QW9EjE
	4Ooy0Fr1WtsgbbXn5wmMmPjb1WnL21aqJ8ZZJoVforv85m2Sfw44avZLuQWV8EvyH
X-Google-Smtp-Source: AGHT+IHB2ZWYxV+IKnzx8LVgrs2gmTV9e8I6dIg8PlQJ5juAMQbHL3PGTl9Bh1N8NdgnZU/+2umfLA==
X-Received: by 2002:a05:6122:7cf:b0:531:4708:3d45 with SMTP id 71dfb90a1353d-535f4a09a56mr3493813e0c.10.1752263455092;
        Fri, 11 Jul 2025 12:50:55 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-535e72192ebsm867100e0c.1.2025.07.11.12.50.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:50:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 3/3] bearer: Add initial implementation of org.bluez.Bearer.{BREDR, LE}
Date: Fri, 11 Jul 2025 15:50:43 -0400
Message-ID: <20250711195043.3875400-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711195043.3875400-1-luiz.dentz@gmail.com>
References: <20250711195043.3875400-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initial implementation of org.bluez.Bearer{BREDR, LE}(5)
interfaces.
---
 Makefile.am  |   3 +-
 src/bearer.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/bearer.h |  22 +++++
 src/device.c |  66 +++++++++++---
 4 files changed, 325 insertions(+), 12 deletions(-)
 create mode 100644 src/bearer.c
 create mode 100644 src/bearer.h

diff --git a/Makefile.am b/Makefile.am
index b75125e8887f..c70d6543e133 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -330,7 +330,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/adv_monitor.h src/adv_monitor.c \
 			src/battery.h src/battery.c \
 			src/settings.h src/settings.c \
-			src/set.h src/set.c
+			src/set.h src/set.c \
+			src/bearer.h src/bearer.c
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			src/libshared-glib.la \
diff --git a/src/bearer.c b/src/bearer.c
new file mode 100644
index 000000000000..4fb6ad3078fe
--- /dev/null
+++ b/src/bearer.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  Intel Corporation
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <stdint.h>
+
+#include <glib.h>
+#include <dbus/dbus.h>
+
+#include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+
+#include "gdbus/gdbus.h"
+#include "src/shared/util.h"
+
+#include "log.h"
+#include "error.h"
+#include "adapter.h"
+#include "device.h"
+#include "dbus-common.h"
+#include "bearer.h"
+
+struct btd_bearer {
+	struct btd_device *device;
+	uint8_t type;
+	const char *path;
+};
+
+static void bearer_free(void *data)
+{
+	struct btd_bearer *bearer = data;
+
+	free(bearer);
+}
+
+static DBusMessage *bearer_connect(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	/* TODO */
+	return NULL;
+}
+
+static DBusMessage *bearer_disconnect(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	/* TODO */
+	return NULL;
+}
+
+static const GDBusMethodTable bearer_methods[] = {
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("Connect", NULL, NULL,
+						bearer_connect) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("Disconnect", NULL, NULL,
+						bearer_disconnect) },
+	{}
+};
+
+static gboolean bearer_get_paired(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_bearer *bearer = data;
+	dbus_bool_t paired = device_is_paired(bearer->device, bearer->type);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &paired);
+
+	return TRUE;
+}
+
+static gboolean bearer_get_bonded(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_bearer *bearer = data;
+	dbus_bool_t bonded = device_is_bonded(bearer->device, bearer->type);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &bonded);
+
+	return TRUE;
+}
+
+static gboolean bearer_get_connected(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_bearer *bearer = data;
+	dbus_bool_t connected = btd_device_bdaddr_type_connected(bearer->device,
+								bearer->type);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &connected);
+
+	return TRUE;
+}
+
+static const GDBusSignalTable bearer_signals[] = {
+	{ GDBUS_SIGNAL("Disconnected",
+			GDBUS_ARGS({ "name", "s" }, { "message", "s" })) },
+	{ }
+};
+
+static const GDBusPropertyTable bearer_properties[] = {
+	{ "Paired", "b", bearer_get_paired, NULL, NULL,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Bonded", "b", bearer_get_bonded, NULL, NULL,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Connected", "b", bearer_get_connected, NULL, NULL,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{}
+};
+
+static const char *bearer_interface(uint8_t type)
+{
+	if (type == BDADDR_BREDR)
+		return BTD_BEARER_BREDR_INTERFACE;
+	else
+		return BTD_BEARER_LE_INTERFACE;
+}
+
+struct btd_bearer *btd_bearer_new(struct btd_device *device, uint8_t type)
+{
+	struct btd_bearer *bearer;
+
+	bearer = new0(struct btd_bearer, 1);
+	bearer->device = device;
+	bearer->type = type;
+	bearer->path = device_get_path(device);
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					bearer->path, bearer_interface(type),
+					bearer_methods, bearer_signals,
+					bearer_properties,
+					bearer, bearer_free)) {
+		error("Unable to register BREDR interface");
+		bearer->path = NULL;
+	}
+
+	return bearer;
+}
+
+void btd_bearer_destroy(struct btd_bearer *bearer)
+{
+	if (!bearer)
+		return;
+
+	if (!bearer->path) {
+		bearer_free(bearer);
+		return;
+	}
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(), bearer->path,
+					bearer_interface(bearer->type));
+}
+
+void btd_bearer_paired(struct btd_bearer *bearer)
+{
+	if (!bearer || !bearer->path)
+		return;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
+					bearer_interface(bearer->type),
+					"Paired");
+}
+
+void btd_bearer_bonded(struct btd_bearer *bearer)
+{
+	if (!bearer || !bearer->path)
+		return;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
+					bearer_interface(bearer->type),
+					"Bonded");
+}
+
+void btd_bearer_connected(struct btd_bearer *bearer)
+{
+	if (!bearer || !bearer->path)
+		return;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
+					bearer_interface(bearer->type),
+					"Connected");
+}
+
+void btd_bearer_disconnected(struct btd_bearer *bearer, uint8_t reason)
+{
+	const char *name;
+	const char *message;
+
+	if (!bearer || !bearer->path)
+		return;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
+					bearer_interface(bearer->type),
+					"Connected");
+
+	switch (reason) {
+	case MGMT_DEV_DISCONN_UNKNOWN:
+		name = "org.bluez.Reason.Unknown";
+		message = "Unspecified";
+		break;
+	case MGMT_DEV_DISCONN_TIMEOUT:
+		name = "org.bluez.Reason.Timeout";
+		message = "Connection timeout";
+		break;
+	case MGMT_DEV_DISCONN_LOCAL_HOST:
+		name = "org.bluez.Reason.Local";
+		message = "Connection terminated by local host";
+		break;
+	case MGMT_DEV_DISCONN_REMOTE:
+		name = "org.bluez.Reason.Remote";
+		message = "Connection terminated by remote user";
+		break;
+	case MGMT_DEV_DISCONN_AUTH_FAILURE:
+		name = "org.bluez.Reason.Authentication";
+		message = "Connection terminated due to authentication failure";
+		break;
+	case MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND:
+		name = "org.bluez.Reason.Suspend";
+		message = "Connection terminated by local host for suspend";
+		break;
+	default:
+		warn("Unknown disconnection value: %u", reason);
+		name = "org.bluez.Reason.Unknown";
+		message = "Unspecified";
+	}
+
+	g_dbus_emit_signal(btd_get_dbus_connection(), bearer->path,
+					bearer_interface(bearer->type),
+					"Disconnected",
+					DBUS_TYPE_STRING, &name,
+					DBUS_TYPE_STRING, &message,
+					DBUS_TYPE_INVALID);
+}
diff --git a/src/bearer.h b/src/bearer.h
new file mode 100644
index 000000000000..4a39dcdd047e
--- /dev/null
+++ b/src/bearer.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  Intel Corporation
+ *
+ *
+ */
+
+#define BTD_BEARER_BREDR_INTERFACE	"org.bluez.Bearer.BREDR1"
+#define BTD_BEARER_LE_INTERFACE		"org.bluez.Bearer.LE1"
+
+struct btd_bearer;
+
+struct btd_bearer *btd_bearer_new(struct btd_device *device, uint8_t type);
+void btd_bearer_destroy(struct btd_bearer *bearer);
+
+void btd_bearer_paired(struct btd_bearer *bearer);
+void btd_bearer_bonded(struct btd_bearer *bearer);
+void btd_bearer_connected(struct btd_bearer *bearer);
+void btd_bearer_disconnected(struct btd_bearer *bearer, uint8_t reason);
diff --git a/src/device.c b/src/device.c
index eed2edcf0dfc..7e62112615e4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -66,6 +66,7 @@
 #include "eir.h"
 #include "settings.h"
 #include "set.h"
+#include "bearer.h"
 
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		1
@@ -205,8 +206,8 @@ struct btd_device {
 	uint8_t		bdaddr_type;
 	bool		rpa;
 	char		*path;
-	bool		bredr;
-	bool		le;
+	struct btd_bearer *bredr;
+	struct btd_bearer *le;
 	bool		pending_paired;		/* "Paired" waiting for SDP */
 	bool		svc_refreshed;
 	bool		refresh_discovery;
@@ -949,6 +950,9 @@ static void device_free(gpointer user_data)
 
 	queue_destroy(device->sirks, free);
 
+	btd_bearer_destroy(device->bredr);
+	btd_bearer_destroy(device->le);
+
 	g_free(device->local_csrk);
 	g_free(device->remote_csrk);
 	free(device->ltk);
@@ -2981,6 +2985,11 @@ static void browse_request_complete(struct browse_req *req, uint8_t type,
 		}
 
 		if (dev->pending_paired) {
+			if (bdaddr_type == BDADDR_BREDR)
+				btd_bearer_paired(dev->bredr);
+			else
+				btd_bearer_paired(dev->le);
+
 			g_dbus_emit_property_changed(dbus_conn, dev->path,
 						DEVICE_INTERFACE, "Paired");
 			dev->pending_paired = false;
@@ -3072,6 +3081,11 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
 	dev->eir_uuids = NULL;
 
 	if (dev->pending_paired) {
+		if (bdaddr_type == BDADDR_BREDR)
+			btd_bearer_paired(dev->bredr);
+		else
+			btd_bearer_paired(dev->le);
+
 		g_dbus_emit_property_changed(dbus_conn, dev->path,
 						DEVICE_INTERFACE, "Paired");
 		dev->pending_paired = false;
@@ -3698,10 +3712,13 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
 	dev->conn_bdaddr_type = dev->bdaddr_type;
 
 	/* If this is the first connection over this bearer */
-	if (bdaddr_type == BDADDR_BREDR)
+	if (bdaddr_type == BDADDR_BREDR) {
 		device_set_bredr_support(dev);
-	else
+		btd_bearer_connected(dev->bredr);
+	} else {
 		device_set_le_support(dev, bdaddr_type);
+		btd_bearer_connected(dev->le);
+	}
 
 	state->connected = true;
 	state->initiator = flags & BIT(3);
@@ -3833,6 +3850,12 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 		device->connect = NULL;
 	}
 
+	/* Update bearer interface */
+	if (bdaddr_type == BDADDR_BREDR)
+		btd_bearer_disconnected(device->bredr, reason);
+	else
+		btd_bearer_disconnected(device->le, reason);
+
 	/* Check paired status of both bearers since it's possible to be
 	 * paired but not connected via link key to LTK conversion.
 	 */
@@ -3843,6 +3866,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 						BDADDR_BREDR);
 		device->bredr_state.paired = false;
 		paired_status_updated = true;
+		btd_bearer_paired(device->bredr);
 	}
 
 	if (!device->le_state.connected && device->le_state.paired &&
@@ -3852,6 +3876,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 						device->bdaddr_type);
 		device->le_state.paired = false;
 		paired_status_updated = true;
+		btd_bearer_paired(device->le);
 	}
 
 	/* report change only if both bearers are unpaired */
@@ -4191,9 +4216,9 @@ static void load_info(struct btd_device *device, const char *local,
 
 	for (t = techno; *t; t++) {
 		if (g_str_equal(*t, "BR/EDR"))
-			device->bredr = true;
+			device->bredr = btd_bearer_new(device, BDADDR_BREDR);
 		else if (g_str_equal(*t, "LE"))
-			device->le = true;
+			device->le = btd_bearer_new(device, BDADDR_LE_PUBLIC);
 		else
 			error("Unknown device technology");
 	}
@@ -4834,9 +4859,9 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	device->bdaddr_type = bdaddr_type;
 
 	if (bdaddr_type == BDADDR_BREDR)
-		device->bredr = true;
+		device->bredr = btd_bearer_new(device, BDADDR_BREDR);
 	else
-		device->le = true;
+		device->le = btd_bearer_new(device, BDADDR_LE_PUBLIC);
 
 	storage_dir = btd_adapter_get_storage_dir(adapter);
 	str = load_cached_name(device, storage_dir, dst);
@@ -4986,7 +5011,8 @@ void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 	/* Since this function is only used for LE SMP Identity
 	 * Resolving purposes we can now assume LE is supported.
 	 */
-	device->le = true;
+	if (!device->le)
+		device->le = btd_bearer_new(device, BDADDR_LE_PUBLIC);
 
 	/* Remove old address from accept/auto-connect list since its address
 	 * will be changed.
@@ -5016,7 +5042,8 @@ void device_set_bredr_support(struct btd_device *device)
 	if (btd_opts.mode == BT_MODE_LE || device->bredr)
 		return;
 
-	device->bredr = true;
+	if (!device->bredr)
+		device->bredr = btd_bearer_new(device, BDADDR_BREDR);
 
 	if (device->le)
 		g_dbus_emit_property_changed(dbus_conn, device->path,
@@ -5030,7 +5057,9 @@ void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type)
 	if (btd_opts.mode == BT_MODE_BREDR || device->le)
 		return;
 
-	device->le = true;
+	if (!device->le)
+		device->le = btd_bearer_new(device, BDADDR_LE_PUBLIC);
+
 	device->bdaddr_type = bdaddr_type;
 
 	g_dbus_emit_property_changed(dbus_conn, device->path,
@@ -6613,6 +6642,11 @@ void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type)
 
 	state->bonded = true;
 
+	if (bdaddr_type == BDADDR_BREDR)
+		btd_bearer_bonded(device->bredr);
+	else
+		btd_bearer_bonded(device->le);
+
 	btd_device_set_temporary(device, false);
 
 	/* If the other bearer state was already true we don't need to
@@ -6863,6 +6897,11 @@ void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type)
 
 	state->paired = true;
 
+	if (bdaddr_type == BDADDR_BREDR)
+		btd_bearer_paired(dev->bredr);
+	else
+		btd_bearer_paired(dev->le);
+
 	/* If the other bearer state was already true we don't need to
 	 * send any property signals.
 	 */
@@ -6887,6 +6926,11 @@ void device_set_unpaired(struct btd_device *dev, uint8_t bdaddr_type)
 
 	state->paired = false;
 
+	if (bdaddr_type == BDADDR_BREDR)
+		btd_bearer_paired(dev->bredr);
+	else
+		btd_bearer_paired(dev->le);
+
 	/*
 	 * If the other bearer state is still true we don't need to
 	 * send any property signals or remove device.
-- 
2.50.0

