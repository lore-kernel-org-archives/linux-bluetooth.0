Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=2.228.72.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828601;
	b=4KJL/p3tRfe1Sj0kg3zloE8dyxNFprsmWvd0UffG6t/0PYeKTsKhfdqBXaB4mE7QnCxf
	 ib2FVDwDyPrBXSAiH9E0YiT3LvY/PehdQIkPD4kp7ouUmVLUbRYm8GyzAH3dTX1UD7szc
	 E0QVbps1RYXEZmxytibVU4UEoU/0uC+q0X0Nv19HqORso9wnHdfFuuQV8IddO6cC5qTHs
	 9g7Ek4zpzzeca1ZCa0CtM0BBYugPz+A1Hasg4MwBS4DnKKFLeqOWizOsfMWwCDBJtsuTm
	 0XeuYWZ0D/sNYSE0mLO00GmgFJVCIN9f5tmGWa7nI5XBWbg2sgf2Wi+bUQLTTVBd0dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828601;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8nb17IzQRsGQ5JTNLEQgRNUA4MqITiUxqWykaSYAYNY=;
	b=1XkgrCePT2C/iALkJjCyNSS3xzZlqfCjEnauR2WuSKaf3Ct9xLI6/0Z1pcrlw3NvjLFg
	 5mmIkrt+c21vdkpoCGNYYDfmmwC2c9Y4DQkgdSdyUjfeVDEY1ppKOkW2d+lN6vITy+E1T
	 zU3gSR2oHRwEqXID+zYpQJ/nqkbe/WbFDpdh9sFD6maWAOlfcidpcd989PZ1Z15TedBck
	 cz0B56Fm9Xl9LCsnmTiukarZNt19q56D6SDh6lQUwjsopCyvvIhyRhWSwbNDaMlyYpWlq
	 ILT+gdHLgjN9MTAbXVKmCIOHXmv/e3sshKPfinRauhP/iJuiv86jDgTY96Jp+XiJ2PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewiz.org;
	spf=pass smtp.mailfrom=codewiz.org;
	dkim=pass header.d=codewiz.org header.i=@codewiz.org header.a=rsa-sha256 header.s=mail header.b=R2nHGFmB;
	arc=none smtp.remote-ip=2.228.72.60
