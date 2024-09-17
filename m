Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D97BB15
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558949; cv=none; b=lKagBb4mYfQDRv3f6yUCEls5aR8+VnjOPVox335ZegXQ+iiTjoliMJqtflTUC3W71YRRkCNa6ZTF2BhGDU8LFwKG+TIMVHo8/mesy7Jnq4Z1dYJ7npqUBvyZoujzZAE7YdX3BblthFBRiV3sHjrcHXVUxn80Cg4ic4P5Rguwtxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558949; c=relaxed/simple;
	bh=p7qzDefy4KmvnMHlngGPsS8f648+E4Q2NNUAQa67wWo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkqyN8E4S1J6zGg2eQ666YYJiAFP/Vf+DpBnUxRcqa0h6QF2VnwYc37doWY8YBbCiYJcPej9luDqVBdXjR+Oc0Md8bALe8fq3tiheyKDj/Lsdl9qLfjYczWjywpBsbNHEpDeBT4ca2ksS++hlhvbfj410pB0QOAJGQ7FieLBGIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PAIKT9At; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PAIKT9At"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726558944;
	bh=p7qzDefy4KmvnMHlngGPsS8f648+E4Q2NNUAQa67wWo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PAIKT9At7183ZvbmnuK1xFEb0Pr6neATEVJGjbQt0D7EvhAErcdAOHuM2hkrpWtso
	 6hwV+r03uSspT2lcDjlGR0EbcQB9lG8euHefdKcLh0s+lh4aUoKkCEkwLoSnbTpe9m
	 Uq7fAoL4dVIw3gUgksRc+HuWnqr8rghjxZA7WKLj/tC3pCD7Rfhb3rBUovgYmG8CHj
	 ovuLq7qCdCz/ohrXgFq3A6QgSegwi61eD0TLUhq0BnZMthkuhBo6ZKwb703/lU50se
	 S91K+VjA+gUm6EKsvMziMSvb9xVc+ShHzhVkMVBIvCsGhv0qCD4mKRcJeGoXsJx9b5
	 oqK2t83H1bz0w==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CEA6D17E0FD6
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 09:42:24 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/5] obexd: Add BIP client for AVRCP cover art download
Date: Tue, 17 Sep 2024 09:42:13 +0200
Message-Id: <20240917074217.231677-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240917074217.231677-1-frederic.danis@collabora.com>
References: <20240917074217.231677-1-frederic.danis@collabora.com>
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
 Makefile.obexd                |   1 +
 doc/org.bluez.obex.Client.rst |   1 +
 obexd/client/bip.c            | 171 ++++++++++++++++++++++++++++++++++
 obexd/client/bip.h            |  12 +++
 obexd/client/manager.c        |   2 +
 5 files changed, 187 insertions(+)
 create mode 100644 obexd/client/bip.c
 create mode 100644 obexd/client/bip.h

diff --git a/Makefile.obexd b/Makefile.obexd
index 4cdce73af..866147dd1 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -81,6 +81,7 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
 			obexd/client/ftp.h obexd/client/ftp.c \
 			obexd/client/opp.h obexd/client/opp.c \
 			obexd/client/map.h obexd/client/map.c \
+			obexd/client/bip.h obexd/client/bip.c \
 			obexd/client/map-event.h obexd/client/map-event.c \
 			obexd/client/transfer.h obexd/client/transfer.c \
 			obexd/client/transport.h obexd/client/transport.c \
diff --git a/doc/org.bluez.obex.Client.rst b/doc/org.bluez.obex.Client.rst
index 5ae7cc5e8..f20dd5baa 100644
--- a/doc/org.bluez.obex.Client.rst
+++ b/doc/org.bluez.obex.Client.rst
@@ -43,6 +43,7 @@ object CreateSession(string destination, dict args)
 		:"opp":
 		:"pbap":
 		:"sync":
+		:"bip-avrcp":
 
 	:string Source:
 
diff --git a/obexd/client/bip.c b/obexd/client/bip.c
new file mode 100644
index 000000000..252bc4cec
--- /dev/null
+++ b/obexd/client/bip.c
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
+#include "bip.h"
+
+#define OBEX_BIP_AVRCP_UUID \
+	"\x71\x63\xDD\x54\x4A\x7E\x11\xE2\xB4\x7C\x00\x50\xC2\x49\x00\x48"
+#define OBEX_BIP_AVRCP_UUID_LEN 16
+
+#define IMAGE_INTERFACE "org.bluez.obex.Image1"
+#define ERROR_INTERFACE "org.bluez.obex.Error"
+#define IMAGE_UUID "0000111A-0000-1000-8000-00805f9b34fb"
+
+#define IMG_HANDLE_TAG  0x30
+
+static DBusConnection *conn;
+
+struct bip_avrcp_data {
+	struct obc_session *session;
+};
+
+static DBusMessage *get_thumbnail(DBusConnection *connection,
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
+		return reply;
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
+	{ GDBUS_ASYNC_METHOD("GetThumbnail",
+		GDBUS_ARGS({ "file", "s" }, { "handle", "s"}),
+		GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }),
+		get_thumbnail) },
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
+	if (!g_dbus_register_interface(conn, path, IMAGE_INTERFACE,
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
+	g_dbus_unregister_interface(conn, path, IMAGE_INTERFACE);
+}
+
+static struct obc_driver bip_avrcp = {
+	.service = "BIP-AVRCP",
+	.uuid = IMAGE_UUID,
+	.target = OBEX_BIP_AVRCP_UUID,
+	.target_len = OBEX_BIP_AVRCP_UUID_LEN,
+	.probe = bip_avrcp_probe,
+	.remove = bip_avrcp_remove
+};
+
+int bip_init(void)
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
+void bip_exit(void)
+{
+	DBG("");
+
+	dbus_connection_unref(conn);
+	conn = NULL;
+
+	obc_driver_unregister(&bip_avrcp);
+}
diff --git a/obexd/client/bip.h b/obexd/client/bip.h
new file mode 100644
index 000000000..18e3360f3
--- /dev/null
+++ b/obexd/client/bip.h
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
+int bip_init(void);
+void bip_exit(void);
diff --git a/obexd/client/manager.c b/obexd/client/manager.c
index 52c00fb0c..52f4d0179 100644
--- a/obexd/client/manager.c
+++ b/obexd/client/manager.c
@@ -32,6 +32,7 @@
 #include "pbap.h"
 #include "sync.h"
 #include "map.h"
+#include "bip.h"
 #include "manager.h"
 
 #define CLIENT_INTERFACE	"org.bluez.obex.Client1"
@@ -258,6 +259,7 @@ static const struct obc_module {
 	{ "pbap", pbap_init, pbap_exit },
 	{ "sync", sync_init, sync_exit },
 	{ "map", map_init, map_exit },
+	{ "bip", bip_init, bip_exit },
 	{ }
 };
 
-- 
2.34.1

