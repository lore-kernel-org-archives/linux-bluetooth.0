Received: from tabos.org (krueger-it.net [145.239.1.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8082400975
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.1.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787009; cv=none; b=pgOOsbyDFb9fY0rSeN74Hc6q2woZs7tKDp95PhbEiXBJs469xPoF+br0rYNiXcWWUGyI9WkJfd9WIS2Z6sHjiWGD9fqeTnYfQ/s2FxZIP6I8dVp9jUjBpfGgNTBTuOyxAb2KoMgJT2K0y8/N5RWHhbmTaCLxgj/fTzdGsOE1jLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787009; c=relaxed/simple;
	bh=eM/PDryfcpe5tttTZWPe0lmK+L9zWwaPH0DBYV+XL9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvywddC9Qf6OSAu9ofDJXOBi7hx4bErxFm7DT4SLjJQ5guTBG/ybZurWdVy3VxI4UanreEQCbLHWDD4K9fSghWiTlIoKAWlSSzamnnBfIOESN/sonwd3lQ8nUlr6RJF7m8kbqnGtgQ+/KvSdIbs4xBAoYWIQJdzFhM3yr1fV0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org; spf=pass smtp.mailfrom=tabos.org; dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b=iDgKEvEZ; arc=none smtp.client-ip=145.239.1.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tabos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b="iDgKEvEZ"
Received: from c0d1ngstat1on.fritz.box (unknown [94.31.74.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by dserver.krueger-it.net (Postfix) with ESMTPSA id 4375A62E15A3;
	Mon,  3 Aug 2026 21:56:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tabos.org;
	s=default; t=1785787004;
	bh=E7qUTr7zsrnkVqEFVtI5X3D6wRZzH94BOLslUv9kqeM=; h=From:To:Subject;
	b=iDgKEvEZMuZiemrH1Nj8Wa0C5rZtdedfO8u6eWvPC0ZsS/DOg8SvQLpPpAfKw4bsC
	 53gnW59StTYWw/cKwGiQv+alOlUjKaG7ewLPFDFB/gCu36nSIssnzMjTMiTxhpBikd
	 ulwGIE6M7eAZtksxYteq477V296D8p8pr73FzYhTuUcByKZ2b6cnNxaTTCUorhF+B9
	 M22AbKQX8r/c6ySrjlvoU8Q1E0kmirL5DD5XjHClOBFYpC/dyEEJLPyLjGpImPYtO5
	 zpeR4dKGdrE7EVvrE3qcTtLrWkZQmCRXWpXUkvpgJ1VhOqoAf7pbgMsl8IsQCjTNyN
	 8o/hFZKgWPxwA==
Authentication-Results: dserver.krueger-it.net;
        spf=pass (sender IP is 94.31.74.100) smtp.mailfrom=jan.brummer@tabos.org smtp.helo=c0d1ngstat1on.fritz.box
Received-SPF: pass (dserver.krueger-it.net: connection is authenticated)
From: Jan-Michael <jan.brummer@tabos.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jan-Michael Brummer <jan.brummer@tabos.org>
Subject: [PATCH BlueZ 1/1] Add cover art support
Date: Mon,  3 Aug 2026 21:55:01 +0200
Message-ID: <20260803195620.255866-2-jan.brummer@tabos.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803195620.255866-1-jan.brummer@tabos.org>
References: <20260803195620.255866-1-jan.brummer@tabos.org>
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
 Makefile.plugins           |   4 +-
 profiles/audio/avrcp-bip.c | 562 +++++++++++++++++++++++++++++++++++++
 profiles/audio/avrcp-bip.h |  31 ++
 profiles/audio/avrcp.c     |  84 +++++-
 profiles/audio/media.c     |  77 +++++
 src/bluetooth.service.in   |   7 +-
 6 files changed, 757 insertions(+), 8 deletions(-)
 create mode 100644 profiles/audio/avrcp-bip.c
 create mode 100644 profiles/audio/avrcp-bip.h

diff --git a/Makefile.plugins b/Makefile.plugins
index ac667beda..101e6bdc6 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -37,7 +37,9 @@ builtin_modules += avrcp
 builtin_sources += profiles/audio/control.h profiles/audio/control.c \
 			profiles/audio/avctp.h profiles/audio/avctp.c \
 			profiles/audio/avrcp.h profiles/audio/avrcp.c \
-			profiles/audio/avrcp-player.c
+			profiles/audio/avrcp-player.c \
+			profiles/audio/avrcp-bip.h profiles/audio/avrcp-bip.c \
+			$(gobex_sources)
 endif
 
 if NETWORK
diff --git a/profiles/audio/avrcp-bip.c b/profiles/audio/avrcp-bip.c
new file mode 100644
index 000000000..4079a6ea9
--- /dev/null
+++ b/profiles/audio/avrcp-bip.c
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  AVRCP 1.6 Cover Art Responder
+ *
+ *  Copyright (C) 2026  Jan-Michael Brummer <jan.brummer@tabos.org>
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "bluetooth/bluetooth.h"
+
+#include "gobex/gobex.h"
+#include "btio/btio.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/log.h"
+
+#include "avctp.h"
+#include "avrcp-bip.h"
+
+/* OBEX Target UUID for AVRCP Cover Art (AVRCP 1.6, section 5.14.2.1) */
+static const uint8_t cover_art_target_uuid[] = {
+	0x71, 0x63, 0xDD, 0x54, 0x4A, 0x7E, 0x11, 0xE2,
+	0xB4, 0x7C, 0x00, 0x50, 0xC2, 0x49, 0x00, 0x48
+};
+
+/* BIP user defined headers */
+#define BIP_HDR_IMG_HANDLE	0x30	/* Unicode text */
+#define BIP_HDR_IMG_DESCRIPTOR	0x71	/* Byte sequence */
+
+#define BIP_TYPE_CAPABILITIES	"x-bt/img-capabilities"
+#define BIP_TYPE_PROPERTIES	"x-bt/img-properties"
+#define BIP_TYPE_IMAGE		"x-bt/img-img"
+#define BIP_TYPE_THUMBNAIL	"x-bt/img-thm"
+
+#define COVER_ART_MAX_IMAGES	4
+
+struct cover_image {
+	char		handle[8];	/* 7 digit handle + NUL */
+	GBytes		*data;
+	unsigned int	width;
+	unsigned int	height;
+};
+
+struct bip_session {
+	GObex		*obex;
+	GBytes		*pending;	/* image being transferred */
+	size_t		offset;
+	bool		connected;	/* CONNECT with valid target seen */
+	bdaddr_t	src;		/* local adapter address */
+	bdaddr_t	dst;		/* peer address */
+};
+
+static const uint16_t candidate_psms[] = {
+	0x10F1, 0x10F3, 0x10F5, 0x10F7, 0x10F9
+};
+
+static GIOChannel *server_io;
+static uint16_t server_psm;
+static unsigned int server_ref;
+static uint32_t next_handle = 1;
+static GSList *images;		/* struct cover_image, newest first */
+static GSList *sessions;	/* struct bip_session */
+
+static bool session_has_avrcp(struct bip_session *session);
+
+static bool jpeg_get_size(const uint8_t *data, size_t len,
+				unsigned int *width, unsigned int *height)
+{
+	size_t i;
+
+	if (len < 4 || data[0] != 0xff || data[1] != 0xd8)
+		return false;
+
+	i = 2;
+	while (i + 9 < len) {
+		uint8_t marker;
+		uint16_t seglen;
+
+		if (data[i] != 0xff) {
+			i++;
+			continue;
+		}
+
+		marker = data[i + 1];
+
+		/* Standalone markers without length field */
+		if (marker == 0xff || (marker >= 0xd0 && marker <= 0xd9)) {
+			i += 2;
+			continue;
+		}
+
+		seglen = (data[i + 2] << 8) | data[i + 3];
+		if (seglen < 2)
+			return false;
+
+		/* SOF0..SOF15 except DHT(C4)/JPG(C8)/DAC(CC) */
+		if (marker >= 0xc0 && marker <= 0xcf && marker != 0xc4 &&
+				marker != 0xc8 && marker != 0xcc) {
+			if (i + 9 >= len)
+				return false;
+			*height = (data[i + 5] << 8) | data[i + 6];
+			*width = (data[i + 7] << 8) | data[i + 8];
+			return true;
+		}
+
+		i += 2 + seglen;
+	}
+
+	return false;
+}
+
+static void cover_image_free(void *data)
+{
+	struct cover_image *img = data;
+
+	g_bytes_unref(img->data);
+	g_free(img);
+}
+
+static struct cover_image *find_image(const char *handle)
+{
+	GSList *l;
+
+	for (l = images; l; l = l->next) {
+		struct cover_image *img = l->data;
+
+		if (g_str_equal(img->handle, handle))
+			return img;
+	}
+
+	return NULL;
+}
+
+const char *avrcp_bip_set_cover_art(const uint8_t *data, size_t len)
+{
+	struct cover_image *img;
+	unsigned int width = 0, height = 0;
+
+	if (data == NULL || len == 0)
+		return NULL;
+
+	if (!jpeg_get_size(data, len, &width, &height)) {
+		DBG("cover art is not a valid JPEG image");
+		return NULL;
+	}
+
+	img = g_new0(struct cover_image, 1);
+	snprintf(img->handle, sizeof(img->handle), "%07u",
+					next_handle++ % 10000000);
+	img->data = g_bytes_new(data, len);
+	img->width = width;
+	img->height = height;
+
+	images = g_slist_prepend(images, img);
+
+	while (g_slist_length(images) > COVER_ART_MAX_IMAGES) {
+		GSList *last = g_slist_last(images);
+
+		cover_image_free(last->data);
+		images = g_slist_delete_link(images, last);
+	}
+
+	DBG("handle %s (%zu bytes, %ux%u)", img->handle, len, width, height);
+
+	return img->handle;
+}
+
+void avrcp_bip_clear_cover_art(void)
+{
+	g_slist_free_full(images, cover_image_free);
+	images = NULL;
+}
+
+static void session_free(struct bip_session *session)
+{
+	sessions = g_slist_remove(sessions, session);
+
+	if (session->pending)
+		g_bytes_unref(session->pending);
+
+	if (session->obex)
+		g_obex_unref(session->obex);
+
+	g_free(session);
+}
+
+static void disconn_func(GObex *obex, GError *err, gpointer user_data)
+{
+	struct bip_session *session = user_data;
+
+	DBG("BIP session disconnected");
+
+	session_free(session);
+}
+
+static char *packet_get_type(GObexPacket *req)
+{
+	GObexHeader *hdr;
+	const guint8 *type;
+	gsize len;
+
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_TYPE);
+	if (hdr == NULL)
+		return NULL;
+
+	if (!g_obex_header_get_bytes(hdr, &type, &len) || len == 0)
+		return NULL;
+
+	return g_strndup((const char *) type, len);
+}
+
+static char *packet_get_img_handle(GObexPacket *req)
+{
+	GObexHeader *hdr;
+	const char *handle;
+
+	hdr = g_obex_packet_get_header(req, BIP_HDR_IMG_HANDLE);
+	if (hdr == NULL)
+		return NULL;
+
+	if (!g_obex_header_get_unicode(hdr, &handle))
+		return NULL;
+
+	return g_strdup(handle);
+}
+
+static void connect_func(GObex *obex, GObexPacket *req, gpointer user_data)
+{
+	struct bip_session *session = user_data;
+	GObexHeader *hdr;
+	const guint8 *target;
+	gsize len;
+	GError *err = NULL;
+
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_TARGET);
+	if (hdr == NULL || !g_obex_header_get_bytes(hdr, &target, &len) ||
+			len != sizeof(cover_art_target_uuid) ||
+			memcmp(target, cover_art_target_uuid, len) != 0) {
+		g_obex_send_rsp(obex, G_OBEX_RSP_NOT_ACCEPTABLE, NULL,
+							G_OBEX_HDR_INVALID);
+		return;
+	}
+
+	session->connected = true;
+
+	DBG("Cover Art OBEX session connected");
+
+	/* gobex fills in version/flags/mpl and the Connection ID */
+	g_obex_send_rsp(obex, G_OBEX_RSP_SUCCESS, &err,
+			G_OBEX_HDR_WHO, cover_art_target_uuid,
+			sizeof(cover_art_target_uuid),
+			G_OBEX_HDR_INVALID);
+
+	if (err != NULL) {
+		error("Cover Art CONNECT rsp: %s", err->message);
+		g_error_free(err);
+	}
+}
+
+static void disconnect_func(GObex *obex, GObexPacket *req, gpointer user_data)
+{
+	g_obex_send_rsp(obex, G_OBEX_RSP_SUCCESS, NULL, G_OBEX_HDR_INVALID);
+}
+
+static gssize pending_data_producer(void *buf, gsize len, gpointer user_data)
+{
+	struct bip_session *session = user_data;
+	gsize size, remaining;
+	const uint8_t *data;
+
+	if (session->pending == NULL)
+		return 0;
+
+	data = g_bytes_get_data(session->pending, &size);
+
+	if (session->offset >= size)
+		remaining = 0;
+	else
+		remaining = size - session->offset;
+
+	if (remaining == 0) {
+		g_bytes_unref(session->pending);
+		session->pending = NULL;
+		session->offset = 0;
+		return 0;
+	}
+
+	len = MIN(len, remaining);
+	memcpy(buf, data + session->offset, len);
+	session->offset += len;
+
+	return len;
+}
+
+static void transfer_complete(GObex *obex, GError *err, gpointer user_data)
+{
+	struct bip_session *session = user_data;
+
+	if (err != NULL)
+		DBG("Cover Art transfer failed: %s", err->message);
+
+	if (session->pending) {
+		g_bytes_unref(session->pending);
+		session->pending = NULL;
+	}
+
+	session->offset = 0;
+}
+
+static void respond_with_bytes(struct bip_session *session, GBytes *bytes,
+							gboolean with_length)
+{
+	GError *err = NULL;
+	gsize size;
+
+	g_bytes_get_data(bytes, &size);
+
+	if (session->pending)
+		g_bytes_unref(session->pending);
+
+	session->pending = g_bytes_ref(bytes);
+	session->offset = 0;
+
+	if (with_length)
+		g_obex_get_rsp(session->obex, pending_data_producer,
+				transfer_complete, session, &err,
+				G_OBEX_HDR_LENGTH, (guint32) size,
+				G_OBEX_HDR_INVALID);
+	else
+		g_obex_get_rsp(session->obex, pending_data_producer,
+				transfer_complete, session, &err,
+				G_OBEX_HDR_INVALID);
+
+	if (err != NULL) {
+		error("Cover Art GET rsp: %s", err->message);
+		g_error_free(err);
+		g_bytes_unref(session->pending);
+		session->pending = NULL;
+	}
+}
+
+static void get_image_properties(struct bip_session *session,
+						struct cover_image *img)
+{
+	GString *xml;
+	GBytes *bytes;
+	gsize size;
+	char *str;
+
+	g_bytes_get_data(img->data, &size);
+
+	xml = g_string_new("");
+	g_string_append_printf(xml,
+		"<image-properties version=\"1.0\" handle=\"%s\">\r\n"
+		"<native encoding=\"JPEG\" pixel=\"%u*%u\" size=\"%zu\"/>\r\n"
+		"<variant encoding=\"JPEG\" pixel=\"200*200\"/>\r\n"
+		"</image-properties>\r\n",
+		img->handle, img->width, img->height, size);
+
+	str = g_string_free(xml, FALSE);
+	bytes = g_bytes_new_take(str, strlen(str));
+
+	respond_with_bytes(session, bytes, FALSE);
+	g_bytes_unref(bytes);
+}
+
+static void get_func(GObex *obex, GObexPacket *req, gpointer user_data)
+{
+	struct bip_session *session = user_data;
+	struct cover_image *img = NULL;
+	char *type, *handle;
+
+	if (!session->connected || !session_has_avrcp(session)) {
+		g_obex_send_rsp(obex, G_OBEX_RSP_FORBIDDEN, NULL,
+							G_OBEX_HDR_INVALID);
+		return;
+	}
+
+	type = packet_get_type(req);
+	if (type == NULL) {
+		g_obex_send_rsp(obex, G_OBEX_RSP_BAD_REQUEST, NULL,
+							G_OBEX_HDR_INVALID);
+		return;
+	}
+
+	handle = packet_get_img_handle(req);
+
+	DBG("type %s handle %s", type, handle ? handle : "(none)");
+
+	if (handle != NULL)
+		img = find_image(handle);
+	else if (images != NULL)
+		img = images->data;	/* newest */
+
+	if (img == NULL) {
+		g_obex_send_rsp(obex, G_OBEX_RSP_NOT_FOUND, NULL,
+							G_OBEX_HDR_INVALID);
+		goto done;
+	}
+
+	if (g_str_equal(type, BIP_TYPE_PROPERTIES)) {
+		get_image_properties(session, img);
+	} else if (g_str_equal(type, BIP_TYPE_THUMBNAIL)) {
+		respond_with_bytes(session, img->data, FALSE);
+	} else if (g_str_equal(type, BIP_TYPE_IMAGE)) {
+		respond_with_bytes(session, img->data, TRUE);
+	} else {
+		g_obex_send_rsp(obex, G_OBEX_RSP_NOT_IMPLEMENTED, NULL,
+							G_OBEX_HDR_INVALID);
+	}
+
+done:
+	g_free(type);
+	g_free(handle);
+}
+
+static void bip_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
+{
+	struct bip_session *session;
+	GObex *obex;
+
+	if (gerr != NULL) {
+		error("Cover Art accept: %s", gerr->message);
+		return;
+	}
+
+	obex = g_obex_new(io, G_OBEX_TRANSPORT_PACKET, -1, -1);
+	if (obex == NULL) {
+		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
+	}
+
+	session = g_new0(struct bip_session, 1);
+	session->obex = obex;
+
+	bt_io_get(io, NULL, BT_IO_OPT_SOURCE_BDADDR, &session->src,
+			BT_IO_OPT_DEST_BDADDR, &session->dst,
+			BT_IO_OPT_INVALID);
+
+	sessions = g_slist_prepend(sessions, session);
+
+	g_obex_set_disconnect_function(obex, disconn_func, session);
+	g_obex_add_request_function(obex, G_OBEX_OP_CONNECT, connect_func,
+								session);
+	g_obex_add_request_function(obex, G_OBEX_OP_DISCONNECT,
+						disconnect_func, session);
+	g_obex_add_request_function(obex, G_OBEX_OP_GET, get_func, session);
+
+	DBG("Cover Art transport connected");
+}
+
+static bool session_has_avrcp(struct bip_session *session)
+{
+	struct btd_adapter *adapter;
+	struct btd_device *device;
+
+	adapter = adapter_find(&session->src);
+	if (adapter == NULL)
+		return false;
+
+	device = btd_adapter_find_device(adapter, &session->dst,
+								BDADDR_BREDR);
+	if (device == NULL || avctp_get(device) == NULL) {
+		DBG("Peer has no AVRCP session");
+		return false;
+	}
+
+	return true;
+}
+
+static void bip_confirm_cb(GIOChannel *io, gpointer user_data)
+{
+	GError *gerr = NULL;
+
+	if (!bt_io_accept(io, bip_connect_cb, NULL, NULL, &gerr)) {
+		error("Cover Art bt_io_accept: %s", gerr->message);
+		g_error_free(gerr);
+		g_io_channel_shutdown(io, TRUE, NULL);
+	}
+}
+
+uint16_t avrcp_bip_server_start(void)
+{
+	size_t i;
+
+	if (server_io != NULL) {
+		server_ref++;
+		return server_psm;
+	}
+
+	for (i = 0; i < G_N_ELEMENTS(candidate_psms); i++) {
+		GError *gerr = NULL;
+
+		server_io = bt_io_listen(NULL, bip_confirm_cb, NULL, NULL,
+				&gerr,
+				BT_IO_OPT_PSM, candidate_psms[i],
+				BT_IO_OPT_MODE, BT_IO_MODE_ERTM,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_INVALID);
+		if (server_io != NULL) {
+			server_psm = candidate_psms[i];
+			break;
+		}
+
+		DBG("Cover Art responder PSM 0x%04x: %s",
+				candidate_psms[i], gerr->message);
+		g_error_free(gerr);
+	}
+
+	if (server_io == NULL) {
+		error("Cover Art responder: no free PSM");
+		return 0;
+	}
+
+	server_ref = 1;
+
+	DBG("Cover Art responder listening on PSM 0x%04x", server_psm);
+
+	return server_psm;
+}
+
+void avrcp_bip_server_stop(void)
+{
+	if (server_io == NULL)
+		return;
+
+	if (--server_ref > 0)
+		return;
+
+	while (sessions != NULL)
+		session_free(sessions->data);
+
+	avrcp_bip_clear_cover_art();
+
+	g_io_channel_shutdown(server_io, TRUE, NULL);
+	g_io_channel_unref(server_io);
+	server_io = NULL;
+	server_psm = 0;
+}
+
+bool avrcp_bip_server_active(void)
+{
+	return server_io != NULL;
+}
+
+uint16_t avrcp_bip_server_get_psm(void)
+{
+	return server_psm;
+}
diff --git a/profiles/audio/avrcp-bip.h b/profiles/audio/avrcp-bip.h
new file mode 100644
index 000000000..ff970ac86
--- /dev/null
+++ b/profiles/audio/avrcp-bip.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  AVRCP 1.6 Cover Art Responder
+ *
+ *  Copyright (C) 2026 Jan-Michael Brummer <jan.brummer@tabos.org>
+ *
+ */
+
+#ifndef __AVRCP_BIP_H
+#define __AVRCP_BIP_H
+
+#include <stdint.h>
+#include <stddef.h>
+#include <stdbool.h>
+
+uint16_t avrcp_bip_server_start(void);
+
+void avrcp_bip_server_stop(void);
+
+bool avrcp_bip_server_active(void);
+
+uint16_t avrcp_bip_server_get_psm(void);
+
+const char *avrcp_bip_set_cover_art(const uint8_t *data, size_t len);
+
+void avrcp_bip_clear_cover_art(void);
+
+#endif /* __AVRCP_BIP_H */
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2194a9135..8f2fd823e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -52,6 +52,7 @@
 
 #include "avctp.h"
 #include "avrcp.h"
+#include "avrcp-bip.h"
 #include "control.h"
 #include "media.h"
 #include "player.h"
@@ -216,6 +217,7 @@ struct get_total_number_of_items_rsp {
 struct avrcp_server {
 	struct btd_adapter *adapter;
 	bool browsing;
+	bool cover_art;
 	uint32_t tg_record_id;
 	uint32_t ct_record_id;
 	GSList *players;
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
@@ -1272,6 +1333,10 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp *session,
 					id > AVRCP_MEDIA_ATTRIBUTE_LAST)
 				continue;
 
+			if (id == AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE &&
+					player_get_metadata(player, id) == NULL)
+				continue;
+
 			len++;
 			attr_ids = g_list_prepend(attr_ids,
 							GUINT_TO_POINTER(id));
@@ -4872,6 +4937,11 @@ static void avrcp_target_server_remove(struct btd_profile *p,
 		server->tg_record_id = 0;
 	}
 
+	if (server->cover_art) {
+		avrcp_bip_server_stop();
+		server->cover_art = false;
+	}
+
 	if (server->ct_record_id == 0)
 		avrcp_server_unregister(server);
 }
@@ -4893,7 +4963,11 @@ static int avrcp_target_server_probe(struct btd_profile *p,
 		return -EPROTONOSUPPORT;
 
 done:
-	record = avrcp_tg_record(server->browsing);
+	if (!server->cover_art)
+		server->cover_art = avrcp_bip_server_start() != 0;
+
+	record = avrcp_tg_record(server->browsing,
+			server->cover_art ? avrcp_bip_server_get_psm() : 0);
 	if (!record) {
 		error("Unable to allocate new service record");
 		avrcp_target_server_remove(p, adapter);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 5d9ea2cbc..7bd1937d6 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -66,6 +66,9 @@
 #ifdef HAVE_A2DP
 #include "a2dp.h"
 #endif
+#ifdef HAVE_AVRCP
+#include "avrcp-bip.h"
+#endif
 
 #define MEDIA_INTERFACE "org.bluez.Media1"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
@@ -159,6 +162,8 @@ struct local_player {
 	bool			previous;
 	bool			control;
 	char			*name;
+	char			*art_url;	/* Registered cover art URL */
+	char			art_handle[8];	/* BIP handle of art_url */
 	struct queue		*cbs;
 };
 
@@ -2069,6 +2074,7 @@ static void local_player_destroy(struct local_player *mp)
 	g_free(mp->path);
 	g_free(mp->status);
 	g_free(mp->name);
+	g_free(mp->art_url);
 	g_free(mp);
 }
 
@@ -2458,6 +2464,72 @@ static gboolean parse_int32_metadata(struct local_player *mp, const char *key,
 	return TRUE;
 }
 
+#ifdef HAVE_AVRCP
+#define COVER_ART_MAX_SIZE (1024 * 1024)
+
+static gboolean parse_art_url_metadata(struct local_player *mp,
+							DBusMessageIter *iter)
+{
+	const char *url, *handle;
+	char *filename, *contents = NULL;
+	gsize len = 0;
+	GError *gerr = NULL;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &url);
+
+	if (!avrcp_bip_server_active())
+		return TRUE;
+
+	if (mp->art_url != NULL && g_str_equal(mp->art_url, url) &&
+						mp->art_handle[0] != '\0') {
+		g_hash_table_insert(mp->track, g_strdup("ImgHandle"),
+						g_strdup(mp->art_handle));
+		return TRUE;
+	}
+
+	filename = g_filename_from_uri(url, NULL, NULL);
+	if (filename == NULL) {
+		DBG("cover art %s is not a local file, ignoring", url);
+		return TRUE;
+	}
+
+	if (!g_file_get_contents(filename, &contents, &len, &gerr)) {
+		DBG("cover art %s: %s", filename, gerr->message);
+		g_error_free(gerr);
+		g_free(filename);
+		return TRUE;
+	}
+
+	g_free(filename);
+
+	if (len == 0 || len > COVER_ART_MAX_SIZE) {
+		DBG("cover art has invalid size (%zu bytes), ignoring", len);
+		g_free(contents);
+		return TRUE;
+	}
+
+	handle = avrcp_bip_set_cover_art((const uint8_t *) contents, len);
+	g_free(contents);
+
+	/* Non-JPEG images are rejected by the responder */
+	if (handle == NULL)
+		return TRUE;
+
+	g_free(mp->art_url);
+	mp->art_url = g_strdup(url);
+	strncpy(mp->art_handle, handle, sizeof(mp->art_handle) - 1);
+	mp->art_handle[sizeof(mp->art_handle) - 1] = '\0';
+
+	g_hash_table_insert(mp->track, g_strdup("ImgHandle"),
+							g_strdup(handle));
+
+	return TRUE;
+}
+#endif
+
 static gboolean parse_player_metadata(struct local_player *mp,
 							DBusMessageIter *iter)
 {
@@ -2517,6 +2589,11 @@ static gboolean parse_player_metadata(struct local_player *mp,
 		} else if (strcasecmp(key, "xesam:trackNumber") == 0) {
 			if (!parse_int32_metadata(mp, "TrackNumber", &var))
 				return FALSE;
+		} else if (strcasecmp(key, "mpris:artUrl") == 0) {
+#ifdef HAVE_AVRCP
+			if (!parse_art_url_metadata(mp, &var))
+				return FALSE;
+#endif
 		} else
 			DBG("%s not supported, ignoring", key);
 
diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 8dcbde236..79372f23e 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -10,11 +10,14 @@ ExecStart=@PKGLIBEXECDIR@/bluetoothd
 NotifyAccess=main
 #WatchdogSec=10
 #Restart=on-failure
-CapabilityBoundingSet=CAP_NET_RAW CAP_NET_ADMIN CAP_NET_BIND_SERVICE
+CapabilityBoundingSet=CAP_NET_RAW CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_DAC_READ_SEARCH
 LimitNPROC=1
 
 # Filesystem lockdown
-ProtectHome=true
+# Cover art referenced by MediaPlayer1 metadata (mpris:artUrl) usually
+# lives in the user's home directory (e.g. ~/.cache of the player), so
+# bluetoothd needs read access to serve it via the AVRCP BIP responder.
+ProtectHome=read-only
 ProtectSystem=strict
 PrivateTmp=true
 ProtectKernelTunables=true
-- 
2.55.0

