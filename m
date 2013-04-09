Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] obexd: Add Message Notification Service (MNS) server
Date: Tue,  9 Apr 2013 13:51:34 +0200
Message-Id: <1365508297-13032-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508297-13032-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508297-13032-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This implements the server role of the MAP Message Notification Service
(MNS) which is part of the MAP Client Equipment (MCE) device.

After successful registration, the MNS will receive event reports,
notifying about state changes on the server side.

Possible events are: NewMessages, DeliverySuccess, SendingSuccess,
DeliveryFailure, SendingFailure, MemoryFull, MemoryAvailable,
MessageDeleted, MessageShift
---
 obexd/client/map-event.h |  42 ++++++
 obexd/client/mns.c       | 363 +++++++++++++++++++++++++++++++++++++++++++++++
 obexd/src/obexd.h        |   1 +
 3 files changed, 406 insertions(+)
 create mode 100644 obexd/client/map-event.h
 create mode 100644 obexd/client/mns.c

diff --git a/obexd/client/map-event.h b/obexd/client/map-event.h
new file mode 100644
index 0000000..749f1e0
--- /dev/null
+++ b/obexd/client/map-event.h
@@ -0,0 +1,42 @@
+/*
+ *
+ *  OBEX
+ *
+ *  Copyright (C) 2013  BMW Car IT GmbH. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+enum map_event_type {
+	MAP_ET_NEW_MESSAGE,
+	MAP_ET_DELIVERY_SUCCESS,
+	MAP_ET_SENDING_SUCCESS,
+	MAP_ET_DELIVERY_FAILURE,
+	MAP_ET_SENDING_FAILURE,
+	MAP_ET_MEMORY_FULL,
+	MAP_ET_MEMORY_AVAILABLE,
+	MAP_ET_MESSAGE_DELETED,
+	MAP_ET_MESSAGE_SHIFT
+};
+
+struct map_event {
+	enum map_event_type type;
+	char *handle;
+	char *folder;
+	char *old_folder;
+	char *msg_type;
+};
diff --git a/obexd/client/mns.c b/obexd/client/mns.c
new file mode 100644
index 0000000..752452c
--- /dev/null
+++ b/obexd/client/mns.c
@@ -0,0 +1,363 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2013  BMW Car IT GmbH. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <string.h>
+#include <errno.h>
+#include <glib.h>
+#include <fcntl.h>
+#include <inttypes.h>
+
+#include <gobex/gobex.h>
+#include <gobex/gobex-apparam.h>
+
+#include "obexd.h"
+#include "plugin.h"
+#include "log.h"
+#include "obex.h"
+#include "service.h"
+#include "mimetype.h"
+#include "map_ap.h"
+#include "map-event.h"
+
+struct mns_session {
+	GString *buffer;
+	GObexApparam *inparams;
+	char *remote_address;
+	uint8_t mas_instance_id;
+};
+
+static const uint8_t MNS_TARGET[TARGET_SIZE] = {
+			0xbb, 0x58, 0x2b, 0x41, 0x42, 0x0c, 0x11, 0xdb,
+			0xb0, 0xde, 0x08, 0x00, 0x20, 0x0c, 0x9a, 0x66  };
+
+static int get_params(struct obex_session *os, struct mns_session *mns)
+{
+	const uint8_t *buffer;
+	ssize_t size;
+
+	size = obex_get_apparam(os, &buffer);
+	if (size < 0)
+		size = 0;
+
+	mns->inparams = g_obex_apparam_decode(buffer, size);
+	if (mns->inparams == NULL) {
+		DBG("Error when parsing parameters!");
+		return -EBADR;
+	}
+
+	return 0;
+}
+
+static void reset_request(struct mns_session *mns)
+{
+	if (mns->buffer) {
+		g_string_free(mns->buffer, TRUE);
+		mns->buffer = NULL;
+	}
+
+	if (mns->inparams) {
+		g_obex_apparam_free(mns->inparams);
+		mns->inparams = NULL;
+	}
+
+	if (mns->remote_address)
+		g_free(mns->remote_address);
+}
+
+static void mns_session_free(struct mns_session *mns)
+{
+	reset_request(mns);
+	g_free(mns);
+}
+
+static void *mns_connect(struct obex_session *os, int *err)
+{
+	struct mns_session *mns;
+	char *address;
+
+	manager_register_session(os);
+
+	mns = g_new0(struct mns_session, 1);
+
+	if (obex_getpeername(os, &address) == 0) {
+		mns->remote_address = g_strdup(address);
+		g_free(address);
+	}
+
+	DBG("MNS connected to %s", mns->remote_address);
+
+	if (err)
+		*err = 0;
+
+	return mns;
+}
+
+static void mns_disconnect(struct obex_session *os, void *user_data)
+{
+	struct mns_session *mns = user_data;
+
+	DBG("MNS disconnected from %s", mns->remote_address);
+
+	manager_unregister_session(os);
+
+	mns_session_free(mns);
+}
+
+static int mns_put(struct obex_session *os, void *user_data)
+{
+	struct mns_session *mns = user_data;
+	const char *type = obex_get_type(os);
+	const char *name = obex_get_name(os);
+	int ret;
+
+	DBG("PUT: name %s type %s mns %p", name, type, mns);
+
+	if (type == NULL)
+		return -EBADR;
+
+	ret = get_params(os, mns);
+	if (ret < 0)
+		goto failed;
+
+	ret = obex_put_stream_start(os, name);
+	if (ret < 0)
+		goto failed;
+
+	return 0;
+
+failed:
+	reset_request(mns);
+
+	return ret;
+}
+
+static void parse_event_report_type(struct map_event *event, const char *value)
+{
+	if (!g_ascii_strcasecmp(value, "NewMessage"))
+		event->type = MAP_ET_NEW_MESSAGE;
+	else if (!g_ascii_strcasecmp(value, "DeliverySuccess"))
+		event->type = MAP_ET_DELIVERY_SUCCESS;
+	else if (!g_ascii_strcasecmp(value, "SendingSuccess"))
+		event->type = MAP_ET_SENDING_SUCCESS;
+	else if (!g_ascii_strcasecmp(value, "DeliveryFailure"))
+		event->type = MAP_ET_DELIVERY_FAILURE;
+	else if (!g_ascii_strcasecmp(value, "SendingFailure"))
+		event->type = MAP_ET_SENDING_FAILURE;
+	else if (!g_ascii_strcasecmp(value, "MemoryFull"))
+		event->type = MAP_ET_MEMORY_FULL;
+	else if (!g_ascii_strcasecmp(value, "MemoryAvailable"))
+		event->type = MAP_ET_MEMORY_AVAILABLE;
+	else if (!g_ascii_strcasecmp(value, "MessageDeleted"))
+		event->type = MAP_ET_MESSAGE_DELETED;
+	else if (!g_ascii_strcasecmp(value, "MessageShift"))
+		event->type = MAP_ET_MESSAGE_SHIFT;
+}
+
+static void parse_event_report_handle(struct map_event *event,
+							const char *value)
+{
+	event->handle = g_strdup(value);
+}
+
+static void parse_event_report_folder(struct map_event *event,
+							const char *value)
+{
+	event->folder = g_strdup(value);
+}
+
+static void parse_event_report_old_folder(struct map_event *event,
+							const char *value)
+{
+	event->old_folder = g_strdup(value);
+}
+
+static void parse_event_report_msg_type(struct map_event *event,
+							const char *value)
+{
+	event->msg_type = g_strdup(value);
+}
+
+static struct map_event_report_parser {
+	const char *name;
+	void (*func) (struct map_event *event, const char *value);
+} event_report_parsers[] = {
+		{ "type", parse_event_report_type },
+		{ "handle", parse_event_report_handle },
+		{ "folder", parse_event_report_folder },
+		{ "old_folder", parse_event_report_old_folder },
+		{ "msg_type", parse_event_report_msg_type },
+		{ }
+};
+
+static void event_report_element(GMarkupParseContext *ctxt,
+				const gchar *element, const gchar **names,
+				const gchar **values, gpointer user_data,
+								GError **gerr)
+{
+	struct map_event *event = user_data;
+	const gchar *key;
+	gint i;
+
+	if (strcasecmp("event", element) != 0)
+		return;
+
+	for (i = 0, key = names[i]; key; key = names[++i]) {
+		struct map_event_report_parser *parser;
+
+		for (parser = event_report_parsers; parser && parser->name;
+								parser++) {
+			if (strcasecmp(key, parser->name) == 0) {
+				parser->func(event, values[i]);
+				break;
+			}
+		}
+	}
+}
+
+static const GMarkupParser event_report_parser = {
+	event_report_element,
+	NULL,
+	NULL,
+	NULL,
+	NULL
+};
+
+static void map_event_free(struct map_event *event)
+{
+	g_free(event->handle);
+	g_free(event->folder);
+	g_free(event->old_folder);
+	g_free(event->msg_type);
+	g_free(event);
+}
+
+static void *event_report_open(const char *name, int oflag, mode_t mode,
+				void *driver_data, size_t *size, int *err)
+{
+	struct mns_session *mns = driver_data;
+
+	DBG("");
+
+	g_obex_apparam_get_uint8(mns->inparams, MAP_AP_MASINSTANCEID,
+							&mns->mas_instance_id);
+
+	mns->buffer = g_string_new("");
+
+	if (*err < 0)
+		return NULL;
+	else
+		return mns;
+}
+
+static int event_report_close(void *obj)
+{
+	struct mns_session *mns = obj;
+	GMarkupParseContext *ctxt;
+	struct map_event *event;
+
+	event = g_new0(struct map_event, 1);
+	ctxt = g_markup_parse_context_new(&event_report_parser, 0, event,
+									NULL);
+	g_markup_parse_context_parse(ctxt, mns->buffer->str, mns->buffer->len,
+									NULL);
+	g_markup_parse_context_free(ctxt);
+
+	DBG("Event report for %s:%d", mns->remote_address,
+							mns->mas_instance_id);
+
+	DBG("type=%x, handle=%s, folder=%s, old_folder=%s, msg_type=%s",
+				event->type, event->handle, event->folder,
+					event->old_folder, event->msg_type);
+
+	map_event_free(event);
+
+	reset_request(mns);
+
+	return 0;
+}
+
+static ssize_t event_report_write(void *obj, const void *buf, size_t count)
+{
+	struct mns_session *mns = obj;
+
+	DBG("");
+
+	g_string_append_len(mns->buffer, buf, count);
+	return count;
+}
+
+static struct obex_service_driver mns = {
+	.name = "Message Notification server",
+	.service = OBEX_MNS,
+	.target = MNS_TARGET,
+	.target_size = TARGET_SIZE,
+	.connect = mns_connect,
+	.put = mns_put,
+	.disconnect = mns_disconnect,
+};
+
+static struct obex_mime_type_driver mime_event_report = {
+	.target = MNS_TARGET,
+	.target_size = TARGET_SIZE,
+	.mimetype = "x-bt/MAP-event-report",
+	.open = event_report_open,
+	.close = event_report_close,
+	.write = event_report_write,
+};
+
+static struct obex_mime_type_driver *mas_drivers[] = {
+	&mime_event_report,
+	NULL
+};
+
+static int mns_init(void)
+{
+	int err;
+
+	err = obex_mime_type_driver_register(&mime_event_report);
+	if (err < 0)
+		goto fail_mime_event;
+
+	err = obex_service_driver_register(&mns);
+	if (err < 0)
+		goto fail_mns_reg;
+
+	return 0;
+
+fail_mns_reg:
+	obex_mime_type_driver_unregister(&mime_event_report);
+fail_mime_event:
+	return err;
+}
+
+static void mns_exit(void)
+{
+	obex_service_driver_unregister(&mns);
+	obex_mime_type_driver_unregister(&mime_event_report);
+}
+
+OBEX_PLUGIN_DEFINE(mns, mns_init, mns_exit)
diff --git a/obexd/src/obexd.h b/obexd/src/obexd.h
index 1c9b2b3..42c3c4d 100644
--- a/obexd/src/obexd.h
+++ b/obexd/src/obexd.h
@@ -29,6 +29,7 @@
 #define OBEX_PCSUITE	(1 << 6)
 #define OBEX_SYNCEVOLUTION	(1 << 7)
 #define OBEX_MAS	(1 << 8)
+#define OBEX_MNS	(1 << 9)
 
 gboolean plugin_init(const char *pattern, const char *exclude);
 void plugin_cleanup(void);
-- 
1.8.2.1

