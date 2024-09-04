Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EAF1D9D6B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458672; cv=none; b=hxGiShkK3zVE+aCEu2VzWDWYOH4DHxnJSy7ye6G7/n3BfImKkA0Atx9kbF/AFmjZPJcjUQBRkD8keWI7Ha1QVWpKQkNmJ7Xw7DiTLiyTmSDRjRNvs3rQ0Z5PPD/jpwS70n9h8mNwGuYQ00Wo2wx0a3G9uYpgQ/r/HS5/YsUfx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458672; c=relaxed/simple;
	bh=LghmL8GcuIs7GVYqo+cR1qlMP6QxCIjDqarelzmnJTQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YP0szjPiTE0Mr9QptomO4DELjzXvn6JdrvpX6AkhX6WaKjZAquqv4ryKJwTpX4EbXqyZho9sniORYEp8n2cZIrkWgO+EOAYM1PU0HJYKSx0m73ovNuDByhh6tVVq7MmFyjqSy2ex9LSnNtEixWl1w9jxClc3Ghw2uFPLJ9WhW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NXemOACA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NXemOACA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725458669;
	bh=LghmL8GcuIs7GVYqo+cR1qlMP6QxCIjDqarelzmnJTQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NXemOACA2P4KiKuRx7VoN31mAGieht2/nl0Rw9Ou+WW3MMz/y7NpYxU2yuLqvJzZA
	 PnByMNMlovyaqG3f9kD5HbBWc/y4TnVxICgyw1wWCBZ5ah9hEhsY0W8RlPrl8vtkAn
	 GFRX7gPVKfEyxhuIqWQr1eiKDyiWa4rPev0A+l4JA9MXO1gwERyU7msZP24hn/a3u6
	 bkyIlO54+PNb8Nx/4S8LL/d5V/eGNRbpBz9gVj2N55/VkiQb0B4SqyCgmHQbqCA6rZ
	 A/z6xHwYzcL9DY/8V6E/lPIMAO4krTafewsTE/b20n6hBrynC7zJweMmloBtVma690
	 F08lN0EUGbhSw==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0B10717E1131
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 16:04:29 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] obexd: Add BIP client for AVRCP cover art download.
Date: Wed,  4 Sep 2024 16:04:18 +0200
Message-Id: <20240904140421.283166-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904140421.283166-1-frederic.danis@collabora.com>
References: <20240904140421.283166-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The cover art image handle is available in the metadata of the track
when the OBEX BIP session is connected to the PSM port provided
in AVRCP SDP record and available as org.bluez.MediaPlayer property.

This service allows to get the thumbnail.
---
 Makefile.obexd           |   1 +
 obexd/client/bip-avrcp.c | 171 +++++++++++++++++++++++++++++++++++++++
 obexd/client/bip-avrcp.h |  12 +++
 obexd/client/manager.c   |   2 +
 obexd/client/transfer.c  |  16 ++++
 obexd/client/transfer.h  |   2 +
 6 files changed, 204 insertions(+)
 create mode 100644 obexd/client/bip-avrcp.c
 create mode 100644 obexd/client/bip-avrcp.h

diff --git a/Makefile.obexd b/Makefile.obexd
index b7e9f2d33..cea163ba7 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -82,6 +82,7 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
 			obexd/client/ftp.h obexd/client/ftp.c \
 			obexd/client/opp.h obexd/client/opp.c \
 			obexd/client/map.h obexd/client/map.c \
+			obexd/client/bip-avrcp.h obexd/client/bip-avrcp.c \
 			obexd/client/map-event.h obexd/client/map-event.c \
 			obexd/client/transfer.h obexd/client/transfer.c \
 			obexd/client/transport.h obexd/client/transport.c \
