Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 1/1] GATT shim to src/shared bt_att
Date: Mon, 20 Oct 2014 09:57:24 -0700
Message-Id: <1413824244-35297-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1413824244-35297-1-git-send-email-jamuraa@chromium.org>
References: <1413824244-35297-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements a version of GAttrib which is backed by
bt_att, which enables the simultaneous use of GAttrib and bt_att.

This should enable smooth transition of profiles from the GAttrib
API to the src/shared bt_att API.
---
 Makefile.am             |   8 +-
 Makefile.tools          |  11 +-
 attrib/gattrib-shared.c | 306 ++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac            |   4 +
 4 files changed, 327 insertions(+), 2 deletions(-)
 create mode 100644 attrib/gattrib-shared.c

diff --git a/Makefile.am b/Makefile.am
index 2dfea28..9785fc0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -129,9 +129,15 @@ src_libshared_mainloop_la_SOURCES = $(shared_sources) \
 
 attrib_sources = attrib/att.h attrib/att-database.h attrib/att.c \
 		attrib/gatt.h attrib/gatt.c \
-		attrib/gattrib.h attrib/gattrib.c \
+		attrib/gattrib.h \
 		attrib/gatt-service.h attrib/gatt-service.c
 
+if SHARED_GATTRIB
+attrib_sources += attrib/gattrib-shared.c
+else
+attrib_sources += attrib/gattrib.c
+endif
+
 btio_sources = btio/btio.h btio/btio.c
 
 gobex_sources = gobex/gobex.h gobex/gobex.c \
diff --git a/Makefile.tools b/Makefile.tools
index 42cccc6..421c151 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -283,10 +283,19 @@ noinst_PROGRAMS += attrib/gatttool \
 			tools/bluetooth-player tools/obexctl
 
 attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
-				attrib/gattrib.c btio/btio.c \
+				btio/btio.c \
 				attrib/gatttool.h attrib/interactive.c \
 				attrib/utils.c src/log.c client/display.c \
 				client/display.h
+
+if SHARED_GATTRIB
+attrib_gatttool_SOURCES += attrib/gattrib-shared.c
+else
+attrib_gatttool_SOURCES += attrib/gattrib.c
+endif
+
+
+
 attrib_gatttool_LDADD = lib/libbluetooth-internal.la \
 			src/libshared-glib.la @GLIB_LIBS@ -lreadline
 
