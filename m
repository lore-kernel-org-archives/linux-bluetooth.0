Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187701509A5
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058975; cv=none; b=Wd6U5N46eW2ETgr2ZMrtuEGnKv7bzZD6vQifuyv92Xizjp9+YEZtDk1dzqpwFRIBDloYXLUtmxy8WKd03/oqkYJiFfWO46Hl5WJUBKKYlLWMjsWPpZET0FhO6nn+EcEb+7CngecNMkb1aN1+M2TpXgrj9Yo8mY9SNSQV87tYPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058975; c=relaxed/simple;
	bh=QuMrTDnBnYoru9RgjjLGoOXPZcj2+6cHE0YCjC//44I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAVFDZDiczyp65CNImvHySS3eS/2XHo9HEPdLeluw8+duKhQ40g40L6tvpV9ELKTOIsVmBjqZ9eec+Ja5D3gcPrx7G02mOhimwUjRBA5+ONlxmJ2cdxOtdulJ6H5Hq5MPWfIlmVex2B+gTk7XNYk/l5uX97pV97xqpRx7NkwnuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=XDP1lvVe; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="XDP1lvVe"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62a2a6a5ccfso6135407b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1718058971; x=1718663771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITIKDbzW/4wq+RqRcHAE3OjjzLRleV+jOvXcRNP9CXY=;
        b=XDP1lvVeaPy+SqoQDbtWqka1rw3MyzdQvcOhBoxDezUrQ0EpDrRKksIzn62NF7Dwcs
         dzuhEQr2SI6XlpSZS5U3IfvnfjM/+nlV0FC43sTGAVgIE/fO4U58cYJnKT2r19btYeSM
         W3b2F3A0LnWUPh4vfREFZD24ahPflibjV5Zfz+8WMNVlbpMhKwuP7Zi6SbI4KWPuAALg
         MmTZ82gRVTHCmDebOQfVQLWrb5TxF3Bw+Dy3SxlqDFPzS34XZSh4AcDPB5Kd3IHQUXba
         z7HI3mv5u+HQEn2yVg0S0D0qgtmuzRvch//AmgSOBFxhxJxVv038bpKruiuOgrMm4UDB
         zpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058971; x=1718663771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITIKDbzW/4wq+RqRcHAE3OjjzLRleV+jOvXcRNP9CXY=;
        b=g+Cvudpfu3IXCDUDxP3bXd9axgMByz0QfveguklSt70IwivsPe+Jyz6xzMAGEgn/QM
         DQt6FhyriEpbc1LiaQmwNTQX+5INKNVYo0KeT/xlAhlFu+3jC3MHGcW7meQ+dzRPNBJK
         2jvrDLC9opOeHdYeZkWUY53WH/KKLurVDaGVB33jdr5uJx1GG4uxOO1Z7fTgE6gWJdro
         nl771aH7lC55Nh8GEsoOECfLElxRzkFsTSAjBVQKeAc97cwlSzrTr4fJYPp10ZUPI7uC
         iKrCRbOpHuYFWKp9y323HASxvjGEmZo3WbsD+DP09qSSlm04Iny/vgmNk97uN5BxDGGV
         3eRw==
X-Gm-Message-State: AOJu0YzZB6QiTwIhZ2FRKp5eQKDEZe6+QeQ9E8rCrfVgQglq1ZIryU5u
	SOsY8JczX1cCLbW0Rw3UYXW6S2KotDsBpeQ8c2g5QCkArac03KFgTxzligHv8vGpY5KYQhiInhc
	P
X-Google-Smtp-Source: AGHT+IFrc9xqsbsNa2Yxxcn5DT8JSnjqBrODfPBJzO2sHGflO8FedbImJTVbRE9V/82c8OZ2om2pMw==
X-Received: by 2002:a0d:eb47:0:b0:627:a917:76b1 with SMTP id 00721157ae682-62cd5688263mr105885967b3.44.1718058970386;
        Mon, 10 Jun 2024 15:36:10 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440711c3c53sm16283221cf.80.2024.06.10.15.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:36:10 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v9 2/3] profiles/audio: Add an ASHA plugin
Date: Mon, 10 Jun 2024 18:36:00 -0400
Message-ID: <20240610223601.378127-3-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240610223601.378127-1-arun@asymptotic.io>
References: <20240610223601.378127-1-arun@asymptotic.io>
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
 profiles/audio/asha.c      | 524 +++++++++++++++++++++++++++++++++++++
 profiles/audio/asha.h      |  38 +++
 profiles/audio/media.c     |  30 +++
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c | 201 +++++++++++++-
 7 files changed, 802 insertions(+), 2 deletions(-)
 create mode 100644 profiles/audio/asha.c
 create mode 100644 profiles/audio/asha.h

