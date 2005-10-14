Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510140530l6055351ak7505758983378586@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_11354_8413446.1129293048161"
Subject: [Bluez-devel] [DBUS-PATCH] list registered paths
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
Date: Fri, 14 Oct 2005 09:30:48 -0300

------=_Part_11354_8413446.1129293048161
Content-Type: multipart/alternative;
	boundary="----=_Part_11355_6426821.1129293048161"

------=_Part_11355_6426821.1129293048161
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

The attached patch implements the service for list the registered paths
under the path /org/bluez/Manager.

The message request signature can be:
1. ListPaths() - list all paths under /org/bluez/Manager
2. ListPaths(String), The string is the relative path. eg: "hci0", "default=
"
- list all paths provided by one adapter

Other minor changes:
- removed some logs
- added verification for dbus_connection_list_registered function. It can
return FALSE if there is no memory
to allocate the child entries


Regards,
Claudio.


--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_11355_6426821.1129293048161
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
The attached patch implements the service for list the registered paths und=
er the path /org/bluez/Manager.<br>
<br>
The message request signature can be:<br>
1. ListPaths() - list all paths under /org/bluez/Manager<br>
2. ListPaths(String), The string is the relative path. eg: &quot;hci0&quot;=
, &quot;default&quot; - list all paths provided by one adapter<br>
<br>
Other minor changes:<br>
- removed some logs<br>
- added verification for dbus_connection_list_registered function. It can r=
eturn FALSE if there is no memory <br>
&nbsp; to allocate the child entries<br>
&nbsp;&nbsp; <br>
<br>
Regards,<br>
Claudio.<br>
<br clear=3D"all"><br>-- <br>----------------------------------------------=
-----------<br>Claudio Takahasi<br>Nokia's Institute of Technology - INdT<b=
r><a href=3D"mailto:claudio.takahasi@indt.org.br">claudio.takahasi@indt.org=
.br
</a><br>


------=_Part_11355_6426821.1129293048161--

------=_Part_11354_8413446.1129293048161
Content-Type: application/octet-stream; name=list_paths_01.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="list_paths_01.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2005-10-13 10:13:28.000000000 -0300
+++ bluez-utils-cvs-hcid/hcid/dbus.h	2005-10-13 16:07:38.000000000 -0300
@@ -30,8 +30,10 @@
  
 #define __END_SIG__ DBUS_TYPE_INVALID_AS_STRING
 
+#define BLUEZ_BUS_NAME		"org.bluez"
+
 #define BASE_PATH		"/org/bluez"
-#define BASE_INTERFACE		"org.bluez"
+#define BASE_INTERFACE		BLUEZ_BUS_NAME	
 
 #define DEVICE_PATH		BASE_PATH "/Device"
 #define DEVICE_INTERFACE	BASE_INTERFACE ".Device"
@@ -91,7 +93,7 @@
  /* ===== Manager definitions, services under DEVICE_PATH ===== */
 #define MGR_GET_DEV			"DeviceList"
 #define MGR_INIT			"Init"
-
+#define MGR_LIST_PATHS			"ListPaths"
 /* Enable/Disable services controller, pan, serial, ... */
 #define MGR_ENABLE			"Enable"
 #define MGR_DISABLE			"Disable"
@@ -99,6 +101,9 @@
 //signatures
 #define MGR_GET_DEV_SIGNATURE			__END_SIG__
 
+#define MGR_LIST_ALL_PATHS_SIGNATURE		__END_SIG__
+#define MGR_LIST_DEV_PATHS_SIGNATURE		DBUS_TYPE_STRING_AS_STRING\
+						__END_SIG__
 /* yya(ss)*/
 #define MGR_GET_DEV_REPLY_SIGNATURE		DBUS_TYPE_BYTE_AS_STRING\
 						DBUS_TYPE_BYTE_AS_STRING\
@@ -106,6 +111,10 @@
 						HCI_DEVICE_STRUCT_SIGNATURE\
 						__END_SIG__
 
