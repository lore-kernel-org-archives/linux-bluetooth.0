Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D308C0502C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Aug 2022 00:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345096AbiH0AFz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 20:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiH0AFx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 20:05:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B621E42ED
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 199so2922380pfz.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=Yoe4noJuNjEWlWGOqPX3R0F/FXc8Ptn+t64/XmAnJP8=;
        b=eGby75WMFGLrfPTT1iyG5M9fScqltZSbBjS5sAPeT6kQ5GCKkL549fXevh0ag31gJ0
         G3qdvlG2Mx5L62U/g6UaFZInOb7Vd+UTnnYbAbl7BuOSNGVAFRDFyCNjoi8G2DY/b40u
         svdxklfvbvXDydjNFFVJcgVkmqL6n5wYKWUFIf1RJx85Cft/FmSP99juAc4YMa9H9RBn
         ytZPid0ogrw8DSFHe6/dG1zbOGHe0VSmj3ZT25lZxFyOHhYnCafKjOU8RXF16eYkjVWE
         tOVX0GTJcRg6kIPYhx5Cv2HYX/rBO5UISPC/6QtpJC/PhgtnWXEI98C36jeHe3RBGe0n
         RMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=Yoe4noJuNjEWlWGOqPX3R0F/FXc8Ptn+t64/XmAnJP8=;
        b=IJHRGGWMfQD30WPyAVOCgXZIxAys7kEuP97RcudW7BIMRFM09XYk4FIfU3urIRK0IE
         dlCQ/qDyWnXfRUQAeMWedIxfg88TpMT5vAKCOloqP407csGruBYd7w3X7SqZmDfwQfWz
         1lkXurVzyFSfsDANjbNeXfFEAu501XSqN7LA3/wx+fCFs+nQS/qrBAkXjMAeX93AWgZK
         Y0/N2zZHZDZT0bCeN+fRRDLnHQsd3Ol4WXYhqUN1SSZHdnZ9PUMJqc9XR1T54I/n+liO
         ZRNZITBJ70voV1XxHCnvnig9qC4/S8ixQk7aypF2PsCRBCY7fkPz0ps6uMIffHI58Z/T
         3BQw==
X-Gm-Message-State: ACgBeo0hQwTDlrEQ6dQhwmrjqS1riALW9fV/+eX3BAs2585wEmjKJDKE
        BIqYIL8AVVgZynfuIHDz5qKwDESiq1I=
X-Google-Smtp-Source: AA6agR5xsUUeUoLPzB1TRkdLecc87RHkF+qkxPSVbhReVNihzAWJLnyCGHJc995FYf0bmkp29DUeFw==
X-Received: by 2002:a63:ee55:0:b0:429:88cf:78df with SMTP id n21-20020a63ee55000000b0042988cf78dfmr5075799pgk.301.1661558748082;
        Fri, 26 Aug 2022 17:05:48 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090a168100b001fa8b909ef0sm2249487pja.7.2022.08.26.17.05.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 17:05:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 04/11] profiles: Add initial code for bap plugin
Date:   Fri, 26 Aug 2022 17:05:33 -0700
Message-Id: <20220827000540.113414-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827000540.113414-1-luiz.dentz@gmail.com>
References: <20220827000540.113414-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initial code for bap plugin which handles Basic Audio
Profile, Publish Audio Capabilities Service and Audio Stream Control
Service.
---
 Makefile.plugins           |    5 +
 configure.ac               |    4 +
 profiles/audio/bap.c       | 1324 ++++++++++++++++++++++++++++++++++++
 profiles/audio/media.c     |  678 ++++++++++++++++--
 profiles/audio/transport.c |  552 ++++++++++++++-
 profiles/audio/transport.h |    3 +-
 6 files changed, 2518 insertions(+), 48 deletions(-)
 create mode 100644 profiles/audio/bap.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 7693c767f785..213ed99edf2d 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -116,3 +116,8 @@ plugins_sixaxis_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version
 plugins_sixaxis_la_LIBADD = $(UDEV_LIBS)
 plugins_sixaxis_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
 endif
+
+if BAP
+builtin_modules += bap
+builtin_sources += profiles/audio/bap.c
+endif
diff --git a/configure.ac b/configure.ac
index 91fd194116f4..1f76915b4349 100644
--- a/configure.ac
+++ b/configure.ac
@@ -195,6 +195,10 @@ AC_ARG_ENABLE(health, AS_HELP_STRING([--enable-health],
 		[enable health profiles]), [enable_health=${enableval}])
 AM_CONDITIONAL(HEALTH, test "${enable_health}" = "yes")
 
+AC_ARG_ENABLE(bap, AS_HELP_STRING([--disable-bap],
+		[disable BAP profile]), [enable_bap=${enableval}])
+AM_CONDITIONAL(BAP, test "${enable_bap}" != "no")
+
 AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
