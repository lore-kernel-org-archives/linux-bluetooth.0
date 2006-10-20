Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45390275.1010607@palmsource.com>
Date: Fri, 20 Oct 2006 19:08:05 +0200
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1155819360.4075.123.camel@aeonflux.holtmann.net>	<20060817113538.GB5118@srcf.ucam.org>	<1155823499.4075.157.camel@aeonflux.holtmann.net>	<20060817122559.GA6422@srcf.ucam.org>	<20060817124514.GA27427@localhost.localdomain>	<1155819813.18545.36.camel@cookie.hadess.net>	<1155839761.4075.165.camel@aeonflux.holtmann.net>	<44E5B2A5.1070002@palmsource.com>	<1155924372.4075.191.camel@aeonflux.holtmann.net>	<45362E18.1040909@palmsource.com>
	<20061018140352.GA11008@localhost.localdomain>
In-Reply-To: <20061018140352.GA11008@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------020509090500050207070305"
Subject: Re: [Bluez-devel]
	DBus	interface	-	determining	whether	a	device	exists
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020509090500050207070305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Johan,

Here is a new version of the patch updated.
Thanks for your comments.


Fred


--------------020509090500050207070305
Content-Type: text/x-patch;
 name="hcid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcid.patch"

diff -Naur hcid.orig/dbus-adapter.c hcid.new/dbus-adapter.c
--- hcid.orig/dbus-adapter.c	2006-10-17 17:54:10.000000000 +0200
+++ hcid.new/dbus-adapter.c	2006-10-20 15:58:53.000000000 +0200
@@ -25,10 +25,12 @@
 #include <config.h>
 #endif
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <time.h>
 #include <sys/param.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -2615,6 +2617,126 @@
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
+struct remote_device_list_t {
+	struct slist *list;
+	time_t time;
+};
+
+static void list_remote_devices_do_append(char *key, char *value, void *data)
+{
+	struct remote_device_list_t *param = data;
+	char *address;
+	struct tm date;
+
+	if (slist_find(param->list, key, (cmp_func_t) strcasecmp))
+		return;
+
+	if (param->time){
+		strptime (value, "%Y-%m-%d %H:%M:%S %Z", &date);
+		if (difftime(mktime(&date), param->time) < 0)
+			return;
+	}
+
+	address = strdup(key);
+	if (!address)
+		return;
+
+	param->list = slist_append(param->list, address);
+}
+
+static void remote_devices_do_append(void *data, void *user_data)
+{
+	DBusMessageIter *iter = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &data);
+}
+
+static DBusHandlerResult adapter_list_remote_devices(DBusConnection *conn, DBusMessage *msg, void *data)
+{
+	struct adapter *adapter = data;
+	DBusMessageIter iter;
+	DBusMessageIter array_iter;
+	DBusMessage *reply;
+	char filename[PATH_MAX + 1];
+	struct remote_device_list_t param = {NULL, 0};
+
+	if (!dbus_message_has_signature(msg, DBUS_TYPE_INVALID_AS_STRING))
+		return error_invalid_arguments(conn, msg);
+
+	/* Add Bonded devices to the list */
+	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "linkkeys");
+	textfile_foreach(filename, list_remote_devices_do_append, &param);
+
+	/* Add Last Used devices to the list */
+	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "lastused");
+	textfile_foreach(filename, list_remote_devices_do_append, &param);
+
+	/* Add Last Seen devices to the list */
+	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "lastseen");
+	textfile_foreach(filename, list_remote_devices_do_append, &param);
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &array_iter);
+
+	slist_foreach(param.list, remote_devices_do_append, &array_iter);
+
+	slist_foreach(param.list, (slist_func_t)free, NULL);
+	slist_free(param.list);
+
+	dbus_message_iter_close_container(&iter, &array_iter);
+
+	return send_message_and_unref(conn, reply);
+}
+
+static DBusHandlerResult adapter_list_recent_remote_devices(DBusConnection *conn, DBusMessage *msg, void *data)
+{
+	struct adapter *adapter = data;
+	const char *string;
+	struct tm date;
+	DBusMessageIter iter;
+	DBusMessageIter array_iter;
+	DBusMessage *reply;
+	char filename[PATH_MAX + 1];
+	struct remote_device_list_t param = {NULL, 0};
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_STRING, &string,
+				DBUS_TYPE_INVALID))
+		return error_invalid_arguments(conn, msg);
+
+	if (strptime (string, "%Y-%m-%d %H:%M:%S", &date) == NULL)
+		return error_invalid_arguments(conn, msg);
+	param.time = mktime(&date);
+
+	/* Add Bonded devices to the list */
+	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "linkkeys");
+	textfile_foreach(filename, list_remote_devices_do_append, &param);
+
+	/* Add Last Used devices to the list */
+	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "lastused");
+	textfile_foreach(filename, list_remote_devices_do_append, &param);
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &array_iter);
+
+	slist_foreach(param.list, remote_devices_do_append, &array_iter);
+
+	slist_foreach(param.list, (slist_func_t)free, NULL);
+	slist_free(param.list);
+
+	dbus_message_iter_close_container(&iter, &array_iter);
+
+	return send_message_and_unref(conn, reply);
+}
+
 const char *major_class_str(uint32_t class)
 {
 	uint8_t index = (class >> 8) & 0x1F;
@@ -2746,6 +2868,9 @@
 	{ "DiscoverDevicesWithoutNameResolving",	adapter_discover_devices	},
 	{ "CancelDiscovery",			adapter_cancel_discovery	},
 
+	{ "ListRemoteDevices",				adapter_list_remote_devices		},
+	{ "ListRecentRemoteDevices",		adapter_list_recent_remote_devices		},
+
 	{ NULL, NULL }
 };
 
diff -Naur hcid.orig/dbus-api.txt hcid.new/dbus-api.txt
--- hcid.orig/dbus-api.txt	2006-10-20 18:56:14.000000000 +0200
+++ hcid.new/dbus-api.txt	2006-10-20 18:58:33.000000000 +0200
@@ -789,6 +789,20 @@
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.Failed
 
+		array{string} ListRemoteDevices()
+
+			List device addresses of all known adapters (seen, used or bonded).
+
+			Possible errors: none
+
+		array{string} ListRecentRemoteDevices(string date)
+
+			List device addresses of all used or bonded adapters since date.
+
+			date format is "YYYY-MM-DD HH:MM:SS GMT"
+
+			Possible errors: none
+
 
 Signals		void ModeChanged(string mode)
 

--------------020509090500050207070305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------020509090500050207070305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020509090500050207070305--