Received: from morpheus.develer.net (morpheus.develer.net [2.228.72.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089C606A79E
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 11:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4089C606A79E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codewiz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewiz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=codewiz.org header.i=@codewiz.org header.a=rsa-sha256 header.s=mail header.b=R2nHGFmB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codewiz.org; s=mail;
	t=1794828597; bh=h14Dd7NsxJMrc3PR4hluK7tTqvTnjTGoBmFC7dXGibE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2nHGFmBzXeYrpKMtMFLCiGImeaDjdIS98KS1ha+Xv5V+nK18M7qwynUppNU7seZy
	 ZMwSofVIOTNUDCz+LE89IhlC20/W+uQk0+muUBXRYv0cxkNPBxPQmI945zevp5LJu6
	 +uOwO1PxcRb18N5BPP2VUp2ERaRLPwyNJRBEAMLg=
Received: from giskard.lan (unknown [135.136.55.122])
	(Authenticated sender: bernie)
	by morpheus.develer.net (Postfix) with ESMTPSA id 996F7247E9C;
	Mon, 16 Nov 2026 12:29:56 +0100 (CET)
From: Bernie Innocenti <bernie@codewiz.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bernie Innocenti <bernie@codewiz.org>
Subject: [PATCH BlueZ v2 2/2] cups: Port printer discovery to the ObjectManager API
Date: Mon, 16 Nov 2026 20:29:31 +0900
Message-ID: <20261116112931.1598858-3-bernie@codewiz.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116112931.1598858-1-bernie@codewiz.org>
References: <CABBYNZL1Hn8dyNfd+xMkXxyVvZxqLH=ZcbSCtjKqLXi6RFeNew@mail.gmail.com>
 <20261116112931.1598858-1-bernie@codewiz.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Discovery still used org.bluez.Manager and the Adapter1 ListDevices,
FindDevice and CreateDevice methods, none of which exist in BlueZ 5,
so the backend never listed any printer.

List the printers among the known devices, then run discovery for 10
seconds, since it no longer stops by itself. Read the device IDs
asynchronously so that an unreachable printer does not stall the
discovery; printers whose ID has not arrived by the deadline are
listed without one.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/cups/cups.h |   2 +
 profiles/cups/main.c | 464 +++++++++++++------------------------------
 profiles/cups/sdp.c  |  68 ++++++-
 3 files changed, 202 insertions(+), 332 deletions(-)

diff --git a/profiles/cups/cups.h b/profiles/cups/cups.h
index f2ec8aec7..e9523e540 100644
--- a/profiles/cups/cups.h
+++ b/profiles/cups/cups.h
@@ -21,6 +21,8 @@ enum {					/**** Backend exit codes ****/
 int sdp_search_spp(sdp_session_t *sdp, uint8_t *channel);
 int sdp_search_hcrp(sdp_session_t *sdp, unsigned short *ctrl_psm, unsigned short *data_psm);
 char *sdp_search_ieee1284_id(sdp_session_t *sdp);
+int sdp_search_ieee1284_id_async(sdp_session_t *sdp);
+char *sdp_parse_ieee1284_id(uint8_t *rsp, size_t size);
 
 int spp_print(bdaddr_t *src, bdaddr_t *dst, uint8_t channel, int fd, int copies, const char *cups_class);
 int hcrp_print(bdaddr_t *src, bdaddr_t *dst, unsigned short ctrl_psm, unsigned short data_psm, int fd, int copies, const char *cups_class);
diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index bcd6d2f9f..40fabca7c 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -19,7 +19,6 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
-#include <assert.h>
 #include <signal.h>
 #include <sys/socket.h>
 
@@ -33,16 +32,19 @@
 
 #include "cups.h"
 
-struct cups_device {
-	char *bdaddr;
+#define DISCOVERY_TIMEOUT 10
+
+struct id_lookup {
 	char *name;
-	char *id;
+	char *bdaddr;
+	sdp_session_t *sdp;
+	guint watch;
 };
 
-static GSList *device_list = NULL;
+static GSList *printer_list = NULL;
+static GSList *lookup_list = NULL;
 static GMainLoop *loop = NULL;
-static DBusConnection *conn = NULL;
-static gboolean doing_disco = FALSE;
+static gboolean adapter_found = FALSE;
 
 static char *device_get_ieee1284_id(const char *address)
 {
@@ -85,400 +87,212 @@ static void print_printer_details(const char *name, const char *bdaddr,
 	g_free(uri);
 }
 
-static void add_device_to_list(const char *name, const char *bdaddr,
-								const char *id)
+static void lookup_done(struct id_lookup *lookup, const char *id)
 {
-	struct cups_device *device;
-	GSList *l;
-
-	/* Look for the device in the list */
-	for (l = device_list; l != NULL; l = l->next) {
-		device = (struct cups_device *) l->data;
-
-		if (strcmp(device->bdaddr, bdaddr) == 0) {
-			if (device->name != name) {
-				g_free(device->name);
-				device->name = g_strdup(name);
-			}
-			g_free(device->id);
-			device->id = g_strdup(id);
-			return;
-		}
-	}
+	print_printer_details(lookup->name, lookup->bdaddr, id);
+
+	lookup_list = g_slist_remove(lookup_list, lookup);
 
-	/* Or add it to the list if it's not there */
-	device = g_new0(struct cups_device, 1);
-	device->bdaddr = g_strdup(bdaddr);
-	device->name = g_strdup(name);
-	device->id = g_strdup(id);
+	if (lookup->watch)
+		g_source_remove(lookup->watch);
 
-	device_list = g_slist_prepend(device_list, device);
-	print_printer_details(device->name, device->bdaddr, device->id);
+	sdp_close(lookup->sdp);
+	g_free(lookup->name);
+	g_free(lookup->bdaddr);
+	g_free(lookup);
 }
 
-static gboolean parse_device_properties(DBusMessageIter *reply_iter,
-						char **name, char **bdaddr)
+static void lookup_complete(uint8_t type, uint16_t status, uint8_t *rsp,
+						size_t size, void *user_data)
 {
-	guint32 class = 0;
-	DBusMessageIter reply_iter_entry;
-
-	if (dbus_message_iter_get_arg_type(reply_iter) != DBUS_TYPE_ARRAY)
-		return FALSE;
-
-	dbus_message_iter_recurse(reply_iter, &reply_iter_entry);
+	struct id_lookup *lookup = user_data;
+	char *id = NULL;
 
-	while (dbus_message_iter_get_arg_type(&reply_iter_entry) ==
-							DBUS_TYPE_DICT_ENTRY) {
-		const char *key;
-		DBusMessageIter dict_entry, iter_dict_val;
+	if (!status && type == SDP_SVC_SEARCH_ATTR_RSP)
+		id = sdp_parse_ieee1284_id(rsp, size);
 
-		dbus_message_iter_recurse(&reply_iter_entry, &dict_entry);
-
-		/* Key == Class ? */
-		dbus_message_iter_get_basic(&dict_entry, &key);
-		if (!key) {
-			dbus_message_iter_next(&reply_iter_entry);
-			continue;
-		}
+	lookup->watch = 0;
+	lookup_done(lookup, id);
+	free(id);
+}
 
-		if (strcmp(key, "Class") != 0 &&
-				strcmp(key, "Alias") != 0 &&
-				strcmp(key, "Address") != 0) {
-			dbus_message_iter_next(&reply_iter_entry);
-			continue;
-		}
+static gboolean lookup_process(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	struct id_lookup *lookup = user_data;
 
-		/* Try to get the value */
-		if (!dbus_message_iter_next(&dict_entry)) {
-			dbus_message_iter_next(&reply_iter_entry);
-			continue;
-		}
-		dbus_message_iter_recurse(&dict_entry, &iter_dict_val);
-		if (strcmp(key, "Class") == 0) {
-			dbus_message_iter_get_basic(&iter_dict_val, &class);
-		} else {
-			const char *value;
-			dbus_message_iter_get_basic(&iter_dict_val, &value);
-			if (strcmp(key, "Alias") == 0) {
-				*name = g_strdup(value);
-			} else if (bdaddr) {
-				*bdaddr = g_strdup(value);
-			}
-		}
-		dbus_message_iter_next(&reply_iter_entry);
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		lookup->watch = 0;
+		lookup_done(lookup, NULL);
+		return FALSE;
 	}
 
-	if (class == 0)
+	/* On failure or completion sdp_process() calls lookup_complete() */
+	if (sdp_process(lookup->sdp) < 0)
 		return FALSE;
-	if (((class & 0x1f00) >> 8) == 0x06 && (class & 0x80))
-		return TRUE;
 
-	return FALSE;
+	return TRUE;
 }
 
-static gboolean device_is_printer(const char *adapter, const char *device_path, char **name, char **bdaddr)
+static gboolean lookup_connected(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
 {
-	DBusMessage *message, *reply;
-	DBusMessageIter reply_iter;
-	gboolean retval;
+	struct id_lookup *lookup = user_data;
+	socklen_t len = sizeof(int);
+	int sk_err = 0;
 
-	message = dbus_message_new_method_call("org.bluez", device_path,
-							"org.bluez.Device1",
-							"GetProperties");
+	lookup->watch = 0;
 
-	reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, NULL);
+	if (getsockopt(g_io_channel_unix_get_fd(chan), SOL_SOCKET, SO_ERROR,
+						&sk_err, &len) < 0 || sk_err ||
+			sdp_set_notify(lookup->sdp, lookup_complete, lookup) < 0 ||
+			sdp_search_ieee1284_id_async(lookup->sdp) < 0) {
+		lookup_done(lookup, NULL);
+		return FALSE;
+	}
 
-	dbus_message_unref(message);
+	lookup->watch = g_io_add_watch(chan,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				lookup_process, lookup);
 
-	if (!reply)
-		return FALSE;
+	return FALSE;
+}
+
+static void lookup_start(const char *name, const char *bdaddr)
+{
+	struct id_lookup *lookup;
+	sdp_session_t *sdp;
+	GIOChannel *chan;
+	bdaddr_t ba;
+
+	str2ba(bdaddr, &ba);
 
-	dbus_message_iter_init(reply, &reply_iter);
+	sdp = sdp_connect(BDADDR_ANY, &ba, SDP_NON_BLOCKING);
+	if (!sdp) {
+		print_printer_details(name, bdaddr, NULL);
+		return;
+	}
 
-	retval = parse_device_properties(&reply_iter, name, bdaddr);
+	lookup = g_new0(struct id_lookup, 1);
+	lookup->name = g_strdup(name);
+	lookup->bdaddr = g_strdup(bdaddr);
+	lookup->sdp = sdp;
 
-	dbus_message_unref(reply);
+	chan = g_io_channel_unix_new(sdp_get_socket(sdp));
+	lookup->watch = g_io_add_watch(chan,
+				G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				lookup_connected, lookup);
+	g_io_channel_unref(chan);
 
-	return retval;
+	lookup_list = g_slist_prepend(lookup_list, lookup);
 }
 
-static void remote_device_found(const char *adapter, const char *bdaddr,
-							const char *name)
+static void device_added(GDBusProxy *proxy)
 {
-	DBusMessage *message, *reply;
 	DBusMessageIter iter;
-	char *object_path = NULL;
-	char *id;
-
-	assert(adapter != NULL);
+	dbus_uint32_t class;
+	const char *bdaddr, *name;
 
-	message = dbus_message_new_method_call("org.bluez", adapter,
-							"org.bluez.Adapter1",
-							"FindDevice");
-	dbus_message_iter_init_append(message, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
+	if (!g_dbus_proxy_get_property(proxy, "Class", &iter))
+		return;
 
-	reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, NULL);
+	dbus_message_iter_get_basic(&iter, &class);
 
-	dbus_message_unref(message);
+	/* Imaging major class with the printer bit set */
+	if (((class & 0x1f00) >> 8) != 0x06 || !(class & 0x80))
+		return;
 
-	if (!reply) {
-		message = dbus_message_new_method_call("org.bluez", adapter,
-							"org.bluez.Adapter1",
-							"CreateDevice");
-		dbus_message_iter_init_append(message, &iter);
-		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
+	if (!g_dbus_proxy_get_property(proxy, "Address", &iter))
+		return;
 
-		reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, NULL);
+	dbus_message_iter_get_basic(&iter, &bdaddr);
 
-		dbus_message_unref(message);
+	if (!g_dbus_proxy_get_property(proxy, "Alias", &iter))
+		return;
 
-		if (!reply)
-			return;
-	}
+	dbus_message_iter_get_basic(&iter, &name);
 
-	if (dbus_message_get_args(reply, NULL,
-					DBUS_TYPE_OBJECT_PATH, &object_path,
-					DBUS_TYPE_INVALID) == FALSE) {
-		dbus_message_unref(reply);
+	if (g_slist_find_custom(printer_list, bdaddr, (GCompareFunc) strcmp))
 		return;
-	}
 
-	id = device_get_ieee1284_id(bdaddr);
-	add_device_to_list(name, bdaddr, id);
-	free(id);
+	printer_list = g_slist_prepend(printer_list, g_strdup(bdaddr));
 
-	dbus_message_unref(reply);
+	lookup_start(name, bdaddr);
 }
 
-static void discovery_completed(void)
+static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
-	g_slist_free(device_list);
-	device_list = NULL;
-
-	g_main_loop_quit(loop);
+	const char *interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, "org.bluez.Adapter1")) {
+		adapter_found = TRUE;
+		g_dbus_proxy_method_call(proxy, "StartDiscovery", NULL, NULL,
+								NULL, NULL);
+	} else if (!strcmp(interface, "org.bluez.Device1")) {
+		device_added(proxy);
+	}
 }
 
-static void remote_device_disappeared(const char *bdaddr)
+static void property_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
 {
-	GSList *l;
-
-	for (l = device_list; l != NULL; l = l->next) {
-		struct cups_device *device = l->data;
+	const char *interface = g_dbus_proxy_get_interface(proxy);
 
-		if (strcmp(device->bdaddr, bdaddr) == 0) {
-			g_free(device->name);
-			g_free(device->bdaddr);
-			g_free(device);
-			device_list = g_slist_delete_link(device_list, l);
-			return;
-		}
-	}
+	if (!strcmp(interface, "org.bluez.Device1") && !strcmp(name, "Class"))
+		device_added(proxy);
 }
 
-static gboolean list_known_printers(const char *adapter)
+static void client_ready(GDBusClient *client, void *user_data)
 {
-	DBusMessageIter reply_iter, iter_array;
-	DBusError error;
-	DBusMessage *message, *reply;
-
-	message = dbus_message_new_method_call("org.bluez", adapter,
-						"org.bluez.Adapter1",
-						"ListDevices");
-	if (message == NULL)
-		return FALSE;
-
-	dbus_error_init(&error);
-	reply = dbus_connection_send_with_reply_and_block(conn, message,
-								-1, &error);
-
-	dbus_message_unref(message);
-
-	if (dbus_error_is_set(&error)) {
-		dbus_error_free(&error);
-		return FALSE;
-	}
-
-	dbus_message_iter_init(reply, &reply_iter);
-	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_ARRAY) {
-		dbus_message_unref(reply);
-		return FALSE;
-	}
-
-	dbus_message_iter_recurse(&reply_iter, &iter_array);
-	while (dbus_message_iter_get_arg_type(&iter_array) ==
-						DBUS_TYPE_OBJECT_PATH) {
-		const char *object_path;
-		char *name = NULL;
-		char *bdaddr = NULL;
-
-		dbus_message_iter_get_basic(&iter_array, &object_path);
-		if (device_is_printer(adapter, object_path, &name, &bdaddr)) {
-			char *id;
-
-			id = device_get_ieee1284_id(bdaddr);
-			add_device_to_list(name, bdaddr, id);
-			free(id);
-		}
-		g_free(name);
-		g_free(bdaddr);
-		dbus_message_iter_next(&iter_array);
-	}
-
-	dbus_message_unref(reply);
-
-	return FALSE;
+	if (!adapter_found)
+		g_main_loop_quit(loop);
 }
 