new file mode 100644
index 000000000000..01ac03026259
--- /dev/null
+++ b/profiles/audio/bap.c
@@ -0,0 +1,1324 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
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
+#include <ctype.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "gdbus/gdbus.h"
+
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
+#include "lib/sdp.h"
+#include "lib/uuid.h"
+
+#include "src/dbus-common.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/bap.h"
+
+#include "btio/btio.h"
+#include "src/plugin.h"
+#include "src/adapter.h"
+#include "src/gatt-database.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/log.h"
+#include "src/error.h"
+
+#define PACS_UUID_STR "00001850-0000-1000-8000-00805f9b34fb"
+#define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
+
+struct bap_ep {
+	char *path;
+	struct bap_data *data;
+	struct bt_bap_pac *lpac;
+	struct bt_bap_pac *rpac;
+	struct bt_bap_stream *stream;
+	GIOChannel *io;
+	unsigned int io_id;
+	bool recreate;
+	struct iovec *caps;
+	struct iovec *metadata;
+	struct bt_bap_qos qos;
+	unsigned int id;
+	DBusMessage *msg;
+};
+
+struct bap_data {
+	struct btd_device *device;
+	struct btd_service *service;
+	struct bt_bap *bap;
+	unsigned int ready_id;
+	unsigned int state_id;
+	unsigned int pac_id;
+	struct queue *srcs;
+	struct queue *snks;
+	struct queue *streams;
+	GIOChannel *listen_io;
+};
+
+static struct queue *sessions;
+
+static void bap_debug(const char *str, void *user_data)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
+static void ep_unregister(void *data)
+{
+	struct bap_ep *ep = data;
+
+	DBG("ep %p path %s", ep, ep->path);
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(), ep->path,
+						MEDIA_ENDPOINT_INTERFACE);
+}
+
+static void bap_data_free(struct bap_data *data)
+{
+	if (data->listen_io) {
+		g_io_channel_shutdown(data->listen_io, TRUE, NULL);
+		g_io_channel_unref(data->listen_io);
+	}
+
+	if (data->service) {
+		btd_service_set_user_data(data->service, NULL);
+		bt_bap_set_user_data(data->bap, NULL);
+	}
+
+	queue_destroy(data->snks, ep_unregister);
+	queue_destroy(data->srcs, ep_unregister);
+	queue_destroy(data->streams, NULL);
+	bt_bap_ready_unregister(data->bap, data->ready_id);
+	bt_bap_state_unregister(data->bap, data->state_id);
+	bt_bap_pac_unregister(data->pac_id);
+	bt_bap_unref(data->bap);
+	free(data);
+}
+
+static void bap_data_remove(struct bap_data *data)
+{
+	DBG("data %p", data);
+
+	if (!queue_remove(sessions, data))
+		return;
+
+	bap_data_free(data);
+
+	if (queue_isempty(sessions)) {
+		queue_destroy(sessions, NULL);
+		sessions = NULL;
+	}
+}
+
+static void bap_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bap_data *data;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	data = btd_service_get_user_data(service);
+	if (!data) {
+		error("BAP service not handled by profile");
+		return;
+	}
+
+	bap_data_remove(data);
+}
+
+static gboolean get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bap_ep *ep = data;
+	const char *uuid;
+
+	if (queue_find(ep->data->snks, NULL, ep))
+		uuid = PAC_SINK_UUID;
+	else
+		uuid = PAC_SOURCE_UUID;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+
+	return TRUE;
+}
+
+static gboolean get_codec(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bap_ep *ep = data;
+	uint8_t codec;
+
+	bt_bap_pac_get_codec(ep->rpac, &codec, NULL, NULL);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &codec);
+
+	return TRUE;
+}
+
+static gboolean get_capabilities(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bap_ep *ep = data;
+	DBusMessageIter array;
+	struct iovec *d;
+
+	bt_bap_pac_get_codec(ep->rpac, NULL, &d, NULL);
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&d->iov_base, d->iov_len);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static gboolean get_device(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bap_ep *ep = data;
+	const char *path;
+
+	path = device_get_path(ep->data->device);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable ep_properties[] = {
+	{ "UUID", "s", get_uuid, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Codec", "y", get_codec, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Capabilities", "ay", get_capabilities, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Device", "o", get_device, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ }
+};
+
+static int parse_array(DBusMessageIter *iter, struct iovec **iov)
+{
+	DBusMessageIter array;
+
+	if (!iov)
+		return 0;
+
+	if (!(*iov))
+		*iov = new0(struct iovec, 1);
+
+	dbus_message_iter_recurse(iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &(*iov)->iov_base,
+						(int *)&(*iov)->iov_len);
+	return 0;
+}
+
+static int parse_properties(DBusMessageIter *props, struct iovec **caps,
+				struct iovec **metadata, struct bt_bap_qos *qos)
+{
+	const char *key;
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
+		if (!strcasecmp(key, "Capabilities")) {
+			if (var != DBUS_TYPE_ARRAY)
+				goto fail;
+
+			if (parse_array(&value, caps))
+				goto fail;
+		} else if (!strcasecmp(key, "Metadata")) {
+			if (var != DBUS_TYPE_ARRAY)
+				goto fail;
+
+			if (parse_array(&value, metadata))
+				goto fail;
+		} else if (!strcasecmp(key, "CIG")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->cig_id);
+		} else if (!strcasecmp(key, "CIS")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->cis_id);
+		} else if (!strcasecmp(key, "Interval")) {
+			if (var != DBUS_TYPE_UINT32)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->interval);
+		} else if (!strcasecmp(key, "Framing")) {
+			dbus_bool_t val;
+
+			if (var != DBUS_TYPE_BOOLEAN)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &val);
+
+			qos->framing = val;
+		} else if (!strcasecmp(key, "PHY")) {
+			const char *str;
+
+			if (var != DBUS_TYPE_STRING)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &str);
+
+			if (!strcasecmp(str, "1M"))
+				qos->phy = 0x01;
+			else if (!strcasecmp(str, "2M"))
+				qos->phy = 0x02;
+			else
+				goto fail;
+		} else if (!strcasecmp(key, "SDU")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->sdu);
+		} else if (!strcasecmp(key, "Retransmissions")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->rtn);
+		} else if (!strcasecmp(key, "Latency")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->latency);
+		} else if (!strcasecmp(key, "Delay")) {
+			if (var != DBUS_TYPE_UINT32)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->delay);
+		} else if (!strcasecmp(key, "TargetLatency")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->target_latency);
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
+	if (*caps) {
+		free(*caps);
+		*caps = NULL;
+	}
+
+	return -EINVAL;
+}
+
+static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	struct bap_ep *ep = user_data;
+	DBusMessage *reply;
+
+	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
+
+	if (!ep->msg)
+		return;
+
+	if (!code)
+		reply = dbus_message_new_method_return(ep->msg);
+	else
+		reply = btd_error_failed(ep->msg, "Unable to configure");
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+	dbus_message_unref(ep->msg);
+	ep->msg = NULL;
+}
+
+static void config_cb(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	struct bap_ep *ep = user_data;
+	DBusMessage *reply;
+
+	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
+
+	ep->id = 0;
+
+	if (!code)
+		return;
+
+	if (!ep->msg)
+		return;
+
+	reply = btd_error_failed(ep->msg, "Unable to configure");
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+	dbus_message_unref(ep->msg);
+	ep->msg = NULL;
+}
+
+static void bap_io_close(struct bap_ep *ep)
+{
+	int fd;
+
+	if (ep->io_id) {
+		g_source_remove(ep->io_id);
+		ep->io_id = 0;
+	}
+
+	if (!ep->io)
+		return;
+
+
+	DBG("ep %p", ep);
+
+	fd = g_io_channel_unix_get_fd(ep->io);
+	close(fd);
+
+	g_io_channel_unref(ep->io);
+	ep->io = NULL;
+}
+
+static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct bap_ep *ep = data;
+	const char *path;
+	DBusMessageIter args, props;
+
+	if (ep->msg)
+		return btd_error_busy(msg);
+
+	dbus_message_iter_init(msg, &args);
+
+	dbus_message_iter_get_basic(&args, &path);
+	dbus_message_iter_next(&args);
+
+	dbus_message_iter_recurse(&args, &props);
+	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
+		return btd_error_invalid_args(msg);
+
+	/* Disconnect IO if connecting since QoS is going to be reconfigured */
+	if (bt_bap_stream_io_is_connecting(ep->stream, NULL)) {
+		bap_io_close(ep);
+		bt_bap_stream_io_connecting(ep->stream, -1);
+	}
+
+	/* Mark CIG and CIS to be auto assigned */
+	ep->qos.cig_id = BT_ISO_QOS_CIG_UNSET;
+	ep->qos.cis_id = BT_ISO_QOS_CIS_UNSET;
+
+	if (parse_properties(&props, &ep->caps, &ep->metadata, &ep->qos) < 0) {
+		DBG("Unable to parse properties");
+		return btd_error_invalid_args(msg);
+	}
+
+	/* TODO: Check if stream capabilities match add support for Latency
+	 * and PHY.
+	 */
+	if (ep->stream)
+		ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
+						config_cb, ep);
+	else
+		ep->stream = bt_bap_config(ep->data->bap, ep->lpac, ep->rpac,
+						&ep->qos, ep->caps,
+						config_cb, ep);
+
+	if (!ep->stream) {
+		DBG("Unable to config stream");
+		free(ep->caps);
+		ep->caps = NULL;
+		return btd_error_invalid_args(msg);
+	}
+
+	bt_bap_stream_set_user_data(ep->stream, ep->path);
+	ep->msg = dbus_message_ref(msg);
+
+	return NULL;
+}
+
+static const GDBusMethodTable ep_methods[] = {
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("SetConfiguration",
+					GDBUS_ARGS({ "endpoint", "o" },
+						{ "properties", "a{sv}" } ),
+					NULL, set_configuration) },
+	{ },
+};
+
+static void ep_free(void *data)
+{
+	struct bap_ep *ep = data;
+
+	if (ep->id)
+		bt_bap_stream_cancel(ep->stream, ep->id);
+
+	bap_io_close(ep);
+
+	free(ep->caps);
+	free(ep->path);
+	free(ep);
+}
+
+static struct bap_ep *ep_register(struct btd_service *service,
+					struct bt_bap_pac *lpac,
+					struct bt_bap_pac *rpac)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bap_data *data = btd_service_get_user_data(service);
+	struct bap_ep *ep;
+	struct queue *queue;
+	int i, err;
+	const char *suffix;
+
+	switch (bt_bap_pac_get_type(rpac)) {
+	case BT_BAP_SINK:
+		queue = data->snks;
+		i = queue_length(data->snks);
+		suffix = "sink";
+		break;
+	case BT_BAP_SOURCE:
+		queue = data->srcs;
+		i = queue_length(data->srcs);
+		suffix = "source";
+		break;
+	default:
+		return NULL;
+	}
+
+	ep = new0(struct bap_ep, 1);
+	ep->data = data;
+	ep->lpac = lpac;
+	ep->rpac = rpac;
+
+	err = asprintf(&ep->path, "%s/pac_%s%d", device_get_path(device),
+		       suffix, i);
+	if (err < 0) {
+		error("Could not allocate path for remote pac %s/pac%d",
+				device_get_path(device), i);
+		free(ep);
+		return NULL;
+	}
+
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+				ep->path, MEDIA_ENDPOINT_INTERFACE,
+				ep_methods, NULL, ep_properties,
+				ep, ep_free) == FALSE) {
+		error("Could not register remote ep %s", ep->path);
+		ep_free(ep);
+		return NULL;
+	}
+
+	DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->path);
+
+	queue_push_tail(queue, ep);
+
+	return ep;
+}
+
+static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
+				struct iovec *metadata, struct bt_bap_qos *qos,
+				void *user_data)
+{
+	struct bap_ep *ep = user_data;
+
+	if (err) {
+		error("err %d", err);
+		return;
+	}
+
+	ep->caps = caps;
+	ep->metadata = metadata;
+	ep->qos = *qos;
+
+	/* TODO: Check if stream capabilities match add support for Latency
+	 * and PHY.
+	 */
+	if (ep->stream)
+		ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
+						config_cb, ep);
+	else
+		ep->stream = bt_bap_config(ep->data->bap, ep->lpac, ep->rpac,
+						&ep->qos, ep->caps,
+						config_cb, ep);
+
+	if (!ep->stream) {
+		DBG("Unable to config stream");
+		free(ep->caps);
+		ep->caps = NULL;
+	}
+
+	bt_bap_stream_set_user_data(ep->stream, ep->path);
+}
+
+static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+							void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct bap_ep *ep;
+
+	DBG("lpac %p rpac %p", lpac, rpac);
+
+	ep = ep_register(service, lpac, rpac);
+	if (!ep) {
+		error("Unable to register endpoint for pac %p", rpac);
+		return true;
+	}
+
+	/* TODO: Cache LRU? */
+	if (btd_service_is_initiator(service))
+		bt_bap_select(lpac, rpac, select_cb, ep);
+
+	return true;
+}
+
+static void bap_ready(struct bt_bap *bap, void *user_data)
+{
+	struct btd_service *service = user_data;
+
+	DBG("bap %p", bap);
+
+	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_found, service);
+	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_found, service);
+}
+
+static bool match_ep_by_stream(const void *data, const void *user_data)
+{
+	const struct bap_ep *ep = data;
+	const struct bt_bap_stream *stream = user_data;
+
+	return ep->stream == stream;
+}
+
+static struct bap_ep *bap_find_ep_by_stream(struct bap_data *data,
+					struct bt_bap_stream *stream)
+{
+	struct bap_ep *ep;
+
+	ep = queue_find(data->snks, match_ep_by_stream, stream);
+	if (ep)
+		return ep;
+
+	return queue_find(data->srcs, match_ep_by_stream, stream);
+}
+
+static void iso_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	struct bt_bap_stream *stream = user_data;
+	int fd;
+
+	if (err) {
+		error("%s", err->message);
+		bt_bap_stream_set_io(stream, -1);
+		return;
+	}
+
+	DBG("ISO connected");
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	if (bt_bap_stream_set_io(stream, fd)) {
+		g_io_channel_set_close_on_unref(chan, FALSE);
+		return;
+	}
+
+	error("Unable to set IO");
+	bt_bap_stream_set_io(stream, -1);
+}
+
+static void bap_iso_qos(struct bt_bap_qos *qos, struct bt_iso_io_qos *io)
+{
+	if (!qos)
+		return;
+
+	io->interval = qos->interval;
+	io->latency = qos->latency;
+	io->sdu = qos->sdu;
+	io->phy = qos->phy;
+	io->rtn = qos->rtn;
+}
+
+static bool match_stream_qos(const void *data, const void *user_data)
+{
+	const struct bt_bap_stream *stream = data;
+	const struct bt_iso_qos *iso_qos = user_data;
+	struct bt_bap_qos *qos;
+
+	qos = bt_bap_stream_get_qos((void *)stream);
+
+	if (iso_qos->cig != qos->cig_id)
+		return false;
+
+	return iso_qos->cis == qos->cis_id;
+}
+
+static void iso_confirm_cb(GIOChannel *io, void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bt_bap_stream *stream;
+	struct bt_iso_qos qos;
+	char address[18];
+	GError *err = NULL;
+
+	bt_io_get(io, &err,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_QOS, &qos,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	DBG("ISO: incoming connect from %s (CIG 0x%02x CIS 0x%02x)",
+					address, qos.cig, qos.cis);
+
+	stream = queue_remove_if(data->streams, match_stream_qos, &qos);
+	if (!stream) {
+		error("No matching stream found");
+		goto drop;
+	}
+
+	if (!bt_io_accept(io, iso_connect_cb, stream, NULL, &err)) {
+		error("bt_io_accept: %s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	return;
+
+drop:
+	g_io_channel_shutdown(io, TRUE, NULL);
+}
+
+static void bap_accept_io(struct bap_data *data, struct bt_bap_stream *stream,
+							int fd, int defer)
+{
+	char c;
+	struct pollfd pfd;
+	socklen_t len;
+
+	if (fd < 0 || defer)
+		return;
+
+	/* Check if socket has DEFER_SETUP set */
+	len = sizeof(defer);
+	if (getsockopt(fd, SOL_BLUETOOTH, BT_DEFER_SETUP, &defer, &len) < 0)
+		/* Ignore errors since the fd may be connected already */
+		return;
+
+	if (!defer)
+		return;
+
+	DBG("stream %p fd %d defer %s", stream, fd, defer ? "true" : "false");
+
+	memset(&pfd, 0, sizeof(pfd));
+	pfd.fd = fd;
+	pfd.events = POLLOUT;
+
+	if (poll(&pfd, 1, 0) < 0) {
+		error("poll: %s (%d)", strerror(errno), errno);
+		goto fail;
+	}
+
+	if (!(pfd.revents & POLLOUT)) {
+		if (read(fd, &c, 1) < 0) {
+			error("read: %s (%d)", strerror(errno), errno);
+			goto fail;
+		}
+	}
+
+	return;
+
+fail:
+	close(fd);
+}
+
+static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
+				struct bt_bap_stream *stream, int defer);
+
+static gboolean bap_io_recreate(void *user_data)
+{
+	struct bap_ep *ep = user_data;
+
+	DBG("ep %p", ep);
+
+	ep->io_id = 0;
+
+	bap_create_io(ep->data, ep, ep->stream, true);
+
+	return FALSE;
+}
+
+static gboolean bap_io_disconnected(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct bap_ep *ep = user_data;
+
+	DBG("ep %p recreate %s", ep, ep->recreate ? "true" : "false");
+
+	ep->io_id = 0;
+
+	bap_io_close(ep);
+
+	/* Check if connecting recreate IO */
+	if (ep->recreate) {
+		ep->recreate = false;
+		ep->io_id = g_idle_add(bap_io_recreate, ep);
+	}
+
+	return FALSE;
+}
+
+static void bap_connect_io_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	struct bap_ep *ep = user_data;
+
+	if (!ep->stream)
+		return;
+
+	iso_connect_cb(chan, err, ep->stream);
+}
+
+static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
+				struct bt_bap_stream *stream,
+				struct bt_iso_qos *qos, int defer)
+{
+	struct btd_adapter *adapter = device_get_adapter(data->device);
+	GIOChannel *io;
+	GError *err = NULL;
+	int fd;
+
+	/* If IO already set skip creating it again */
+	if (bt_bap_stream_get_io(stream))
+		return;
+
+	if (bt_bap_stream_io_is_connecting(stream, &fd)) {
+		bap_accept_io(data, stream, fd, defer);
+		return;
+	}
+
+	/* If IO channel still up wait for it to be disconnected and then
+	 * recreate.
+	 */
+	if (ep->io) {
+		ep->recreate = true;
+		return;
+	}
+
+	if (ep->io_id) {
+		g_source_remove(ep->io_id);
+		ep->io_id = 0;
+	}
+
+	DBG("ep %p stream %p defer %s", ep, stream, defer ? "true" : "false");
+
+	io = bt_io_connect(bap_connect_io_cb, ep, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR,
+				btd_adapter_get_address(adapter),
+				BT_IO_OPT_DEST_BDADDR,
+				device_get_address(ep->data->device),
+				BT_IO_OPT_DEST_TYPE,
+				device_get_le_address_type(ep->data->device),
+				BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+				BT_IO_OPT_QOS, qos,
+				BT_IO_OPT_DEFER_TIMEOUT, defer,
+				BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+		return;
+	}
+
+	ep->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+						bap_io_disconnected, ep);
+
+	ep->io = io;
+
+	bt_bap_stream_io_connecting(stream, g_io_channel_unix_get_fd(io));
+}
+
+static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
+						struct bt_iso_qos *qos)
+{
+	struct btd_adapter *adapter = device_get_adapter(data->device);
+	GIOChannel *io;
+	GError *err = NULL;
+
+	DBG("stream %p", stream);
+
+	/* If IO already set skip creating it again */
+	if (bt_bap_stream_get_io(stream) || data->listen_io)
+		return;
+
+	io = bt_io_listen(NULL, iso_confirm_cb, data, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR,
+				btd_adapter_get_address(adapter),
+				BT_IO_OPT_DEST_BDADDR,
+				device_get_address(data->device),
+				BT_IO_OPT_DEST_TYPE,
+				device_get_le_address_type(data->device),
+				BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+				BT_IO_OPT_QOS, qos,
+				BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+		return;
+	}
+
+	data->listen_io = io;
+}
+
+static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
+				struct bt_bap_stream *stream, int defer)
+{
+	struct bt_bap_qos *qos[2] = {};
+	struct bt_iso_qos iso_qos;
+
+	DBG("ep %p stream %p defer %s", ep, stream, defer ? "true" : "false");
+
+	if (!data->streams)
+		data->streams = queue_new();
+
+	if (!queue_find(data->streams, NULL, stream))
+		queue_push_tail(data->streams, stream);
+
+	if (!bt_bap_stream_io_get_qos(stream, &qos[0], &qos[1])) {
+		error("bt_bap_stream_get_qos_links: failed");
+		return;
+	}
+
+	memset(&iso_qos, 0, sizeof(iso_qos));
+	iso_qos.cig = qos[0] ? qos[0]->cig_id : qos[1]->cig_id;
+	iso_qos.cis = qos[0] ? qos[0]->cis_id : qos[1]->cis_id;
+
+	bap_iso_qos(qos[0], &iso_qos.in);
+	bap_iso_qos(qos[1], &iso_qos.out);
+
+	if (ep)
+		bap_connect_io(data, ep, stream, &iso_qos, defer);
+	else
+		bap_listen_io(data, stream, &iso_qos);
+}
+
+static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
+				uint8_t new_state, void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bap_ep *ep;
+
+	DBG("stream %p: %s(%u) -> %s(%u)", stream,
+			bt_bap_stream_statestr(old_state), old_state,
+			bt_bap_stream_statestr(new_state), new_state);
+
+	if (new_state == old_state)
+		return;
+
+	ep = bap_find_ep_by_stream(data, stream);
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_IDLE:
+		/* Release stream if idle */
+		if (ep)
+			bap_io_close(ep);
+		else
+			queue_remove(data->streams, stream);
+		break;
+	case BT_BAP_STREAM_STATE_CONFIG:
+		if (ep && !ep->id) {
+			bap_create_io(data, ep, stream, true);
+			if (!ep->io) {
+				error("Unable to create io");
+				bt_bap_stream_release(stream, NULL, NULL);
+				return;
+			}
+
+
+			/* Wait QoS response to respond */
+			ep->id = bt_bap_stream_qos(stream, &ep->qos, qos_cb,
+									ep);
+			if (!ep->id) {
+				error("Failed to Configure QoS");
+				bt_bap_stream_release(stream, NULL, NULL);
+			}
+		}
+		break;
+	case BT_BAP_STREAM_STATE_QOS:
+		bap_create_io(data, ep, stream, true);
+		break;
+	case BT_BAP_STREAM_STATE_ENABLING:
+		if (ep)
+			bap_create_io(data, ep, stream, false);
+		break;
+	}
+}
+
+static void pac_added(struct bt_bap_pac *pac, void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct bap_data *data;
+
+	DBG("pac %p", pac);
+
+	if (btd_service_get_state(service) != BTD_SERVICE_STATE_CONNECTED)
+		return;
+
+	data = btd_service_get_user_data(service);
+
+	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_found, service);
+	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_found, service);
+}
+
+static bool ep_match_rpac(const void *data, const void *match_data)
+{
+	const struct bap_ep *ep = data;
+	const struct bt_bap_pac *pac = match_data;
+
+	return ep->rpac == pac;
+}
+
+static void pac_removed(struct bt_bap_pac *pac, void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct bap_data *data;
+	struct queue *queue;
+	struct bap_ep *ep;
+
+	DBG("pac %p", pac);
+
+	if (btd_service_get_state(service) != BTD_SERVICE_STATE_CONNECTED)
+		return;
+
+	data = btd_service_get_user_data(service);
+
+	switch (bt_bap_pac_get_type(pac)) {
+	case BT_BAP_SINK:
+		queue = data->srcs;
+		break;
+	case BT_BAP_SOURCE:
+		queue = data->snks;
+		break;
+	default:
+		return;
+	}
+
+	ep = queue_remove_if(queue, ep_match_rpac, pac);
+	if (!ep)
+		return;
+
+	ep_unregister(ep);
+}
+
+static struct bap_data *bap_data_new(struct btd_device *device)
+{
+	struct bap_data *data;
+
+	data = new0(struct bap_data, 1);
+	data->device = device;
+	data->srcs = queue_new();
+	data->snks = queue_new();
+
+	return data;
+}
+
+static void bap_data_add(struct bap_data *data)
+{
+	DBG("data %p", data);
+
+	if (queue_find(sessions, NULL, data)) {
+		error("data %p already added", data);
+		return;
+	}
+
+	bt_bap_set_debug(data->bap, bap_debug, NULL, NULL);
+
+	if (!sessions)
+		sessions = queue_new();
+
+	queue_push_tail(sessions, data);
+
+	if (data->service)
+		btd_service_set_user_data(data->service, data);
+}
+
+static bool match_data(const void *data, const void *match_data)
+{
+	const struct bap_data *bdata = data;
+	const struct bt_bap *bap = match_data;
+
+	return bdata->bap == bap;
+}
+
+static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
+							void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bap_ep *ep;
+	GIOChannel *io;
+
+	if (!state)
+		return;
+
+	ep = bap_find_ep_by_stream(data, stream);
+	if (!ep)
+		return;
+
+	ep->recreate = false;
+
+	if (!ep->io) {
+		io = g_io_channel_unix_new(fd);
+		ep->io = io;
+	} else
+		io = ep->io;
+
+	g_io_channel_set_close_on_unref(io, FALSE);
+
+	/* Attempt to get CIG/CIS if they have not been set */
+	if (ep->qos.cig_id == BT_ISO_QOS_CIG_UNSET ||
+				ep->qos.cis_id == BT_ISO_QOS_CIS_UNSET) {
+		struct bt_iso_qos qos;
+		GError *err = NULL;
+
+		if (!bt_io_get(io, &err, BT_IO_OPT_QOS, &qos,
+					BT_IO_OPT_INVALID)) {
+			error("%s", err->message);
+			g_error_free(err);
+			g_io_channel_unref(io);
+			return;
+		}
+
+		ep->qos.cig_id = qos.cig;
+		ep->qos.cis_id = qos.cis;
+	}
+
+	DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
+					ep->qos.cig_id, ep->qos.cis_id);
+}
+
+static void bap_attached(struct bt_bap *bap, void *user_data)
+{
+	struct bap_data *data;
+	struct bt_att *att;
+	struct btd_device *device;
+
+	DBG("%p", bap);
+
+	data = queue_find(sessions, match_data, bap);
+	if (data)
+		return;
+
+	att = bt_bap_get_att(bap);
+	if (!att)
+		return;
+
+	device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
+	if (!device) {
+		error("Unable to find device");
+		return;
+	}
+
+	data = bap_data_new(device);
+	data->bap = bap;
+
+	bap_data_add(data);
+
+	data->state_id = bt_bap_state_register(data->bap, bap_state,
+						bap_connecting, data, NULL);
+}
+
+static void bap_detached(struct bt_bap *bap, void *user_data)
+{
+	struct bap_data *data;
+
+	DBG("%p", bap);
+
+	data = queue_find(sessions, match_data, bap);
+	if (!data) {
+		error("Unable to find bap session");
+		return;
+	}
+
+	/* If there is a service it means there is PACS thus we can keep
+	 * instance allocated.
+	 */
+	if (data->service)
+		return;
+
+	bap_data_remove(data);
+}
+
+static int bap_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct bap_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
+		error("BAP requires ISO Socket which is not enabled");
+		return -ENOTSUP;
+	}
+
+	/* Ignore, if we were probed for this device already */
+	if (data) {
+		error("Profile probed twice for the same device!");
+		return -EINVAL;
+	}
+
+	data = bap_data_new(device);
+	data->service = service;
+
+	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
+					btd_device_get_gatt_db(device));
+	if (!data->bap) {
+		error("Unable to create BAP instance");
+		free(data);
+		return -EINVAL;
+	}
+
+	bap_data_add(data);
+
+	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
+								NULL);
+	data->state_id = bt_bap_state_register(data->bap, bap_state,
+						bap_connecting, data, NULL);
+	data->pac_id = bt_bap_pac_register(pac_added, pac_removed, service,
+								NULL);
+
+	bt_bap_set_user_data(data->bap, service);
+
+	return 0;
+}
+
+static int bap_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct bap_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	if (!data) {
+		error("BAP service not handled by profile");
+		return -EINVAL;
+	}
+
+	if (!bt_bap_attach(data->bap, client)) {
+		error("BAP unable to attach");
+		return -EINVAL;
+	}
+
+	btd_service_connecting_complete(service, 0);
+
+	return 0;
+}
+
+static bool ep_remove(const void *data, const void *match_data)
+{
+	ep_unregister((void *)data);
+
+	return true;
+}
+
+static int bap_disconnect(struct btd_service *service)
+{
+	struct bap_data *data = btd_service_get_user_data(service);
+
+	queue_remove_all(data->snks, ep_remove, NULL, NULL);
+	queue_remove_all(data->srcs, ep_remove, NULL, NULL);
+
+	bt_bap_detach(data->bap);
+
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
+static struct btd_profile bap_profile = {
+	.name		= "bap",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.remote_uuid	= PACS_UUID_STR,
+	.device_probe	= bap_probe,
+	.device_remove	= bap_remove,
+	.accept		= bap_accept,
+	.disconnect	= bap_disconnect,
+};
+
+static unsigned int bap_id = 0;
+
+static int bap_init(void)
+{
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		warn("D-Bus experimental not enabled");
+		return -ENOTSUP;
+	}
+
+	btd_profile_register(&bap_profile);
+	bap_id = bt_bap_register(bap_attached, bap_detached, NULL);
+
+	return 0;
+}
+
+static void bap_exit(void)
+{
+	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
+		btd_profile_unregister(&bap_profile);
+		bt_bap_unregister(bap_id);
+	}
+}
+
+BLUETOOTH_PLUGIN_DEFINE(bap, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							bap_init, bap_exit)
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index c5d8ab14ef49..ff3fa197b284 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -31,12 +31,16 @@
 #include "src/device.h"
 #include "src/dbus-common.h"
 #include "src/profile.h"
