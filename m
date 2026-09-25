Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9103CC9F6
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342749; cv=none; b=CFrUnM1TuHn+caAbRLfTdjGYXkm2tu4HGMjgjRlsfpoLeLDgWn8oc1135Dd+mSzuc0tNKXxtGKrIczxMR6vHMjGszHcI3fLxwA8POaM2y+kGqWn5+9NRpmMKBAOnA1eBYPjd1vjPpz9mhnZrDWNyy4j4CExcVucM/GkLvLPv+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342749; c=relaxed/simple;
	bh=cxc/cp073+ey5XgGFKkXu0IVdNVZIJ6zROdG03g2J8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7FATQ+kx8L3w4ozhdzGw/vUyblZMf3tubldLWdIXH2k/GaLtjZYXGZyIsHOUzKDUcCOR9C7b+JtVz6tu533Of4reIMIkabAsJiXaLP0lQgXeMACXPev1ktvUE+YWo8DDMBKr/9HUz/B3zSxYB+j0muPC7equmzWTRmVBC7No3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l4lWU3MP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l4lWU3MP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790342736;
	bh=cxc/cp073+ey5XgGFKkXu0IVdNVZIJ6zROdG03g2J8U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l4lWU3MPSM/qNUTd2db+bJe0UEM26IOTWcHDMfUR+p04hgn0LVw4btb2JaaNshGTI
	 6Jo/uPIVbZMIXlY+h7y2loLn0V22QerXLNgpRvM97V87pmam6JhBis0W6dVac2mpwe
	 aFqNDchpG5pmUaI5S3U5p+RkIKu1ZL+rCeh+AgRhAn72J53DsOHmUWU+8tFyHgIS0+
	 lV4m+5Qj3oD5PkUdI/AadKQ/Tocd19gzjTYbg4BUHSvRCa67hbdijib2y0RR4tH2fI
	 sOGAbHbCD33zcx6c1bBjKTHe5Gzj8KAPMxlXmNc1X2UXl+2j/1vRw5fAzQrHgUd7NA
	 HHlFD/uQI0lJA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1E46517E0B0F
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:25:36 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/12] audio/hfp-hf: Add MediaEndpoint for HFP codecs
Date: Fri, 25 Sep 2026 15:25:18 +0200
Message-ID: <20260925132528.3361517-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925132528.3361517-1-frederic.danis@collabora.com>
References: <20260925132528.3361517-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Register a MediaEndpoint1 (org.bluez.MediaEndpoint1) for each HFP
codec supported by the remote AG, exposing SCO audio through the
standard media transport API.

Adds a SCO listening/connecting socket in hfp-hf, endpoint
registration/unregistration tied to the HFP connection lifecycle,
and wires MediaTransport creation/configuration for the HFP_AG_UUID
endpoint in media.c.

Assisted-by: Claude:claude-sonnet-5
---
 profiles/audio/hfp-hf.c    | 415 +++++++++++++++++++++++++++++++++++++
 profiles/audio/hfp-hf.h    |  26 +++
 profiles/audio/media.c     |  76 +++++++
 profiles/audio/media.h     |   6 +
 profiles/audio/transport.c | 158 ++++++++++++++
 5 files changed, 681 insertions(+)
 create mode 100644 profiles/audio/hfp-hf.h

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 102a8006f..dddd56261 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -44,8 +44,12 @@
 #include "src/shared/hfp.h"
 #include "src/shared/queue.h"
 
+#include "hfp-hf.h"
+#include "media.h"
 #include "telephony.h"
 
+#define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
+
 #define HFP_HF_VERSION		0x0109
 #define HFP_HF_DEFAULT_CHANNEL	7
 
@@ -70,14 +74,23 @@ struct hfp_device {
 	struct telephony	*telephony;
 	uint16_t		version;
 	GIOChannel		*io;
+	GIOChannel		*sco_io;
+	uint16_t		imtu;
+	uint16_t		omtu;
 	struct hfp_hf		*hf;
 	struct queue		*calls;
+	uint8_t			codec;
+	unsigned int		resume_id;
+	hfp_hf_sco_closed_cb	sco_closed_cb;
+	void			*sco_closed_data;
 };
 
 struct hfp_server {
 	struct btd_adapter	*adapter;
 	GIOChannel		*io;
+	GIOChannel		*sco_io;
 	uint32_t		record_id;
+	GSList			*endpoints;
 };
 
 static GSList *servers;
