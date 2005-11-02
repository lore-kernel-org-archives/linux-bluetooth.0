Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051102153212.GA11188@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Subject: [Bluez-devel] [PATCH] Better D-BUS path tracking
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
Date: Wed, 2 Nov 2005 17:32:12 +0200


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch introduces a new path_id field to the hci_dbus_data struct as
well as renames the id field to dev_id. This allows more accurate path
identification in the callback functions. It also removes the need to do
hard-to-follow string manipulations to find out the child path component.

Johan

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="path-id.patch"

Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.41
diff -u -r1.41 dbus.c
--- hcid/dbus.c	1 Nov 2005 19:49:49 -0000	1.41
+++ hcid/dbus.c	2 Nov 2005 15:22:50 -0000
@@ -75,7 +75,8 @@
 };
 
 struct hci_dbus_data {
-	uint16_t id;
+	uint16_t dev_id;
+	uint16_t path_id;
 };
 
 typedef int register_function_t(DBusConnection *conn, uint16_t id);
@@ -89,9 +90,7 @@
 typedef const struct service_data *get_svc_table_func_t(void);
 
 struct profile_obj_path_data {
-	const char		*name;
-	int			status; /* 1:active  0:disabled */
-	int			dft_reg; /* dft path registered */
+	uint16_t		id;
 	register_function_t	*reg_func;
 	unregister_function_t	*unreg_func;
 	get_svc_table_func_t	*get_svc_table; /* return the service table */
@@ -247,9 +246,9 @@
  *
  */
 static struct profile_obj_path_data obj_path_table[] = {
-	{ BLUEZ_HCI, 1, 0, hci_dbus_reg_obj_path, hci_dbus_unreg_obj_path, get_hci_table },
+	{ HCI_PATH_ID, hci_dbus_reg_obj_path, hci_dbus_unreg_obj_path, get_hci_table },
 	/* add other profiles here */
-	{ NULL, 0, 0, NULL, NULL, NULL }
+	{ INVALID_PATH_ID, NULL, NULL, NULL }
 };
 
 /*
@@ -379,7 +378,8 @@
 	free(req);
 }
 
-static gboolean register_dbus_path(const char *path, uint16_t id, const DBusObjectPathVTable *pvtable)
+static gboolean register_dbus_path(const char *path, uint16_t path_id, uint16_t dev_id,
+				const DBusObjectPathVTable *pvtable, gboolean fallback)
 {
 	struct hci_dbus_data *data;
 
@@ -391,12 +391,21 @@
 		return FALSE;
 	}
 
-	data->id = id;
+	data->path_id = path_id;
+	data->dev_id = dev_id;
 
-	if (!dbus_connection_register_object_path(connection, path, pvtable, data)) {
-		syslog(LOG_ERR,"DBUS failed to register %s object", path);
-		free(data);
-		return FALSE;
+	if (fallback) {
+		if (!dbus_connection_register_fallback(connection, path, pvtable, data)) {
+			syslog(LOG_ERR,"DBUS failed to register %s object", path);
+			free(data);
+			return FALSE;
+		}
+	} else {
+		if (!dbus_connection_register_object_path(connection, path, pvtable, data)) {
+			syslog(LOG_ERR,"DBUS failed to register %s object", path);
+			free(data);
+			return FALSE;
+		}
 	}
 
 	return TRUE;
@@ -835,7 +844,6 @@
 
 gboolean hcid_dbus_init(void)
 {
-	struct hci_dbus_data *data;
 	DBusError error;
 
 	dbus_error_init(&error);
@@ -859,29 +867,13 @@
 		return FALSE;
 	}
 
-	data = malloc(sizeof(struct hci_dbus_data));
-	if (data == NULL)
-		return FALSE;
-
-	data->id = DEVICE_PATH_ID;
-
-	if (!dbus_connection_register_fallback(connection, DEVICE_PATH,
-						&obj_dev_vtable, data)) {
-		syslog(LOG_ERR, "Can't register %s object", DEVICE_PATH);
-		return FALSE;
-	}
-
-	data = malloc(sizeof(struct hci_dbus_data));
-	if (data == NULL)
+	if (!register_dbus_path(DEVICE_PATH, DEVICE_ROOT_ID, INVALID_DEV_ID,
+				&obj_dev_vtable, TRUE))
 		return FALSE;
 
-	data->id = MANAGER_PATH_ID;
-
-	if (!dbus_connection_register_object_path(connection, MANAGER_PATH,
-						&obj_mgr_vtable, data)) {
-		syslog(LOG_ERR, "Can't register %s object", MANAGER_PATH);
+	if (!register_dbus_path(MANAGER_PATH, MANAGER_ROOT_ID, INVALID_DEV_ID,
+				&obj_mgr_vtable, FALSE))
 		return FALSE;
-	}
 
 	if (!dbus_connection_add_filter(connection, hci_signal_filter, NULL, NULL)) {
 		syslog(LOG_ERR, "Can't add new HCI filter");
@@ -953,7 +945,7 @@
 	if (message)
 		dbus_message_unref(message);
 
-	ret = register_dbus_path(path, id, &obj_dev_vtable);
+	ret = register_dbus_path(path, DEVICE_PATH_ID, id, &obj_dev_vtable, FALSE);
 
 	if (ret && default_dev < 0)
 		default_dev = id;
@@ -1011,7 +1003,7 @@
 	if (!connection)
 		return FALSE;
 
-	for (; ptr->name; ptr++) {
+	for (; ptr->id != INVALID_PATH_ID; ptr++) {
 		if (ptr->reg_func(connection, id) < 0)
 			goto failed;
 	}
@@ -1052,7 +1044,7 @@
 	if (!connection)
 		return FALSE;
 
-	for (; ptr->name; ptr++) {
+	for (; ptr->id != INVALID_PATH_ID; ptr++) {
 		if (ptr->unreg_func(connection, id) < 0)
 			goto failed;
 	}
@@ -1097,7 +1089,7 @@
 
 	/* register the default path*/
 	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
-	if (!register_dbus_path(path, id, &obj_dev_vtable))
+	if (!register_dbus_path(path, HCI_PATH_ID, id, &obj_dev_vtable, FALSE))
 		return -1;
 
 	return 0;
@@ -1170,7 +1162,6 @@
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
 	int type;
-	const char *child;
 	const char *iface;
 	const char *method;
 	const char *signature;
@@ -1184,27 +1175,25 @@
 	method = dbus_message_get_member(msg);
 	signature = dbus_message_get_signature(msg);
 
-	syslog(LOG_INFO, "%s - path:%s, id:%04X", __PRETTY_FUNCTION__, path, dbus_data->id);
+	syslog(LOG_INFO, "%s - path:%s, path_id:%04X dev_id:%04X", __PRETTY_FUNCTION__,
+			path, dbus_data->path_id, dbus_data->dev_id);
 
-	if (dbus_data->id == DEVICE_PATH_ID)
+	/* Check for message that doesn't belong in this path */
+	if (!(dbus_data->path_id & DEVICE_PATH_MASK))
 		return ret;
 
-	if (strcmp(path, DEVICE_PATH) == 0)
+	/* Fallback services not currently supported */
+	if (dbus_data->path_id == DEVICE_ROOT_ID)
+		return ret;
+
+	if (dbus_data->path_id == DEVICE_PATH_ID)
 		handlers = device_services;
 	else {
-		child = strrchr(path,'/');
-		if (child && *child) {
-			struct profile_obj_path_data *profile;
-			child++;
-			if (!strncmp(child, "hci", 3)) {
-				handlers = device_services;
-			} else {
-				for (profile = obj_path_table; profile->name != NULL; profile++) {
-					if (strcmp(profile->name, child) == 0) {
-						handlers = profile->get_svc_table();
-						break;
-					}
-				}
+		struct profile_obj_path_data *profile;
+		for (profile = obj_path_table; profile->id != INVALID_PATH_ID; profile++) {
+			if (profile->id == dbus_data->path_id) {
+				handlers = profile->get_svc_table();
+				break;
 			}
 		}
 	}
@@ -1298,7 +1287,7 @@
 	uint8_t min_period;
 	int dd = -1;
 
-	dd = hci_open_dev(dbus_data->id);
+	dd = hci_open_dev(dbus_data->dev_id);
 	if (dd < 0) {
 		syslog(LOG_ERR, "HCI device open failed");
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
@@ -1359,7 +1348,7 @@
 	struct hci_dbus_data *dbus_data = data;
 	int dd = -1;
 
-	dd = hci_open_dev(dbus_data->id);
+	dd = hci_open_dev(dbus_data->dev_id);
 	if (dd < 0) {
 		syslog(LOG_ERR, "HCI device open failed");
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
@@ -1403,9 +1392,9 @@
 		goto failed;
 	}
 
-	dd = hci_open_dev(dbus_data->id);
+	dd = hci_open_dev(dbus_data->dev_id);
 	if (dd < 0) {
-		syslog(LOG_ERR, "Unable to open device %d: %s", dbus_data->id, strerror(errno));
+		syslog(LOG_ERR, "Unable to open device %d: %s", dbus_data->dev_id, strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
@@ -1448,9 +1437,10 @@
 	struct hci_dbus_data *dbus_data = data;
 	int dd = -1;
 
-	dd = hci_open_dev(dbus_data->id);
+	dd = hci_open_dev(dbus_data->dev_id);
 	if (dd < 0) {
-		syslog(LOG_ERR, "Unable to open device %d: %s", dbus_data->id, strerror(errno));
+		syslog(LOG_ERR, "Unable to open device %d: %s",
+				dbus_data->dev_id, strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
@@ -1499,7 +1489,7 @@
 		goto failed;
 	}
 
-	if (dbus_data->id != dev_id) {
+	if (dbus_data->dev_id != dev_id) {
 		syslog(LOG_ERR, "Connection not found\n");
 		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
 		goto failed;
@@ -1544,9 +1534,10 @@
 
 	str2ba(str_bdaddr, &bdaddr);
 
-	dd = hci_open_dev(dbus_data->id);
+	dd = hci_open_dev(dbus_data->dev_id);
 	if (dd < 0) {
-		syslog(LOG_ERR, "Unable to open device %d: %s", dbus_data->id, strerror(errno));
+		syslog(LOG_ERR, "Unable to open device %d: %s",
+				dbus_data->dev_id, strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
@@ -1606,7 +1597,7 @@
 		goto failed;
 	}
 
-	cl->dev_id = dbus_data->id;
+	cl->dev_id = dbus_data->dev_id;
 	cl->conn_num = MAX_CONN_NUMBER;
 	ci = cl->conn_info;
 
@@ -1669,7 +1660,7 @@
 		goto failed;
 	}
 
-	if (dbus_data->id != dev_id) {
+	if (dbus_data->dev_id != dev_id) {
 		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
 		goto failed;
 	}
@@ -1712,6 +1703,8 @@
 		goto failed;
 	}
 
+	reply = dbus_message_new_method_return(msg);
+
 failed:
 	if (dd >= 0)
 		close(dd);
@@ -1743,20 +1736,20 @@
 		goto failed;
 	}
 
-	if (ioctl(sk, HCIDEVUP, dbus_data->id) < 0 && errno != EALREADY) {
+	if (ioctl(sk, HCIDEVUP, dbus_data->dev_id) < 0 && errno != EALREADY) {
 		syslog(LOG_ERR, "Can't init device hci%d: %s (%d)\n",
-			dbus_data->id, strerror(errno), errno);
+			dbus_data->dev_id, strerror(errno), errno);
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
 
 	if (ioctl(sk, HCIGETDEVINFO, (void *) &di) >= 0 &&
 					!hci_test_bit(HCI_RAW, &di.flags)) {
-		dr.dev_id  = dbus_data->id;
+		dr.dev_id  = dbus_data->dev_id;
 		dr.dev_opt = SCAN_PAGE | SCAN_INQUIRY; /* piscan */
 		if (ioctl(sk, HCISETSCAN, (unsigned long) &dr) < 0) {
 			syslog(LOG_ERR, "Can't set scan mode on hci%d: %s (%d)\n",
-					dbus_data->id, strerror(errno), errno);
+					dbus_data->dev_id, strerror(errno), errno);
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 			goto failed;
 		}
@@ -1785,9 +1778,9 @@
 		goto failed;
 	}
 
-	if (ioctl(sk, HCIDEVDOWN, dbus_data->id) < 0) {
+	if (ioctl(sk, HCIDEVDOWN, dbus_data->dev_id) < 0) {
 		syslog(LOG_ERR, "Can't down device hci%d: %s (%d)\n",
-					dbus_data->id, strerror(errno), errno);
+					dbus_data->dev_id, strerror(errno), errno);
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
Index: hcid/dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.12
diff -u -r1.12 dbus.h
--- hcid/dbus.h	1 Nov 2005 16:41:24 -0000	1.12
+++ hcid/dbus.h	2 Nov 2005 15:22:50 -0000
@@ -34,8 +34,23 @@
 
 #define ERROR_INTERFACE		BASE_INTERFACE ".Error"
 
-#define MANAGER_PATH_ID		(0xFFFF)
-#define DEVICE_PATH_ID		(0xFFFE)
+#define MANAGER_PATH_MASK	(1 << 15)
+#define DEVICE_PATH_MASK	(1 << 14)
+
+/* /org/bluez/Manager */
+#define MANAGER_ROOT_ID		MANAGER_PATH_MASK
+
+/* /org/bluez/Device */
+#define DEVICE_ROOT_ID		DEVICE_PATH_MASK
+
+/* E.g. /org/bluez/Device/hci0 */
+#define DEVICE_PATH_ID		(DEVICE_PATH_MASK | 0x0001)
+
+/* E.g. /org/bluez/Device/hci0/Controller */
+#define HCI_PATH_ID		(DEVICE_PATH_MASK | 0x0002)
+
+#define INVALID_PATH_ID		0xFFFF
+#define INVALID_DEV_ID		0xFFFF
 
 /*======================================================================== 
     BlueZ D-Bus Manager service definitions "/org/bluez/Manager"

--7JfCtLOvnd9MIVvH--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