+#include "src/service.h"
 
 #include "src/uuid-helper.h"
 #include "src/log.h"
 #include "src/error.h"
+#include "src/gatt-database.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/bap.h"
 
 #include "avdtp.h"
 #include "media.h"
@@ -81,10 +85,14 @@ struct endpoint_request {
 
 struct media_endpoint {
 	struct a2dp_sep		*sep;
+	struct bt_bap_pac	*pac;
+	void			*stream;
 	char			*sender;	/* Endpoint DBus bus id */
 	char			*path;		/* Endpoint object path */
 	char			*uuid;		/* Endpoint property UUID */
 	uint8_t			codec;		/* Endpoint codec */
+	bool			delay_reporting;/* Endpoint delay_reporting */
+	struct bt_bap_pac_qos	qos;		/* Endpoint qos */
 	uint8_t			*capabilities;	/* Endpoint property capabilities */
 	size_t			size;		/* Endpoint capabilities size */
 	guint			hs_watch;
@@ -161,6 +169,12 @@ static void media_endpoint_destroy(struct media_endpoint *endpoint)
 
 	g_slist_free_full(endpoint->transports,
 				(GDestroyNotify) media_transport_destroy);
+	endpoint->transports = NULL;
+
+	if (endpoint->pac) {
+		bt_bap_remove_pac(endpoint->pac);
+		endpoint->pac = NULL;
+	}
 
 	g_dbus_remove_watch(btd_get_dbus_connection(), endpoint->watch);
 	g_free(endpoint->capabilities);
@@ -286,6 +300,7 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 	struct endpoint_request *request = user_data;
 	struct media_endpoint *endpoint = request->endpoint;
 	DBusMessage *reply;
+	DBusMessageIter args, props;
 	DBusError err;
 	gboolean value;
 	void *ret = NULL;
@@ -318,7 +333,7 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 	}
 
 	if (dbus_message_is_method_call(request->msg, MEDIA_ENDPOINT_INTERFACE,
-				"SelectConfiguration")) {
+						"SelectConfiguration")) {
 		DBusMessageIter args, array;
 		uint8_t *configuration;
 
@@ -330,7 +345,14 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 
 		ret = configuration;
 		goto done;
-	} else  if (!dbus_message_get_args(reply, &err, DBUS_TYPE_INVALID)) {
+	} else if (dbus_message_is_method_call(request->msg,
+						MEDIA_ENDPOINT_INTERFACE,
+						"SelectProperties")) {
+		dbus_message_iter_init(reply, &args);
+		dbus_message_iter_recurse(&args, &props);
+		ret = &props;
+		goto done;
+	} else if (!dbus_message_get_args(reply, &err, DBUS_TYPE_INVALID)) {
 		error("Wrong reply signature: %s", err.message);
 		dbus_error_free(&err);
 		goto done;
@@ -496,7 +518,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 
 	transport = media_transport_create(device,
 					a2dp_setup_remote_path(data->setup),
-					configuration, size, endpoint);
+					configuration, size, endpoint, NULL);
 	if (transport == NULL)
 		return FALSE;
 
