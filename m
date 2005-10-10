Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid patch (patch 00.13)
Message-ID: <20051010195850.GA23080@localhost.localdomain>
References: <e1effdeb0510060731s191b17bbrd52897af77622ba6@mail.gmail.com> <1128784148.5212.17.camel@blade> <e1effdeb0510081605p56bcd8fcob8fcd77f616c105d@mail.gmail.com> <1128896442.19569.26.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
In-Reply-To: <1128896442.19569.26.camel@blade>
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
Date: Mon, 10 Oct 2005 22:58:50 +0300


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I took a closer look at the latest D-BUS patch and made a couple of
fixes. A rather severe bug was that only 1 byte was allocated for the
data pointer in the object path functions, but a uint16_t value was
written to it. The attached patch removes the need to allocate this
memory alltogether by typecasting the integer values directly to the
void pointer (perhaps not a very "beautiful" solution, but it works and
simplifies the code quite a lot). The patch also contains some general
cleanup (removal of unecessary typecasts, etc).

Then, about the signals sent for inquiry result and name request. You
currently also send the local BT address in the message parameters.
Isn't that redundant since the local device should be evident from the
object path that the message originates from? I know that the path isn't
currently set properly for these signals, but in the future it probably
should.

Johan

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dbus-cleanup.patch"

