Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1190504329.7150.277.camel@pmac.infradead.org>
References: <1190504329.7150.277.camel@pmac.infradead.org>
Date: Sun, 23 Sep 2007 17:21:55 +0100
Message-Id: <1190564515.7150.304.camel@pmac.infradead.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Serial service support for bluez-gnome
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Sun, 2007-09-23 at 00:38 +0100, David Woodhouse wrote:
> It would be nicer if we could print the service ident string, and also
> the friendly name of the device we're connecting to. But the former
> isn't available, and for the latter I think I need to select a local
> adapter to query even if I only want to take it from the cache? I
> suppose I could hard-code it to hci0 but that seems a bit wrong.

This gives me the name. I'll look at doing the service ident later.

diff --git a/serial/manager.c b/serial/manager.c
index bb46d35..f1831a9 100644
--- a/serial/manager.c
+++ b/serial/manager.c
@@ -562,7 +562,7 @@ static void record_reply(DBusPendingCall *call, void *data)
 		if (svcname)
 			g_free(svcname);
 
-		port_register(pc->conn, err, &dst, port_name, path);
+		port_register(pc->conn, err, &pc->src, &dst, port_name, path);
 		ports_paths = g_slist_append(ports_paths, g_strdup(path));
 
 		reply = dbus_message_new_method_return(pc->msg);