@@ -671,32 +693,474 @@ static void a2dp_destroy_endpoint(void *user_data)
 	release_endpoint(endpoint);
 }
 
-static gboolean endpoint_init_a2dp_source(struct media_endpoint *endpoint,
-						gboolean delay_reporting,
-						int *err)
+static bool endpoint_init_a2dp_source(struct media_endpoint *endpoint, int *err)
 {
 	endpoint->sep = a2dp_add_sep(endpoint->adapter->btd_adapter,
 					AVDTP_SEP_TYPE_SOURCE, endpoint->codec,
-					delay_reporting, &a2dp_endpoint,
-					endpoint, a2dp_destroy_endpoint, err);
+					endpoint->delay_reporting,
+					&a2dp_endpoint, endpoint,
+					a2dp_destroy_endpoint, err);
 	if (endpoint->sep == NULL)
-		return FALSE;
+		return false;
 
-	return TRUE;
+	return true;
 }
 
-static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
-						gboolean delay_reporting,
-						int *err)
+static bool endpoint_init_a2dp_sink(struct media_endpoint *endpoint, int *err)
 {
 	endpoint->sep = a2dp_add_sep(endpoint->adapter->btd_adapter,
 					AVDTP_SEP_TYPE_SINK, endpoint->codec,
-					delay_reporting, &a2dp_endpoint,
-					endpoint, a2dp_destroy_endpoint, err);
+					endpoint->delay_reporting,
+					&a2dp_endpoint, endpoint,
+					a2dp_destroy_endpoint, err);
 	if (endpoint->sep == NULL)
