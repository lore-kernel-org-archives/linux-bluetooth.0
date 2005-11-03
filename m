Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0511030532w61ccb889haee2e766a631f618@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net, Claudio Takahasi <cktakahasi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2645_18666737.1131024771222"
Subject: [Bluez-devel] [DBUS PATCH] more cleanup
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
Date: Thu, 3 Nov 2005 11:32:51 -0200

------=_Part_2645_18666737.1131024771222
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Here are some cleanups that I detected when I was reading the last modifica=
tion.

1. Fallback
I changed the return message when the path is not registered.
Currently, the dbus-daemon returns the following message: 'Error
org.freedesktop.DBus.Error.UnknownMethod: Method "Inquiry" with
signature "yy" on interface "org.bluez.Device" doesn't exist'
Now it's returning "Unknow D-Bus path when a client sent a message to
invalid path(the path was unregistered or wrong).

2. msg unref
 It's not necessary check if the message is NULL, this verification is
already done inside the dbus_message_unref.

3. up_adapters removed

4. Added some comments

5. device path checking
   It's not necessary check if the message belongs to the device path
hierarchy because we split the msg_func(msg_func_device and
msg_func_manager)


Regards,
Claudio.

--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_2645_18666737.1131024771222
Content-Type: text/x-patch; name=cleanup.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cleanup.patch"

--- bluez-utils-cvs.orig/hcid/dbus.c	2005-11-03 09:09:02.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-11-03 10:30:10.000000000 -0200
@@ -46,15 +46,11 @@
 
 static DBusConnection *connection;
 static int default_dev = -1;
-static int up_adapters = 0;
 
 #define TIMEOUT				(30 * 1000)	/* 30 seconds */
-#define BLUETOOTH_DEVICE_NAME_LEN	18
-#define BLUETOOTH_DEVICE_ADDR_LEN	18
+#define BTADDR_LEN			18
 #define MAX_PATH_LENGTH			64
-#define READ_REMOTE_NAME_TIMEOUT	25000
 #define MAX_CONN_NUMBER			10
-#define DEVICE_FLAG_NAME		16
 
 #define PINAGENT_SERVICE_NAME BASE_INTERFACE ".PinAgent"
 #define PINAGENT_INTERFACE PINAGENT_SERVICE_NAME
@@ -133,7 +129,7 @@
 	{ BLUEZ_EDBUS_RECORD_NOT_FOUND,	"No record found"		},
 	{ BLUEZ_EDBUS_NO_MEM,		"No memory"			},
 	{ BLUEZ_EDBUS_CONN_NOT_FOUND,	"Connection not found"		},
-	{ BLUEZ_EDBUS_UNKNOWN_PATH,	"Device path is not registered"	},
+	{ BLUEZ_EDBUS_UNKNOWN_PATH,	"Unknown D-BUS path"		},
 	{ 0, NULL }
 };
 
@@ -252,15 +248,10 @@
 };
 
 /*
- * Device Message handler functions object table declaration
+ * Virtual table that handle the object path hierarchy
  */
 static DBusHandlerResult msg_func_device(DBusConnection *conn, DBusMessage *msg, void *data);
 static DBusHandlerResult msg_func_manager(DBusConnection *conn, DBusMessage *msg, void *data);
-
-static DBusMessage* handle_device_up_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_down_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_default_device_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_not_implemented_req(DBusMessage *msg, void *data);
 
 static const DBusObjectPathVTable obj_dev_vtable = {
@@ -273,6 +264,12 @@
 	.unregister_function = NULL
 };
 
+/*
+ * Services provided under the path DEVICE_PATH
+ */
+static DBusMessage* handle_device_up_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_down_req(DBusMessage *msg, void *data);
+
 static const struct service_data device_services[] = {
 	{ DEV_UP,		handle_device_up_req,		DEV_UP_SIGNATURE		},
 	{ DEV_DOWN,		handle_device_down_req,		DEV_DOWN_SIGNATURE		},
@@ -283,9 +280,11 @@
 };
 
 /*
- * Manager Message handler functions object table declaration
- *
+ * Services provided under the path MANAGER_PATH
  */