@@ -87,6 +100,22 @@ static void hfp_hf_debug(const char *str, void *user_data)
 	DBG_IDX(0xffff, "%s", str);
 }
 
+static char *make_endpoint_path(struct telephony *telephony, uint8_t codec)
+{
+	char *path;
+	int err;
+
+	err = asprintf(&path, "%s/sep%u", telephony_get_path(telephony),
+								codec);
+	if (err < 0) {
+		error("Could not allocate path for remote %s",
+			device_get_path(telephony_get_device(telephony)));
+		return NULL;
+	}
+
+	return path;
+}
+
 static struct hfp_server *find_server(GSList *list, struct btd_adapter *a)
 {
 	for (; list; list = list->next) {
@@ -99,6 +128,20 @@ static struct hfp_server *find_server(GSList *list, struct btd_adapter *a)
 	return NULL;
 }
 
+static void unregister_endpoint(gpointer data, gpointer user_data)
+{
+	struct media_endpoint *ep = data;
+	struct telephony *telephony = user_data;
+	char *path;
+
+	path = make_endpoint_path(telephony, media_endpoint_get_codec(ep));
+	if (path) {
+		g_dbus_unregister_interface(btd_get_dbus_connection(),
+				path, MEDIA_ENDPOINT_INTERFACE);
+		free(path);
+	}
+}
+
 static enum call_state hfp_call_status_to_call_state(
 						enum hfp_call_status status)
 {
@@ -128,6 +171,8 @@ static bool call_id_cmp(const void *data, const void *match_data)
 
 static void device_destroy(struct hfp_device *dev)
 {
+	struct hfp_server *server;
+
 	DBG("%s", telephony_get_path(dev->telephony));
 
 	telephony_set_state(dev->telephony, DISCONNECTING);
@@ -137,11 +182,22 @@ static void device_destroy(struct hfp_device *dev)
 		dev->hf = NULL;
 	}
 
+	if (dev->sco_io) {
+		g_io_channel_unref(dev->sco_io);
+		dev->sco_io = NULL;
+	}
+
 	if (dev->io) {
 		g_io_channel_unref(dev->io);
 		dev->io = NULL;
 	}
 
+	server = find_server(servers,
+		device_get_adapter(telephony_get_device(dev->telephony)));
+	if (server)
+		g_slist_foreach(server->endpoints, unregister_endpoint,
+					dev->telephony);
+
 	telephony_unregister_interface(dev->telephony);
 }
 
@@ -296,10 +352,68 @@ static void hfp_disconnect_watch(void *user_data)
 	device_destroy(user_data);
 }
 