-		return FALSE;
+		return false;
 
-	return TRUE;
+	return true;
+}
+
+struct pac_select_data {
+	struct bt_bap_pac *pac;
+	bt_bap_pac_select_t cb;
+	void *user_data;
+};
+
+static int parse_array(DBusMessageIter *iter, struct iovec **iov)
+{
+	DBusMessageIter array;
+
+	if (!iov)
+		return 0;
+
+	if (!(*iov))
+		*iov = new0(struct iovec, 1);
+
+	dbus_message_iter_recurse(iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &(*iov)->iov_base,
+						(int *)&(*iov)->iov_len);
+	return 0;
+}
+
+static int parse_select_properties(DBusMessageIter *props, struct iovec **caps,
+					struct iovec **metadata,
+					struct bt_bap_qos *qos)
+{
+	const char *key;
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
+		if (!strcasecmp(key, "Capabilities")) {
+			if (var != DBUS_TYPE_ARRAY)
+				goto fail;
+
+			if (parse_array(&value, caps))
+				goto fail;
+		} else if (!strcasecmp(key, "Metadata")) {
+			if (var != DBUS_TYPE_ARRAY)
+				goto fail;
+
+			if (parse_array(&value, metadata))
+				goto fail;
+		} else if (!strcasecmp(key, "CIG")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->cig_id);
+		} else if (!strcasecmp(key, "CIS")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->cis_id);
+		} else if (!strcasecmp(key, "Interval")) {
+			if (var != DBUS_TYPE_UINT32)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->interval);
+		} else if (!strcasecmp(key, "Framing")) {
+			dbus_bool_t val;
+
+			if (var != DBUS_TYPE_BOOLEAN)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &val);
+
+			qos->framing = val;
+		} else if (!strcasecmp(key, "PHY")) {
+			const char *str;
+
+			if (var != DBUS_TYPE_STRING)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &str);
+
+			if (!strcasecmp(str, "1M"))
+				qos->phy = 0x01;
+			else if (!strcasecmp(str, "2M"))
+				qos->phy = 0x02;
+			else
+				goto fail;
+		} else if (!strcasecmp(key, "SDU")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->sdu);
+		} else if (!strcasecmp(key, "Retransmissions")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->rtn);
+		} else if (!strcasecmp(key, "Latency")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->latency);
+		} else if (!strcasecmp(key, "Delay")) {
+			if (var != DBUS_TYPE_UINT32)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->delay);
+		} else if (!strcasecmp(key, "TargetLatency")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->target_latency);
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
+	if (*caps) {
+		free(*caps);
+		*caps = NULL;
+	}
+
+	return -EINVAL;
+}
+
+static void pac_select_cb(struct media_endpoint *endpoint, void *ret, int size,
+							void *user_data)
+{
+	struct pac_select_data *data = user_data;
+	DBusMessageIter *iter = ret;
+	int err;
+	struct iovec *caps = NULL, *metadata = NULL;
+	struct bt_bap_qos qos;
+
+	if (!ret) {
+		err = -EPERM;
+		goto done;
+	}
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_DICT_ENTRY) {
+		DBG("Unexpected argument type: %c != %c",
+			    dbus_message_iter_get_arg_type(iter),
+			    DBUS_TYPE_DICT_ENTRY);
+		err = -EINVAL;
+		goto done;
+	}
+
+	memset(&qos, 0, sizeof(qos));
+
+	/* Mark CIG and CIS to be auto assigned */
+	qos.cig_id = BT_ISO_QOS_CIG_UNSET;
+	qos.cis_id = BT_ISO_QOS_CIS_UNSET;
+
+	err = parse_select_properties(iter, &caps, &metadata, &qos);
+	if (err < 0)
+		DBG("Unable to parse properties");
+
+done:
+	data->cb(data->pac, err, caps, metadata, &qos, data->user_data);
+}
+
+static int pac_select(struct bt_bap_pac *pac, struct bt_bap_pac_qos *qos,
+			struct iovec *caps, struct iovec *metadata,
+			bt_bap_pac_select_t cb, void *cb_data, void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+	struct pac_select_data *data;
+	DBusMessage *msg;
+	DBusMessageIter iter, dict;
+	const char *key = "Capabilities";
+
+	if (!caps)
+		return -EINVAL;
+
+	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
+						MEDIA_ENDPOINT_INTERFACE,
+						"SelectProperties");
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return -ENOMEM;
+	}
+
+	data = new0(struct pac_select_data, 1);
+	data->pac = pac;
+	data->cb = cb;
+	data->user_data = cb_data;
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+
+	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
+					DBUS_TYPE_BYTE, &caps->iov_base,
+					caps->iov_len);
+
+	if (metadata) {
+		key = "Metadata";
+		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
+						DBUS_TYPE_BYTE,
+						&metadata->iov_base,
+						metadata->iov_len);
+	}
+
+	if (qos && qos->phy) {
+		g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BYTE,
+							&qos->framing);
+
+		g_dbus_dict_append_entry(&dict, "PHY", DBUS_TYPE_BYTE,
+							&qos->phy);
+
+		g_dbus_dict_append_entry(&dict, "Latency", DBUS_TYPE_UINT16,
+							&qos->latency);
+
+		g_dbus_dict_append_entry(&dict, "MinimumDelay",
+					DBUS_TYPE_UINT32, &qos->pd_min);
+
+		g_dbus_dict_append_entry(&dict, "MaximumDelay",
+					DBUS_TYPE_UINT32, &qos->pd_max);
+
+		g_dbus_dict_append_entry(&dict, "PreferredMinimumDelay",
+					DBUS_TYPE_UINT32, &qos->ppd_min);
+
+		g_dbus_dict_append_entry(&dict, "PreferredMaximumDelay",
+					DBUS_TYPE_UINT32, &qos->ppd_min);
+	}
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return media_endpoint_async_call(msg, endpoint, NULL, pac_select_cb,
+								data, free);
+}
+
+struct pac_config_data {
+	struct bt_bap_stream *stream;
+	bt_bap_pac_config_t cb;
+	void *user_data;
+};
+
+static int transport_cmp(gconstpointer data, gconstpointer user_data)
+{
+	const struct media_transport *transport = data;
+	const char *path = user_data;
+
+	if (g_str_has_prefix(media_transport_get_path((void *)transport), path))
+		return 0;
+
+	return -1;
+}
+
+static struct media_transport *find_transport(struct media_endpoint *endpoint,
+						const char *path)
+{
+	GSList *match;
+
+	if (!path)
+		return NULL;
+
+	match = g_slist_find_custom(endpoint->transports, path, transport_cmp);
+	if (match == NULL)
+		return NULL;
+
+	return match->data;
+}
+
+static void pac_config_cb(struct media_endpoint *endpoint, void *ret, int size,
+							void *user_data)
+{
+	struct pac_config_data *data = user_data;
+	gboolean *ret_value = ret;
+
+	if (ret_value)
+		endpoint->stream = data->stream;
+
+	data->cb(data->stream, ret_value ? 0 : -EINVAL);
+}
+
+static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
+			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
+			void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+	DBusConnection *conn = btd_get_dbus_connection();
+	struct pac_config_data *data;
+	struct media_transport *transport;
+	DBusMessage *msg;
+	DBusMessageIter iter;
+	const char *path;
+
+	path = bt_bap_stream_get_user_data(stream);
+
+	DBG("endpoint %p path %s", endpoint, path);
+
+	transport = find_transport(endpoint, path);
+	if (!transport) {
+		struct bt_bap *bap = bt_bap_stream_get_session(stream);
+		struct btd_service *service = bt_bap_get_user_data(bap);
+		struct btd_device *device;
+
+		if (service)
+			device = btd_service_get_device(service);
+		else {
+			struct bt_att *att = bt_bap_get_att(bap);
+			int fd = bt_att_get_fd(att);
+
+			device = btd_adapter_find_device_by_fd(fd);
+		}
+
+		if (!device) {
+			error("Unable to find device");
+			return -EINVAL;
+		}
+
+		transport = media_transport_create(device, path, cfg->iov_base,
+							cfg->iov_len, endpoint,
+							stream);
+		if (!transport)
+			return -EINVAL;
+
+		path = media_transport_get_path(transport);
+		bt_bap_stream_set_user_data(stream, (void *)path);
+	}
+
+	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
+						MEDIA_ENDPOINT_INTERFACE,
+						"SetConfiguration");
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		media_transport_destroy(transport);
+		return FALSE;
+	}
+
+	data = new0(struct pac_config_data, 1);
+	data->stream = stream;
+	data->cb = cb;
+	data->user_data = user_data;
+
+	endpoint->transports = g_slist_append(endpoint->transports, transport);
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	path = media_transport_get_path(transport);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	g_dbus_get_properties(conn, path, "org.bluez.MediaTransport1", &iter);
+
+	return media_endpoint_async_call(msg, endpoint, transport,
+					pac_config_cb, data, free);
+}
+
+static void pac_clear(struct bt_bap_stream *stream, void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+
+	endpoint->stream = NULL;
+
+	while (endpoint->transports != NULL)
+		clear_configuration(endpoint, endpoint->transports->data);
+}
+
+static struct bt_bap_pac_ops pac_ops = {
+	.select = pac_select,
+	.config = pac_config,
+	.clear = pac_clear,
+};
+
+static void bap_debug(const char *str, void *user_data)
+{
+	DBG("%s", str);
+}
+
+static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
+								int *err)
+{
+	struct btd_gatt_database *database;
+	struct gatt_db *db;
+	struct iovec data;
+	char *name;
+
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		warn("D-Bus experimental not enabled");
+		*err = -ENOTSUP;
+		return false;
+	}
+
+	database = btd_adapter_get_database(endpoint->adapter->btd_adapter);
+	if (!database) {
+		error("Adapter database not found");
+		return false;
+	}
+
+	if (!bap_print_cc(endpoint->capabilities, endpoint->size, bap_debug,
+								NULL)) {
+		error("Unable to parse endpoint capabilities");
+		return false;
+	}
+
+	db = btd_gatt_database_get_db(database);
+
+	data.iov_base = endpoint->capabilities;
+	data.iov_len = endpoint->size;
+
+	/* TODO: Add support for metadata */
+
+	if (asprintf(&name, "%s:%s", endpoint->sender, endpoint->path) < 0) {
+		error("Could not allocate name for pac %s:%s",
+				endpoint->sender, endpoint->path);
+		return false;
+	}
+
+	endpoint->pac = bt_bap_add_pac(db, name, type, endpoint->codec,
+					&endpoint->qos, &data, NULL);
+	if (!endpoint->pac) {
+		error("Unable to create PAC");
+		return false;
+	}
+
+	bt_bap_pac_set_ops(endpoint->pac, &pac_ops, endpoint);
+
+	DBG("PAC %s registered", name);
+
+	free(name);
+
+	return true;
+}
+
+static bool endpoint_init_pac_sink(struct media_endpoint *endpoint, int *err)
+{
+	return endpoint_init_pac(endpoint, BT_BAP_SINK, err);
+}
+
+static bool endpoint_init_pac_source(struct media_endpoint *endpoint, int *err)
+{
+	return endpoint_init_pac(endpoint, BT_BAP_SOURCE, err);
 }
 
 static bool endpoint_properties_exists(const char *uuid,
@@ -781,24 +1245,55 @@ static bool endpoint_properties_get(const char *uuid,
 	return true;
 }
 
-static struct media_endpoint *media_endpoint_create(struct media_adapter *adapter,
+static bool endpoint_supported(void)
+{
+	return true;
+}
+
+static bool experimental_endpoint_supported(void)
+{
+	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
+}
+
+static struct media_endpoint_init {
+	const char *uuid;
+	bool (*func)(struct media_endpoint *endpoint, int *err);
+	bool (*supported)(void);
+} init_table[] = {
+	{ A2DP_SOURCE_UUID, endpoint_init_a2dp_source, endpoint_supported },
+	{ A2DP_SINK_UUID, endpoint_init_a2dp_sink, endpoint_supported },
+	{ PAC_SINK_UUID, endpoint_init_pac_sink,
+				experimental_endpoint_supported },
+	{ PAC_SOURCE_UUID, endpoint_init_pac_source,
+				experimental_endpoint_supported },
+};
+
+static struct media_endpoint *
+media_endpoint_create(struct media_adapter *adapter,
 						const char *sender,
 						const char *path,
 						const char *uuid,
 						gboolean delay_reporting,
 						uint8_t codec,
+						struct bt_bap_pac_qos *qos,
 						uint8_t *capabilities,
 						int size,
 						int *err)
 {
 	struct media_endpoint *endpoint;
-	gboolean succeeded;
+	struct media_endpoint_init *init;
+	size_t i;
+	bool succeeded = false;
 
 	endpoint = g_new0(struct media_endpoint, 1);
 	endpoint->sender = g_strdup(sender);
 	endpoint->path = g_strdup(path);
 	endpoint->uuid = g_strdup(uuid);
 	endpoint->codec = codec;
+	endpoint->delay_reporting = delay_reporting;
+
+	if (qos)
+		endpoint->qos = *qos;
 
 	if (size > 0) {
 		endpoint->capabilities = g_new(uint8_t, size);
@@ -808,26 +1303,17 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 
 	endpoint->adapter = adapter;
 
-	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0)
-		succeeded = endpoint_init_a2dp_source(endpoint,
-							delay_reporting, err);
-	else if (strcasecmp(uuid, A2DP_SINK_UUID) == 0)
-		succeeded = endpoint_init_a2dp_sink(endpoint,
-							delay_reporting, err);
-	else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
-					strcasecmp(uuid, HSP_AG_UUID) == 0)
-		succeeded = TRUE;
-	else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
-					strcasecmp(uuid, HSP_HS_UUID) == 0)
-		succeeded = TRUE;
-	else {
-		succeeded = FALSE;
+	for (i = 0; i < ARRAY_SIZE(init_table); i++) {
+		init = &init_table[i];
 
-		if (err)
-			*err = -EINVAL;
+		if (!strcasecmp(init->uuid, uuid)) {
+			succeeded = init->func(endpoint, err);
+			break;
+		}
 	}
 
 	if (!succeeded) {
+		error("Unable initialize endpoint for UUID %s", uuid);
 		media_endpoint_destroy(endpoint);
 		return NULL;
 	}
@@ -853,6 +1339,7 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 
 static int parse_properties(DBusMessageIter *props, const char **uuid,
 				gboolean *delay_reporting, uint8_t *codec,
+				struct bt_bap_pac_qos *qos,
 				uint8_t **capabilities, int *size)
 {
 	gboolean has_uuid = FALSE;
@@ -893,6 +1380,34 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 			dbus_message_iter_recurse(&value, &array);
 			dbus_message_iter_get_fixed_array(&array, capabilities,
 							size);
+		} else if (strcasecmp(key, "Framing") == 0) {
+			if (var != DBUS_TYPE_BYTE)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &qos->framing);
+		} else if (strcasecmp(key, "PHY") == 0) {
+			if (var != DBUS_TYPE_BYTE)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &qos->phy);
+		} else if (strcasecmp(key, "RTN") == 0) {
+			if (var != DBUS_TYPE_BYTE)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &qos->rtn);
+		} else if (strcasecmp(key, "MinimumDelay") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &qos->pd_min);
+		} else if (strcasecmp(key, "MaximumDelay") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &qos->pd_max);
+		} else if (strcasecmp(key, "PreferredMinimumDelay") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &qos->pd_min);
+		} else if (strcasecmp(key, "PreferredMaximumDelay") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &qos->pd_max);
 		}
 
 		dbus_message_iter_next(props);
