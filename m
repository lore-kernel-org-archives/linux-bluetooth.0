Received: from tabos.org (krueger-it.net [145.239.1.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B74DD3D6
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.1.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553787; cv=none; b=IA0i21nooT3gKacr/3NPkbN/S9UX0LS5KUNeNU75TtIUV249sHApZFrkGwt2ER95LnWzAbdONg8tdD1DlmbnEYujy/JAnEMPTg4uFlIdtnedubinwDKqGNwAQgRAMAdxVPhpQEf/WatcrTcrZsoJNUuGgWjlEgy6VQ8L/vx0UEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553787; c=relaxed/simple;
	bh=6xEfhrrFO2Qo8HoWFARM9QlQyHd5ePBd4oXD4IYHbuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPWfb6TMTvN3uqFeBAus99yy9E0sXr3y0C88cXq8FxDGoQnaTScQ8pRBZrGWMwfSe7UQSWaIrHqzThMCR5dTPQclWpRFOklzA54/YQAzLdUOU055tZ30wYJTEgiYMVUwTs/XbG50OBDrPwqxis7jflUBfFK6PbxERCpnRKvGrao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org; spf=pass smtp.mailfrom=tabos.org; dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b=QyzsIPL+; arc=none smtp.client-ip=145.239.1.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tabos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b="QyzsIPL+"
Received: from c0d1ngstat1on.fritz.box (unknown [94.31.74.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by dserver.krueger-it.net (Postfix) with ESMTPSA id E9D3A62E0797;
	Fri,  9 Oct 2026 15:49:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tabos.org;
	s=default; t=1791553776;
	bh=pWiTXX4mFQszmWw42w1YA5Unk+dyHj8pdAYB3/2mWzQ=; h=From:To:Subject;
	b=QyzsIPL+33rKfFdVPfCx8LLOEM1ak1YjWloYzoGYcn2Ox2eKZNxJWkIi93iPH7DN9
	 h8OP2XdKw5fzMe6yk4sSbK28Z06HyZNYGRRApyeuij1Cs1AaCD37NH3NBqzCRW/yeQ
	 tILcoNBkbap7iughtEWBDJPBGBTalu12ZHjTdndj+NOBQvu1OZ6Hr4rGxumuyFF5Z5
	 Wlxo7ai2IQPjDJDlimdATI2iGrV6qSZ5krrIxQgoRjiPrQvfSkSeGIifc9YWL0SQfW
	 AX/CxQ6coQX5pQUz+gr0pF0uD9L+j4AebFoSQ27KnovFTwsDOBLR3EwcRFobnJJ3sf
	 UZL6r7ym8ZLTA==
Authentication-Results: dserver.krueger-it.net;
        spf=pass (sender IP is 94.31.74.100) smtp.mailfrom=jan.brummer@tabos.org smtp.helo=c0d1ngstat1on.fritz.box
Received-SPF: pass (dserver.krueger-it.net: connection is authenticated)
From: Jan-Michael <jan.brummer@tabos.org>
To: linux-bluetooth@vger.kernel.org
Cc: jan.brummer@tabos.org
Subject: [PATCH BlueZ] Add cover art support
Date: Fri,  9 Oct 2026 15:49:24 +0200
Message-ID: <20261009134924.122040-2-jan.brummer@tabos.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009134924.122040-1-jan.brummer@tabos.org>
References: <20260803195620.255866-1-jan.brummer@tabos.org>
 <20261009134924.122040-1-jan.brummer@tabos.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan-Michael Brummer <jan.brummer@tabos.org>

Add bluetooth cover art support based on the existing code.
Tested with VW head unit and Fairphone 5.
---
 Makefile.obexd            |   3 +
 lib/bluetooth/uuid.h      |   2 +
 obexd/plugins/bip-avrcp.c | 566 ++++++++++++++++++++++++++++++++++++++
 obexd/plugins/bluetooth.c |  13 +
 obexd/src/obex-priv.h     |   1 +
 obexd/src/obex.c          |  32 +++
 obexd/src/obex.h          |   1 +
 profiles/audio/avrcp.c    | 150 +++++++++-
 profiles/audio/media.c    |  35 +++
 src/profile.c             |  77 ++++++
 src/profile.h             |   7 +
 11 files changed, 872 insertions(+), 15 deletions(-)
 create mode 100644 obexd/plugins/bip-avrcp.c

diff --git a/Makefile.obexd b/Makefile.obexd
index 7ad74e128..2421b6814 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -41,6 +41,9 @@ obexd_builtin_sources += obexd/plugins/opp.c
 obexd_builtin_modules += ftp
 obexd_builtin_sources += obexd/plugins/ftp.c obexd/plugins/ftp.h
 
+obexd_builtin_modules += bip_avrcp
+obexd_builtin_sources += obexd/plugins/bip-avrcp.c
+
 obexd_builtin_modules += irmc
 obexd_builtin_sources += obexd/plugins/irmc.c
 
diff --git a/lib/bluetooth/uuid.h b/lib/bluetooth/uuid.h
index bd3fdd486..af5cdf027 100644
--- a/lib/bluetooth/uuid.h
+++ b/lib/bluetooth/uuid.h
@@ -102,6 +102,8 @@ extern "C" {
 #define OBEX_MAS_UUID		"00001132-0000-1000-8000-00805f9b34fb"
 #define OBEX_MNS_UUID		"00001133-0000-1000-8000-00805f9b34fb"
 #define OBEX_MAP_UUID		"00001134-0000-1000-8000-00805f9b34fb"
+/* AVRCP 1.6 Cover Art, Imaging Responder role */
+#define OBEX_BIP_AVRCP_UUID	"0000111b-0000-1000-8000-00805f9b34fb"
 
 /* GATT UUIDs section */
 #define GATT_PRIM_SVC_UUID				0x2800
diff --git a/obexd/plugins/bip-avrcp.c b/obexd/plugins/bip-avrcp.c
new file mode 100644
index 000000000..ffa192136
--- /dev/null
+++ b/obexd/plugins/bip-avrcp.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  OBEX Server - AVRCP Cover Art responder
+ *
+ *  Copyright (C) 2026  Jan-Michael Brummer <jan.brummer@tabos.org>
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/stat.h>
+
+#include <glib.h>
+#include <dbus/dbus.h>
+
+#include "gdbus/gdbus.h"
+
+#include "obexd/src/obexd.h"
+#include "obexd/src/plugin.h"
+#include "obexd/src/obex.h"
+#include "obexd/src/service.h"
+#include "obexd/src/mimetype.h"
+#include "obexd/src/log.h"
+#include "obexd/src/manager.h"
+
+/* AVRCP 1.6 section 5.14.2.1 */
+#define COVER_ART_TARGET ((const uint8_t *) \
+	"\x71\x63\xDD\x54\x4A\x7E\x11\xE2\xB4\x7C\x00\x50\xC2\x49\x00\x48")
+#define COVER_ART_TARGET_SIZE 16
+
+#define COVER_ART_MAX_SIZE (1024 * 1024)
+
+#define MPRIS_PREFIX "org.mpris.MediaPlayer2."
+#define MPRIS_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
+
+struct cover_art_object {
+	int fd;
+	char *contents;		/* Properties document, NULL for images */
+	size_t size;
+	size_t offset;
+};
+
+/*
+ * The image handle is derived from the art URL, the same way bluetoothd
+ * derives the value it reports in AVRCP attribute 0x08. Keep in sync with
+ * profiles/audio/media.c.
+ */
+static void cover_art_handle(const char *url, char *handle, size_t len)
+{
+	snprintf(handle, len, "%07u", g_str_hash(url) % 10000000);
+}
+
+static char *mpris_get_art_url(DBusConnection *conn, const char *name)
+{
+	DBusMessage *msg, *reply;
+	DBusMessageIter iter, variant, dict;
+	const char *iface = MPRIS_PLAYER_INTERFACE;
+	const char *prop = "Metadata";
+	char *url = NULL;
+
+	msg = dbus_message_new_method_call(name, "/org/mpris/MediaPlayer2",
+					"org.freedesktop.DBus.Properties",
+					"Get");
+	if (msg == NULL)
+		return NULL;
+
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &iface,
+					DBUS_TYPE_STRING, &prop,
+					DBUS_TYPE_INVALID);
+
+	reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, NULL);
+	dbus_message_unref(msg);
+
+	if (reply == NULL)
+		return NULL;
+
+	if (!dbus_message_iter_init(reply, &iter) ||
+			dbus_message_iter_get_arg_type(&iter) !=
+							DBUS_TYPE_VARIANT)
+		goto done;
+
+	dbus_message_iter_recurse(&iter, &variant);
+
+	if (dbus_message_iter_get_arg_type(&variant) != DBUS_TYPE_ARRAY)
+		goto done;
+
+	dbus_message_iter_recurse(&variant, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter entry, value;
+		const char *key, *str;
+
+		dbus_message_iter_recurse(&dict, &entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
+			break;
+
+		dbus_message_iter_get_basic(&entry, &key);
+		dbus_message_iter_next(&entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) !=
+							DBUS_TYPE_VARIANT)
+			break;
+
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (g_str_equal(key, "mpris:artUrl") &&
+				dbus_message_iter_get_arg_type(&value) ==
+							DBUS_TYPE_STRING) {
+			dbus_message_iter_get_basic(&value, &str);
+			url = g_strdup(str);
+			break;
+		}
+
+		dbus_message_iter_next(&dict);
+	}
+
+done:
+	dbus_message_unref(reply);
+
+	return url;
+}
+
+/*
+ * Controllers fetch lazily and commonly ask for the previous track's
+ * handle after a track change, when the player no longer advertises that
+ * art URL. Remember the last few resolved handles so those requests can
+ * still be answered.
+ */
+#define COVER_ART_CACHE_SIZE 4
+
+struct cover_art_entry {
+	char handle[8];
+	char *filename;
+};
+
+static GQueue cover_art_cache = G_QUEUE_INIT;
+
+static void cover_art_cache_add(const char *handle, const char *filename)
+{
+	struct cover_art_entry *entry;
+	GList *l;
+
+	for (l = cover_art_cache.head; l != NULL; l = g_list_next(l)) {
+		entry = l->data;
+
+		if (!g_str_equal(entry->handle, handle))
+			continue;
+
+		g_queue_unlink(&cover_art_cache, l);
+		g_queue_push_head_link(&cover_art_cache, l);
+		return;
+	}
+
+	if (g_queue_get_length(&cover_art_cache) >= COVER_ART_CACHE_SIZE) {
+		entry = g_queue_pop_tail(&cover_art_cache);
+		g_free(entry->filename);
+		g_free(entry);
+	}
+
+	entry = g_new0(struct cover_art_entry, 1);
+	strncpy(entry->handle, handle, sizeof(entry->handle) - 1);
+	entry->filename = g_strdup(filename);
+
+	g_queue_push_head(&cover_art_cache, entry);
+}
+
+static char *cover_art_cache_lookup(const char *handle)
+{
+	GList *l;
+
+	for (l = cover_art_cache.head; l != NULL; l = g_list_next(l)) {
+		struct cover_art_entry *entry = l->data;
+
+		if (g_str_equal(entry->handle, handle))
+			return g_strdup(entry->filename);
+	}
+
+	return NULL;
+}
+
+static void cover_art_cache_clear(void)
+{
+	struct cover_art_entry *entry;
+
+	while ((entry = g_queue_pop_head(&cover_art_cache)) != NULL) {
+		g_free(entry->filename);
+		g_free(entry);
+	}
+}
+
+/*
+ * Find the file a handle refers to by asking every MPRIS player on the bus
+ * for its current art URL and hashing it. Players are few and the lookup
+ * only happens when a controller actually fetches an image.
+ */
+static char *cover_art_lookup(const char *handle)
+{
+	DBusConnection *conn = obex_get_dbus_connection();
+	DBusMessage *msg, *reply;
+	DBusMessageIter iter, array;
+	char *filename = NULL;
+
+	if (handle == NULL)
+		return NULL;
+
+	filename = cover_art_cache_lookup(handle);
+	if (filename != NULL)
+		return filename;
+
+	if (conn == NULL)
+		return NULL;
+
+	msg = dbus_message_new_method_call("org.freedesktop.DBus",
+					"/org/freedesktop/DBus",
+					"org.freedesktop.DBus", "ListNames");
+	if (msg == NULL)
+		return NULL;
+
+	reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, NULL);
+	dbus_message_unref(msg);
+
+	if (reply == NULL)
+		return NULL;
+
+	if (!dbus_message_iter_init(reply, &iter) ||
+			dbus_message_iter_get_arg_type(&iter) !=
+							DBUS_TYPE_ARRAY)
+		goto done;
+
+	dbus_message_iter_recurse(&iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
+		const char *name;
+		char *url;
+		char h[8];
+
+		dbus_message_iter_get_basic(&array, &name);
+		dbus_message_iter_next(&array);
+
+		if (!g_str_has_prefix(name, MPRIS_PREFIX))
+			continue;
+
+		url = mpris_get_art_url(conn, name);
+		if (url == NULL)
+			continue;
+
+		cover_art_handle(url, h, sizeof(h));
+
+		if (g_str_equal(h, handle)) {
+			filename = g_filename_from_uri(url, NULL, NULL);
+
+			if (filename != NULL)
+				cover_art_cache_add(handle, filename);
+		}
+
+		g_free(url);
+
+		if (filename != NULL)
+			break;
+	}
+
+done:
+	dbus_message_unref(reply);
+
+	return filename;
+}
+
+static void *cover_art_open_image(const char *name, int oflag, mode_t mode,
+					void *context, size_t *size, int *err)
+{
+	struct cover_art_object *obj;
+	struct stat st;
+	char *filename;
+	int fd;
+
+	if (oflag != O_RDONLY) {
+		if (err)
+			*err = -EPERM;
+		return NULL;
+	}
+
+	filename = cover_art_lookup(name);
+	if (filename == NULL) {
+		DBG("no image for handle %s", name ? name : "(none)");
+		if (err)
+			*err = -ENOENT;
+		return NULL;
+	}
+
+	fd = open(filename, O_RDONLY | O_CLOEXEC);
+	g_free(filename);
+
+	if (fd < 0) {
+		if (err)
+			*err = -errno;
+		return NULL;
+	}
+
+	if (fstat(fd, &st) < 0 || !S_ISREG(st.st_mode) ||
+					st.st_size > COVER_ART_MAX_SIZE) {
+		close(fd);
+		if (err)
+			*err = -EINVAL;
+		return NULL;
+	}
+
+	obj = g_new0(struct cover_art_object, 1);
+	obj->fd = fd;
+	obj->size = st.st_size;
+
+	if (size)
+		*size = obj->size;
+
+	if (err)
+		*err = 0;
+
+	return obj;
+}
+
+/*
+ * Parse the JPEG start-of-frame marker for the image dimensions, which the
+ * image-properties document has to carry.
+ */
+static gboolean jpeg_dimensions(int fd, unsigned int *width,
+						unsigned int *height)
+{
+	uint8_t buf[4];
+	off_t pos = 2;
+
+	if (lseek(fd, 0, SEEK_SET) < 0)
+		return FALSE;
+
+	if (read(fd, buf, 2) != 2 || buf[0] != 0xff || buf[1] != 0xd8)
+		return FALSE;
+
+	while (lseek(fd, pos, SEEK_SET) >= 0 && read(fd, buf, 4) == 4) {
+		uint16_t len = (buf[2] << 8) | buf[3];
+
+		if (buf[0] != 0xff)
+			return FALSE;
+
+		/* SOF0..SOF3, SOF5..SOF7, SOF9..SOF11, SOF13..SOF15 */
+		if (buf[1] >= 0xc0 && buf[1] <= 0xcf &&
+				buf[1] != 0xc4 && buf[1] != 0xc8 &&
+				buf[1] != 0xcc) {
+			uint8_t sof[5];
+
+			if (read(fd, sof, 5) != 5)
+				return FALSE;
+
+			*height = (sof[1] << 8) | sof[2];
+			*width = (sof[3] << 8) | sof[4];
+
+			return TRUE;
+		}
+
+		if (len < 2)
+			return FALSE;
+
+		pos += 2 + len;
+	}
+
+	return FALSE;
+}
+
+static void *cover_art_open_properties(const char *name, int oflag,
+					mode_t mode, void *context,
+					size_t *size, int *err)
+{
+	struct cover_art_object *obj;
+	unsigned int width = 0, height = 0;
+	GString *props;
+
+	obj = cover_art_open_image(name, oflag, mode, context, NULL, err);
+	if (obj == NULL)
+		return NULL;
+
+	if (!jpeg_dimensions(obj->fd, &width, &height)) {
+		close(obj->fd);
+		g_free(obj);
+		if (err)
+			*err = -EINVAL;
+		return NULL;
+	}
+
+	props = g_string_new("<image-properties version=\"1.0\" handle=\"");
+	g_string_append_printf(props, "%s\">\n", name);
+	g_string_append_printf(props,
+		"<native encoding=\"JPEG\" pixel=\"%ux%u\" size=\"%zu\"/>\n",
+		width, height, obj->size);
+	g_string_append(props, "</image-properties>\n");
+
+	close(obj->fd);
+	obj->fd = -1;
+	obj->size = props->len;
+	obj->contents = g_string_free(props, FALSE);
+
+	if (size)
+		*size = obj->size;
+
+	return obj;
+}
+
+static ssize_t cover_art_read(void *object, void *buf, size_t count)
+{
+	struct cover_art_object *obj = object;
+	ssize_t len;
+
+	if (obj->contents != NULL) {
+		len = MIN(count, obj->size - obj->offset);
+		memcpy(buf, obj->contents + obj->offset, len);
+		obj->offset += len;
+
+		return len;
+	}
+
+	len = read(obj->fd, buf, count);
+	if (len < 0)
+		return -errno;
+
+	return len;
+}
+
+static int cover_art_close(void *object)
+{
+	struct cover_art_object *obj = object;
+
+	if (obj->fd >= 0)
+		close(obj->fd);
+
+	g_free(obj->contents);
+	g_free(obj);
+
+	return 0;
+}
+
+static void *cover_art_connect(struct obex_session *os, int *err)
+{
+	DBG("");
+
+	manager_register_session(os);
+
+	if (err)
+		*err = 0;
+
+	return NULL;
+}
+
+static void cover_art_disconnect(struct obex_session *os, void *user_data)
+{
+	DBG("");
+
+	manager_unregister_session(os);
+}
+
+static int cover_art_get(struct obex_session *os, void *user_data)
+{
+	const char *type = obex_get_type(os);
+	const char *handle = obex_get_img_handle(os);
+
+	DBG("type %s handle %s", type ? type : "(none)",
+					handle ? handle : "(none)");
+
+	if (type == NULL || handle == NULL)
+		return -EBADR;
+
+	return obex_get_stream_start(os, handle);
+}
+
+static const struct obex_service_driver cover_art = {
+	.name = "AVRCP Cover Art server",
+	.service = OBEX_BIP,
+	.target = COVER_ART_TARGET,
+	.target_size = COVER_ART_TARGET_SIZE,
+	.connect = cover_art_connect,
+	.get = cover_art_get,
+	.disconnect = cover_art_disconnect,
+};
+
+static const struct obex_mime_type_driver properties = {
+	.target = COVER_ART_TARGET,
+	.target_size = COVER_ART_TARGET_SIZE,
+	.mimetype = "x-bt/img-properties",
+	.open = cover_art_open_properties,
+	.close = cover_art_close,
+	.read = cover_art_read,
+};
+
+/*
+ * The linked thumbnail is served in the image's native encoding rather
+ * than the 200x200 JPEG the specification describes: scaling would mean
+ * decoding images inside obexd. Controllers seen so far accept it.
+ */
+static const struct obex_mime_type_driver thumbnail = {
+	.target = COVER_ART_TARGET,
+	.target_size = COVER_ART_TARGET_SIZE,
+	.mimetype = "x-bt/img-thm",
+	.open = cover_art_open_image,
+	.close = cover_art_close,
+	.read = cover_art_read,
+};
+
+static const struct obex_mime_type_driver image = {
+	.target = COVER_ART_TARGET,
+	.target_size = COVER_ART_TARGET_SIZE,
+	.mimetype = "x-bt/img-img",
+	.open = cover_art_open_image,
+	.close = cover_art_close,
+	.read = cover_art_read,
+};
+
+static int bip_avrcp_init(void)
+{
+	int err;
+
+	err = obex_mime_type_driver_register(&properties);
+	if (err < 0)
+		return err;
+
+	err = obex_mime_type_driver_register(&thumbnail);
+	if (err < 0)
+		goto failed_thumbnail;
+
+	err = obex_mime_type_driver_register(&image);
+	if (err < 0)
+		goto failed_image;
+
+	err = obex_service_driver_register(&cover_art);
+	if (err < 0)
+		goto failed_service;
+
+	return 0;
+
+failed_service:
+	obex_mime_type_driver_unregister(&image);
+failed_image:
+	obex_mime_type_driver_unregister(&thumbnail);
+failed_thumbnail:
+	obex_mime_type_driver_unregister(&properties);
+
+	return err;
+}
+
+static void bip_avrcp_exit(void)
+{
+	cover_art_cache_clear();
+
+	obex_service_driver_unregister(&cover_art);
+	obex_mime_type_driver_unregister(&image);
+	obex_mime_type_driver_unregister(&thumbnail);
+	obex_mime_type_driver_unregister(&properties);
+}
+
+OBEX_PLUGIN_DEFINE(bip_avrcp, bip_avrcp_init, bip_avrcp_exit)
diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index 3af1b504d..962c88c8f 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -259,6 +259,17 @@ static int register_profile(struct bluetooth_profile *profile)
 					&opt);
 	g_dbus_dict_append_entry(&opt, "AutoConnect", DBUS_TYPE_BOOLEAN,
 								&auto_connect);