+static gboolean get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	const char *uuid;
+
+	uuid = HFP_HS_UUID;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+
+	return TRUE;
+}
+
+static gboolean get_device(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct hfp_device *dev = data;
+	const char *path;
+
+	path = device_get_path(telephony_get_device(dev->telephony));
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
+
+static const GDBusMethodTable hfp_hf_ep_methods[] = {
+	{ },
+};
+
+static const GDBusPropertyTable hfp_hf_ep_properties[] = {
+	{ "UUID", "s", get_uuid, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Device", "o", get_device, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ }
+};
+
+static void register_endpoint(gpointer data, gpointer user_data)
+{
+	struct media_endpoint *ep = data;
+	struct hfp_device *dev = user_data;
+	char *path = NULL;
+
+	path = make_endpoint_path(dev->telephony,
+					media_endpoint_get_codec(ep));
+	if (path) {
+		if (g_dbus_register_interface(btd_get_dbus_connection(),
+					path, MEDIA_ENDPOINT_INTERFACE,
+					hfp_hf_ep_methods, NULL,
+					hfp_hf_ep_properties,
+					dev, NULL) == FALSE) {
+			error("Could not register remote ep %s", path);
+		}
+		free(path);
+	}
+}
+
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct hfp_device *dev = user_data;
 	struct btd_service *service = telephony_get_service(dev->telephony);
+	struct hfp_server *server;
 
 	DBG("");
 
@@ -333,6 +447,10 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	telephony_set_state(dev->telephony, SESSION_CONNECTING);
 	btd_service_connecting_complete(service, 0);
 
+	server = find_server(servers,
+		device_get_adapter(telephony_get_device(dev->telephony)));
+	g_slist_foreach(server->endpoints, register_endpoint, dev);
+
 	return;
 
 failed:
@@ -507,6 +625,8 @@ static int hfp_probe(struct btd_service *service)
 		return -EINVAL;
 
 	dev->telephony = telephony_new(service, dev, &hfp_callbacks);
+	/* Use CVSD codec by default */
+	dev->codec = 1;
 	btd_service_set_user_data(service, dev);
 	telephony_add_uri_scheme(dev->telephony, URI);
 
@@ -670,6 +790,296 @@ static GIOChannel *server_socket(struct btd_adapter *adapter)
 	return io;
 }
 
+static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond, void *data)
+{
+	struct hfp_device *dev = data;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	DBG("sco connection released");
+	g_io_channel_shutdown(dev->sco_io, TRUE, NULL);
+	g_io_channel_unref(dev->sco_io);
+	dev->sco_io = NULL;
+
+	/* The remote end hung up the SCO connection instead of us
+	 * releasing it locally, e.g. via Suspend/Release on the media
+	 * transport. Notify the transport so it can update its state
+	 * and release/suspend accordingly.
+	 */
+	if (dev->sco_closed_cb)
+		dev->sco_closed_cb(dev, dev->sco_closed_data);
+
+	return FALSE;
+}
+
+struct connect_data {
+	struct hfp_device *dev;
+	void (*cb)(int status, void *data);
+	void *cb_user_data;
+};
+
+static void sco_connect_complete(struct connect_data *connect_data, int status)
+{
+	if (!connect_data || !connect_data->cb)
+		goto done;
+
+	connect_data->cb(status, connect_data->cb_user_data);
+
+done:
+	g_free(connect_data);
+}
+
+static void sco_connect_cb(GIOChannel *io, GError *err, gpointer user_data)
+{
+	struct connect_data *connect_data = user_data;
+	bdaddr_t src, dst;
+	char addr[18];
+	uint16_t handle;
+	struct btd_adapter *adapter;
+	struct btd_device *device;
+	struct btd_service *service;
+	struct hfp_device *dev;
+	struct hfp_server *server;
+	struct media_endpoint *endpoint = NULL;
+	GSList *l;
+	char *path = NULL;
+	uint16_t imtu, omtu;
+
+	if (err) {
+		error("Connecting failed: %s\n", err->message);
+		sco_connect_complete(connect_data, -EIO);
+		return;
+	}
+
+	if (!bt_io_get(io, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_DEST, addr,
+			BT_IO_OPT_HANDLE, &handle,
+			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_OMTU, &omtu,
+			BT_IO_OPT_INVALID)) {
+		error("Unable to get destination address: %s\n", err->message);
+		g_clear_error(&err);
+		sco_connect_complete(connect_data, -EIO);
+		return;
+	}
+
+	DBG("Successfully connected to %s. handle=%u imtu=%u omtu=%u",
+						addr, handle, imtu, omtu);
+
+	adapter = adapter_find(&src);
+	if (!adapter) {
+		sco_connect_complete(connect_data, -EIO);
+		return;
+	}
+
+	device = btd_adapter_find_device(adapter, &dst, BDADDR_BREDR);
+	if (!device) {
+		sco_connect_complete(connect_data, -EIO);
+		return;
+	}
+
+	service = btd_device_get_service(device, HFP_AG_UUID);
+	if (!service) {
+		sco_connect_complete(connect_data, -EIO);
+		return;
+	}
+
+	dev = btd_service_get_user_data(service);
+
+	server = find_server(servers, adapter);
+	if (server == NULL) {
+		sco_connect_complete(connect_data, -EIO);
+		return;
+	}
+
+	for (l = server->endpoints; l; l = l->next) {
+		if (media_endpoint_get_codec(l->data) == dev->codec) {
+			endpoint = l->data;
+			break;
+		}
+	}
+	if (endpoint == NULL) {
+		sco_connect_complete(connect_data, -EIO);
+		return;
+	}
+
+	path = make_endpoint_path(dev->telephony, dev->codec);
+	if (path == NULL) {
+		error("Could not allocate path for remote %s",
+			device_get_path(telephony_get_device(dev->telephony)));
+		sco_connect_complete(connect_data, -ENOMEM);
+		return;
+	}
+
+	if (!hfp_hf_set_configuration(endpoint, path, NULL, dev, NULL)) {
+		free(path);
+		sco_connect_complete(connect_data, -EIO);
+		return;
+	}
+	free(path);
+
+	dev->imtu = imtu;
+	dev->omtu = omtu;
+	dev->sco_io = g_io_channel_ref(io);
+
+	g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) sco_io_cb, dev);
+
+	sco_connect_complete(connect_data, 0);
+}
+
+bool hfp_hf_sco_listen(struct btd_adapter *adapter, void *endpoint)
+{
+	struct hfp_server *server;
+	GError *err = NULL;
+
+	DBG("path %s, codec %u", adapter_get_path(adapter),
+					media_endpoint_get_codec(endpoint));
+
+	server = find_server(servers, adapter);
+	if (server == NULL)
+		return false;
+
+	server->endpoints = g_slist_append(server->endpoints, endpoint);
+
+	if (server->sco_io)
+		return true;
+
+	server->sco_io = bt_io_listen(sco_connect_cb, NULL, NULL, NULL,
+				&err,
+				BT_IO_OPT_SOURCE_BDADDR,
+				btd_adapter_get_address(server->adapter),
+				BT_IO_OPT_INVALID);
+	if (server->sco_io) {
+		DBG("SCO server started");
+		return true;
+	}
+
+	server->endpoints = g_slist_remove(server->endpoints, endpoint);
+	error("%s", err->message);
+	g_error_free(err);
+
+	return false;
+}
+
+void hfp_hf_sco_remove(struct btd_adapter *adapter, void *endpoint)
+{
+	struct hfp_server *server;
+
+	DBG("path %s, codec %u", adapter_get_path(adapter),
+					media_endpoint_get_codec(endpoint));
+
+	server = find_server(servers, adapter);
+	if (server == NULL) {
+		error("No server for %s codec %u", adapter_get_path(adapter),
+					media_endpoint_get_codec(endpoint));
+		return;
+	}
+
+	server->endpoints = g_slist_remove(server->endpoints, endpoint);
+
+	if (server->sco_io && g_slist_length(server->endpoints) == 0) {
+		g_io_channel_shutdown(server->sco_io, TRUE, NULL);
+		g_io_channel_unref(server->sco_io);
+		server->sco_io = NULL;
+		DBG("SCO server stopped");
+	}
+}
+
+struct btd_device *hfp_hf_get_device(struct hfp_device *dev)
+{
+	return telephony_get_device(dev->telephony);
+}
+
+int hfp_hf_device_get_fd(struct hfp_device *dev)
+{
+	if (!dev->sco_io)
+		return -1;
+
+	return g_io_channel_unix_get_fd(dev->sco_io);
+}
+
+uint16_t hfp_hf_device_get_imtu(struct hfp_device *dev)
+{
+	return dev->imtu;
+}
+
+uint16_t hfp_hf_device_get_omtu(struct hfp_device *dev)
+{
+	return dev->omtu;
+}
+
+static gboolean sco_start_cb(gpointer data)
+{
+	struct connect_data *connect_data = data;
+
+	if (connect_data && connect_data->cb) {
+		connect_data->cb(0, connect_data->cb_user_data);
+		g_free(connect_data);
+	}
+
+	return FALSE;
+}
+
+unsigned int hfp_hf_sco_start(struct hfp_device *dev, void *cb, void *user_data)
+{
+	bdaddr_t src, dst;
+	struct connect_data *connect_data;
+	GError *err = NULL;
+	GIOChannel *io;
+
+	DBG("codec %u", dev->codec);
+
+	connect_data = g_new0(struct connect_data, 1);
+	connect_data->dev = dev;
+	connect_data->cb = cb;
+	connect_data->cb_user_data = user_data;
+
+	src = telephony_get_src(dev->telephony);
+	dst = telephony_get_dst(dev->telephony);
+	if (!dev->sco_io) {
+		io = bt_io_connect(sco_connect_cb, connect_data, NULL, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+			BT_IO_OPT_INVALID);
+		if (!io) {
+			error("%s", err->message);
+			g_error_free(err);
+			g_free(connect_data);
+			return 0;
+		}
+	} else {
+		g_idle_add(sco_start_cb, connect_data);
+	}
+
+	return (++dev->resume_id);
+}
+
+unsigned int hfp_hf_sco_stop(struct hfp_device *dev)
+{
+	if (!dev->sco_io)
+		return 0;
+
+	DBG("codec %u", dev->codec);
+
+	g_io_channel_shutdown(dev->sco_io, TRUE, NULL);
+	g_io_channel_unref(dev->sco_io);
+	dev->sco_io = NULL;
+
+	return dev->resume_id;
+}
+
+void hfp_hf_set_sco_closed_cb(struct hfp_device *dev,
+				hfp_hf_sco_closed_cb cb, void *user_data)
+{
+	dev->sco_closed_cb = cb;
+	dev->sco_closed_data = user_data;
+}
+
 static int hfp_adapter_probe(struct btd_profile *p,
 				struct btd_adapter *adapter)
 {
@@ -724,6 +1134,11 @@ static void hfp_adapter_remove(struct btd_profile *p,
 	if (!server)
 		return;
 
+	if (server->sco_io) {
+		g_io_channel_shutdown(server->sco_io, TRUE, NULL);
+		g_io_channel_unref(server->sco_io);
+	}
+
 	if (server->io) {
 		g_io_channel_shutdown(server->io, TRUE, NULL);
 		g_io_channel_unref(server->io);
diff --git a/profiles/audio/hfp-hf.h b/profiles/audio/hfp-hf.h
new file mode 100644
index 000000000..6dfa3b12f
--- /dev/null
+++ b/profiles/audio/hfp-hf.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright © 2025 Collabora Ltd.
+ *
+ *
+ */
+
+struct hfp_device;
+
+typedef void (*hfp_hf_sco_closed_cb) (struct hfp_device *dev, void *user_data);
+
+bool hfp_hf_sco_listen(struct btd_adapter *adapter, void *endpoint);
+void hfp_hf_sco_remove(struct btd_adapter *adapter, void *endpoint);
+unsigned int hfp_hf_sco_start(struct hfp_device *dev, void *cb,
+							void *user_data);
+unsigned int hfp_hf_sco_stop(struct hfp_device *dev);
+void hfp_hf_set_sco_closed_cb(struct hfp_device *dev,
+				hfp_hf_sco_closed_cb cb, void *user_data);
+
+struct btd_device *hfp_hf_get_device(struct hfp_device *dev);
+int hfp_hf_device_get_fd(struct hfp_device *dev);
+uint16_t hfp_hf_device_get_imtu(struct hfp_device *dev);
+uint16_t hfp_hf_device_get_omtu(struct hfp_device *dev);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index dd1d4e571..e8418280e 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -66,6 +66,9 @@
 #ifdef HAVE_A2DP
 #include "a2dp.h"
 #endif
+#ifdef HAVE_HFP
+#include "hfp-hf.h"
+#endif
 
 #define MEDIA_INTERFACE "org.bluez.Media1"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
@@ -119,6 +122,7 @@ struct media_endpoint {
 #endif
 	struct bt_bap_pac	*pac;
 	struct bt_asha_device	*asha;
+	bool			sco;
 	char			*sender;	/* Endpoint DBus bus id */
 	char			*path;		/* Endpoint object path */
 	char			*uuid;		/* Endpoint property UUID */
@@ -234,6 +238,11 @@ static void media_endpoint_destroy(struct media_endpoint *endpoint)
 		endpoint->pac = NULL;
 	}
 
+	if (endpoint->sco) {
+		hfp_hf_sco_remove(endpoint->adapter->btd_adapter, endpoint);
+		endpoint->sco = false;
+	}
+
 	g_dbus_remove_watch(btd_get_dbus_connection(), endpoint->watch);
 	g_free(endpoint->capabilities);
 	g_free(endpoint->metadata);
@@ -1430,6 +1439,64 @@ static bool endpoint_init_asha(struct media_endpoint *endpoint,
 	return true;
 }
 
+gboolean hfp_hf_set_configuration(struct media_endpoint *endpoint,
+					const char *ep_path,
+					media_endpoint_cb_t cb,
+					void *user_data,
+					GDestroyNotify destroy)
+{
+	struct hfp_device *hfp_dev = user_data;
+	struct btd_device *device = hfp_hf_get_device(hfp_dev);
+	DBusConnection *conn = btd_get_dbus_connection();
+	DBusMessage *msg;
+	DBusMessageIter iter;
+	struct media_transport *transport;
+	const char *path;
+
+	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
+						MEDIA_ENDPOINT_INTERFACE,
+						"SetConfiguration");
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return FALSE;
+	}
+
+	transport = find_device_transport(endpoint, device);
+	if (transport == NULL) {
+		transport = media_transport_create(device, ep_path, NULL, 0,
+							endpoint, hfp_dev);
+		if (transport == NULL)
+			return FALSE;
+
+		endpoint->transports = g_slist_append(endpoint->transports,
+								transport);
+	}
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	path = media_transport_get_path(transport);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	g_dbus_get_properties(conn, path, "org.bluez.MediaTransport1", &iter);
+
+	return media_endpoint_async_call(msg, endpoint, transport,
+						cb, user_data, destroy, -1);
+}
+
+static bool endpoint_init_sco(struct media_endpoint *endpoint,
+						int *err)
+{
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		DBG("D-Bus experimental not enabled");
+		*err = -ENOTSUP;
+		return false;
+	}
+
+	endpoint->sco = true;
+
+	return hfp_hf_sco_listen(endpoint->adapter->btd_adapter, endpoint);
+}
+
 static bool endpoint_properties_exists(const char *uuid,
 						struct btd_device *dev,
 						void *user_data)
