Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sat, 22 Sep 2007 22:52:28 +0100
Message-Id: <1190497949.7150.252.camel@pmac.infradead.org>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Fix leak in serial service.
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

When we remove a port, we should remove it from the ports_paths list.
Also, channel numbers can have more than one digit -- allow for up to
three digits, to avoid truncating the ident string in the storage entry.

Would actually be nice if there was a method to retrieve that ident string...

diff --git a/serial/manager.c b/serial/manager.c
index bb46d35..6aaa985 100644
--- a/serial/manager.c
+++ b/serial/manager.c
@@ -896,6 +896,7 @@ static DBusHandlerResult remove_port(DBusConnection *conn,
 {
 	struct rfcomm_dev_info di;
 	DBusError derr;
+	GSList *l;
 	const char *path;
 	int16_t id;
 
@@ -927,6 +928,12 @@ static DBusHandlerResult remove_port(DBusConnection *conn,
 			DBUS_TYPE_STRING, &path,
 			DBUS_TYPE_INVALID);
 
+	l = g_slist_find_custom(ports_paths, path, (GCompareFunc) strcmp);
+	if (l) {
+		g_free(l->data);
+		ports_paths = g_slist_remove(ports_paths, l->data);
+	}
+
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
diff --git a/serial/storage.c b/serial/storage.c
index 8b66354..110d8de 100644
--- a/serial/storage.c
+++ b/serial/storage.c
@@ -75,7 +75,7 @@ int port_store(bdaddr_t *src, bdaddr_t *dst, int16_t id,
 	create_name(filename, PATH_MAX, STORAGEDIR, src_addr, "serial");
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	size = strlen(svcname) + 3;
+	size = strlen(svcname) + 5;
 	value = g_malloc0(size);
 
 	snprintf(key, 32, "%s#%hd", dst_addr, id);


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