Index: dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.18
diff -u -r1.18 dbus.c
--- dbus.c	9 Oct 2005 22:15:22 -0000	1.18
+++ dbus.c	10 Oct 2005 19:48:17 -0000
@@ -178,12 +178,8 @@
 static DBusMessage* handle_not_implemented_req(DBusMessage *msg, void *data);
 
 static const DBusObjectPathVTable obj_vtable = {
-	NULL,
-	&msg_func,
-	NULL,
-	NULL,
-	NULL,
-	NULL
+	.message_function = &msg_func,
+	.unregister_function = NULL
 };
 
 /*
@@ -554,8 +550,6 @@
 gboolean hcid_dbus_init(void)
 {
 	DBusError error;
-	uint16_t *dev_path_id  = (uint16_t *) malloc(1);
-	uint16_t *mgr_path_id  = (uint16_t *) malloc(1);
 
 	dbus_error_init(&error);
 
@@ -578,33 +572,22 @@
 		return FALSE;
 	}
 
-	if (!dev_path_id)
-		return FALSE;
-
-	*dev_path_id = DEVICE_PATH_ID;
-
 	if (!dbus_connection_register_object_path(connection, DEVICE_PATH,
-						&obj_vtable, dev_path_id)) {
+						&obj_vtable, (void *)DEVICE_PATH_ID)) {
 		syslog(LOG_ERR, "Can't register %s object", DEVICE_PATH);
 		return FALSE;
 	}
 
 	syslog(LOG_INFO,"Registered %s object", DEVICE_PATH);
 
-	if (!mgr_path_id)
-		goto done;
-
-	*mgr_path_id = MANAGER_PATH_ID;
-
 	if (!dbus_connection_register_fallback(connection, MANAGER_PATH,
-						&obj_vtable, mgr_path_id)) {
+						&obj_vtable, (void *)MANAGER_PATH_ID)) {
 		syslog(LOG_ERR, "Can't register %s object", MANAGER_PATH);
 		return FALSE;
 	}
 
 	syslog(LOG_INFO, "Registered %s object", MANAGER_PATH);
 
-done:
 	if (!dbus_connection_add_filter(connection, hci_signal_filter, NULL, NULL)) {
 		syslog(LOG_ERR, "Can't add new HCI filter");
 		return FALSE;
@@ -625,32 +608,15 @@
 	char **snd_level = NULL;
 	char *ptr1;
 	char *ptr2;
-	uint16_t *data = NULL;
 
 	if (!connection)
 		return;
 
-	if (dbus_connection_get_object_path_data(connection,
-						DEVICE_PATH, (void *) &data)) {
-		if (data) {
-			free(data);
-			data = NULL;
-		}
-	}
-
 	if (!dbus_connection_unregister_object_path(connection, DEVICE_PATH))
 		syslog(LOG_ERR, "Can't unregister %s object", DEVICE_PATH);
 	else
 		syslog(LOG_INFO, "Unregistered %s object", DEVICE_PATH);
 
-	if (dbus_connection_get_object_path_data(connection,
-						MANAGER_PATH, (void*) &data)) {
-		if (data) {
-			free(data);
-			data = NULL;
-		}
-	}
-
 	if (!dbus_connection_unregister_object_path(connection, MANAGER_PATH))
 		syslog(LOG_ERR, "Can't unregister %s object", MANAGER_PATH);
 	else 
@@ -669,14 +635,6 @@
 
 			syslog(LOG_INFO, "Unregistered %s object", path);
 
-			if (dbus_connection_get_object_path_data(connection,
-							path, (void*) &data)) {
-				if (data) {
-					free(data);
-					data = NULL;
-				}
-			}
-
 			if (!dbus_connection_unregister_object_path(connection, path))
 				syslog(LOG_ERR, "Can't unregister %s object", path);
 
@@ -689,14 +647,6 @@
 
 			syslog(LOG_INFO, "Unregistered %s object", path);
 
-			if (dbus_connection_get_object_path_data(connection,
-							path, (void*) &data)) {
-				if (data) {
-					free(data);
-					data = NULL;
-				}
-			}
-
 			if (!dbus_connection_unregister_object_path(connection, path))
 				syslog(LOG_ERR, "Can't unregister %s object", path);
 		}
@@ -760,31 +710,25 @@
 static int hci_dbus_reg_obj_path(DBusConnection *conn, int dft_reg, uint16_t id)
 {
 	char path[MAX_PATH_LENGTH];
-	uint16_t *ptr_id =  (uint16_t*)malloc(1);
-	uint16_t *ptr_id_dft;
 
 	/* register the default path*/
 	if (!dft_reg) {
-		ptr_id_dft =  (uint16_t*)malloc(1);
-		*ptr_id_dft = DEFAULT_DEVICE_PATH_ID;
 		sprintf(path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
 
 		syslog(LOG_INFO, "registering dft path:%s - id:%d", path, DEFAULT_DEVICE_PATH_ID);
 
-		if (!dbus_connection_register_object_path(conn, path, &obj_vtable, ptr_id_dft)) { 
+		if (!dbus_connection_register_object_path(conn, path, &obj_vtable, (void *)DEFAULT_DEVICE_PATH_ID)) { 
 			syslog(LOG_ERR,"DBUS failed to register %s object", path);
 			/* ignore, the default path was already registered */
 		}
 	}
 
-	*ptr_id = id;
-
 	/* register the default path*/
 	sprintf(path, "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
 
 	syslog(LOG_INFO, "registering  -  path:%s - id:%d",path, id);
 
-	if (!dbus_connection_register_object_path(conn, path, &obj_vtable, ptr_id)) {
+	if (!dbus_connection_register_object_path(conn, path, &obj_vtable, (void *)((uint32_t)id))) {
 		syslog(LOG_ERR,"DBUS failed to register %s object", path);
 		/* ignore, the path was already registered */
 	}
@@ -807,7 +751,6 @@
 	int ret = 0;
 	char path[MAX_PATH_LENGTH];
 	char dft_path[MAX_PATH_LENGTH];
-	uint16_t *data;
 
 	if (unreg_dft) {
 		sprintf(dft_path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
@@ -815,13 +758,6 @@
 		if (!dbus_connection_unregister_object_path (connection, dft_path)) {
 			syslog(LOG_ERR,"DBUS failed to unregister %s object", dft_path);
 			ret = -1;
-		} else {
-			if (dbus_connection_get_object_path_data(conn, dft_path, (void *) &data)) {
-				if (data) {
-					free(data);
-					data = NULL;
-				}
-			}
 		}
 	}
 
@@ -830,13 +766,6 @@
 	if (!dbus_connection_unregister_object_path (connection, path)) {
 		syslog(LOG_ERR,"DBUS failed to unregister %s object", path);
 		ret = -1;
-	} else {
-		if (dbus_connection_get_object_path_data(conn, path, (void *) &data)) {
-			if (data) {
-				free(data);
-				data = NULL;
-			}
-		}
 	}
 
 	return ret;
@@ -897,7 +826,7 @@
 	const char *path;
 	const char *rel_path;
 	const char *tmp_iface = NULL;
-	const uint16_t *udata = (uint16_t *) data;
+	const uint32_t udata = (uint32_t)data;
 	uint32_t result = BLUEZ_EDBUS_UNKNOWN_METHOD;
 	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	uint8_t found = 0;
@@ -908,7 +837,7 @@
 	method = dbus_message_get_member (msg);
 	signature = dbus_message_get_signature(msg);
 
-	syslog (LOG_INFO, "%s - path:%s, udata:0x%X", __PRETTY_FUNCTION__, path, *udata);
+	syslog (LOG_INFO, "%s - path:%s, udata:0x%X", __PRETTY_FUNCTION__, path, udata);
 
 	if (strcmp(path, DEVICE_PATH) == 0) {
 		ptr_handlers = dev_services;
@@ -917,7 +846,7 @@
 	} else {
 		if (strcmp(path, MANAGER_PATH) > 0) {
 			/* it is device specific path */
-			if ( *udata == MANAGER_PATH_ID ) {
+			if ( udata == MANAGER_PATH_ID ) {
 				/* fallback handling. The child path IS NOT registered */
 				reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_UNKNOWN_PATH);
 				ret = DBUS_HANDLER_RESULT_HANDLED;
@@ -989,14 +918,14 @@
 	periodic_inquiry_cp inq_param;
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
-	const uint16_t *udata = (uint16_t *) data;
+	uint32_t udata = (uint32_t)data;
 	uint8_t length;
 	uint8_t max_period;
 	uint8_t min_period;
 	int sock = -1;
 	int dev_id = -1;
 
-	if (*udata == DEFAULT_DEVICE_PATH_ID) {
+	if (udata == DEFAULT_DEVICE_PATH_ID) {
 		if ((dev_id = hci_get_route(NULL)) < 0) {
 			syslog(LOG_ERR, "Bluetooth device is not available");
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
@@ -1004,7 +933,7 @@
 		
 		}
 	} else
-		dev_id = *udata;
+		dev_id = udata;
 
 	if ((sock = hci_open_dev(dev_id)) < 0) {
 		syslog(LOG_ERR, "HCI device open failed");
@@ -1068,18 +997,18 @@
 {
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
-	const uint16_t *udata = (uint16_t *)data;
+	uint32_t udata = (uint32_t)data;
 	int sock = -1;
 	int dev_id = -1;
 
-	if (*udata == DEFAULT_DEVICE_PATH_ID) {
+	if (udata == DEFAULT_DEVICE_PATH_ID) {
 		if ((dev_id = hci_get_route(NULL)) < 0) {
 			syslog(LOG_ERR, "Bluetooth device is not available");
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 			goto failed;
 		}
 	} else
-		dev_id = *udata;
+		dev_id = udata;
 
 	if ((sock = hci_open_dev(dev_id)) < 0) {
 		syslog(LOG_ERR, "HCI device open failed");
@@ -1114,7 +1043,7 @@
 	DBusMessageIter  struct_iter;
 	DBusMessage *reply = NULL;
 	inquiry_info *info = NULL;
-	const uint16_t *udata = (uint16_t *)data;
+	uint32_t udata = (uint32_t)data;
 	const char *paddr = addr;
 	int dev_id = -1;
 	int i;
@@ -1124,14 +1053,14 @@
 	int8_t length;
 	int8_t num_rsp;
 
-	if (*udata == DEFAULT_DEVICE_PATH_ID) {
+	if (udata == DEFAULT_DEVICE_PATH_ID) {
 		if ((dev_id = hci_get_route(NULL)) < 0) {
 			syslog(LOG_ERR, "Bluetooth device is not available");
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 			goto failed;
 		}
 	} else
-		dev_id = *udata;
+		dev_id = udata;
 
 	dbus_message_iter_init(msg, &iter);
 	dbus_message_iter_get_basic(&iter, &length);
@@ -1183,7 +1112,7 @@
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	char *str_bdaddr = NULL;
-	const uint16_t *udata = (uint16_t *)data;
+	const uint32_t udata = (uint32_t)data;
 	bdaddr_t bdaddr;
 	uint8_t role;
 	int dev_id = -1;
@@ -1204,7 +1133,7 @@
 		goto failed;
 	}
 
-	if (*udata != DEFAULT_DEVICE_PATH_ID && *udata != dev_id) {
+	if (udata != DEFAULT_DEVICE_PATH_ID && udata != dev_id) {
 		syslog(LOG_ERR, "Connection not found\n");
 		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
 		goto failed;
@@ -1276,7 +1205,7 @@
 	dl->dev_num = HCI_MAX_DEV;
 	dr = dl->dev_req;
 
-	if (ioctl(sock, HCIGETDEVLIST, (void *) dl) < 0) {
+	if (ioctl(sock, HCIGETDEVLIST, dl) < 0) {
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
@@ -1292,7 +1221,7 @@
 			memset(&di, 0 , sizeof(struct hci_dev_info));
 			di.dev_id = dr->dev_id;
 
-			if (!ioctl(sock, HCIGETDEVINFO, (void *) &di)) {
+			if (!ioctl(sock, HCIGETDEVINFO, &di)) {
 				strcpy(aname, di.name);
 				ba2str(&di.bdaddr, aaddr);
 				dbus_message_iter_open_container(&array_iter, DBUS_TYPE_STRUCT, NULL,

--VS++wcV0S1rZb1Fb--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