diff --git a/Makefile.plugins b/Makefile.plugins
index 4aa2c9c92..44fda4536 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -147,3 +147,8 @@ if CSIP
 builtin_modules += csip
 builtin_sources += profiles/audio/csip.c
 endif
+
+if ASHA
+builtin_modules += asha
+builtin_sources += profiles/audio/asha.h profiles/audio/asha.c
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
index 000000000..1c4f751d1
--- /dev/null
+++ b/profiles/audio/asha.c
@@ -0,0 +1,524 @@
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
+#include <errno.h>
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <sys/socket.h>
+
+#include <dbus/dbus.h>
+#include <glib.h>
+
+#include "btio/btio.h"
+#include "gdbus/gdbus.h"
+#include "lib/bluetooth.h"
+#include "lib/l2cap.h"
+#include "lib/uuid.h"
+
+#include "src/dbus-common.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/log.h"
+#include "src/plugin.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/shared/util.h"
+
+#include "profiles/audio/asha.h"
+#include "profiles/audio/media.h"
+#include "profiles/audio/transport.h"
+
+#define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
+
+/* 2 byte SDU length, 1 byte sequence number, and then 20ms of G.722 */
+#define ASHA_MIN_MTU 163
+/* The default of 672 does not work */
+#define ASHA_CONNECTION_MTU 512
+
+struct bt_asha_device {
+	struct bt_asha *asha;
+	struct btd_device *device;
+	struct media_transport *transport;
+
+	GIOChannel *io;
+	uint16_t imtu, omtu;
+
+	unsigned int resume_id;
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
+}
+
+struct connect_data {
+	struct bt_asha_device *asha_dev;
+	bt_asha_cb_t cb;
+	void *cb_user_data;
+};
+
+static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
+{
+	struct connect_data *conn_data = user_data;
+	struct bt_asha_device *asha_dev = conn_data->asha_dev;
+	GError *gerr = NULL;
+
+	if (!bt_io_get(io, &gerr,
+				BT_IO_OPT_IMTU, &asha_dev->imtu,
+				BT_IO_OPT_OMTU, &asha_dev->omtu,
+				BT_IO_OPT_INVALID )) {
+		/* Let this be non-fatal? */
+		asha_dev->omtu = ASHA_MIN_MTU;
+		asha_dev->imtu = ASHA_CONNECTION_MTU;
+		error("Could not get L2CAP CoC socket MTU: %s", err->message);
+		g_error_free(gerr);
+	}
+
+	asha_dev->io = io;
+
+	bt_asha_start(asha_dev->asha, conn_data->cb,
+					conn_data->cb_user_data);
+}
+
+static int asha_connect_socket(struct bt_asha_device *asha_dev,
+					bt_asha_cb_t cb, void *user_data)
+{
+	GError *gerr = NULL;
+	const bdaddr_t *src_addr;
+	struct connect_data *conn_data;
+
+	if (asha_dev->asha->state != ASHA_STOPPED) {
+		error("ASHA device connect failed. Bad state %d",
+							asha_dev->asha->state);
+		return 0;
+	}
+
+	conn_data = g_new0(struct connect_data, 1);
+	conn_data->asha_dev = asha_dev;
+	conn_data->cb = cb;
+	conn_data->cb_user_data = user_data;
+
+	src_addr = btd_adapter_get_address(
+			device_get_adapter(asha_dev->device));
+
+	if (!bt_io_connect(connect_cb, conn_data,
+				g_free, &gerr,
+				BT_IO_OPT_MODE, BT_IO_MODE_LE_FLOWCTL,
+				BT_IO_OPT_SOURCE_TYPE, BDADDR_LE_PUBLIC,
+				BT_IO_OPT_SOURCE_BDADDR, src_addr,
+				BT_IO_OPT_DEST_TYPE, BDADDR_LE_PUBLIC,
+				BT_IO_OPT_DEST_BDADDR, device_get_address(asha_dev->device),
+				BT_IO_OPT_PSM, asha_dev->asha->psm,
+				BT_IO_OPT_OMTU, ASHA_MIN_MTU,
+				BT_IO_OPT_IMTU, ASHA_CONNECTION_MTU,
+				BT_IO_OPT_INVALID)) {
+		error("Could not open L2CAP CoC socket: %s", gerr->message);
+		g_error_free(gerr);
+		goto error;
+	}
+
+	DBG("L2CAP CoC socket is open");
+	return 0;
+
+error:
+	return -1;
+}
+
+unsigned int bt_asha_device_start(struct bt_asha_device *asha_dev,
+					bt_asha_cb_t cb, void *user_data)
+{
+	int ret;
+
+	btd_device_set_conn_param(asha_dev->device,
+			0x0010 /* min interval = 1.25ms intervals => 20ms */,
+			0x0010 /* max interval = 1.25ms intervals => 20ms */,
+			0x000A /* 10 events' latency */,
+			0x0064 /* 1s timeout */);
+
+	ret = asha_connect_socket(asha_dev, cb, user_data);
+
+	if (ret < 0)
+		return 0;
+	else
+		return (++asha_dev->resume_id);
+}
+
+unsigned int bt_asha_device_stop(struct bt_asha_device *asha_dev,
+					bt_asha_cb_t cb, void *user_data)
+{
+	bt_asha_stop(asha_dev->asha, cb, user_data);
+
+	if (asha_dev->io) {
+		g_io_channel_shutdown(asha_dev->io, TRUE, NULL);
+		g_io_channel_unref(asha_dev->io);
+		asha_dev->io = NULL;
+	};
+
+	return asha_dev->resume_id;
+}
+
+void bt_asha_device_state_reset(struct bt_asha_device *asha_dev)
+{
+	if (asha_dev->io) {
+		g_io_channel_shutdown(asha_dev->io, TRUE, NULL);
+		g_io_channel_unref(asha_dev->io);
+		asha_dev->io = NULL;
+	};
+
+	bt_asha_state_reset(asha_dev->asha);
+
+	asha_dev->resume_id = 0;
+}
+
+unsigned int bt_asha_device_device_get_resume_id(
+					struct bt_asha_device *asha_dev)
+{
+	return asha_dev->resume_id;
+}
+
+enum bt_asha_state_t bt_asha_device_get_state(
+					struct bt_asha_device *asha_dev)
+{
+	return asha_dev->asha->state;
+}
+
+uint16_t bt_asha_device_get_render_delay(struct bt_asha_device *asha_dev)
+{
+	return asha_dev->asha->render_delay;
+}
+
+int8_t bt_asha_device_get_volume(struct bt_asha_device *asha_dev)
+{
+	return asha_dev->asha->volume;
+}
+
+bool bt_asha_device_set_volume(struct bt_asha_device *asha_dev, int8_t volume)
+{
+	return bt_asha_set_volume(asha_dev->asha, volume);
+}
+
+int bt_asha_device_get_fd(struct bt_asha_device *asha_dev)
+{
+	return g_io_channel_unix_get_fd(asha_dev->io);
+}
+
+uint16_t bt_asha_device_get_imtu(struct bt_asha_device *asha_dev)
+{
+	return asha_dev->imtu;
+}
+
+uint16_t bt_asha_device_get_omtu(struct bt_asha_device *asha_dev)
+{
+	return asha_dev->omtu;
+}
+
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
+	asha_dev->asha = bt_asha_new();
+	asha_dev->io = NULL;
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
+					NULL, 0, (void *) asha_ep, asha_dev);
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
+	if (!bt_asha_probe(asha_dev->asha, db, client))
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
diff --git a/profiles/audio/asha.h b/profiles/audio/asha.h
new file mode 100644
index 000000000..afd23e137
--- /dev/null
+++ b/profiles/audio/asha.h
@@ -0,0 +1,38 @@
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
+#include <stdbool.h>
+#include <stdint.h>
+
+#include "src/shared/asha.h"
+
+struct bt_asha_device;
+
+unsigned int bt_asha_device_start(struct bt_asha_device *asha_dev,
+					bt_asha_cb_t cb, void *user_data);
+unsigned int bt_asha_device_stop(struct bt_asha_device *asha_dev,
+					bt_asha_cb_t cb, void *user_data);
+
+void bt_asha_device_state_reset(struct bt_asha_device *asha_dev);
+unsigned int bt_asha_device_device_get_resume_id(
+					struct bt_asha_device *asha_dev);
+
+uint16_t bt_asha_device_get_render_delay(struct bt_asha_device *asha_dev);
+enum bt_asha_state_t bt_asha_device_get_state(
+					struct bt_asha_device *asha_dev);
+
+int bt_asha_device_get_fd(struct bt_asha_device *asha_dev);
+uint16_t bt_asha_device_get_omtu(struct bt_asha_device *asha_dev);
+uint16_t bt_asha_device_get_imtu(struct bt_asha_device *asha_dev);
+
+int8_t bt_asha_device_get_volume(struct bt_asha_device *asha_dev);
+bool bt_asha_device_set_volume(struct bt_asha_device *asha_dev, int8_t volume);
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
index 5b11bfeb6..0ce94bae3 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -37,6 +37,7 @@
 #include "src/shared/bap.h"
 #include "src/shared/io.h"
 