@@ -1559,6 +1626,11 @@ static bool experimental_asha_supported(struct btd_adapter *adapter)
 	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 }
 
+static bool experimental_sco_supported(struct btd_adapter *adapter)
+{
+	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
+}
+
 static const struct media_endpoint_init {
 	const char *uuid;
 	bool (*func)(struct media_endpoint *endpoint, int *err);
@@ -1580,6 +1652,10 @@ static const struct media_endpoint_init {
 			experimental_bcast_sink_ep_supported },
 	{ ASHA_PROFILE_UUID, endpoint_init_asha,
 			experimental_asha_supported },
+#ifdef HAVE_HFP
+	{ HFP_AG_UUID, endpoint_init_sco,
+			experimental_sco_supported },
+#endif
 };
 
 static struct media_endpoint *
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 43a85b1d6..a84634fff 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -82,3 +82,9 @@ typedef void (*local_player_added_t)(struct local_player *lp, void *user_data);
 unsigned int local_player_register_watch(local_player_added_t cb,
 							void *user_data);
 void local_player_unregister_watch(unsigned int id);
+
+gboolean hfp_hf_set_configuration(struct media_endpoint *endpoint,
+					const char *ep_path,
+					media_endpoint_cb_t cb,
+					void *user_data,
+					GDestroyNotify destroy);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index e3f3df50e..8cfc98a52 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -53,6 +53,10 @@
 #include "asha.h"
 #endif
 
