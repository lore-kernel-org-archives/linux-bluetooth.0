Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid patch (remote name and connections)
Message-ID: <20051011192801.GA12571@localhost.localdomain>
References: <e1effdeb0510110726k15f2bdx405606b1f6d3a297@mail.gmail.com> <1129053693.8229.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
In-Reply-To: <1129053693.8229.1.camel@localhost.localdomain>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 11 Oct 2005 22:28:01 +0300


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 11, 2005, Marcel Holtmann wrote:
> let's wait until Johan finished his patch to remove the bad pointer
> versus integer casting.

Here you go. The idea was to wait for Claudio's new patch to be applied
first, but I guess we can do it in this order also. Btw, I haven't
tested the patch too much, but at least it compiles without warnings and
seems to run also withough any problems. The patch also changes the
dbus_watch stuff to use dynamically allocated memory instead of the
integer-pointer cast it was doing earlier.

Johan

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dbus-struct.patch"

Index: dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.20
diff -u -r1.20 dbus.c
--- dbus.c	11 Oct 2005 10:13:10 -0000	1.20
+++ dbus.c	11 Oct 2005 19:05:56 -0000
@@ -77,6 +77,10 @@
 	const char             *signature;
 };
 
+struct hci_dbus_data {
+	uint16_t id;
+};
+
 typedef int register_function_t(DBusConnection *conn, int dft_reg, uint16_t id);
 typedef int unregister_function_t(DBusConnection *conn, int unreg_dft, uint16_t id);
 
@@ -507,12 +511,16 @@
 {
 	GIOCondition cond = G_IO_HUP | G_IO_ERR;
 	GIOChannel *io;
-	gulong id;
+	guint *id;
 	int fd, flags;
 
 	if (!dbus_watch_get_enabled(watch))
 		return TRUE;
 
+	id = malloc(sizeof(guint));
+	if (id == NULL)
+		return FALSE;
+
 	fd = dbus_watch_get_fd(watch);
 	io = g_io_channel_unix_new(fd);
 	flags = dbus_watch_get_flags(watch);
@@ -520,21 +528,23 @@
 	if (flags & DBUS_WATCH_READABLE) cond |= G_IO_IN;
 	if (flags & DBUS_WATCH_WRITABLE) cond |= G_IO_OUT;
 
-	id = (gulong) g_io_add_watch(io, cond, watch_func, watch);
+	*id = g_io_add_watch(io, cond, watch_func, watch);
 
-	dbus_watch_set_data(watch, (void *) id, NULL);
+	dbus_watch_set_data(watch, id, NULL);
 
 	return TRUE;
 }
 
 static void remove_watch(DBusWatch *watch, void *data)
 {
-	gulong id = (gulong) dbus_watch_get_data(watch);
+	guint *id = dbus_watch_get_data(watch);
 
 	dbus_watch_set_data(watch, NULL, NULL);
 
-	if (id)
-		g_io_remove_watch((guint) id);
+	if (id) {
+		g_io_remove_watch(*id);
+		free(id);
+	}
 }
 
 static void watch_toggled(DBusWatch *watch, void *data)
@@ -549,6 +559,7 @@
 
 gboolean hcid_dbus_init(void)
 {
+	struct hci_dbus_data *data;
 	DBusError error;
 
 	dbus_error_init(&error);
@@ -572,16 +583,28 @@
 		return FALSE;
 	}
 
+	data = malloc(sizeof(struct hci_dbus_data));
+	if (data == NULL)
+		return FALSE;
+
+	data->id = DEVICE_PATH_ID;
+
 	if (!dbus_connection_register_object_path(connection, DEVICE_PATH,
-						&obj_vtable, (void *)DEVICE_PATH_ID)) {
+						&obj_vtable, data)) {
 		syslog(LOG_ERR, "Can't register %s object", DEVICE_PATH);
 		return FALSE;
 	}
 
 	syslog(LOG_INFO,"Registered %s object", DEVICE_PATH);
 
+	data = malloc(sizeof(struct hci_dbus_data));
+	if (data == NULL)
+		return FALSE;
+
+	data->id = MANAGER_PATH_ID;
+
 	if (!dbus_connection_register_fallback(connection, MANAGER_PATH,
-						&obj_vtable, (void *)MANAGER_PATH_ID)) {
+						&obj_vtable, data)) {
 		syslog(LOG_ERR, "Can't register %s object", MANAGER_PATH);
 		return FALSE;
 	}