@@ -908,7 +1423,8 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	DBusMessageIter args, props;
 	const char *sender, *path, *uuid;
 	gboolean delay_reporting = FALSE;
-	uint8_t codec;
+	uint8_t codec = 0;
+	struct bt_bap_pac_qos qos = {};
 	uint8_t *capabilities;
 	int size = 0;
 	int err;
@@ -927,12 +1443,13 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
 		return btd_error_invalid_args(msg);
 
-	if (parse_properties(&props, &uuid, &delay_reporting, &codec,
+	if (parse_properties(&props, &uuid, &delay_reporting, &codec, &qos,
 						&capabilities, &size) < 0)
 		return btd_error_invalid_args(msg);
 
 	if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
-				codec, capabilities, size, &err) == NULL) {
+					codec, &qos, capabilities, size,
+					&err) == NULL) {
 		if (err == -EPROTONOSUPPORT)
 			return btd_error_not_supported(msg);
 		else
@@ -1958,6 +2475,7 @@ static void app_register_endpoint(void *data, void *user_data)
 	const char *uuid;
 	gboolean delay_reporting = FALSE;
 	uint8_t codec;
+	struct bt_bap_pac_qos qos;
 	uint8_t *capabilities = NULL;
 	int size = 0;
 	DBusMessageIter iter, array;
@@ -2002,9 +2520,60 @@ static void app_register_endpoint(void *data, void *user_data)
 		dbus_message_iter_get_fixed_array(&array, &capabilities, &size);
 	}
 