+	if (profile->driver->service == OBEX_BIP) {
+		dbus_uint16_t psm = 0;
+
+		/*
+		 * Ask for a dynamically assigned L2CAP PSM: Cover Art is
+		 * advertised inside the AVRCP target record, which
+		 * bluetoothd builds once it knows which PSM was handed
+		 * out, so no separate service record is published here.
+		 */
+		g_dbus_dict_append_entry(&opt, "PSM", DBUS_TYPE_UINT16, &psm);
+	}
 	if (profile->driver->record) {
 		if (profile->driver->port != 0)
 			xml = g_markup_printf_escaped(profile->driver->record,
@@ -309,6 +320,8 @@ static const char *service2uuid(uint16_t service)
 		return OBEX_MAS_UUID;
 	case OBEX_MNS:
 		return OBEX_MNS_UUID;
+	case OBEX_BIP:
+		return OBEX_BIP_AVRCP_UUID;
 	}
 
 	return NULL;
diff --git a/obexd/src/obex-priv.h b/obexd/src/obex-priv.h
index d2c62a596..f43a235aa 100644
--- a/obexd/src/obex-priv.h
+++ b/obexd/src/obex-priv.h
@@ -17,6 +17,7 @@ struct obex_session {
 	char *src;
 	char *dst;
 	char *name;
+	char *img_handle;
 	char *destname;
 	char *type;
 	char *path;
diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index 370bfac9e..5573f33ad 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -582,6 +582,31 @@ static void parse_name(struct obex_session *os, GObexPacket *req)
 	DBG("NAME: %s", os->name);
 }
 
+/*
+ * BIP carries the image handle in an application specific header rather
+ * than in Name; see the Basic Imaging Profile, Img-Handle.
+ */
+#define OBEX_HDR_IMG_HANDLE 0x30
+
+static void parse_img_handle(struct obex_session *os, GObexPacket *req)
+{
+	GObexHeader *hdr;
+	const char *handle;
+
+	g_free(os->img_handle);
+	os->img_handle = NULL;
+
+	hdr = g_obex_packet_get_header(req, OBEX_HDR_IMG_HANDLE);
+	if (hdr == NULL)
+		return;
+
+	if (!g_obex_header_get_unicode(hdr, &handle))
+		return;
+
+	os->img_handle = g_strdup(handle);
+	DBG("IMG-HANDLE: %s", os->img_handle);
+}
+
 static void parse_apparam(struct obex_session *os, GObexPacket *req)
 {
 	GObexHeader *hdr;
@@ -638,6 +663,8 @@ static void cmd_get(GObex *obex, GObexPacket *req, gpointer user_data)
 
 	parse_name(os, req);
 
+	parse_img_handle(os, req);
+
 	parse_apparam(os, req);
 
 	err = os->service->get(os, os->service_data);
@@ -1008,6 +1035,11 @@ const char *obex_get_name(struct obex_session *os)
 	return os->name;
 }
 
+const char *obex_get_img_handle(struct obex_session *os)
+{
+	return os->img_handle;
+}
+
 const char *obex_get_destname(struct obex_session *os)
 {
 	return os->destname;
diff --git a/obexd/src/obex.h b/obexd/src/obex.h
index 755be1caf..20389284e 100644
--- a/obexd/src/obex.h
+++ b/obexd/src/obex.h
@@ -21,6 +21,7 @@ struct obex_session;
 int obex_get_stream_start(struct obex_session *os, const char *filename);
 int obex_put_stream_start(struct obex_session *os, const char *filename);
 const char *obex_get_name(struct obex_session *os);
+const char *obex_get_img_handle(struct obex_session *os);
 const char *obex_get_destname(struct obex_session *os);
 void obex_set_name(struct obex_session *os, const char *name);
 ssize_t obex_get_size(struct obex_session *os);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2194a9135..0cc680e51 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -217,6 +217,8 @@ struct avrcp_server {
 	struct btd_adapter *adapter;
 	bool browsing;
 	uint32_t tg_record_id;
+	uint16_t cover_psm;
+	unsigned int cover_watch;
 	uint32_t ct_record_id;
 	GSList *players;
 	GSList *sessions;
@@ -484,7 +486,63 @@ static sdp_record_t *avrcp_ct_record(bool browsing)
 	return record;
 }
 
-static sdp_record_t *avrcp_tg_record(bool browsing)
+static void avrcp_tg_add_protos(sdp_record_t *record, sdp_data_t *version,
+					bool browsing, uint16_t cover_psm)
+{
+	sdp_list_t *apseq_browsing = NULL, *apseq_obex = NULL;
+	uuid_t l2cap, avctp, obex;
+	sdp_list_t *aproto = NULL, *proto[2] = { NULL, NULL };
+	sdp_list_t *oproto[2] = { NULL, NULL };
+	sdp_data_t *psm = NULL, *opsm = NULL;
+	uint16_t ap = AVCTP_BROWSING_PSM;
+
+	if (!browsing && cover_psm == 0)
+		return;
+
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+
+	if (browsing) {
+		proto[0] = sdp_list_append(NULL, &l2cap);
+		psm = sdp_data_alloc(SDP_UINT16, &ap);
+		proto[0] = sdp_list_append(proto[0], psm);
+		apseq_browsing = sdp_list_append(NULL, proto[0]);
+
+		sdp_uuid16_create(&avctp, AVCTP_UUID);
+		proto[1] = sdp_list_append(NULL, &avctp);
+		proto[1] = sdp_list_append(proto[1], version);
+		apseq_browsing = sdp_list_append(apseq_browsing, proto[1]);
+
+		aproto = sdp_list_append(aproto, apseq_browsing);
+	}
+
+	/* AVRCP 1.6 section 8: Cover Art OBEX transport entry */
+	if (cover_psm != 0) {
+		oproto[0] = sdp_list_append(NULL, &l2cap);
+		opsm = sdp_data_alloc(SDP_UINT16, &cover_psm);
+		oproto[0] = sdp_list_append(oproto[0], opsm);
+		apseq_obex = sdp_list_append(NULL, oproto[0]);
+
+		sdp_uuid16_create(&obex, OBEX_UUID);
+		oproto[1] = sdp_list_append(NULL, &obex);
+		apseq_obex = sdp_list_append(apseq_obex, oproto[1]);
+
+		aproto = sdp_list_append(aproto, apseq_obex);
+	}
+
+	sdp_set_add_access_protos(record, aproto);
+
+	free(psm);
+	free(opsm);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(oproto[0], NULL);
+	sdp_list_free(oproto[1], NULL);
+	sdp_list_free(apseq_browsing, NULL);
+	sdp_list_free(apseq_obex, NULL);
+	sdp_list_free(aproto, NULL);
+}
+
+static sdp_record_t *avrcp_tg_record(bool browsing, uint16_t cover_psm)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
 	uuid_t root_uuid, l2cap, avctp, avrtg;
@@ -500,6 +558,9 @@ static sdp_record_t *avrcp_tg_record(bool browsing)
 					AVRCP_FEATURE_CATEGORY_4 |
 					AVRCP_FEATURE_TG_PLAYER_SETTINGS);
 
+	if (cover_psm != 0)
+		feat |= AVRCP_FEATURE_TG_COVERT_ART;
+
 	record = sdp_record_alloc();
 	if (!record)
 		return NULL;
@@ -530,10 +591,10 @@ static sdp_record_t *avrcp_tg_record(bool browsing)
 	sdp_set_access_protos(record, aproto_control);
 
 	/* Additional Protocol Descriptor List */
-	if (browsing) {
+	if (browsing)
 		feat |= AVRCP_FEATURE_BROWSING;
-		avrcp_browsing_record(record, version);
-	}
+
+	avrcp_tg_add_protos(record, version, browsing, cover_psm);
 
 	/* Bluetooth Profile Descriptor List */
 	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
@@ -1272,6 +1333,18 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp *session,
 					id > AVRCP_MEDIA_ATTRIBUTE_LAST)
 				continue;
 
