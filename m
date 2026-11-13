Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=2.228.72.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562507;
	b=I040G8G5gkoC7J4iG0Lk9iNFp2wL9Oe9AVkotcRRQI4yVR5ZhNmh3lKSz9S+ZsEefcPC
	 Zl6JfLkrP3JDCP9ICpdLxwXmeJFeMuK6pHcHqLSsBA6Ye9c3by6Ph6zC6clAuqcBDK6v4
	 qsAMvspcwP/SSptnZ/0wWwcdzgD8UPPPSphOO60Pi0EJeXGkkr8rCrczzRpuC0OSP3RCG
	 O/hOPZoNsaggXbhsRkDMq6Kil+z19LTIHR53RcGFwqIDX+koI8/JAr6rLdcUrcWUTb41L
	 Z+cHkK6LhsANFq2FYV7AKI4dmZCayPIDRbc9KmGszxp+NRRCkB0AT7kB9Xr81IUSYpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562507;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KZ6fswn3l/a3uVRqxwf9XZvixk3FRu6gwFdvV+FhYfw=;
	b=5YOmcRp4Cwb2LK26qu/9nA6A06SaAV2WPyjCunZRCRkAdRWlmPzSls+IG7PIAEwGoeK5
	 o85uXfEuXm2Dlb0OZMFSi8sb5jNs9Fs4bFY4nLyP/znHSxwzGCWdVnldhkYBgGgKXKly3
	 Ly1AvUFjrtfDGL/c/10RM6WZsazLvNjUVeMp7zO+h9wh0T2HFj13gt1Ras1QOTzwIpO7X
	 ZQ1EeC7QBzMkkDbmnQZeemtakkjI0bfwony+GaEy3lOyXP9kk9I0xeBqsQV1m4RQeP86I
	 OQ/djTPRN2ZXPE0qGr1nO7KRfrONIV4WfuH/lkr8iskQBujw8b3RiwRfAHuHr/BGptw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewiz.org;
	spf=pass smtp.mailfrom=codewiz.org;
	dkim=pass header.d=codewiz.org header.i=@codewiz.org header.a=rsa-sha256 header.s=mail header.b=jAhFMPWN;
	arc=none smtp.remote-ip=2.228.72.60