+#ifdef HAVE_HFP
+#include "hfp-hf.h"
+#endif
+
 #include "media.h"
 #include "transport.h"
 #include "vcp.h"
@@ -1748,6 +1752,15 @@ static const GDBusPropertyTable transport_asha_properties[] = {
 };
 #endif /* HAVE_ASHA */
 
+static const GDBusPropertyTable transport_hfp_properties[] = {
+	{ "Device", "o", get_device },
+	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
+	{ "UUID", "s", get_uuid },
+	{ "Codec", "y", get_codec },
+	{ "State", "s", get_state },
+	{ }
+};
+
 #ifdef HAVE_A2DP
 static void transport_a2dp_destroy(void *data)
 {
@@ -2644,6 +2657,140 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 }
 #endif /* HAVE_ASHA */
 
+#ifdef HAVE_HFP
+static void hfp_transport_sco_closed(struct hfp_device *hfp_dev,
+							void *user_data)
+{
+	struct media_transport *transport = user_data;
+
+	DBG("%s", transport->path);
+
+	/* The remote hung up the SCO connection on its own, without us
+	 * requesting a Release/Suspend. Bring the transport back down so
+	 * its state reflects reality.
+	 */
+	if (transport->owner)
+		media_transport_remove_owner(transport);
+	else if (transport->state != TRANSPORT_STATE_IDLE)
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+}
+
+static void *transport_hfp_init(struct media_transport *transport, void *data)
+{
+	/* We just store the struct hfp_device on the transport */
+	hfp_hf_set_sco_closed_cb(data, hfp_transport_sco_closed, transport);
+
+	return data;
+}
+
+static void transport_hfp_destroy(void *data)
+{
+	hfp_hf_set_sco_closed_cb(data, NULL, NULL);
+}
+
+static void hfp_transport_resume_cb(int status, void *user_data)
+{
+	struct media_owner *owner = user_data;
+	struct media_transport *transport = owner->transport;
+	struct hfp_device *hfp_dev = transport->data;
+	int fd;
+	uint16_t imtu, omtu;
+	gboolean ret;
+
+	DBG("");
+
+	if (!transport) {
+		DBG("Lost owner while connecting, bailing");
+		return;
+	}
+
+	fd = hfp_hf_device_get_fd(hfp_dev);
+	imtu = hfp_hf_device_get_imtu(hfp_dev);
+	omtu = hfp_hf_device_get_omtu(hfp_dev);
+
+	media_transport_set_fd(transport, fd, imtu, omtu);
+
+	owner->pending->id = 0;
+	ret = g_dbus_send_reply(btd_get_dbus_connection(),
+			owner->pending->msg,
+			DBUS_TYPE_UNIX_FD, &fd,
+			DBUS_TYPE_UINT16, &imtu,
+			DBUS_TYPE_UINT16, &omtu,
+			DBUS_TYPE_INVALID);
+	if (!ret) {
+		media_transport_remove_owner(transport);
+		return;
+	}
+
+	media_owner_remove(owner);
+
+	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
+}
+
+static guint transport_hfp_resume(struct media_transport *transport,
+						struct media_owner *owner)
+{
+	struct hfp_device *hfp_dev = transport->data;
+
+	return hfp_hf_sco_start(hfp_dev, hfp_transport_resume_cb, owner);
+}
+
+static gboolean hfp_transport_suspend_cb(void *user_data)
+{
+	struct media_owner *owner = user_data;
+	struct media_transport *transport = owner->transport;
+
+	/* Release always succeeds */
+	if (owner->pending) {
+		owner->pending->id = 0;
+		media_request_reply(owner->pending, 0);
+		media_owner_remove(owner);
+	}
+
+	media_transport_remove_owner(transport);
+	return FALSE;
+}
+
+static guint transport_hfp_suspend(struct media_transport *transport,
+						struct media_owner *owner)
+{
+	struct hfp_device *hfp_dev = transport->data;
+	guint ret = 0;
+
+	hfp_hf_sco_stop(hfp_dev);
+
+	if (owner) {
+		/* Return the g_idle_add() source id here, not
+		 * hfp_hf_sco_stop()'s return value (dev->resume_id). The
+		 * latter is unrelated and is 0 whenever dev->sco_io is
+		 * already NULL, e.g. right after the peer has hung up SCO.
+		 * release() below treats a 0 id as "no pending async
+		 * operation" and immediately, synchronously frees owner via
+		 * media_transport_remove_owner() -- while the idle callback
+		 * queued here still holds a pointer to it, causing a
+		 * use-after-free crash in hfp_transport_suspend_cb() on the
+		 * next mainloop iteration.
+		 */
+		ret = g_idle_add(hfp_transport_suspend_cb, owner);
+	} else {
+		/* We won't have a callback to set the final state */
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	}
+
+	return ret;
+}
+
+static void transport_hfp_cancel(struct media_transport *transport, guint id)
+{
+	/* id is the g_idle_add() source id returned by transport_hfp_suspend()
+	 * for its still-pending hfp_transport_suspend_cb() callback. Cancel it
+	 * so it can never fire with a dangling owner pointer if owner is torn
+	 * down through another path first.
+	 */
+	g_source_remove(id);
+}
+#endif /* HAVE_HFP */
+
 #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
 		      _resume, _suspend, _cancel, _set_state, _get_stream, \
 		      _get_volume, _set_volume, _set_delay, _update_links, \
@@ -2704,6 +2851,14 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_asha_get_volume, transport_asha_set_volume, \
 			NULL, NULL, NULL, NULL)
 
+#define HFP_OPS(_uuid) \
+	TRANSPORT_OPS(_uuid, transport_hfp_properties, NULL, NULL, \
+			transport_hfp_init, \
+			transport_hfp_resume, transport_hfp_suspend, \
+			transport_hfp_cancel, NULL, NULL, \
+			NULL, NULL, \
+			NULL, NULL, transport_hfp_destroy, NULL)
+
 static const struct media_transport_ops transport_ops[] = {
 #ifdef HAVE_A2DP
 	A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
@@ -2730,6 +2885,9 @@ static const struct media_transport_ops transport_ops[] = {
 #ifdef HAVE_ASHA
 	ASHA_OPS(ASHA_PROFILE_UUID),
 #endif /* HAVE_ASHA */
+#ifdef HAVE_HFP
+	HFP_OPS(HFP_AG_UUID),
+#endif /* HAVE_HFP */
 };
 
 static const struct media_transport_ops *
-- 
2.43.0

