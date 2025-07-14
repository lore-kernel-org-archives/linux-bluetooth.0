Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABF02367DE
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525337; cv=none; b=eieh9J24wFlv1bsI928bCy6RB6QfJUPGMjA2IZq8qfupOUJ6nZ+qIu+GrHiIieEsbGejlL25hRnYNTjbM3yKR70hiIqF7qmuzsdNoKsAd1wryvZ+c2nF3cVXMPZ2/AG2Mr2N0bOw8rHZoPhipDr8+hqXmej2HUlIw9eAp93rtpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525337; c=relaxed/simple;
	bh=Yr8n/us0Ejv9yugDMA/MkWrNbMXIJMPVNf88pWcMAhc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuhMaU/olN5x7uur5QJt0JRfwYSTd0DO8hkHG+DQWwFakR3EzHvgQShnehAC7G47v7hs0qnfJQLL5F8B/zkphiAhys82wsjNnTBlG/2nylw/f84Eh12BLUWGIcLIL4CfVGBqsoxXTRbWaK2yEQJ7YWULSN9gf8k2/KrsQzyJBsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3OJMTog; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3OJMTog"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-532d498eb95so2120969e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752525333; x=1753130133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSxANV+4K+l+ybWCO0XRXiuWCZyhH++vpYjfiOcHWfE=;
        b=R3OJMTog5qtuRWqHz/BcopblyVQ3UPMkcYQI5/g6r7ZsrbVzrWb5Um2QDxD5lwPVr7
         qJvI83XwMWMZx+wuUthMqB3YRM9Dqu47uW4sDn6WS7GXGR17xAD0KaB8Nl4h8LMPfDvG
         hcvjl+xF3RE6H/lcQAmQqBRldVM6zUMftxbOOzeqnTOybzj45584ReR5/9QSx7+iiBoq
         bZVrxgqcssBmFJNnzyn4ORa+YSCVsklMaQ6RbmeapygDA9GBjvd8GByIMO13BbSbpybj
         FvZpFzZAFqf8YNuX7COBgbRFwoSSmYDF5EziwngfKmS+hCIuIyUgbNgCbVyhDp/BNfdV
         colw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752525333; x=1753130133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSxANV+4K+l+ybWCO0XRXiuWCZyhH++vpYjfiOcHWfE=;
        b=lgvHmaYXBXdGEK1atNdMLix/NrBndMJwOwwQnIch10w1/1dRnllKoaCOX1DziRRbDw
         K0cdztFY3EI/oYoqzLmgm4NC+0wtG+4Q0TMZ5zP4BbkaGc2begtIbaulphHDQ+p0o2Pq
         qrebRzfO1WMgb1JBN++nNnf989jvqza+KXn53OBxP4yD6g/zsPHqcDnvXf4ahSElw81J
         xXeOgyInYB6SCFqbUdv97/Agx6+jhk8vTDKADTSmeo0/Ra/ynzStyjFQ0lSPD9gP3mHQ
         inVSPk2Ll7kVz6SsHLwFSuEsORtFaBPPdK0angXOE63Ul/FMJ4V4ERkRLzxOriSEV+Fg
         JscA==
X-Gm-Message-State: AOJu0Yy67qtwSlD3kn8ULZyZGAJTA0uskCIxasu5k1H3ZbzFAmNPJefy
	d+GFK46M01adxA6ywjr89fAX+PIMGlPcB0H9NoT/uMWOLNim8hrIqv9GRhOOYusx
X-Gm-Gg: ASbGncs1RYYneNGBncO6tWoyze00YIm0G5KyJ0KFEi8Uzc0Z/lE8zxS/CTfkkHxh49V
	r1T+O72vlv4mofolvdsR1GMzy+Kko3i5svy6JT4kOyFltJp1D/nNLp84QsPf6XOFYjqUXn2xrVE
	bBFLiQr65wZjX9KWkNCpf6QGJPUmVy2BA2lbynlRduyYmh4G/sWufjTC+v/q4yW6FiWKdgV+cLn
	B5Gl0Frk7tgxMwE6JgSFJMISMzZd4nYhdqVwnNOK42fj+S5lnsHJHU8vZiTSOgC/RvbPDxUiwSL
	9cTBFBT7vMxMczHG3Tb6WYw8o/MXbsHGGOZzZy9lAbFQ3Z4LhyDzWKAp65CHbcLQElijg2PbUUR
	h03PZuoY1R1wJixS1MwmD8Alpjaaue5xLUtCxeHuIEHcLYZdXTu6ZZE9HnawKX2XJ
X-Google-Smtp-Source: AGHT+IFCBquyh937Kb2hMeMTMoam5GlP/IKrlAvgOvAI4p/IUoPGih12TeZFNYVCPY0HUdzgWlOZVg==
X-Received: by 2002:a05:6102:2c0f:b0:4e6:dbbc:16d0 with SMTP id ada2fe7eead31-4f641e9b649mr9167081137.14.1752525332536;
        Mon, 14 Jul 2025 13:35:32 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-888ec44a6f6sm1887177241.24.2025.07.14.13.35.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 13:35:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] bearer: Add initial implementation of org.bluez.Bearer.{BREDR, LE}
Date: Mon, 14 Jul 2025 16:35:17 -0400
Message-ID: <20250714203519.345226-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714203519.345226-1-luiz.dentz@gmail.com>
References: <20250714203519.345226-1-luiz.dentz@gmail.com>
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
 src/bearer.c | 260 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/bearer.h |  22 +++++
 src/device.c |  66 ++++++++++---
 4 files changed, 339 insertions(+), 12 deletions(-)
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
index 000000000000..d4286b431583
--- /dev/null
+++ b/src/bearer.c
@@ -0,0 +1,260 @@
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
+static gboolean bearer_get_adapter(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_bearer *bearer = data;
+	struct btd_adapter *adapter = device_get_adapter(bearer->device);
+	const char *path = adapter_get_path(adapter);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
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
+	{ "Adapter", "o", bearer_get_adapter, NULL, NULL,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
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