+	/* Parse QoS preferences */
+	memset(&qos, 0, sizeof(qos));
+	if (g_dbus_proxy_get_property(proxy, "Framing", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BYTE)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &qos.framing);
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "PHY", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BYTE)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &qos.phy);
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "Latency", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &qos.latency);
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "MinimumDelay", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT32)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &qos.pd_min);
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "MaximumDelay", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT32)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &qos.pd_max);
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "PreferredMinimumDelay", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT32)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &qos.ppd_min);
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "PreferredMaximumDelay", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT32)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &qos.ppd_min);
+	}
+
 	endpoint = media_endpoint_create(app->adapter, app->sender, path, uuid,
-					delay_reporting, codec, capabilities,
-					size, &app->err);
+						delay_reporting, codec, &qos,
+						capabilities, size, &app->err);
 	if (!endpoint) {
 		error("Unable to register endpoint %s:%s: %s", app->sender,
 						path, strerror(-app->err));
@@ -2390,6 +2959,33 @@ static const GDBusMethodTable media_methods[] = {
 	{ },
 };
 
+static gboolean supported_uuids(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	DBusMessageIter entry;
+	size_t i;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	for (i = 0; i < ARRAY_SIZE(init_table); i++) {
+		struct media_endpoint_init *init = &init_table[i];
+
+		if (init->supported())
+			dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+							&init->uuid);
+	}
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable media_properties[] = {
+	{ "SupportedUUIDs", "as", supported_uuids },
+	{ }
+};
+
 static void path_free(void *data)
 {
 	struct media_adapter *adapter = data;
@@ -2419,7 +3015,7 @@ int media_register(struct btd_adapter *btd_adapter)
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(btd_adapter),
 					MEDIA_INTERFACE,
-					media_methods, NULL, NULL,
+					media_methods, NULL, media_properties,
 					adapter, path_free)) {
 		error("D-Bus failed to register %s path",
 						adapter_get_path(btd_adapter));
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 5848e4019650..47db2a8026b2 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -23,6 +23,7 @@
 #include "lib/uuid.h"
 
 #include "gdbus/gdbus.h"
+#include "btio/btio.h"
 
 #include "src/adapter.h"
 #include "src/device.h"
@@ -30,7 +31,9 @@
 
 #include "src/log.h"
 #include "src/error.h"
+#include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/shared/bap.h"
 
 #include "avdtp.h"
 #include "media.h"
@@ -76,6 +79,19 @@ struct a2dp_transport {
 	int8_t			volume;
 };
 
+struct bap_transport {
+	struct bt_bap_stream	*stream;
+	unsigned int		state_id;
+	bool			linked;
+	uint32_t		interval;
+	uint8_t			framing;
+	uint8_t			phy;
+	uint16_t		sdu;
+	uint8_t			rtn;
+	uint16_t		latency;
+	uint32_t		delay;
+};
+
 struct media_transport {
 	char			*path;		/* Transport object path */
 	struct btd_device	*device;	/* Transport device */
@@ -97,6 +113,8 @@ struct media_transport {
 					struct media_owner *owner);
 	void			(*cancel) (struct media_transport *transport,
 								guint id);
+	void			(*set_state) (struct media_transport *transport,
+						transport_state_t state);
 	GDestroyNotify		destroy;
 	void			*data;
 };
@@ -134,6 +152,29 @@ static gboolean state_in_use(transport_state_t state)
 	return FALSE;
 }
 
+static struct media_transport *
+find_transport_by_bap_stream(const struct bt_bap_stream *stream)
+{
+	GSList *l;
+
+	for (l = transports; l; l = g_slist_next(l)) {
+		struct media_transport *transport = l->data;
+		const char *uuid = media_endpoint_get_uuid(transport->endpoint);
+		struct bap_transport *bap;
+
+		if (strcasecmp(uuid, PAC_SINK_UUID) &&
+				strcasecmp(uuid, PAC_SOURCE_UUID))
+			continue;
+
+		bap = transport->data;
+
+		if (bap->stream == stream)
+			return transport;
+	}
+
+	return NULL;
+}
+
 static void transport_set_state(struct media_transport *transport,
 							transport_state_t state)
 {
@@ -155,6 +196,10 @@ static void transport_set_state(struct media_transport *transport,
 						transport->path,
 						MEDIA_TRANSPORT_INTERFACE,
 						"State");
+
+	/* Update transport specific data */
+	if (transport->set_state)
+		transport->set_state(transport, state);
 }
 
 void media_transport_destroy(struct media_transport *transport)
@@ -240,6 +285,9 @@ static void media_transport_remove_owner(struct media_transport *transport)
 {
 	struct media_owner *owner = transport->owner;
 
+	if (!transport->owner)
+		return;
+
 	DBG("Transport %s Owner %s", transport->path, owner->name);
 
 	/* Reply if owner has a pending request */
@@ -597,7 +645,8 @@ static gboolean get_state(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean delay_exists(const GDBusPropertyTable *property, void *data)
+static gboolean delay_reporting_exists(const GDBusPropertyTable *property,
+							void *data)
 {
 	struct media_transport *transport = data;
 	struct a2dp_transport *a2dp = transport->data;
@@ -605,7 +654,7 @@ static gboolean delay_exists(const GDBusPropertyTable *property, void *data)
 	return a2dp->delay != 0;
 }
 
-static gboolean get_delay(const GDBusPropertyTable *property,
+static gboolean get_delay_reporting(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_transport *transport = data;
@@ -709,19 +758,181 @@ static const GDBusMethodTable transport_methods[] = {
 	{ },
 };
 
-static const GDBusPropertyTable transport_properties[] = {
+static const GDBusPropertyTable a2dp_properties[] = {
 	{ "Device", "o", get_device },
 	{ "UUID", "s", get_uuid },
 	{ "Codec", "y", get_codec },
 	{ "Configuration", "ay", get_configuration },
 	{ "State", "s", get_state },
-	{ "Delay", "q", get_delay, NULL, delay_exists },
+	{ "Delay", "q", get_delay_reporting, NULL, delay_reporting_exists },
 	{ "Volume", "q", get_volume, set_volume, volume_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists,
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
+static gboolean get_interval(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &bap->interval);
+
+	return TRUE;
+}
+
+static gboolean get_framing(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	dbus_bool_t val = bap->framing;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
+
+	return TRUE;
+}
+
+static gboolean get_sdu(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &bap->sdu);
+
+	return TRUE;
+}
+
+static gboolean get_retransmissions(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->rtn);
+
+	return TRUE;
+}
+
+static gboolean get_latency(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &bap->latency);
+
+	return TRUE;
+}
+
+static gboolean get_delay(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &bap->delay);
+
+	return TRUE;
+}
+
+static gboolean get_location(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	uint32_t location = bt_bap_stream_get_location(bap->stream);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &location);
+
+	return TRUE;
+}
+
+static gboolean get_metadata(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	struct iovec *meta = bt_bap_stream_get_metadata(bap->stream);
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	if (meta)
+		dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+							&meta->iov_base,
+							meta->iov_len);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static gboolean links_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	return bap->linked;
+}
+
+static void append_links(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	DBusMessageIter *array = user_data;
+	struct media_transport *transport;
+
+	transport = find_transport_by_bap_stream(stream);
+	if (!transport) {
+		error("Unable to find transport");
+		return;
+	}
+
+	dbus_message_iter_append_basic(array, DBUS_TYPE_OBJECT_PATH,
+					&transport->path);
+}
+
+static gboolean get_links(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_OBJECT_PATH_AS_STRING,
+					&array);
+
+	queue_foreach(links, append_links, &array);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable bap_properties[] = {
+	{ "Device", "o", get_device },
+	{ "UUID", "s", get_uuid },
+	{ "Codec", "y", get_codec },
+	{ "Configuration", "ay", get_configuration },
+	{ "State", "s", get_state },
+	{ "Interval", "u", get_interval },
+	{ "Framing", "b", get_framing },
+	{ "SDU", "q", get_sdu },
+	{ "Retransmissions", "y", get_retransmissions },
+	{ "Latency", "q", get_latency },
+	{ "Delay", "u", get_delay },
+	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
+	{ "Location", "u", get_location },
+	{ "Metadata", "ay", get_metadata },
+	{ "Links", "ao", get_links, NULL, links_exists },
+	{ }
+};
+
 static void destroy_a2dp(void *data)
 {
 	struct a2dp_transport *a2dp = data;
@@ -842,15 +1053,337 @@ static int media_transport_init_sink(struct media_transport *transport)
 	return 0;
 }
 