+static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_default_device_req(DBusMessage *msg, void *data);
+
 static const struct service_data manager_services[] = {
 	{ MGR_DEVICE_LIST,	handle_device_list_req,		MGR_GET_DEV_SIGNATURE		},
 	{ MGR_DEFAULT_DEVICE,	handle_default_device_req,	MGR_DEFAULT_DEV_SIGNATURE	},
@@ -296,8 +295,7 @@
 };
 
 /*
- * HCI Manager Message handler functions object table declaration
- *
+ * HCI D-Bus services
  */
 static DBusHandlerResult hci_signal_filter (DBusConnection *conn, DBusMessage *msg, void *data);
 
@@ -389,7 +387,7 @@
 	data = malloc(sizeof(struct hci_dbus_data));
 	if (data == NULL) {
 		syslog(LOG_ERR, "Failed to alloc memory to DBUS path register data (%s)", path);
-		goto out;
+		goto failed;
 	}
 
 	data->path_id = path_id;
@@ -398,18 +396,18 @@
 	if (fallback) {
 		if (!dbus_connection_register_fallback(connection, path, pvtable, data)) {
 			syslog(LOG_ERR, "DBUS failed to register %s fallback", path);
-			goto out;
+			goto failed;
 		}
 	} else {
 		if (!dbus_connection_register_object_path(connection, path, pvtable, data)) {
 			syslog(LOG_ERR, "DBUS failed to register %s object", path);
-			goto out;
+			goto failed;
 		}
 	}
 
 	ret = TRUE;
 
-out:
+failed:
 	if (!ret && data)
 		free(data);
 
@@ -735,8 +733,7 @@
 	dbus_connection_flush(connection);
 
 failed:
-	if (message)
-		dbus_message_unref(message);
+	dbus_message_unref(message);
 
 	bt_free(local_addr);
 	bt_free(peer_addr);
@@ -902,6 +899,8 @@
 
 	unregister_dbus_path(DEVICE_PATH);
 	unregister_dbus_path(MANAGER_PATH);
+
+	dbus_connection_close(connection);
 }
 
 gboolean hcid_dbus_register_device(uint16_t id) 
@@ -918,7 +917,7 @@
 
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
-		goto out;
+		goto failed;
 	}
 
 	dbus_message_append_args(message,
@@ -927,14 +926,13 @@
 
 	if (!dbus_connection_send(connection, message, NULL)) {
 		syslog(LOG_ERR, "Can't send D-BUS added device message");
-		goto out;
+		goto failed;
 	}
 
 	dbus_connection_flush(connection);
 
-out:
-	if (message)
-		dbus_message_unref(message);
+failed:
+	dbus_message_unref(message);
 
 	ret = register_dbus_path(path, DEVICE_PATH_ID, id, &obj_dev_vtable, FALSE);
 
@@ -957,7 +955,7 @@
 							BLUEZ_MGR_DEV_REMOVED);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
-		goto out;
+		goto failed;
 	}
 
 	dbus_message_append_args(message,
@@ -966,14 +964,13 @@
 
 	if (!dbus_connection_send(connection, message, NULL)) {
 		syslog(LOG_ERR, "Can't send D-BUS added device message");
-		goto out;
+		goto failed;
 	}
 
 	dbus_connection_flush(connection);
 
-out:
-	if (message)
-		dbus_message_unref(message);
+failed:
+	dbus_message_unref(message);
 
 	ret = unregister_device_path(path);
 
@@ -999,8 +996,6 @@
 			goto failed;
 	}
 
-	up_adapters++;
-
 	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
 	message = dbus_message_new_signal(path, DEVICE_INTERFACE, DEV_UP);
@@ -1020,8 +1015,7 @@
 failed:
 	/* if the signal can't be sent ignore the error */
 
-	if (message)
-		dbus_message_unref(message);
+	dbus_message_unref(message);
 
 	return TRUE;
 }
@@ -1040,8 +1034,6 @@
 			syslog(LOG_ERR, "Unregistering profile id %04X failed", ptr->id);
 	}
 
-	up_adapters--;
-
 	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
 	message = dbus_message_new_signal(path, DEVICE_INTERFACE, DEV_DOWN);
@@ -1060,8 +1052,7 @@
 failed:
 	/* if the signal can't be sent ignore the error */
 
-	if (message)
-		dbus_message_unref(message);
+	dbus_message_unref(message);
 
 	return TRUE;
 }
@@ -1114,10 +1105,9 @@
 
 /*****************************************************************
  *  
- *  Section reserved to HCI Manaher D-Bus message handlers
+ *  Section reserved to HCI D-Bus services 
  *  
  *****************************************************************/
