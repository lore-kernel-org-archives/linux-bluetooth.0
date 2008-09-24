Return-Path: <cyrus@holtmann.org>
Subject: Re: Port bluetooth-sendto to BlueZ 4.x
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1222225071.22725.0.camel@californication>
References: <1222217742.10497.130.camel@snoogens.fab.redhat.com>
	 <1222225071.22725.0.camel@californication>
Content-Type: multipart/mixed; boundary="=-AydLESLOt01Bt8Ka5ft4"
Date: Wed, 24 Sep 2008 11:18:55 -0700
Message-Id: <1222280335.10497.177.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-AydLESLOt01Bt8Ka5ft4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2008-09-24 at 04:57 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > Patch attached.
> 
> it doesn't apply against upstream GIT and please also fix the coding
> style.

I blame git for allowing me to do stupid things. Fixed patch attached.

Cheers

--=-AydLESLOt01Bt8Ka5ft4
Content-Disposition: attachment; filename="0001-Fix-getting-names-of-remote-devices.patch"
Content-Type: text/x-patch; name="0001-Fix-getting-names-of-remote-devices.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/sendto/main.c b/sendto/main.c
index afa8036..b01dafc 100644
--- a/sendto/main.c
+++ b/sendto/main.c
@@ -415,52 +415,75 @@ static void create_notify(DBusGProxy *proxy,
 							G_TYPE_INVALID);
 }
 
+static gchar *get_name(DBusGProxy *device)
+{
+	GHashTable *hash;
+
+	if (dbus_g_proxy_call(device, "GetProperties", NULL,
+			      G_TYPE_INVALID, dbus_g_type_get_map("GHashTable", G_TYPE_STRING, G_TYPE_VALUE),
+			      &hash, G_TYPE_INVALID) != FALSE) {
+		GValue *value;
+		char *name;
+
+		value = g_hash_table_lookup(hash, "Name");
+		name = value ? g_value_dup_string(value) : NULL;
+		g_hash_table_destroy(hash);
+		return name;
+	}
+
+	return NULL;
+}
+
 static gchar *get_device_name(const gchar *address)
 {
 	DBusGConnection *connection;
-	DBusGProxy *manager, *proxy;
-	gchar *adapter, *name;
+	DBusGProxy *manager;
+	GPtrArray *adapters;
+	gchar *name;
+	guint i;
+
+	name = NULL;
 
 	connection = dbus_g_bus_get(DBUS_BUS_SYSTEM, NULL);
 	if (connection == NULL)
-		return NULL;
+		return name;
 
 	manager = dbus_g_proxy_new_for_name(connection, "org.bluez",
-						"/", "org.bluez.Manager");
+					    "/", "org.bluez.Manager");
 	if (manager == NULL) {
 		dbus_g_connection_unref(connection);
-		return NULL;
+		return name;
 	}
 
-	if (dbus_g_proxy_call(manager, "DefaultAdapter", NULL, G_TYPE_INVALID,
-			G_TYPE_STRING, &adapter, G_TYPE_INVALID) == FALSE) {
+	if (dbus_g_proxy_call(manager, "ListAdapters", NULL,
+			      G_TYPE_INVALID, dbus_g_type_get_collection("GPtrArray", DBUS_TYPE_G_OBJECT_PATH), &adapters,
+			      G_TYPE_INVALID) == FALSE) {
 		g_object_unref(manager);
 		dbus_g_connection_unref(connection);
-		return NULL;
+		return name;
 	}
 
-	g_object_unref(manager);
-
-	proxy = dbus_g_proxy_new_for_name(connection, "org.bluez",
-						adapter, "org.bluez.Adapter");
-	if (proxy == NULL) {
-		g_free(adapter);
-		dbus_g_connection_unref(connection);
-		return NULL;
-	}
-
-	g_free(adapter);
-
-	if (dbus_g_proxy_call(proxy, "GetRemoteName", NULL,
-			G_TYPE_STRING, address, G_TYPE_INVALID,
-			G_TYPE_STRING, &name, G_TYPE_INVALID) == FALSE) {
-		g_object_unref(proxy);
-		dbus_g_connection_unref(connection);
-		return NULL;
+	for (i = 0; i < adapters->len && name == NULL; i++)
+	{
+		DBusGProxy *adapter;
+		char *device_path;
+
+		adapter = dbus_g_proxy_new_for_name(connection, "org.bluez",
+						    g_ptr_array_index(adapters, i), "org.bluez.Adapter");
+		if (dbus_g_proxy_call(adapter, "FindDevice", NULL,
+				      G_TYPE_STRING, address, G_TYPE_INVALID,
+				      DBUS_TYPE_G_OBJECT_PATH, &device_path, G_TYPE_INVALID) != FALSE) {
+			DBusGProxy *device;
+			device = dbus_g_proxy_new_for_name(connection, "org.bluez", device_path, "org.bluez.Device");
+			name = get_name(device);
+			g_object_unref(device);
+			break;
+		}
+		g_object_unref(adapter);
 	}
 
-	g_object_unref(proxy);
-
+	g_ptr_array_free(adapters, TRUE);
+	g_object_unref(manager);
 	dbus_g_connection_unref(connection);
 
 	return name;

--=-AydLESLOt01Bt8Ka5ft4--