Received: from morpheus.develer.net (morpheus.develer.net [2.228.72.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B565606A33D
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B565606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codewiz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewiz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=codewiz.org header.i=@codewiz.org header.a=rsa-sha256 header.s=mail header.b=jAhFMPWN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codewiz.org; s=mail;
	t=1794562504; bh=1e4lQ3TvPUQc/Ggc07tFEYmZmM4K/klR7UEWQco6jJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAhFMPWN8CxfxxY8NmKp/6kHj2DllQqJWzJh2onI/Lf/UboTPOcrJFQwLZdXIHxw6
	 ryFo+OEUqE7D18B8mbfjpdofBZWnYYBmuxgQSKQ7gndyi1e7wiQBwHXyzM3yxcs0KP
	 y0n7+0fzN1zSxlsOFPH096/FbuVAlba2yO7eQigo=
Received: from giskard.lan (unknown [IPv6:2404:7a80:ff26:6c00:fb7a:abd8:86ed:512c])
	(Authenticated sender: bernie)
	by morpheus.develer.net (Postfix) with ESMTPSA id 32A03247D82;
	Fri, 13 Nov 2026 10:35:02 +0100 (CET)
From: Bernie Innocenti <bernie@codewiz.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bernie Innocenti <bernie@codewiz.org>
Subject: [PATCH BlueZ 2/2] cups: Port printer discovery to the ObjectManager API
Date: Fri, 13 Nov 2026 18:34:28 +0900
Message-ID: <20261113093428.2971436-3-bernie@codewiz.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113093428.2971436-1-bernie@codewiz.org>
References: <20261113093428.2971436-1-bernie@codewiz.org>
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
seconds, since it no longer stops by itself.

Assisted-by: Claude:claude-fable-5
---
 profiles/cups/main.c | 409 ++++++-------------------------------------
 1 file changed, 57 insertions(+), 352 deletions(-)

diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index bcd6d2f9f..588bd80a7 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -19,7 +19,6 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
-#include <assert.h>
 #include <signal.h>
 #include <sys/socket.h>
 
@@ -33,16 +32,11 @@
 
 #include "cups.h"
 
-struct cups_device {
-	char *bdaddr;
-	char *name;
-	char *id;
-};
+#define DISCOVERY_TIMEOUT 10
 
-static GSList *device_list = NULL;
+static GSList *printer_list = NULL;
 static GMainLoop *loop = NULL;
-static DBusConnection *conn = NULL;
-static gboolean doing_disco = FALSE;
+static gboolean adapter_found = FALSE;
 
 static char *device_get_ieee1284_id(const char *address)
 {
@@ -85,400 +79,111 @@ static void print_printer_details(const char *name, const char *bdaddr,
 	g_free(uri);
 }
 
-static void add_device_to_list(const char *name, const char *bdaddr,
-								const char *id)
-{
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
-
-	/* Or add it to the list if it's not there */
-	device = g_new0(struct cups_device, 1);
-	device->bdaddr = g_strdup(bdaddr);
-	device->name = g_strdup(name);
-	device->id = g_strdup(id);
-
-	device_list = g_slist_prepend(device_list, device);
-	print_printer_details(device->name, device->bdaddr, device->id);
-}
-
-static gboolean parse_device_properties(DBusMessageIter *reply_iter,
-						char **name, char **bdaddr)
-{
-	guint32 class = 0;
-	DBusMessageIter reply_iter_entry;
-
-	if (dbus_message_iter_get_arg_type(reply_iter) != DBUS_TYPE_ARRAY)
-		return FALSE;
-
-	dbus_message_iter_recurse(reply_iter, &reply_iter_entry);
-
-	while (dbus_message_iter_get_arg_type(&reply_iter_entry) ==
-							DBUS_TYPE_DICT_ENTRY) {
-		const char *key;
-		DBusMessageIter dict_entry, iter_dict_val;
-
-		dbus_message_iter_recurse(&reply_iter_entry, &dict_entry);
-
-		/* Key == Class ? */
-		dbus_message_iter_get_basic(&dict_entry, &key);
-		if (!key) {
-			dbus_message_iter_next(&reply_iter_entry);
-			continue;
-		}
-
-		if (strcmp(key, "Class") != 0 &&
-				strcmp(key, "Alias") != 0 &&
-				strcmp(key, "Address") != 0) {
-			dbus_message_iter_next(&reply_iter_entry);
-			continue;
-		}
-
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
-	}
-
-	if (class == 0)
-		return FALSE;
-	if (((class & 0x1f00) >> 8) == 0x06 && (class & 0x80))
-		return TRUE;
-
-	return FALSE;
-}
-
-static gboolean device_is_printer(const char *adapter, const char *device_path, char **name, char **bdaddr)
+static void device_added(GDBusProxy *proxy)
 {
-	DBusMessage *message, *reply;
-	DBusMessageIter reply_iter;
-	gboolean retval;
-
-	message = dbus_message_new_method_call("org.bluez", device_path,
-							"org.bluez.Device1",
-							"GetProperties");
-
-	reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, NULL);
-
-	dbus_message_unref(message);
-
-	if (!reply)
-		return FALSE;
-
-	dbus_message_iter_init(reply, &reply_iter);
-
-	retval = parse_device_properties(&reply_iter, name, bdaddr);
-
-	dbus_message_unref(reply);
-
-	return retval;
-}
-
-static void remote_device_found(const char *adapter, const char *bdaddr,
-							const char *name)
-{
-	DBusMessage *message, *reply;
 	DBusMessageIter iter;
-	char *object_path = NULL;
+	dbus_uint32_t class;
+	const char *bdaddr, *name;
 	char *id;
 
-	assert(adapter != NULL);
-
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
+
+	printer_list = g_slist_prepend(printer_list, g_strdup(bdaddr));
 
 	id = device_get_ieee1284_id(bdaddr);
-	add_device_to_list(name, bdaddr, id);
+	print_printer_details(name, bdaddr, id);
 	free(id);
-
-	dbus_message_unref(reply);
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
+	const char *interface = g_dbus_proxy_get_interface(proxy);
 
-	for (l = device_list; l != NULL; l = l->next) {
-		struct cups_device *device = l->data;
-
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
+	g_main_loop_quit(loop);
 
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
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
-		dbus_connection_unref(conn);
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
+	if (!dbus_bus_name_has_owner(conn, "org.bluez", NULL)) {
 		dbus_connection_unref(conn);
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
+	g_dbus_client_set_ready_watch(client, client_ready, NULL);
+	g_dbus_client_set_proxy_handlers(client, proxy_added, NULL,
+						property_changed, NULL);
 
-	match = g_strdup_printf(MATCH_FORMAT, adapter);
-	dbus_bus_add_match(conn, match, &error);
-	g_free(match);
-
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
-- 
2.56.1