-
 static DBusHandlerResult hci_signal_filter (DBusConnection *conn, DBusMessage *msg, void *data)
 {
 	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
@@ -1165,13 +1155,12 @@
 	syslog(LOG_INFO, "%s - path:%s, path_id:%04X dev_id:%04X", __PRETTY_FUNCTION__,
 			path, dbus_data->path_id, dbus_data->dev_id);
 
-	/* Check for message that doesn't belong in this path */
-	if (!(dbus_data->path_id & DEVICE_PATH_MASK))
-		return ret;
-
-	/* Fallback services not currently supported */
-	if (dbus_data->path_id == DEVICE_ROOT_ID)
-		return ret;
+	if (dbus_data->path_id == DEVICE_ROOT_ID) {
+		/* Device is down(path unregistered) or the path is wrong */
+		ret = DBUS_HANDLER_RESULT_HANDLED;
+		error = BLUEZ_EDBUS_UNKNOWN_PATH;
+		goto failed;
+	}
 
 	if (dbus_data->path_id == DEVICE_PATH_ID)
 		handlers = device_services;
@@ -1200,6 +1189,7 @@
 		}
 	}
 
+failed:
 	if (error)
 		reply = bluez_new_failure_msg(msg, error);
 
@@ -1558,7 +1548,7 @@
 	DBusMessageIter iter;
 	DBusMessageIter array_iter;
 	DBusMessageIter  struct_iter;
-	char addr[18];
+	char addr[BTADDR_LEN];
 	const char array_sig[] = HCI_CONN_INFO_STRUCT_SIGNATURE;
 	const char *paddr = addr;
 	struct hci_dbus_data *dbus_data = data;
@@ -1587,6 +1577,11 @@
 	}
 
 	reply = dbus_message_new_method_return(msg);
+	if (reply == NULL) {
+		syslog(LOG_ERR, "Out of memory while calling dbus_message_new_method_return");
+		goto failed;
+	}
+
 	dbus_message_iter_init_append(reply, &iter);
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, array_sig, &array_iter);
 
@@ -1697,7 +1692,7 @@
 
 /*****************************************************************
  *  
- *  Section reserved to Manager D-Bus message handlers
+ *  Section reserved to local device configuration D-Bus Services
  *  
  *****************************************************************/
 static DBusMessage* handle_device_up_req(DBusMessage *msg, void *data)
@@ -1810,13 +1805,18 @@
 
 	/* active bluetooth adapter found */
 	reply = dbus_message_new_method_return(msg);
+	if (reply == NULL) {
+		syslog(LOG_ERR, "Out of memory while calling dbus_message_new_method_return");
+		goto failed;
+	}
+
 	dbus_message_iter_init_append(reply, &iter);
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, array_sig, &array_iter);
 	dr = dl->dev_req;
 
 	for (i = 0; i < dl->dev_num; i++, dr++) {
 		char apath[MAX_PATH_LENGTH];
-		char aaddr[BLUETOOTH_DEVICE_ADDR_LEN];
+		char aaddr[BTADDR_LEN];
 		char *paddr = aaddr;
 		char *ppath = apath;
 		char *ptype;
@@ -1875,6 +1875,11 @@
 	return reply;
 }
 
+/*****************************************************************
+ *  
+ *  Section reserved to Manager D-Bus services
+ *  
+ *****************************************************************/
 static DBusMessage* handle_default_device_req(DBusMessage *msg, void *data) {
 	char path[MAX_PATH_LENGTH];
 	char *pptr = path;
@@ -1882,13 +1887,13 @@
 
 	if (default_dev < 0) {
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-		goto out;
+		goto failed;
 	}
 
 	reply = dbus_message_new_method_return(msg);
 	if (reply == NULL) {
-		syslog(LOG_ERR, "Out of memory while calling new_method_return");
-		goto out;
+		syslog(LOG_ERR, "Out of memory while calling dbus_message_new_method_return");
+		goto failed;
 	}
 
 	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, default_dev);
@@ -1896,7 +1901,7 @@
 					DBUS_TYPE_STRING, &pptr,
 					DBUS_TYPE_INVALID);
 
-out:
+failed:
 	return reply;
 }
 

------=_Part_2645_18666737.1131024771222--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