+			/*
+			 * AVRCP 1.6 Section 5.14: the Default Cover Art
+			 * attribute shall only be included if a valid
+			 * image handle exists for the current track.
+			 * Returning it with an empty value makes some
+			 * head units (e.g. VW MIB) give up on Cover Art
+			 * for the rest of the session.
+			 */
+			if (id == AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE &&
+					player_get_metadata(player, id) == NULL)
+				continue;
+
 			len++;
 			attr_ids = g_list_prepend(attr_ids,
 							GUINT_TO_POINTER(id));
@@ -4867,6 +4940,11 @@ static void avrcp_target_server_remove(struct btd_profile *p,
 	if (!server)
 		return;
 
+	if (server->cover_watch != 0) {
+		btd_profile_remove_psm_watch(server->cover_watch);
+		server->cover_watch = 0;
+	}
+
 	if (server->tg_record_id != 0) {
 		adapter_service_remove(adapter, server->tg_record_id);
 		server->tg_record_id = 0;
@@ -4876,10 +4954,56 @@ static void avrcp_target_server_remove(struct btd_profile *p,
 		avrcp_server_unregister(server);
 }
 
+/*
+ * The Cover Art PSM belongs to the responder in obexd, which registers its
+ * profile whenever the session daemon happens to start. Rebuild the record
+ * when that changes so the advertised PSM always matches a listening
+ * socket, and so no Cover Art is advertised while none is there.
+ */
+static int avrcp_tg_record_update(struct avrcp_server *server)
+{
+	sdp_record_t *record;
+
+	if (server->tg_record_id != 0) {
+		adapter_service_remove(server->adapter, server->tg_record_id);
+		server->tg_record_id = 0;
+	}
+
+	record = avrcp_tg_record(server->browsing, server->cover_psm);
+	if (!record) {
+		error("Unable to allocate new service record");
+		return -1;
+	}
+
+	if (adapter_service_add(server->adapter, record) < 0) {
+		error("Unable to register AVRCP target service record");
+		sdp_record_free(record);
+		return -1;
+	}
+
+	server->tg_record_id = record->handle;
+
+	return 0;
+}
+
+static void avrcp_cover_art_psm_cb(struct btd_adapter *adapter, uint16_t psm,
+							void *user_data)
+{
+	struct avrcp_server *server = user_data;
+
+	if (server->adapter != adapter || server->cover_psm == psm)
+		return;
+
+	DBG("Cover Art PSM %u", psm);
+
+	server->cover_psm = psm;
+
+	avrcp_tg_record_update(server);
+}
+
 static int avrcp_target_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
-	sdp_record_t *record;
 	struct avrcp_server *server;
 
 	DBG("path %s", adapter_get_path(adapter));
@@ -4893,20 +5017,16 @@ static int avrcp_target_server_probe(struct btd_profile *p,
 		return -EPROTONOSUPPORT;
 
 done:
-	record = avrcp_tg_record(server->browsing);
-	if (!record) {
-		error("Unable to allocate new service record");
-		avrcp_target_server_remove(p, adapter);
-		return -1;
-	}
+	if (server->cover_watch == 0)
+		server->cover_watch = btd_profile_add_psm_watch(
+						OBEX_BIP_AVRCP_UUID,
+						avrcp_cover_art_psm_cb,
+						server);
 
-	if (adapter_service_add(adapter, record) < 0) {
-		error("Unable to register AVRCP target service record");
+	if (avrcp_tg_record_update(server) < 0) {
 		avrcp_target_server_remove(p, adapter);
-		sdp_record_free(record);
 		return -1;
 	}
-	server->tg_record_id = record->handle;
 
 	return 0;
 }
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 5d9ea2cbc..4917372a8 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -2458,6 +2458,38 @@ static gboolean parse_int32_metadata(struct local_player *mp, const char *key,
 	return TRUE;
 }
 
+/*
+ * AVRCP 1.6 section 5.14: the Default Cover Art attribute carries a BIP
+ * image handle, seven US-ASCII digits identifying the image.
+ *
+ * The handle is derived from the art URL rather than allocated, so that
+ * the Cover Art responder in obexd arrives at the same value for the same
+ * URL without any coordination between the two daemons. It also makes the
+ * handle stable across reconnects and daemon restarts, which spares
+ * controllers a re-fetch of an image they already hold.
+ *
+ * Keep in sync with obexd/plugins/bip-avrcp.c.
+ */
+static gboolean parse_art_url_metadata(struct local_player *mp,
+							DBusMessageIter *iter)
+{
+	const char *url;
+	char handle[8];
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &url);
+
+	snprintf(handle, sizeof(handle), "%07u",
+					g_str_hash(url) % 10000000);
+
+	g_hash_table_insert(mp->track, g_strdup("ImgHandle"),
+							g_strdup(handle));
+
+	return TRUE;
+}
+
 static gboolean parse_player_metadata(struct local_player *mp,
 							DBusMessageIter *iter)
 {
@@ -2517,6 +2549,9 @@ static gboolean parse_player_metadata(struct local_player *mp,
 		} else if (strcasecmp(key, "xesam:trackNumber") == 0) {
 			if (!parse_int32_metadata(mp, "TrackNumber", &var))
 				return FALSE;
+		} else if (strcasecmp(key, "mpris:artUrl") == 0) {
+			if (!parse_art_url_metadata(mp, &var))
+				return FALSE;
 		} else
 			DBG("%s not supported, ignoring", key);
 
diff --git a/src/profile.c b/src/profile.c
index 97fffe9b4..449eb9a5d 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -59,6 +59,9 @@
 #define BT_RX_MTU		32767
 
 #define BTD_PROFILE_PSM_AUTO	-1
+
+static void psm_watch_notify(const char *uuid, struct btd_adapter *adapter,
+							uint16_t psm);
 #define BTD_PROFILE_CHAN_AUTO	-1
 
 #define HFP_HF_RECORD							\
@@ -1444,6 +1447,8 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
 			l2cap->adapter = btd_adapter_ref(adapter);
 			ext->servers = g_slist_append(ext->servers, l2cap);
 			DBG("%s listening on PSM %u", ext->name, psm);
+
+			psm_watch_notify(ext->uuid, adapter, psm);
 		}
 	}
 
@@ -1494,6 +1499,66 @@ failed:
 	return 0;
 }
 