+#define MGR_LIST_PATHS_REPLY_SIGNATURE		DBUS_TYPE_ARRAY_AS_STRING\
+						DBUS_TYPE_STRING_AS_STRING\
+						__END_SIG__
+
 /* ===== HCI definitions ===== */
 #define BLUEZ_HCI			"Controller"
 #define BLUEZ_HCI_PATH			MANAGER_PATH "/" BLUEZ_HCI
--- bluez-utils-cvs.orig/hcid/dbus.c	2005-10-14 08:13:43.000000000 -0300
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-10-14 09:16:47.000000000 -0300
@@ -181,6 +181,7 @@
 static DBusHandlerResult msg_func(DBusConnection *conn, DBusMessage *msg, void *data);
 
 static DBusMessage* handle_get_devices_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_list_paths_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_not_implemented_req(DBusMessage *msg, void *data);
 
 static const DBusObjectPathVTable obj_vtable = {
@@ -206,11 +207,13 @@
  *
  */
 static const struct service_data mgr_services[] = {
-	{ MGR_GET_DEV,		handle_get_devices_req,		MGR_GET_DEV_SIGNATURE	},
-	{ MGR_INIT,		handle_not_implemented_req,	NULL			},
-	{ MGR_ENABLE,		handle_not_implemented_req,	NULL			},
-	{ MGR_DISABLE,		handle_not_implemented_req,	NULL			},
-	{ NULL,			handle_not_implemented_req,	NULL			}
+	{ MGR_GET_DEV,		handle_get_devices_req,		MGR_GET_DEV_SIGNATURE		},
+	{ MGR_INIT,		handle_not_implemented_req,	NULL				},
+	{ MGR_ENABLE,		handle_not_implemented_req,	NULL				},
+	{ MGR_LIST_PATHS,	handle_list_paths_req,		MGR_LIST_ALL_PATHS_SIGNATURE	},
+	{ MGR_LIST_PATHS,	handle_list_paths_req,		MGR_LIST_DEV_PATHS_SIGNATURE	},
+	{ MGR_DISABLE,		handle_not_implemented_req,	NULL				},
+	{ NULL,			handle_not_implemented_req,	NULL				}
 };
 
 /*
@@ -631,8 +634,6 @@
 		return FALSE;
 	}
 
-	syslog(LOG_INFO,"Registered %s object", DEVICE_PATH);
-
 	data = malloc(sizeof(struct hci_dbus_data));
 	if (data == NULL)
 		return FALSE;
@@ -645,8 +646,6 @@
 		return FALSE;
 	}
 
-	syslog(LOG_INFO, "Registered %s object", MANAGER_PATH);
-
 	if (!dbus_connection_add_filter(connection, hci_signal_filter, NULL, NULL)) {
 		syslog(LOG_ERR, "Can't add new HCI filter");
 		return FALSE;
@@ -673,7 +672,7 @@
 		return;
 
 	if (dbus_connection_get_object_path_data(connection,
-						DEVICE_PATH, &data)) {
+				DEVICE_PATH, &data)) {
 		if (data) {
 			free(data);
 			data = NULL;
@@ -682,11 +681,9 @@
 
 	if (!dbus_connection_unregister_object_path(connection, DEVICE_PATH))
 		syslog(LOG_ERR, "Can't unregister %s object", DEVICE_PATH);
-	else
-		syslog(LOG_INFO, "Unregistered %s object", DEVICE_PATH);
 
 	if (dbus_connection_get_object_path_data(connection,
-						MANAGER_PATH, &data)) {
+				MANAGER_PATH, &data)) {
 		if (data) {
 			free(data);
 			data = NULL;
@@ -695,60 +692,56 @@
 
 	if (!dbus_connection_unregister_object_path(connection, MANAGER_PATH))
 		syslog(LOG_ERR, "Can't unregister %s object", MANAGER_PATH);
-	else
-		syslog(LOG_INFO, "Unregistered %s object", MANAGER_PATH);
-
-	dbus_connection_list_registered(connection, fst_parent, &fst_level);
 
-	for (; *fst_level; fst_level++) {
-		ptr1 = *fst_level;
-		sprintf(snd_parent, "%s/%s", fst_parent, ptr1);
+	if (dbus_connection_list_registered(connection, fst_parent, &fst_level)) {
 
-		dbus_connection_list_registered(connection, snd_parent, &snd_level);
+		for (; *fst_level; fst_level++) {
+			ptr1 = *fst_level;
+			sprintf(snd_parent, "%s/%s", fst_parent, ptr1);
 
-		if (!(*snd_level)) {
-			sprintf(path, "%s/%s", MANAGER_PATH, ptr1);
+			if (dbus_connection_list_registered(connection, snd_parent, &snd_level)) {
 
-			syslog(LOG_INFO, "Unregistered %s object", path);
+				if (!(*snd_level)) {
+					sprintf(path, "%s/%s", MANAGER_PATH, ptr1);
 
-			if (dbus_connection_get_object_path_data(connection,
+					if (dbus_connection_get_object_path_data(connection,
 								path, &data)) {
-				if (data) {
-					free(data);
-					data = NULL;
-				}
-			}
-
-			if (!dbus_connection_unregister_object_path(connection, path))
-				syslog(LOG_ERR, "Can't unregister %s object", path);
+						if (data) {
+							free(data);
+							data = NULL;
+						}
+					}
 
-			continue;
-		}
+					if (!dbus_connection_unregister_object_path(connection, path))
+						syslog(LOG_ERR, "Can't unregister %s object", path);
 
-		for (; *snd_level; snd_level++) {
-			ptr2 = *snd_level;
-			sprintf(path, "%s/%s/%s", MANAGER_PATH, ptr1, ptr2);
+					continue;
+				}
 
-			syslog(LOG_INFO, "Unregistered %s object", path);
+				for (; *snd_level; snd_level++) {
+					ptr2 = *snd_level;
+					sprintf(path, "%s/%s/%s", MANAGER_PATH, ptr1, ptr2);
 
-			if (dbus_connection_get_object_path_data(connection,
+					if (dbus_connection_get_object_path_data(connection,
 								path, &data)) {
-				if (data) {
-					free(data);
-					data = NULL;
+						if (data) {
+							free(data);
+							data = NULL;
+						}
+					}
+
+					if (!dbus_connection_unregister_object_path(connection, path))
+						syslog(LOG_ERR, "Can't unregister %s object", path);
 				}
-			}
 
-			if (!dbus_connection_unregister_object_path(connection, path))
-				syslog(LOG_ERR, "Can't unregister %s object", path);
+				if (*snd_level)
+					dbus_free_string_array(snd_level);
+			}
 		}
 
-		if (*snd_level)
-			dbus_free_string_array(snd_level);
+		if (*fst_level)
+			dbus_free_string_array(fst_level);
 	}
-
-	if (*fst_level)
-		dbus_free_string_array(fst_level);
 }
 
 gboolean hcid_dbus_register_device(uint16_t id)
@@ -806,9 +799,8 @@
 
 	/* register the default path*/
 	if (!dft_reg) {
-		sprintf(path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
 
-		syslog(LOG_INFO, "registering dft path:%s - id:%d", path, DEFAULT_DEVICE_PATH_ID);
+		sprintf(path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
 
 		data = malloc(sizeof(struct hci_dbus_data));
 		if (data == NULL)
@@ -831,8 +823,6 @@
 	/* register the default path*/
 	sprintf(path, "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
 
-	syslog(LOG_INFO, "registering  -  path:%s - id:%d",path, id);
-
 	if (!dbus_connection_register_object_path(conn, path, &obj_vtable, data)) {
 		syslog(LOG_ERR,"DBUS failed to register %s object", path);
 		/* ignore, the path was already registered */
@@ -859,8 +849,9 @@
 	void *data = NULL;
 
 	if (unreg_dft) {
+
 		sprintf(dft_path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
-		syslog(LOG_INFO, "%s - unregistering dft:%s", __PRETTY_FUNCTION__, dft_path);
+
 		if (!dbus_connection_unregister_object_path (connection, dft_path)) {
 			syslog(LOG_ERR,"DBUS failed to unregister %s object", dft_path);
 			ret = -1;
@@ -875,7 +866,7 @@
 	}
 
 	sprintf(path, "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
-	syslog(LOG_INFO, "%s - unregistering spec:%s", __PRETTY_FUNCTION__, path);
+
 	if (!dbus_connection_unregister_object_path (connection, path)) {
 		syslog(LOG_ERR,"DBUS failed to unregister %s object", path);
 		ret = -1;
@@ -1315,7 +1306,6 @@
 			reply = dbus_message_new_method_return(msg);
 			dbus_message_iter_init_append(reply, &iter);
 			dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &pname);
-			syslog(LOG_INFO, "Remote Name: %s", pname);
 		} else {
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		}
@@ -1410,7 +1400,7 @@
 
 /*****************************************************************
  *  
- *  Section reserved to Device D-Bus message handlers
+ *  Section reserved to Manager D-Bus message handlers
  *  
  *****************************************************************/
 
@@ -1492,6 +1482,98 @@
 	return reply;
 }
 
+static DBusMessage* handle_list_paths_req(DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter;
+	DBusMessageIter array_iter;
+	DBusMessage *reply = NULL;
+	const char *rel_path;
+	char parent_path[MAX_PATH_LENGTH];
+	char dev_path[MAX_PATH_LENGTH];
+	char abs_path[MAX_PATH_LENGTH];
+	const char array_sig[] = DBUS_TYPE_STRING_AS_STRING; 
+	char **fst_level;
+	char **snd_level;
+	const char *pabs_path = abs_path;
+	uint32_t result = BLUEZ_EDBUS_NO_MEM; 
+
+	if (strcmp(MGR_LIST_DEV_PATHS_SIGNATURE, dbus_message_get_signature(msg)) == 0) {
+
+		/* The device was informed, list all services provided by one device */
+
+		dbus_message_iter_init(msg, &iter);
+		dbus_message_iter_get_basic(&iter, &rel_path);
+
+		sprintf(parent_path, "%s/%s" , MANAGER_PATH, rel_path);
+		if (dbus_connection_list_registered(connection, parent_path, &fst_level)) {
+
+			result = 0; /* success */
+
+			reply = dbus_message_new_method_return(msg);
+			dbus_message_iter_init_append(reply, &iter);
+			dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, array_sig, &array_iter);
+
+			for ( ; *fst_level; fst_level++) {
+				sprintf(abs_path, "%s/%s", parent_path, *fst_level);
+				dbus_message_iter_append_basic(&array_iter, DBUS_TYPE_STRING , &pabs_path);
+			}
+
+			dbus_message_iter_close_container(&iter, &array_iter);
+
+			if (*fst_level)
+				dbus_free_string_array(fst_level);
+		}
+
+	} else {
+		/* The path is relative. It is not possible use an recursive 
+		 * call because the function returns only one level of the path*/
+		sprintf(parent_path, "%s" , MANAGER_PATH);
+
+		reply = dbus_message_new_method_return(msg);
+		dbus_message_iter_init_append(reply, &iter);
+		dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, array_sig, &array_iter);
+
+		if (dbus_connection_list_registered(connection, parent_path, &fst_level)) {
+			for ( ; *fst_level; fst_level++) {
+				sprintf(dev_path, "%s/%s", parent_path, *fst_level);
+				if (dbus_connection_list_registered(connection, dev_path, &snd_level)) {
+
+					result = 0; /* success */
+
+					for ( ; *snd_level; snd_level++) {
+						sprintf(abs_path, "%s/%s", dev_path, *snd_level);
+						dbus_message_iter_append_basic(&array_iter, DBUS_TYPE_STRING , &pabs_path);
+					}
+
+					if (*snd_level)
+						dbus_free_string_array(snd_level);
+				} else {
+					result = BLUEZ_EDBUS_NO_MEM;
+					goto failed;
+				}
+
+			}
+
+			if (*fst_level)
+				dbus_free_string_array(fst_level);
+		}
+
+		dbus_message_iter_close_container(&iter, &array_iter);
+	}
+
+failed:
+	if (result) {
+		/* free the reply when an error is detected */
+		if (reply)
+			dbus_message_unref(reply);
+
+		reply = bluez_new_failure_msg(msg, result);
+	}
+
+	return reply;
+}
+
+
 static DBusMessage* handle_not_implemented_req(DBusMessage *msg, void *data) 
 {
 	const char *path = dbus_message_get_path(msg);

------=_Part_11354_8413446.1129293048161--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