-static DBusHandlerResult filter_func(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
+static gboolean discovery_timeout(gpointer user_data)
 {
-	if (dbus_message_is_signal(message, "org.bluez.Adapter1",
-						"DeviceFound")) {
-		const char *adapter, *bdaddr;
-		char *name;
-		DBusMessageIter iter;
-
-		dbus_message_iter_init(message, &iter);
-		dbus_message_iter_get_basic(&iter, &bdaddr);
-		dbus_message_iter_next(&iter);
-
-		adapter = dbus_message_get_path(message);
-		if (parse_device_properties(&iter, &name, NULL))
-			remote_device_found(adapter, bdaddr, name);
-		g_free (name);
-	} else if (dbus_message_is_signal(message, "org.bluez.Adapter1",
-						"DeviceDisappeared")) {
-		const char *bdaddr;
-
-		dbus_message_get_args(message, NULL,
-					DBUS_TYPE_STRING, &bdaddr,
-					DBUS_TYPE_INVALID);
-		remote_device_disappeared(bdaddr);
-	} else if (dbus_message_is_signal(message, "org.bluez.Adapter1",
-						"PropertyChanged")) {
-		DBusMessageIter iter, value_iter;
-		const char *name;
-		gboolean discovering;
-
-		dbus_message_iter_init(message, &iter);
-		dbus_message_iter_get_basic(&iter, &name);
-		if (name == NULL || strcmp(name, "Discovering") != 0)
-			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-		dbus_message_iter_next(&iter);
-		dbus_message_iter_recurse(&iter, &value_iter);
-		dbus_message_iter_get_basic(&value_iter, &discovering);
-
-		if (discovering == FALSE && doing_disco) {
-			doing_disco = FALSE;
-			discovery_completed();
-		}
-	}
+	/* List the printers whose device ID did not arrive in time */
+	while (lookup_list)
+		lookup_done(lookup_list->data, NULL);
 
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	g_main_loop_quit(loop);
+
+	return FALSE;
 }
 
 static gboolean list_printers(void)
 {
-	/* 1. Connect to the bus
-	 * 2. Get the manager
-	 * 3. Get the default adapter
-	 * 4. Get a list of devices
-	 * 5. Get the class of each device
-	 * 6. Print the details from each printer device
-	 */
-	DBusError error;
-	dbus_bool_t hcid_exists;
-	DBusMessage *reply, *message;
-	DBusMessageIter reply_iter;
-	char *adapter, *match;
+	DBusConnection *conn;
+	GDBusClient *client;
 
 	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 	if (conn == NULL)
 		return TRUE;
 
-	dbus_error_init(&error);
-	hcid_exists = dbus_bus_name_has_owner(conn, "org.bluez", &error);
-	if (dbus_error_is_set(&error)) {
-		dbus_error_free(&error);
-		return TRUE;
-	}
-
-	if (!hcid_exists)
-		return TRUE;
-
-	/* Get the default adapter */
-	message = dbus_message_new_method_call("org.bluez", "/",
-						"org.bluez.Manager",
-						"DefaultAdapter");
-	if (message == NULL) {
+	if (!dbus_bus_name_has_owner(conn, "org.bluez", NULL)) {
 		dbus_connection_unref(conn);
-		return FALSE;
-	}
-
-	reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, &error);
-
-	dbus_message_unref(message);
-
-	if (dbus_error_is_set(&error)) {
-		dbus_error_free(&error);
-		dbus_connection_unref(conn);
-		/* No adapter */
 		return TRUE;
 	}
 
-	dbus_message_iter_init(reply, &reply_iter);
-	if (dbus_message_iter_get_arg_type(&reply_iter) !=
-						DBUS_TYPE_OBJECT_PATH) {
-		dbus_message_unref(reply);
-		dbus_connection_unref(conn);
-		return FALSE;
-	}
-
-	dbus_message_iter_get_basic(&reply_iter, &adapter);
-	adapter = g_strdup(adapter);
-	dbus_message_unref(reply);
+	loop = g_main_loop_new(NULL, FALSE);
 
-	if (!dbus_connection_add_filter(conn, filter_func, adapter, g_free)) {
-		g_free(adapter);
+	client = g_dbus_client_new(conn, "org.bluez", "/org/bluez");
+	if (client == NULL) {
+		g_main_loop_unref(loop);
 		dbus_connection_unref(conn);
 		return FALSE;
 	}
 
-#define MATCH_FORMAT				\
-	"type='signal',"			\
-	"interface='org.bluez.Adapter1',"	\
-	"sender='org.bluez',"			\
-	"path='%s'"
-
-	match = g_strdup_printf(MATCH_FORMAT, adapter);
-	dbus_bus_add_match(conn, match, &error);
-	g_free(match);
+	g_dbus_client_set_ready_watch(client, client_ready, NULL);
+	g_dbus_client_set_proxy_handlers(client, proxy_added, NULL,
+						property_changed, NULL);
 
-	/* Add the the recent devices */
-	list_known_printers(adapter);
-
-	doing_disco = TRUE;
-	message = dbus_message_new_method_call("org.bluez", adapter,
-					"org.bluez.Adapter1",
-					"StartDiscovery");
-
-	if (!dbus_connection_send_with_reply(conn, message, NULL, -1)) {
-		dbus_message_unref(message);
-		dbus_connection_unref(conn);
-		g_free(adapter);
-		return FALSE;
-	}
-	dbus_message_unref(message);
+	/* bluetoothd stops the discovery when we drop off the bus */
+	g_timeout_add_seconds(DISCOVERY_TIMEOUT, discovery_timeout, NULL);
 
-	loop = g_main_loop_new(NULL, TRUE);
 	g_main_loop_run(loop);
 
-	g_free(adapter);
+	g_dbus_client_unref(client);
+	g_main_loop_unref(loop);
 	dbus_connection_unref(conn);
 
 	return TRUE;
diff --git a/profiles/cups/sdp.c b/profiles/cups/sdp.c
index e83196df6..3ad5bd939 100644
--- a/profiles/cups/sdp.c
+++ b/profiles/cups/sdp.c
@@ -124,16 +124,15 @@ static char *record_get_ieee1284_id(sdp_record_t *rec)
 	return strndup(data->val.str + 2, len - 2);
 }
 
-char *sdp_search_ieee1284_id(sdp_session_t *sdp)
+static int search_ieee1284_id(sdp_session_t *sdp, sdp_list_t **rsp)
 {
-	sdp_list_t *srch, *attrs, *rsp, *l;
+	sdp_list_t *srch, *attrs;
 	uuid_t svclass;
 	uint16_t attr;
-	char *id = NULL;
 	int err;
 
 	if (!sdp)
-		return NULL;
+		return -1;
 
 	sdp_uuid16_create(&svclass, HCR_PRINT_SVCLASS_ID);
 	srch = sdp_list_append(NULL, &svclass);
@@ -141,11 +140,25 @@ char *sdp_search_ieee1284_id(sdp_session_t *sdp)
 	attr = ATTRID_1284ID;
 	attrs = sdp_list_append(NULL, &attr);
 
-	err = sdp_service_search_attr_req(sdp, srch, SDP_ATTR_REQ_INDIVIDUAL,
-								attrs, &rsp);
+	if (rsp)
+		err = sdp_service_search_attr_req(sdp, srch,
+					SDP_ATTR_REQ_INDIVIDUAL, attrs, rsp);
+	else
+		err = sdp_service_search_attr_async(sdp, srch,
+					SDP_ATTR_REQ_INDIVIDUAL, attrs);
+
 	sdp_list_free(srch, NULL);
 	sdp_list_free(attrs, NULL);
-	if (err)
+
+	return err;
+}
+
+char *sdp_search_ieee1284_id(sdp_session_t *sdp)
+{
+	sdp_list_t *rsp, *l;
+	char *id = NULL;
+
+	if (search_ieee1284_id(sdp, &rsp))
 		return NULL;
 
 	for (l = rsp; l; l = l->next) {
@@ -159,3 +172,44 @@ char *sdp_search_ieee1284_id(sdp_session_t *sdp)
 
 	return id;
 }
+
+int sdp_search_ieee1284_id_async(sdp_session_t *sdp)
+{
+	return search_ieee1284_id(sdp, NULL);
+}
+
+char *sdp_parse_ieee1284_id(uint8_t *rsp, size_t size)
+{
+	int scanned, seqlen = 0, bytesleft = size;
+	uint8_t dtd;
+	char *id = NULL;
+
+	scanned = sdp_extract_seqtype(rsp, bytesleft, &dtd, &seqlen);
+	if (!scanned || !seqlen)
+		return NULL;
+
+	rsp += scanned;
+	bytesleft -= scanned;
+
+	while (!id && bytesleft > 0) {
+		sdp_record_t *rec;
+		int recsize = 0;
+
+		rec = sdp_extract_pdu(rsp, bytesleft, &recsize);
+		if (!rec)
+			break;
+
+		if (recsize)
+			id = record_get_ieee1284_id(rec);
+
+		sdp_record_free(rec);
+
+		if (!recsize)
+			break;
+
+		rsp += recsize;
+		bytesleft -= recsize;
+	}
+
+	return id;
+}
-- 
2.56.1