@@ -608,15 +631,32 @@
 	char **snd_level = NULL;
 	char *ptr1;
 	char *ptr2;
+	void *data = NULL;
 
 	if (!connection)
 		return;
 
+	if (dbus_connection_get_object_path_data(connection,
+						DEVICE_PATH, &data)) {
+		if (data) {
+			free(data);
+			data = NULL;
+		}
+	}
+
 	if (!dbus_connection_unregister_object_path(connection, DEVICE_PATH))
 		syslog(LOG_ERR, "Can't unregister %s object", DEVICE_PATH);
 	else
 		syslog(LOG_INFO, "Unregistered %s object", DEVICE_PATH);
 
+	if (dbus_connection_get_object_path_data(connection,
+						MANAGER_PATH, &data)) {
+		if (data) {
+			free(data);
+			data = NULL;
+		}
+	}
+
 	if (!dbus_connection_unregister_object_path(connection, MANAGER_PATH))
 		syslog(LOG_ERR, "Can't unregister %s object", MANAGER_PATH);
 	else
@@ -635,6 +675,14 @@
 
 			syslog(LOG_INFO, "Unregistered %s object", path);
 
+			if (dbus_connection_get_object_path_data(connection,
+								path, &data)) {
+				if (data) {
+					free(data);
+					data = NULL;
+				}
+			}
+
 			if (!dbus_connection_unregister_object_path(connection, path))
 				syslog(LOG_ERR, "Can't unregister %s object", path);
 
@@ -647,6 +695,14 @@
 
 			syslog(LOG_INFO, "Unregistered %s object", path);
 
+			if (dbus_connection_get_object_path_data(connection,
+								path, &data)) {
+				if (data) {
+					free(data);
+					data = NULL;
+				}
+			}
+
 			if (!dbus_connection_unregister_object_path(connection, path))
 				syslog(LOG_ERR, "Can't unregister %s object", path);
 		}
@@ -709,6 +765,7 @@
  */
 static int hci_dbus_reg_obj_path(DBusConnection *conn, int dft_reg, uint16_t id)
 {
+	struct hci_dbus_data *data;
 	char path[MAX_PATH_LENGTH];
 
 	/* register the default path*/
@@ -723,12 +780,18 @@
 		}
 	}
 