diff --git a/attrib/gattrib-shared.c b/attrib/gattrib-shared.c
new file mode 100644
index 0000000..593d01d
--- /dev/null
+++ b/attrib/gattrib-shared.c
@@ -0,0 +1,306 @@
+/*
+ *
+ * BlueZ - Bluetooth protocol stack for Linux
+ *
+ * Copyright (C) 2014  Google, Inc.
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
+#include "config.h"
+#endif
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <glib.h>
+
+#include <stdio.h>
+
+#include <bluetooth/bluetooth.h>
+
+#include "btio/btio.h"
+#include "src/log.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "attrib/gattrib.h"
+
+struct _GAttrib {
+	int ref_count;
+	struct bt_att *att;
+	GIOChannel *io;
+	GDestroyNotify destroy;
+	gpointer destroy_user_data;
+	GQueue *callbacks;
+	uint8_t *buf;
+	size_t buflen;
+};
+
+
+struct attrib_callbacks {
+	GAttribResultFunc result_func;
+	GAttribNotifyFunc notify_func;
+	GDestroyNotify destroy_func;
+	gpointer user_data;
+	GAttrib *parent;
+};
+
+GAttrib *g_attrib_new(GIOChannel *io)
+{
+	gint fd;
+	GAttrib *attr;
+
+	DBG("%p: new bt_att GAttrib", io);
+
+	if (!io)
+		return NULL;
+
+	fd = g_io_channel_unix_get_fd(io);
+	attr = new0(GAttrib, 1);
+	if (!attr)
+		return NULL;
+
+	g_io_channel_ref(io);
+	attr->io = io;
+
+	attr->att = bt_att_new(fd);
+	if (!attr->att)
+		goto fail;
+
+	/* TODO: need to probe the IOChannel for a mtu? */
+	attr->buf = g_malloc0(BT_ATT_DEFAULT_LE_MTU);
+	attr->buflen = BT_ATT_DEFAULT_LE_MTU;
+	if (!attr->buf)
+		goto fail;
+
+	attr->callbacks = g_queue_new();
+	if (!attr->callbacks)
+		goto fail;
+
+	return g_attrib_ref(attr);
+
+fail:
+	free(attr->buf);
+	bt_att_unref(attr->att);
+	g_io_channel_unref(io);
+	free(attr);
+	return NULL;
+}
+
+GAttrib *g_attrib_ref(GAttrib *attrib)
+{
+	if (!attrib)
+		return NULL;
+
+	__sync_fetch_and_add(&attrib->ref_count, 1);
+
+	return attrib;
+}
+
+static void attrib_callbacks_destroy(void *user_data)
+{
+	struct attrib_callbacks *cb;
+
+	cb = (struct attrib_callbacks *)user_data;
+	if (!user_data || !g_queue_remove(cb->parent->callbacks, user_data))
+		return;
+
+	if (cb->destroy_func)
+		cb->destroy_func(cb->user_data);
+
+	free(user_data);
+}
+
+void g_attrib_unref(GAttrib *attrib)
+{
+	struct attrib_callbacks *cb;
+
+	if (!attrib)
+		return;
+
+	if (__sync_sub_and_fetch(&attrib->ref_count, 1))
+		return;
+
+	if (attrib->destroy)
+		attrib->destroy(attrib->destroy_user_data);
+
+	while (cb = g_queue_peek_head(attrib->callbacks))
+		attrib_callbacks_destroy(cb);
+
+	g_queue_free(attrib->callbacks);
+
+	g_free(attrib->buf);
+
+	bt_att_unref(attrib->att);
+
+	g_io_channel_unref(attrib->io);
+
+	g_free(attrib);
+}
+
+GIOChannel *g_attrib_get_channel(GAttrib *attrib)
+{
+	if (!attrib)
+		return NULL;
+
+	return attrib->io;
+}
+
+gboolean g_attrib_set_destroy_function(GAttrib *attrib,
+		GDestroyNotify destroy, gpointer user_data)
+{
+	if (!attrib)
+		return FALSE;
+
+	attrib->destroy = destroy;
+	attrib->destroy_user_data = user_data;
+
+	return TRUE;
+}
+
+
+static void attrib_callback_result(uint8_t opcode, const void *pdu,
+				   uint16_t length, void *user_data)
+{
+	struct attrib_callbacks *cb = user_data;
+
+	if (!cb)
+		return;
+
+	if (cb->result_func) {
+		/* TODO: make sure this is right */
+		cb->result_func(0, pdu, length, cb->user_data);
+	}
+
+	attrib_callbacks_destroy(user_data);
+}
+
+
+static void attrib_callback_notify(uint8_t opcode, const void *pdu,
+				uint16_t length, void *user_data)
+{
+	struct attrib_callbacks *cb = user_data;
+
+	if (!cb)
+		return;
+
+
+	if (cb->notify_func)
+		cb->notify_func(pdu, length, cb->user_data);
+}
+
+guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
+			GAttribResultFunc func, gpointer user_data,
+			GDestroyNotify notify)
+{
+	struct attrib_callbacks *cb = NULL;
+
+	if (func || notify) {
+		cb = new0(struct attrib_callbacks, 1);
+		if (cb == 0)
+			return 0;
+		cb->result_func = func;
+		cb->user_data = user_data;
+		cb->destroy_func = notify;
+		cb->parent = attrib;
+		g_queue_push_head(attrib->callbacks, cb);
+	}
+
+	return bt_att_send(attrib->att, pdu[0], (void *)pdu, len,
+			   attrib_callback_result, cb, attrib_callbacks_destroy);
+}
+
+gboolean g_attrib_cancel(GAttrib *attrib, guint id)
+{
+	/* NOTE: no code uses this function, this is sufficient */
+	return FALSE;
+}
+
+gboolean g_attrib_cancel_all(GAttrib *attrib)
+{
+	return bt_att_cancel_all(attrib->att);
+}
+
+gboolean g_attrib_set_debug(GAttrib *attrib,
+		GAttribDebugFunc func, gpointer user_data)
+{
+	/* NOTE: not used, not implemented in GAttrib. */
+	return TRUE;
+}
+
+guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
+				GAttribNotifyFunc func, gpointer user_data,
+				GDestroyNotify notify)
+{
+	struct attrib_callbacks *cb = NULL;
+
+	if (func || notify) {
+		cb = new0(struct attrib_callbacks, 1);
+		if (cb == 0)
+			return 0;
+		cb->notify_func = func;
+		cb->user_data = user_data;
+		cb->destroy_func = notify;
+		cb->parent = attrib;
+		g_queue_push_head(attrib->callbacks, cb);
+	}
+
+	return bt_att_register(attrib->att, opcode, attrib_callback_notify,
+			       cb, attrib_callbacks_destroy);
+}
+
+gboolean g_attrib_is_encrypted(GAttrib *attrib)
+{
+	/* NOTE: copied from gattrib.c, should continue to work */
+	BtIOSecLevel sec_level;
+
+	if (!bt_io_get(attrib->io, NULL,
+			BT_IO_OPT_SEC_LEVEL, &sec_level,
+			BT_IO_OPT_INVALID))
+		return FALSE;
+
+	return sec_level > BT_IO_SEC_LOW;
+}
+
+uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
+{
+	if (len == NULL)
+		return NULL;
+
+	*len = attrib->buflen;
+	return attrib->buf;
+}
+
+gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
+{
+	/* Clients of this expect a buffer to use. */
+	if (mtu > attrib->buflen)
+		attrib->buf = g_realloc(attrib->buf, mtu);
+
+	return bt_att_set_mtu(attrib->att, mtu);
+}
+
+gboolean g_attrib_unregister(GAttrib *attrib, guint id)
+{
+	return bt_att_unregister(attrib->att, id);
+}
+
+gboolean g_attrib_unregister_all(GAttrib *attrib)
+{
+	return bt_att_unregister_all(attrib->att);
+}
diff --git a/configure.ac b/configure.ac
index 981b1bf..3a56140 100644
--- a/configure.ac
+++ b/configure.ac
@@ -274,4 +274,8 @@ fi
 AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
 			[Directory for the Android daemon storage files])
 
+AC_ARG_ENABLE(shared-gattrib, AC_HELP_STRING([--disable-shared-gattrib],
+			[disable shared GAttrib shim]), [enable_shared_gattrib=${enableval}])
+AM_CONDITIONAL(SHARED_GATTRIB, test "${enable_shared_gattrib}" != "no")
+
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
2.1.0.rc2.206.gedb03e5