+#include "asha.h"
 #include "avdtp.h"
 #include "media.h"
 #include "transport.h"
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
+	struct bt_asha_device *asha_dev = transport->data;
+	uint16_t delay;
+
+	// Delay property is in 1/10ths of ms, while ASHA RenderDelay is in ms
+	delay = bt_asha_device_get_render_delay(asha_dev) * 10;
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
@@ -1716,6 +1746,164 @@ static void *transport_bap_init(struct media_transport *transport, void *stream)
 	return bap;
 }
 
+static void asha_transport_sync_state(struct media_transport *transport,
+						struct bt_asha_device *asha_dev)
+{
+	switch (bt_asha_device_get_state(asha_dev)) {
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
+	struct bt_asha_device *asha_dev;
+	enum bt_asha_state_t state;
+
+	if (!transport) {
+		DBG("Lost owner while connecting, bailing");
+		return;
+	}
+
+	asha_dev = transport->data;
+	state = bt_asha_device_get_state(asha_dev);
+
+	if (state == ASHA_STARTED) {
+		int fd;
+		uint16_t imtu, omtu;
+		gboolean ret;
+
+		fd = bt_asha_device_get_fd(asha_dev);
+		imtu = bt_asha_device_get_imtu(asha_dev);
+		omtu = bt_asha_device_get_omtu(asha_dev);
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
+	asha_transport_sync_state(transport, asha_dev);
+}
+
+static guint transport_asha_resume(struct media_transport *transport,
+						struct media_owner *owner)
+{
+	struct bt_asha_device *asha_dev = transport->data;
+	guint ret;
+
+	ret = bt_asha_device_start(asha_dev, asha_transport_state_cb, owner);
+	asha_transport_sync_state(transport, asha_dev);
+
+	return ret > 0 ? ret : 0;
+}
+
+static guint transport_asha_suspend(struct media_transport *transport,
+						struct media_owner *owner)
+{
+	struct bt_asha_device *asha_dev = transport->data;
+	guint ret = 0;
+
+	if (owner) {
+		ret = bt_asha_device_stop(asha_dev, asha_transport_state_cb,
+									owner);
+		asha_transport_sync_state(transport, asha_dev);
+	} else {
+		ret = bt_asha_device_stop(asha_dev, NULL, NULL);
+		/* We won't have a callback to set the final state */
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	}
+
+	return ret;
+}
+
+static void transport_asha_cancel(struct media_transport *transport, guint id)
+{
+	struct bt_asha_device *asha_dev = transport->data;
+	enum bt_asha_state_t state = bt_asha_device_get_state(asha_dev);
+
+	if (id != bt_asha_device_device_get_resume_id(asha_dev)) {
+		/* Not current, ignore */
+		DBG("Ignoring cancel request for id %d", id);
+		return;
+	}
+
+	if (state == ASHA_STARTING || state == ASHA_STARTED) {
+		DBG("Cancel requested, stopping");
+		bt_asha_device_stop(asha_dev, NULL, NULL);
+		/* We won't have a callback to set the final state */
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	} else if (state == ASHA_STOPPING) {
+		DBG("Cancel requested, resetting transport state");
+		/* We already dispatched a stop, just reset our state */
+		bt_asha_device_state_reset(asha_dev);
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	}
+}
+
+static int8_t transport_asha_get_volume(struct media_transport *transport)
+{
+	struct bt_asha_device *asha_dev = transport->data;
+	int8_t volume;
+	int scaled_volume;
+
+	volume = bt_asha_device_get_volume(asha_dev);
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
+	struct bt_asha_device *asha_dev = transport->data;
+	int scaled_volume;
+
+	/* Convert 0-127 to -128-0 */
+	scaled_volume = ((((int) volume) * 128) / 127) - 128;
+
+	return bt_asha_device_set_volume(asha_dev, scaled_volume) ? 0 : -EIO;
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
@@ -1757,6 +1945,14 @@ static void *transport_bap_init(struct media_transport *transport, void *stream)
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
@@ -1768,6 +1964,7 @@ static const struct media_transport_ops transport_ops[] = {
 	BAP_UC_OPS(PAC_SINK_UUID),
 	BAP_BC_OPS(BCAA_SERVICE_UUID),
 	BAP_BC_OPS(BAA_SERVICE_UUID),
+	ASHA_OPS(ASHA_PROFILE_UUID),
 };
 
 static const struct media_transport_ops *
@@ -1805,7 +2002,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 	transport->endpoint = endpoint;
 	transport->configuration = util_memdup(configuration, size);
 	transport->size = size;
-	transport->remote_endpoint = remote_endpoint;
+	transport->remote_endpoint = g_strdup(remote_endpoint);
 
 	if (device)
 		transport->path = g_strdup_printf("%s/fd%d",
-- 
2.45.2