+static void bap_enable_complete(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	struct media_owner *owner = user_data;
+
+	if (code)
+		media_transport_remove_owner(owner->transport);
+}
+
+static gboolean resume_complete(void *data)
+{
+	struct media_transport *transport = data;
+	struct media_owner *owner = transport->owner;
+
+	if (!owner)
+		return FALSE;
+
+	if (transport->fd < 0) {
+		media_transport_remove_owner(transport);
+		return FALSE;
+	}
+
+	if (owner->pending) {
+		gboolean ret;
+
+		ret = g_dbus_send_reply(btd_get_dbus_connection(),
+					owner->pending->msg,
+					DBUS_TYPE_UNIX_FD, &transport->fd,
+					DBUS_TYPE_UINT16, &transport->imtu,
+					DBUS_TYPE_UINT16, &transport->omtu,
+						DBUS_TYPE_INVALID);
+		if (!ret) {
+			media_transport_remove_owner(transport);
+			return FALSE;
+		}
+	}
+
+	media_owner_remove(owner);
+
+	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
+
+	return FALSE;
+}
+
+static void bap_update_links(const struct media_transport *transport);
+
+static bool match_link_transport(const void *data, const void *user_data)
+{
+	const struct bt_bap_stream *stream = data;
+	const struct media_transport *transport;
+
+	transport = find_transport_by_bap_stream(stream);
+	if (!transport)
+		return false;
+
+	bap_update_links(transport);
+
+	return true;
+}
+
+static void bap_update_links(const struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
+
+	if (bap->linked == !queue_isempty(links))
+		return;
+
+	bap->linked = !queue_isempty(links);
+
+	/* Check if the links transport has been create yet */
+	if (bap->linked && !queue_find(links, match_link_transport, NULL)) {
+		bap->linked = false;
+		return;
+	}
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"Links");
+
+	DBG("stream %p linked %s", bap->stream, bap->linked ? "true" : "false");
+}
+
+static guint resume_bap(struct media_transport *transport,
+				struct media_owner *owner)
+{
+	struct bap_transport *bap = transport->data;
+	guint id;
+
+	if (!bap->stream)
+		return 0;
+
+	bap_update_links(transport);
+
+	switch (bt_bap_stream_get_state(bap->stream)) {
+	case BT_BAP_STREAM_STATE_ENABLING:
+		bap_enable_complete(bap->stream, 0x00, 0x00, owner);
+		if (owner->pending)
+			return owner->pending->id;
+		return 0;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		return g_idle_add(resume_complete, transport);
+	}
+
+	id = bt_bap_stream_enable(bap->stream, bap->linked, NULL,
+					bap_enable_complete, owner);
+	if (!id)
+		return 0;
+
+	if (transport->state == TRANSPORT_STATE_IDLE)
+		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
+
+	return id;
+}
+
+static void bap_stop_complete(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	struct media_owner *owner = user_data;
+	struct media_request *req = owner->pending;
+	struct media_transport *transport = owner->transport;
+
+	/* Release always succeeds */
+	if (req) {
+		req->id = 0;
+		media_request_reply(req, 0);
+		media_owner_remove(owner);
+	}
+
+	transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	media_transport_remove_owner(transport);
+}
+
+static void bap_disable_complete(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	bap_stop_complete(stream, code, reason, user_data);
+}
+
+static guint suspend_bap(struct media_transport *transport,
+				struct media_owner *owner)
+{
+	struct bap_transport *bap = transport->data;
+	bt_bap_stream_func_t func = NULL;
+
+	if (!bap->stream)
+		return 0;
+
+	if (owner)
+		func = bap_disable_complete;
+	else
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+
+	bap_update_links(transport);
+
+	return bt_bap_stream_disable(bap->stream, bap->linked, func, owner);
+}
+
+static void cancel_bap(struct media_transport *transport, guint id)
+{
+	struct bap_transport *bap = transport->data;
+
+	if (!bap->stream)
+		return;
+
+	bt_bap_stream_cancel(bap->stream, id);
+}
+
+static void link_set_state(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	transport_state_t state = PTR_TO_UINT(user_data);
+	struct media_transport *transport;
+
+	transport = find_transport_by_bap_stream(stream);
+	if (!transport) {
+		error("Unable to find transport");
+		return;
+	}
+
+	transport_set_state(transport, state);
+}
+
+static void set_state_bap(struct media_transport *transport,
+					transport_state_t state)
+{
+	struct bap_transport *bap = transport->data;
+
+	if (!bap->linked)
+		return;
+
+	/* Update links */
+	queue_foreach(bt_bap_stream_io_get_links(bap->stream), link_set_state,
+							UINT_TO_PTR(state));
+}
+
+static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
+				uint8_t new_state, void *user_data)
+{
+	struct media_transport *transport = user_data;
+	struct bap_transport *bap = transport->data;
+	struct media_owner *owner = transport->owner;
+	struct io *io;
+	GIOChannel *chan;
+	GError *err = NULL;
+	int fd;
+	uint16_t imtu, omtu;
+
+	if (bap->stream != stream)
+		return;
+
+	DBG("stream %p: %s(%u) -> %s(%u)", stream,
+			bt_bap_stream_statestr(old_state), old_state,
+			bt_bap_stream_statestr(new_state), new_state);
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_IDLE:
+	case BT_BAP_STREAM_STATE_CONFIG:
+	case BT_BAP_STREAM_STATE_QOS:
+		/* If a request is pending wait it to complete */
+		if (owner && owner->pending)
+			return;
+		transport_update_playing(transport, FALSE);
+		return;
+	case BT_BAP_STREAM_STATE_DISABLING:
+		return;
+	case BT_BAP_STREAM_STATE_ENABLING:
+		if (!bt_bap_stream_get_io(stream))
+			return;
+		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		break;
+	}
+
+	io = bt_bap_stream_get_io(stream);
+	if (!io) {
+		error("Unable to get stream IO");
+		/* TODO: Fail if IO has not been established */
+		goto done;
+	}
+
+	fd = io_get_fd(io);
+	if (fd < 0) {
+		error("Unable to get IO fd");
+		goto done;
+	}
+
+	chan = g_io_channel_unix_new(fd);
+
+	if (!bt_io_get(chan, &err, BT_IO_OPT_OMTU, &omtu,
+					BT_IO_OPT_IMTU, &imtu,
+					BT_IO_OPT_INVALID)) {
+		error("%s", err->message);
+		goto done;
+	}
+
+	g_io_channel_unref(chan);
+
+	media_transport_set_fd(transport, fd, imtu, omtu);
+	transport_update_playing(transport, TRUE);
+
+done:
+	resume_complete(transport);
+}
+
+static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
+							void *user_data)
+{
+	struct media_transport *transport = user_data;
+	struct bap_transport *bap = transport->data;
+
+	if (bap->stream != stream)
+		return;
+
+	bap_update_links(transport);
+}
+
+static void free_bap(void *data)
+{
+	struct bap_transport *bap = data;
+
+	bt_bap_state_unregister(bt_bap_stream_get_session(bap->stream),
+							bap->state_id);
+	free(bap);
+}
+
+static int media_transport_init_bap(struct media_transport *transport,
+							void *stream)
+{
+	struct bt_bap_qos *qos;
+	struct bap_transport *bap;
+
+	qos = bt_bap_stream_get_qos(stream);
+
+	bap = new0(struct bap_transport, 1);
+	bap->stream = stream;
+	bap->interval = qos->interval;
+	bap->framing = qos->framing;
+	bap->phy = qos->phy;
+	bap->rtn = qos->rtn;
+	bap->latency = qos->latency;
+	bap->delay = qos->delay;
+	bap->state_id = bt_bap_state_register(bt_bap_stream_get_session(stream),
+						bap_state_changed,
+						bap_connecting,
+						transport, NULL);
+
+	transport->data = bap;
+	transport->resume = resume_bap;
+	transport->suspend = suspend_bap;
+	transport->cancel = cancel_bap;
+	transport->set_state = set_state_bap;
+	transport->destroy = free_bap;
+
+	return 0;
+}
+
 struct media_transport *media_transport_create(struct btd_device *device,
 						const char *remote_endpoint,
 						uint8_t *configuration,
-						size_t size, void *data)
+						size_t size, void *data,
+						void *stream)
 {
 	struct media_endpoint *endpoint = data;
 	struct media_transport *transport;
 	const char *uuid;
 	static int fd = 0;
+	const GDBusPropertyTable *properties;
 
 	transport = g_new0(struct media_transport, 1);
 	transport->device = device;
@@ -868,15 +1401,22 @@ struct media_transport *media_transport_create(struct btd_device *device,
 	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0) {
 		if (media_transport_init_source(transport) < 0)
 			goto fail;
+		properties = a2dp_properties;
 	} else if (strcasecmp(uuid, A2DP_SINK_UUID) == 0) {
 		if (media_transport_init_sink(transport) < 0)
 			goto fail;
+		properties = a2dp_properties;
+	} else if (!strcasecmp(uuid, PAC_SINK_UUID) ||
+				!strcasecmp(uuid, PAC_SOURCE_UUID)) {
+		if (media_transport_init_bap(transport, stream) < 0)
+			goto fail;
+		properties = bap_properties;
 	} else
 		goto fail;
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 				transport->path, MEDIA_TRANSPORT_INTERFACE,
-				transport_methods, NULL, transport_properties,
+				transport_methods, NULL, properties,
 				transport, media_transport_free) == FALSE) {
 		error("Could not register transport %s", transport->path);
 		goto fail;
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index 51a67ea74f46..102fc3cf1153 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -14,7 +14,8 @@ struct media_transport;
 struct media_transport *media_transport_create(struct btd_device *device,
 						const char *remote_endpoint,
 						uint8_t *configuration,
-						size_t size, void *data);
+						size_t size, void *data,
+						void *stream);
 
 void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
-- 
2.37.2