+struct psm_watch {
+	unsigned int id;
+	char *uuid;
+	btd_profile_psm_func func;
+	void *user_data;
+};
+
+static GSList *psm_watches;
+static unsigned int psm_watch_id;
+
+unsigned int btd_profile_add_psm_watch(const char *uuid,
+					btd_profile_psm_func func,
+					void *user_data)
+{
+	struct psm_watch *watch;
+
+	if (uuid == NULL || func == NULL)
+		return 0;
+
+	watch = g_new0(struct psm_watch, 1);
+	watch->id = ++psm_watch_id;
+	watch->uuid = g_strdup(uuid);
+	watch->func = func;
+	watch->user_data = user_data;
+
+	psm_watches = g_slist_append(psm_watches, watch);
+
+	return watch->id;
+}
+
+static void psm_watch_notify(const char *uuid, struct btd_adapter *adapter,
+							uint16_t psm)
+{
+	GSList *l;
+
+	for (l = psm_watches; l != NULL; l = g_slist_next(l)) {
+		struct psm_watch *watch = l->data;
+
+		if (strcasecmp(watch->uuid, uuid) == 0)
+			watch->func(adapter, psm, watch->user_data);
+	}
+}
+
+void btd_profile_remove_psm_watch(unsigned int id)
+{
+	GSList *l;
+
+	for (l = psm_watches; l != NULL; l = g_slist_next(l)) {
+		struct psm_watch *watch = l->data;
+
+		if (watch->id != id)
+			continue;
+
+		psm_watches = g_slist_remove(psm_watches, watch);
+		g_free(watch->uuid);
+		g_free(watch);
+		return;
+	}
+}
+
 static struct ext_profile *find_ext(struct btd_profile *p)
 {
 	GSList *l;
@@ -1574,6 +1639,9 @@ static void ext_adapter_remove(struct btd_profile *p,
 		if (server->adapter != adapter)
 			continue;
 
+		if (server->proto == BTPROTO_L2CAP)
+			psm_watch_notify(ext->uuid, adapter, 0);
+
 		ext->servers = g_slist_remove(ext->servers, server);
 		ext_io_destroy(server);
 	}
@@ -2213,6 +2281,15 @@ static struct default_settings {
 		.get_record	= get_mns_record,
 		.version	= 0x0104,
 		.imtu		= BT_RX_MTU,
+	}, {
+		.uuid		= OBEX_BIP_AVRCP_UUID,
+		.name		= "AVRCP Cover Art",
+		.psm		= BTD_PROFILE_PSM_AUTO,
+		.mode		= BT_IO_MODE_ERTM,
+		.sec_level	= BT_IO_SEC_LOW,
+		.authorize	= false,
+		.version	= 0x0100,
+		.imtu		= BT_RX_MTU,
 	},
 };
 
diff --git a/src/profile.h b/src/profile.h
index 04a99528b..26be997e7 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -112,3 +112,10 @@ typedef const struct btd_profile *(*btd_profile_list_get)(void *item,
 							void *user_data);
 GSList *btd_profile_sort_list(GSList *list, btd_profile_list_get get,
 							void *user_data);
+
+typedef void (*btd_profile_psm_func)(struct btd_adapter *adapter,
+					uint16_t psm, void *user_data);
+unsigned int btd_profile_add_psm_watch(const char *uuid,
+					btd_profile_psm_func func,
+					void *user_data);
+void btd_profile_remove_psm_watch(unsigned int id);
-- 
2.56.0