@@ -840,7 +840,7 @@ static DBusHandlerResult create_port(DBusConnection *conn,
 
 	snprintf(port_name, sizeof(port_name), "/dev/rfcomm%d", err);
 	port_store(&src, &dst, err, val, NULL);
-	port_register(conn, err, &dst, port_name, path);
+	port_register(conn, err, &src, &dst, port_name, path);
 	ports_paths = g_slist_append(ports_paths, g_strdup(path));
 
 	reply = dbus_message_new_method_return(msg);
@@ -2157,7 +2164,7 @@ static void parse_port(char *key, char *value, void *data)
 
 	snprintf(port_name, sizeof(port_name), "/dev/rfcomm%d", id);
 
-	if (port_register(connection, id, &dst, port_name, path) < 0) {
+	if (port_register(connection, id, &src, &dst, port_name, path) < 0) {
 		rfcomm_release(id);
 		return;
 	}
diff --git a/serial/port.c b/serial/port.c
index e404825..208d3ef 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -52,6 +52,7 @@
 
 struct rfcomm_node {
 	int16_t		id;		/* RFCOMM device id */
+	bdaddr_t	src;		/* Source (local) address */
 	bdaddr_t	dst;		/* Destination address */
 	char		*device;	/* RFCOMM device name */
 	DBusConnection	*conn;		/* for name listener handling */
@@ -113,6 +114,49 @@ static DBusHandlerResult port_get_device(DBusConnection *conn,
 
 }
 
+static DBusHandlerResult port_get_adapter(DBusConnection *conn,
+					  DBusMessage *msg, void *data)
+{
+	struct rfcomm_node *node = data;
+	DBusMessage *reply;
+	char addr[18];
+	const char *paddr = addr;
+
+	ba2str(&node->src, addr);
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+
+	dbus_message_append_args(reply,
+			DBUS_TYPE_STRING, &paddr,
+			DBUS_TYPE_INVALID);
+
+	return send_message_and_unref(conn, reply);
+}
+
+
+static DBusHandlerResult port_get_name(DBusConnection *conn,
+				       DBusMessage *msg, void *data)
+{
+	struct rfcomm_node *node = data;
+	DBusMessage *reply;
+	const char *pname = "";
+
+	read_device_name(&node->src, &node->dst, &pname);
+	
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+
+	dbus_message_append_args(reply,
+			DBUS_TYPE_STRING, &pname,
+			DBUS_TYPE_INVALID);
+
+	return send_message_and_unref(conn, reply);
+}
+
+
 static DBusHandlerResult port_get_info(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -148,6 +192,8 @@ static DBusHandlerResult port_get_info(DBusConnection *conn,
 static DBusMethodVTable port_methods[] = {
 	{ "GetAddress",	port_get_address,	"",	"s"	},
 	{ "GetDevice",	port_get_device,	"",	"s"	},
+	{ "GetAdapter",	port_get_adapter,	"",	"s"	},
+	{ "GetName",	port_get_name,		"",	"s"	},
 	{ "GetInfo",	port_get_info,		"",	"{sv}"	},
 	{ NULL, NULL, NULL, NULL },
 };
@@ -257,14 +303,15 @@ int port_remove_listener(const char *owner, const char *dev)
 	return 0;
 }
 
-int port_register(DBusConnection *conn, int16_t id, bdaddr_t *dst,
-					const char *dev, char *ppath)
+int port_register(DBusConnection *conn, int16_t id, bdaddr_t *src,
+		  bdaddr_t *dst, const char *dev, char *ppath)
 {
 	char path[MAX_PATH_LENGTH];
 	struct rfcomm_node *node;
 
 	node = g_new0(struct rfcomm_node, 1);
 	bacpy(&node->dst, dst);
+	bacpy(&node->src, src);
 	node->id	= id;
 	node->device	= g_strdup(dev);
 	node->conn	= dbus_connection_ref(conn);
diff --git a/serial/port.h b/serial/port.h
index c0b9073..5935bef 100644
--- a/serial/port.h
+++ b/serial/port.h
@@ -26,7 +26,7 @@ int port_add_listener(DBusConnection *conn, int16_t id, bdaddr_t *dst,
 
 int port_remove_listener(const char *owner, const char *dev);
 
-int port_register(DBusConnection *conn, int16_t id, bdaddr_t *dst,
-					const char *dev, char *ppath);
+int port_register(DBusConnection *conn, int16_t id, bdaddr_t *src,
+		  bdaddr_t *dst, const char *dev, char *ppath);
 
 int port_unregister(const char *path);
diff --git a/serial/serial-api.txt b/serial/serial-api.txt
index 5ac7091..20a94e5 100644
--- a/serial/serial-api.txt
+++ b/serial/serial-api.txt
@@ -102,7 +102,11 @@ Port hierarchy (experimental)
 Interface	org.bluez.serial.Port
 Object path	/org/bluez/serial/rfcomm*
 
-Methods		string GetAddress() [experimental]
+Methods		string GetAdapter() [experimental]
+
+			Returns the adapter address.
+
+		string GetAddress() [experimental]
 
 			Returns the Bluetooth address of the ending point.
 
@@ -114,6 +118,10 @@ Methods		string GetAddress() [experimental]
 
 			Returns the port properties.
 
+		string GetName() [experimental]
+
+			Returns the name of the remote device.
+
 Proxy hierarchy (experimental)
 =============================
 Interface	org.bluez.serial.Proxy
diff --git a/serial/storage.c b/serial/storage.c
index 8b66354..0440eb2 100644
--- a/serial/storage.c
+++ b/serial/storage.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
 #include <stdlib.h>
 #include <termios.h>
 #include <unistd.h>
@@ -133,3 +134,38 @@ done:
 
 	return err;
 }
+
+int read_device_name(bdaddr_t *src, bdaddr_t *dst, char **name)
+{
+	char filename[PATH_MAX + 1], *str;
+	char src_addr[18], dst_addr[18];
+	int len;
+	char key[32];
+
+	ba2str(src, src_addr);
+	ba2str(dst, dst_addr);
+
+	create_name(filename, PATH_MAX, STORAGEDIR, src_addr, "names");
+
+	str = textfile_get(filename, dst_addr);
+	if (!str)
+		return -ENOENT;
+
+	len = strlen(str);
+
+	/* HID max name size is 128 chars */
+	if (len < 128) {
+		*name = str;
+		return 0;
+	}
+
+	*name = g_try_malloc0(128);
+	if (!*name)
+		return -ENOMEM;
+
+	snprintf(*name, 128, "%s", str);
+
+	free(str);
+
+	return 0;
+}
diff --git a/serial/storage.h b/serial/storage.h
index 4a24bdf..271ae72 100644
--- a/serial/storage.h
+++ b/serial/storage.h
@@ -27,3 +27,4 @@ int port_store(bdaddr_t *src, bdaddr_t *dst, int16_t id,
 int proxy_delete(bdaddr_t *src, const char *tty);
 int proxy_store(bdaddr_t *src, const char *uuid, const char *tty,
 		const char *name, uint8_t ch, int opts, struct termios *ti);
+int read_device_name(bdaddr_t *src, bdaddr_t *dst, char **name);

-- 
dwmw2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