diff --git a/obexd/client/bip-avrcp.c b/obexd/client/bip-avrcp.c
new file mode 100644
index 000000000..ca702be5a
--- /dev/null
+++ b/obexd/client/bip-avrcp.c
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2024  Collabora Ltd.
+ *
+ *
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "gdbus/gdbus.h"
+#include "gobex/gobex.h"
+
+#include "obexd/src/log.h"
+#include "transfer.h"
+#include "session.h"
+#include "driver.h"
+#include "bip-avrcp.h"
+
+#define OBEX_BIP_AVRCP_UUID \
+	"\x71\x63\xDD\x54\x4A\x7E\x11\xE2\xB4\x7C\x00\x50\xC2\x49\x00\x48"
+#define OBEX_BIP_AVRCP_UUID_LEN 16
+
+#define BIP_AVRCP_INTERFACE "org.bluez.obex.BipAvrcp1"
+#define ERROR_INTERFACE "org.bluez.obex.Error"
+#define BIP_AVRCP_UUID "0000111A-0000-1000-8000-00805f9b34fb"
+
+#define IMG_HANDLE_TAG  0x30
+
+static DBusConnection *conn;
+
+struct bip_avrcp_data {
+	struct obc_session *session;
+};
+
+static DBusMessage *get_image_thumbnail(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct bip_avrcp_data *bip_avrcp = user_data;
+	const char *handle = NULL, *image_path = NULL;
+	struct obc_transfer *transfer;
+	GObexHeader *header;
+	DBusMessage *reply = NULL;
+	GError *err = NULL;
+
+	DBG("");
+
+	if (dbus_message_get_args(message, NULL,
+				DBUS_TYPE_STRING, &image_path,
+				DBUS_TYPE_STRING, &handle,
+				DBUS_TYPE_INVALID) == FALSE) {
+		reply = g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+		goto fail;
+	}
+
+	transfer = obc_transfer_get("x-bt/img-thm", NULL, image_path, &err);
+	if (transfer == NULL)
+		goto fail;
+
+	header = g_obex_header_new_unicode(IMG_HANDLE_TAG, handle);
+	obc_transfer_add_header(transfer, header);
+
+	if (!obc_session_queue(bip_avrcp->session, transfer, NULL, NULL, &err))
+		goto fail;
+
+	return obc_transfer_create_dbus_reply(transfer, message);
+
+fail:
+	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
+								err->message);
+	g_error_free(err);
+	return reply;
+}
+
+static const GDBusMethodTable bip_avrcp_methods[] = {
+	{ GDBUS_ASYNC_METHOD("GetImageThumbnail",
+		GDBUS_ARGS({ "file", "s" }, { "handle", "s"}),
+		GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }),
+		get_image_thumbnail) },
+	{ }
+};
+
+static void bip_avrcp_free(void *data)
+{
+	struct bip_avrcp_data *bip_avrcp = data;
+
+	obc_session_unref(bip_avrcp->session);
+	g_free(bip_avrcp);
+}
+
+static int bip_avrcp_probe(struct obc_session *session)
+{
+	struct bip_avrcp_data *bip_avrcp;
+	const char *path;
+
+	path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	bip_avrcp = g_try_new0(struct bip_avrcp_data, 1);
+	if (!bip_avrcp)
+		return -ENOMEM;
+
+	bip_avrcp->session = obc_session_ref(session);
+
+	if (!g_dbus_register_interface(conn, path, BIP_AVRCP_INTERFACE,
+					bip_avrcp_methods,
+					NULL, NULL,
+					bip_avrcp, bip_avrcp_free)) {
+		bip_avrcp_free(bip_avrcp);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void bip_avrcp_remove(struct obc_session *session)
+{
+	const char *path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	g_dbus_unregister_interface(conn, path, BIP_AVRCP_INTERFACE);
+}
+
+static struct obc_driver bip_avrcp = {
+	.service = "BIP-AVRCP",
+	.uuid = BIP_AVRCP_UUID,
+	.target = OBEX_BIP_AVRCP_UUID,
+	.target_len = OBEX_BIP_AVRCP_UUID_LEN,
+	.probe = bip_avrcp_probe,
+	.remove = bip_avrcp_remove
+};
+
+int bip_avrcp_init(void)
+{
+	int err;
+
+	DBG("");
+
+	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (!conn)
+		return -EIO;
+
+	err = obc_driver_register(&bip_avrcp);
+	if (err < 0)
+		goto failed;
+
+	return 0;
+
+failed:
+	dbus_connection_unref(conn);
+	conn = NULL;
+	return err;
+}
+
+void bip_avrcp_exit(void)
+{
+	DBG("");
+
+	dbus_connection_unref(conn);
+	conn = NULL;
+
+	obc_driver_unregister(&bip_avrcp);
+}
diff --git a/obexd/client/bip-avrcp.h b/obexd/client/bip-avrcp.h
new file mode 100644
index 000000000..acd8068f2
--- /dev/null
+++ b/obexd/client/bip-avrcp.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2024  Collabora Ltd.
+ *
+ *
+ */
+
+int bip_avrcp_init(void);
+void bip_avrcp_exit(void);
diff --git a/obexd/client/manager.c b/obexd/client/manager.c
index 52c00fb0c..5078f56da 100644
--- a/obexd/client/manager.c
+++ b/obexd/client/manager.c
@@ -32,6 +32,7 @@
 #include "pbap.h"
 #include "sync.h"
 #include "map.h"
+#include "bip-avrcp.h"
 #include "manager.h"
 
 #define CLIENT_INTERFACE	"org.bluez.obex.Client1"
@@ -258,6 +259,7 @@ static const struct obc_module {
 	{ "pbap", pbap_init, pbap_exit },
 	{ "sync", sync_init, sync_exit },
 	{ "map", map_init, map_exit },
+	{ "bip-avrcp", bip_avrcp_init, bip_avrcp_exit },
 	{ }
 };
 
diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index a7a85a0c0..fdf32a985 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -57,6 +57,7 @@ struct obc_transfer {
 	GObex *obex;
 	uint8_t status;
 	GObexApparam *apparam;
+	GSList *headers;
 	guint8 op;
 	struct transfer_callback *callback;
 	DBusConnection *conn;
@@ -820,6 +821,16 @@ static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 		g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, transfer->type,
 						strlen(transfer->type) + 1);
 
+	if (transfer->headers != NULL) {
+		GSList *l;
+
+		for (l = transfer->headers; l != NULL; l = g_slist_next(l)) {
+			GObexHeader *hdr = l->data;
+
+			g_obex_packet_add_header(req, hdr);
+		}
+	}
+
 	if (transfer->apparam != NULL) {
 		hdr = g_obex_header_new_apparam(transfer->apparam);
 		g_obex_packet_add_header(req, hdr);
@@ -974,3 +985,8 @@ gint64 obc_transfer_get_size(struct obc_transfer *transfer)
 {
 	return transfer->size;
 }
+
+void obc_transfer_add_header(struct obc_transfer *transfer, void *data)
+{
+	transfer->headers = g_slist_append(transfer->headers, data);
+}
diff --git a/obexd/client/transfer.h b/obexd/client/transfer.h
index 323332a62..1ed195984 100644
--- a/obexd/client/transfer.h
+++ b/obexd/client/transfer.h
@@ -47,3 +47,5 @@ gint64 obc_transfer_get_size(struct obc_transfer *transfer);
 
 DBusMessage *obc_transfer_create_dbus_reply(struct obc_transfer *transfer,
 							DBusMessage *message);
+
+void obc_transfer_add_header(struct obc_transfer *transfer, void *data);
-- 
2.34.1