+	data = malloc(sizeof(struct hci_dbus_data));
+	if (data == NULL)
+		return -1;
+
+	data->id = id;
+
 	/* register the default path*/
 	sprintf(path, "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
 
 	syslog(LOG_INFO, "registering  -  path:%s - id:%d",path, id);
 
-	if (!dbus_connection_register_object_path(conn, path, &obj_vtable, (void *) ((long) id))) {
+	if (!dbus_connection_register_object_path(conn, path, &obj_vtable, data)) {
 		syslog(LOG_ERR,"DBUS failed to register %s object", path);
 		/* ignore, the path was already registered */
 	}
@@ -751,6 +814,7 @@
 	int ret = 0;
 	char path[MAX_PATH_LENGTH];
 	char dft_path[MAX_PATH_LENGTH];
+	void *data = NULL;
 
 	if (unreg_dft) {
 		sprintf(dft_path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
@@ -758,6 +822,13 @@
 		if (!dbus_connection_unregister_object_path (connection, dft_path)) {
 			syslog(LOG_ERR,"DBUS failed to unregister %s object", dft_path);
 			ret = -1;
+		} else {
+			if (dbus_connection_get_object_path_data(conn, dft_path, &data)) {
+				if (data) {
+					free(data);
+					data = NULL;
+				}
+			}
 		}
 	}
 
@@ -766,6 +837,13 @@
 	if (!dbus_connection_unregister_object_path (connection, path)) {
 		syslog(LOG_ERR,"DBUS failed to unregister %s object", path);
 		ret = -1;
+	} else {
+		if (dbus_connection_get_object_path_data(conn, path, &data)) {
+			if (data) {
+				free(data);
+				data = NULL;
+			}
+		}
 	}
 
 	return ret;
@@ -826,7 +904,7 @@
 	const char *path;
 	const char *rel_path;
 	const char *tmp_iface = NULL;
-	long udata = (long) data;
+	struct hci_dbus_data *dbus_data = data;
 	uint32_t result = BLUEZ_EDBUS_UNKNOWN_METHOD;
 	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	uint8_t found = 0;
@@ -837,7 +915,7 @@
 	method = dbus_message_get_member (msg);
 	signature = dbus_message_get_signature(msg);
 
-	syslog (LOG_INFO, "%s - path:%s, udata:0x%X", __PRETTY_FUNCTION__, path, (guint) udata);
+	syslog (LOG_INFO, "%s - path:%s, id:0x%X", __PRETTY_FUNCTION__, path, dbus_data->id);
 
 	if (strcmp(path, DEVICE_PATH) == 0) {
 		ptr_handlers = dev_services;
@@ -846,7 +924,7 @@
 	} else {
 		if (strcmp(path, MANAGER_PATH) > 0) {
 			/* it is device specific path */
-			if ( udata == MANAGER_PATH_ID ) {
+			if ( dbus_data->id == MANAGER_PATH_ID ) {
 				/* fallback handling. The child path IS NOT registered */
 				reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_UNKNOWN_PATH);
 				ret = DBUS_HANDLER_RESULT_HANDLED;
@@ -918,14 +996,14 @@
 	periodic_inquiry_cp inq_param;
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
-	long udata = (long) data;
+	struct hci_dbus_data *dbus_data = data;
 	uint8_t length;
 	uint8_t max_period;
 	uint8_t min_period;
 	int sock = -1;
 	int dev_id = -1;
 
-	if (udata == DEFAULT_DEVICE_PATH_ID) {
+	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
 		if ((dev_id = hci_get_route(NULL)) < 0) {
 			syslog(LOG_ERR, "Bluetooth device is not available");
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
@@ -933,7 +1011,7 @@
 		
 		}
 	} else
-		dev_id = (int) udata;
+		dev_id =  dbus_data->id;
 
 	if ((sock = hci_open_dev(dev_id)) < 0) {
 		syslog(LOG_ERR, "HCI device open failed");
@@ -997,18 +1075,18 @@
 {
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
-	long udata = (long) data;
+	struct hci_dbus_data *dbus_data = data;
 	int sock = -1;
 	int dev_id = -1;
 
-	if (udata == DEFAULT_DEVICE_PATH_ID) {
+	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
 		if ((dev_id = hci_get_route(NULL)) < 0) {
 			syslog(LOG_ERR, "Bluetooth device is not available");
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 			goto failed;
 		}
 	} else
-		dev_id = (int) udata;
+		dev_id = dbus_data->id;
 
 	if ((sock = hci_open_dev(dev_id)) < 0) {
 		syslog(LOG_ERR, "HCI device open failed");
@@ -1043,7 +1121,7 @@
 	DBusMessageIter  struct_iter;
 	DBusMessage *reply = NULL;
 	inquiry_info *info = NULL;
-	long udata = (long) data;
+	struct hci_dbus_data *dbus_data = data;
 	const char *paddr = addr;
 	int dev_id = -1;
 	int i;
@@ -1053,14 +1131,14 @@
 	int8_t length;
 	int8_t num_rsp;
 
-	if (udata == DEFAULT_DEVICE_PATH_ID) {
+	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
 		if ((dev_id = hci_get_route(NULL)) < 0) {
 			syslog(LOG_ERR, "Bluetooth device is not available");
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 			goto failed;
 		}
 	} else
-		dev_id = (int) udata;
+		dev_id = dbus_data->id;
 
 	dbus_message_iter_init(msg, &iter);
 	dbus_message_iter_get_basic(&iter, &length);
@@ -1112,7 +1190,7 @@
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	char *str_bdaddr = NULL;
-	long udata = (long) data;
+	struct hci_dbus_data *dbus_data = data;
 	bdaddr_t bdaddr;
 	uint8_t role;
 	int dev_id = -1;
@@ -1133,7 +1211,7 @@
 		goto failed;
 	}
 
-	if (udata != DEFAULT_DEVICE_PATH_ID && udata != dev_id) {
+	if (dbus_data->id != DEFAULT_DEVICE_PATH_ID && dbus_data->id != dev_id) {
 		syslog(LOG_ERR, "Connection not found\n");
 		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
 		goto failed;

--envbJBWh7q8WU6mo--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
