Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Some thoughts on the current D-BUS interface
Message-ID: <20051101155447.GA26044@localhost.localdomain>
References: <20051031224006.GA14057@localhost.localdomain> <1130799900.31561.38.camel@blade> <20051031233610.GA14937@localhost.localdomain> <e1effdeb0511010433x11bbef22q8648e30b565cf41c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
In-Reply-To: <e1effdeb0511010433x11bbef22q8648e30b565cf41c@mail.gmail.com>
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
Date: Tue, 1 Nov 2005 17:54:47 +0200


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's the patch which implements the interface redesign. The change
ended up being a little bigger than I originally thought, but I think
the code and interface become more understandable this way. Attached is
also a simple python app which tests the DeviceList and DefaultDevice
methods. I've also updated the pygtk test app to work with the new
interface:
http://www.iki.fi/~jhedberg/bluez-python/

On Tue, Nov 01, 2005, Claudio Takahasi wrote:
> Considering that local and remote configuration tasks will be
> available under the same path, we need change the child path
> register/unregister action. When a device is turned DOWN the path
> can't be unregistered anymore.  We can use the attribute "status" of
> the struct "profile_obj_path_data" to control this. I think this
> attribute was initially added with this purpose :)
> Any comment? Does someone has another suggestion?

My idea is that we would use paths such as "/org/bluez/Device/hci0" for
the Up/Down stuff as well as other device configuration. The
"/org/bluez/Device/hci0/Controller" path in turn is used for the other
things and it us unregistered/registered during Down/Up events.

Johan

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dbus-path.patch"

Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.39
diff -u -r1.39 dbus.c
--- hcid/dbus.c	31 Oct 2005 15:39:14 -0000	1.39
+++ hcid/dbus.c	1 Nov 2005 15:45:02 -0000
@@ -45,15 +45,16 @@
 #include "dbus.h"
 
 static DBusConnection *connection;
+static int default_dev = -1;
 static int up_adapters = 0;
 
-#define TIMEOUT (30 * 1000)		/* 30 seconds */
-#define BLUETOOTH_DEVICE_NAME_LEN    (18)
-#define BLUETOOTH_DEVICE_ADDR_LEN    (18)
-#define MAX_PATH_LENGTH   (64)
-#define READ_REMOTE_NAME_TIMEOUT	(25000)
-#define MAX_CONN_NUMBER			(10)
-#define DEVICE_FLAG_NAME		(16)
+#define TIMEOUT				(30 * 1000)	/* 30 seconds */
+#define BLUETOOTH_DEVICE_NAME_LEN	18
+#define BLUETOOTH_DEVICE_ADDR_LEN	18
+#define MAX_PATH_LENGTH			64
+#define READ_REMOTE_NAME_TIMEOUT	25000
+#define MAX_CONN_NUMBER			10
+#define DEVICE_FLAG_NAME		16
 
 #define PINAGENT_SERVICE_NAME BASE_INTERFACE ".PinAgent"
 #define PINAGENT_INTERFACE PINAGENT_SERVICE_NAME
@@ -77,13 +78,13 @@
 	uint16_t id;
 };
 
-typedef int register_function_t(DBusConnection *conn, int dft_reg, uint16_t id);
-typedef int unregister_function_t(DBusConnection *conn, int unreg_dft, uint16_t id);
+typedef int register_function_t(DBusConnection *conn, uint16_t id);
+typedef int unregister_function_t(DBusConnection *conn, uint16_t id);
 
 const struct service_data *get_hci_table(void);
 
-static int hci_dbus_reg_obj_path(DBusConnection *conn, int dft_reg, uint16_t id);
-static int hci_dbus_unreg_obj_path(DBusConnection *conn, int unreg_dft, uint16_t id);
+static int hci_dbus_reg_obj_path(DBusConnection *conn, uint16_t id);
+static int hci_dbus_unreg_obj_path(DBusConnection *conn, uint16_t id);
 
 typedef const struct service_data *get_svc_table_func_t(void);
 
@@ -257,8 +258,8 @@
 static DBusHandlerResult msg_func_device(DBusConnection *conn, DBusMessage *msg, void *data);
 static DBusHandlerResult msg_func_manager(DBusConnection *conn, DBusMessage *msg, void *data);
 
-static DBusMessage* handle_get_devices_req_device(DBusMessage *msg, void *data);
-static DBusMessage* handle_get_devices_req_manager(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_default_device_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_not_implemented_req(DBusMessage *msg, void *data);
 
 static const DBusObjectPathVTable obj_dev_vtable = {
@@ -271,16 +272,7 @@
 	.unregister_function = NULL
 };
 
-/*
- * Service provided under the path DEVICE_PATH
- * TODO add the handlers
- */
-static const struct service_data dev_root_services[] = {
-	{ DEV_GET_DEV,		handle_get_devices_req_device,	DEV_GET_DEV_SIGNATURE		},
-	{ NULL, NULL, NULL}
-};
-
-static const struct service_data dev_services[] = {
+static const struct service_data device_services[] = {
 	{ DEV_UP,		handle_not_implemented_req,	DEV_UP_SIGNATURE		},
 	{ DEV_DOWN,		handle_not_implemented_req,	DEV_DOWN_SIGNATURE		},
 	{ DEV_RESET,		handle_not_implemented_req,	DEV_RESET_SIGNATURE		},
@@ -293,11 +285,12 @@
  * Manager Message handler functions object table declaration
  *
  */
-static const struct service_data mgr_services[] = {
-	{ MGR_GET_DEV,		handle_get_devices_req_manager,	MGR_GET_DEV_SIGNATURE	},
-	{ MGR_INIT,		handle_not_implemented_req,	NULL			},
-	{ MGR_ENABLE,		handle_not_implemented_req,	NULL			},
-	{ MGR_DISABLE,		handle_not_implemented_req,	NULL			},
+static const struct service_data manager_services[] = {
+	{ MGR_DEVICE_LIST,	handle_device_list_req,		MGR_GET_DEV_SIGNATURE		},
+	{ MGR_DEFAULT_DEVICE,	handle_default_device_req,	MGR_DEFAULT_DEV_SIGNATURE	},
+	{ MGR_INIT,		handle_not_implemented_req,	NULL				},
+	{ MGR_ENABLE,		handle_not_implemented_req,	NULL				},
+	{ MGR_DISABLE,		handle_not_implemented_req,	NULL				},
 	{ NULL, NULL, NULL }
 };
 
@@ -316,7 +309,7 @@
 static DBusMessage* handle_display_conn_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_auth_req(DBusMessage *msg, void *data);
 
-static const struct service_data hci_services[] = {
+static const struct service_data device_hci_services[] = {
 	{ HCI_PERIODIC_INQ,		handle_periodic_inq_req,	HCI_PERIODIC_INQ_SIGNATURE		},
 	{ HCI_CANCEL_PERIODIC_INQ,	handle_cancel_periodic_inq_req,	HCI_CANCEL_PERIODIC_INQ_SIGNATURE	},
 	{ HCI_ROLE_SWITCH,		handle_role_switch_req,		HCI_ROLE_SWITCH_SIGNATURE		},
@@ -384,7 +377,7 @@
 	free(req);
 }
 
-static gboolean register_dbus_path(char *path, uint16_t id, const DBusObjectPathVTable *pvtable)
+static gboolean register_dbus_path(const char *path, uint16_t id, const DBusObjectPathVTable *pvtable)
 {
 	struct hci_dbus_data *data;
 	syslog(LOG_INFO,"Registering DBUS Path: %s", path);
@@ -403,7 +396,7 @@
 	return TRUE;
 }
 
-static gboolean unregister_dbus_path(char *path)
+static gboolean unregister_dbus_path(const char *path)
 {
 	void *data;
 	syslog(LOG_INFO,"Unregistering DBUS Path: %s", path);
@@ -477,10 +470,9 @@
 		goto failed;
 	}
 
-	snprintf(path, sizeof(path), "%s/hci%d/%s", MANAGER_PATH, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
 
-	message = dbus_message_new_signal(path,
-				BLUEZ_HCI_INTERFACE, BLUEZ_HCI_INQ_START);
+	message = dbus_message_new_signal(path, DEV_HCI_INTERFACE, BLUEZ_HCI_INQ_START);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS inquiry start message");
 		goto failed;
@@ -517,10 +509,10 @@
 		goto failed;
 	}
 
-	snprintf(path, sizeof(path), "%s/hci%d/%s", MANAGER_PATH, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
 
 	message = dbus_message_new_signal(path,
-				BLUEZ_HCI_INTERFACE, BLUEZ_HCI_INQ_COMPLETE);
+				DEV_HCI_INTERFACE, BLUEZ_HCI_INQ_COMPLETE);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
 		goto failed;
@@ -560,10 +552,10 @@
 		goto failed;
 	}
 
-	snprintf(path, sizeof(path), "%s/hci%d/%s", MANAGER_PATH, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
 
 	message = dbus_message_new_signal(path,
-				BLUEZ_HCI_INTERFACE, BLUEZ_HCI_INQ_RESULT);
+				DEV_HCI_INTERFACE, BLUEZ_HCI_INQ_RESULT);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS inquiry result message");
 		goto failed;
@@ -608,10 +600,10 @@
 		goto failed;
 	}
 
-	snprintf(path, sizeof(path), "%s/hci%d/%s", MANAGER_PATH, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
 
 	message = dbus_message_new_signal(path,
-				BLUEZ_HCI_INTERFACE, BLUEZ_HCI_REMOTE_NAME);
+				DEV_HCI_INTERFACE, BLUEZ_HCI_REMOTE_NAME);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
 		goto failed;
@@ -655,10 +647,10 @@
 		goto failed;
 	}
 
-	snprintf(path, sizeof(path), "%s/hci%d/%s", MANAGER_PATH, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
 
 	message = dbus_message_new_signal(path,
-				BLUEZ_HCI_INTERFACE, BLUEZ_HCI_REMOTE_NAME_FAILED);
+				DEV_HCI_INTERFACE, BLUEZ_HCI_REMOTE_NAME_FAILED);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
 		goto failed;
@@ -710,9 +702,9 @@
 		goto failed;
 	}
 
-	snprintf(path, sizeof(path), "%s/hci%d/%s", MANAGER_PATH, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
 
-	message = dbus_message_new_signal(path, BLUEZ_HCI_INTERFACE, BLUEZ_HCI_AUTH_COMPLETE);
+	message = dbus_message_new_signal(path, DEV_HCI_INTERFACE, BLUEZ_HCI_AUTH_COMPLETE);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
 		goto failed;
@@ -810,6 +802,26 @@
 		remove_watch(watch, data);
 }
 
+static gboolean unregister_device_path(const char *path)
+{
+	char **children = NULL;
+
+	if (dbus_connection_list_registered(connection, path, &children)) {
+		for (; *children; children++) {
+			char child_path[MAX_PATH_LENGTH];
+
+			snprintf(child_path, sizeof(child_path), "%s/%s", path, *children);
+
+			unregister_dbus_path(child_path);
+		}
+
+		if (*children)
+			dbus_free_string_array(children);
+	}
+
+	return unregister_dbus_path(path);
+}
+
 gboolean hcid_dbus_init(void)
 {
 	struct hci_dbus_data *data;
@@ -854,7 +866,7 @@
 
 	data->id = MANAGER_PATH_ID;
 
-	if (!dbus_connection_register_fallback(connection, MANAGER_PATH,
+	if (!dbus_connection_register_object_path(connection, MANAGER_PATH,
 						&obj_mgr_vtable, data)) {
 		syslog(LOG_ERR, "Can't register %s object", MANAGER_PATH);
 		return FALSE;
@@ -873,149 +885,137 @@
 
 void hcid_dbus_exit(void)
 {
-	char path[MAX_PATH_LENGTH];
-	char fst_parent[] = MANAGER_PATH;
-	char snd_parent[MAX_PATH_LENGTH];
-	char **fst_level = NULL;
-	char **snd_level = NULL;
-	char *ptr1;
-	char *ptr2;
-	void *data = NULL;
+	char **children = NULL;
 
 	if (!connection)
 		return;
 
-	if (dbus_connection_get_object_path_data(connection,
-				DEVICE_PATH, &data)) {
-		if (data) {
-			free(data);
-			data = NULL;
-		}
-	}
+	/* Unregister all paths in Device path hierarchy */
+	if (dbus_connection_list_registered(connection, DEVICE_PATH, &children)) {
+
+		for (; *children; children++) {
+			char dev_path[MAX_PATH_LENGTH];
 
-	if (!dbus_connection_unregister_object_path(connection, DEVICE_PATH))
-		syslog(LOG_ERR, "Can't unregister %s object", DEVICE_PATH);
+			snprintf(dev_path, sizeof(dev_path), "%s/%s", DEVICE_PATH, *children);
 
-	if (dbus_connection_get_object_path_data(connection,
-				MANAGER_PATH, &data)) {
-		if (data) {
-			free(data);
-			data = NULL;
+			unregister_device_path(dev_path);
 		}
+
+		if (*children)
+			dbus_free_string_array(children);
 	}
 
-	if (!dbus_connection_unregister_object_path(connection, MANAGER_PATH))
-		syslog(LOG_ERR, "Can't unregister %s object", MANAGER_PATH);
+	unregister_dbus_path(DEVICE_PATH);
+	unregister_dbus_path(MANAGER_PATH);
 
-	if (dbus_connection_list_registered(connection, fst_parent, &fst_level)) {
+}
 
-		for (; *fst_level; fst_level++) {
-			ptr1 = *fst_level;
-			snprintf(snd_parent, sizeof(snd_parent), "%s/%s", fst_parent, ptr1);
+gboolean hcid_dbus_register_device(uint16_t id) 
+{
+	char path[MAX_PATH_LENGTH];
+	char *pptr = path;
+	gboolean ret;
+	DBusMessage *message = NULL;
 
-			if (dbus_connection_list_registered(connection, snd_parent, &snd_level)) {
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
-				if (!(*snd_level)) {
-					snprintf(path, sizeof(path), "%s/%s", MANAGER_PATH, ptr1);
+	message = dbus_message_new_signal(MANAGER_PATH, MANAGER_INTERFACE,
+					BLUEZ_MGR_DEV_ADDED);
 
-					if (dbus_connection_get_object_path_data(connection,
-								path, &data)) {
-						if (data) {
-							free(data);
-							data = NULL;
-						}
-					}
+	if (message == NULL) {
+		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
+		goto out;
+	}
 
-					if (!dbus_connection_unregister_object_path(connection, path))
-						syslog(LOG_ERR, "Can't unregister %s object", path);
+	dbus_message_append_args(message,
+			DBUS_TYPE_STRING, &pptr,
+			DBUS_TYPE_INVALID);
 
-					continue;
-				}
+	if (!dbus_connection_send(connection, message, NULL)) {
+		syslog(LOG_ERR, "Can't send D-BUS added device message");
+		goto out;
+	}
 
-				for (; *snd_level; snd_level++) {
-					ptr2 = *snd_level;
-					snprintf(path, sizeof(path), "%s/%s/%s", MANAGER_PATH, ptr1, ptr2);
-
-					if (dbus_connection_get_object_path_data(connection,
-								path, &data)) {
-						if (data) {
-							free(data);
-							data = NULL;
-						}
-					}
+	dbus_connection_flush(connection);
 
-					if (!dbus_connection_unregister_object_path(connection, path))
-						syslog(LOG_ERR, "Can't unregister %s object", path);
-				}
+out:
+	if (message)
+		dbus_message_unref(message);
 
-				if (*snd_level)
-					dbus_free_string_array(snd_level);
-			}
-		}
+	ret = register_dbus_path(path, id, &obj_dev_vtable);
 
-		if (*fst_level)
-			dbus_free_string_array(fst_level);
-	}
+	if (ret && default_dev < 0)
+		default_dev = id;
+
+	return ret;
 }
 
-gboolean hcid_dbus_register_device(uint16_t id) 
+gboolean hcid_dbus_unregister_device(uint16_t id)
 {
+	gboolean ret;
+	DBusMessage *message = NULL;
 	char path[MAX_PATH_LENGTH];
-	char dev[BLUETOOTH_DEVICE_NAME_LEN];
-	const char *pdev = dev;
+	char *pptr = path;
 
-	snprintf(dev, sizeof(dev), HCI_DEVICE_NAME "%d", id);
-	snprintf(path, sizeof(path), "%s/%s", DEVICE_PATH, pdev);
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
-	/* register the default path*/
-	return register_dbus_path(path, id, &obj_dev_vtable);
-}
+	message = dbus_message_new_signal(MANAGER_PATH, MANAGER_INTERFACE,
+					BLUEZ_MGR_DEV_REMOVED);
+	if (message == NULL) {
+		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
+		goto out;
+	}
 
-gboolean hcid_dbus_unregister_device(uint16_t id)
-{
-	char dev[BLUETOOTH_DEVICE_NAME_LEN];
-	char path[MAX_PATH_LENGTH];
-	const char *pdev = dev;
+	dbus_message_append_args(message,
+			DBUS_TYPE_STRING, &pptr,
+			DBUS_TYPE_INVALID);
 
-	snprintf(dev, sizeof(dev), HCI_DEVICE_NAME "%d", id);
-	snprintf(path, sizeof(path), "%s/%s", DEVICE_PATH, pdev);
+	if (!dbus_connection_send(connection, message, NULL)) {
+		syslog(LOG_ERR, "Can't send D-BUS added device message");
+		goto out;
+	}
 
-	return unregister_dbus_path(path);
+	dbus_connection_flush(connection);
+
+out:
+	if (message)
+		dbus_message_unref(message);
+
+	ret = unregister_device_path(path);
+
+	/* FIXME: If there are any devices left after this removal the default
+	 * device should be changed to one of them */
+	if (ret && default_dev == id)
+		default_dev = -1;
+
+	return ret;
 }
 
-gboolean hcid_dbus_register_manager(uint16_t id)
+gboolean hcid_dbus_dev_up(uint16_t id)
 {
-	char dev[BLUETOOTH_DEVICE_NAME_LEN];
+	char path[MAX_PATH_LENGTH];
 	struct profile_obj_path_data *ptr = obj_path_table;
 	DBusMessage *message = NULL;
-	const char *pdev = dev;
-	DBusMessageIter iter;
-	int ret = -1; 
 
 	if (!connection)
 		return FALSE;
 
 	for (; ptr->name; ptr++) {
-		ret = ptr->reg_func(connection, ptr->dft_reg, id);
-		ptr->dft_reg = 1;
+		if (ptr->reg_func(connection, id) < 0)
+			goto failed;
 	}
 
-	if (!ret)
-		up_adapters++;
+	up_adapters++;
+
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
-	message = dbus_message_new_signal(BLUEZ_HCI_PATH,
-			BLUEZ_HCI_INTERFACE, BLUEZ_HCI_DEV_ADDED);
+	message = dbus_message_new_signal(path, DEVICE_INTERFACE, DEV_UP);
 
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
 		goto failed;
 	}
 
-	snprintf(dev, sizeof(dev), HCI_DEVICE_NAME "%d", id);
-
-	dbus_message_iter_init_append(message, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING ,&pdev);
-
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {
 		syslog(LOG_ERR, "Can't send D-BUS added device message");
 		goto failed;
@@ -1032,40 +1032,30 @@
 	return TRUE;
 }
 
-gboolean hcid_dbus_unregister_manager(uint16_t id)
+gboolean hcid_dbus_dev_down(uint16_t id)
 {
-	char dev[BLUETOOTH_DEVICE_NAME_LEN];
+	char path[MAX_PATH_LENGTH];
 	struct profile_obj_path_data *ptr = obj_path_table;
 	DBusMessage *message = NULL;
-	const char *pdev = dev;
-	DBusMessageIter iter;
-	int dft_unreg = 0;
 
 	if (!connection)
 		return FALSE;
 
 	for (; ptr->name; ptr++) {
-		dft_unreg = (up_adapters > 1) ? 0 : 1;
-		up_adapters--;
-		ptr->unreg_func(connection, dft_unreg, id);
-
-		if (dft_unreg )
-			ptr->dft_reg = 0;
+		if (ptr->unreg_func(connection, id) < 0)
+			goto failed;	
 	}
 
-	message = dbus_message_new_signal(BLUEZ_HCI_PATH,
-			BLUEZ_HCI_INTERFACE, BLUEZ_HCI_DEV_REMOVED);
+	up_adapters--;
 
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
+
+	message = dbus_message_new_signal(path, DEVICE_INTERFACE, DEV_DOWN); 
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS device removed  message");
 		goto failed;
 	}
 
-	snprintf(dev, sizeof(dev), HCI_DEVICE_NAME "%d", id);
-
-	dbus_message_iter_init_append(message, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING ,&pdev);
-
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {
 		syslog(LOG_ERR, "Can't send D-BUS removed device message");
 		goto failed;
@@ -1087,23 +1077,17 @@
  * Detailed description: function responsible for register a new hci 
  * D-Bus path. If necessary the default path must be registered too.
  * @param conn D-Bus connection
- * @param dft_reg register the default path(0 or !0)
  * @param id hci device identification
  * @return (0-Success/-1 failure)
  */
-static int hci_dbus_reg_obj_path(DBusConnection *conn, int dft_reg, uint16_t id)
+static int hci_dbus_reg_obj_path(DBusConnection *conn, uint16_t id)
 {
 	char path[MAX_PATH_LENGTH];
 
 	/* register the default path*/
-	if (!dft_reg) {
-		snprintf(path, sizeof(path), "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
-		register_dbus_path(path, DEFAULT_DEVICE_PATH_ID, &obj_mgr_vtable);
-	}
-
-	/* register the default path*/
-	snprintf(path, sizeof(path), "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
-	register_dbus_path(path, id, &obj_mgr_vtable);
+	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
+	if (!register_dbus_path(path, id, &obj_dev_vtable))
+		return -1;
 
 	return 0;
 }
@@ -1118,25 +1102,20 @@
  * @param id hci device identification
  * @return (0-Success/-1 failure)
  */
-static int hci_dbus_unreg_obj_path(DBusConnection *conn, int unreg_dft, uint16_t id) 
+static int hci_dbus_unreg_obj_path(DBusConnection *conn, uint16_t id) 
 {
-	int ret = 0;
 	char path[MAX_PATH_LENGTH];
 
-	if (unreg_dft) {
-		snprintf(path, sizeof(path), "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
-		unregister_dbus_path(path);
-	}
+	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
+	if (!unregister_dbus_path(path))
+		return -1;
 
-	snprintf(path, sizeof(path), "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
-	unregister_dbus_path(path);
-
-	return ret;
+	return 0;
 }
 
 const struct service_data *get_hci_table(void)
 {
-	return hci_services;
+	return device_hci_services;
 }
 
 /*****************************************************************
@@ -1173,24 +1152,20 @@
 
 	return ret;
 }
-/*
- * There is only one message handler function for all object paths
- *
- */
 
 static DBusHandlerResult msg_func_device(DBusConnection *conn, DBusMessage *msg, void *data)
 {
-	const struct service_data *ptr_handlers = NULL;
+	const struct service_data *handlers = NULL;
 	DBusMessage *reply = NULL;
+	struct hci_dbus_data *dbus_data = data;
 	int type;
+	const char *child;
 	const char *iface;
 	const char *method;
 	const char *signature;
 	const char *path;
-	struct hci_dbus_data *dbus_data = data;
-	uint32_t result = BLUEZ_EDBUS_UNKNOWN_METHOD;
+	uint32_t error = BLUEZ_EDBUS_UNKNOWN_METHOD;
 	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-	uint8_t found = 0;
 
 	path = dbus_message_get_path(msg);
 	type = dbus_message_get_type(msg);
@@ -1198,50 +1173,48 @@
 	method = dbus_message_get_member(msg);
 	signature = dbus_message_get_signature(msg);
 
-	if (strcmp(iface, DEVICE_INTERFACE))
-		return ret;
+	syslog(LOG_INFO, "%s - path:%s, id:%04X", __PRETTY_FUNCTION__, path, dbus_data->id);
 
-	if (strcmp(path, DEVICE_PATH) > 0) {
-		if (dbus_data->id == DEVICE_PATH_ID) {
-			/* fallback handling. The child path IS NOT registered */
-			reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_UNKNOWN_PATH);
-			ret = DBUS_HANDLER_RESULT_HANDLED;
-		} else {
-			/* hciX code */
-		}
-	} else {
-		/* it's the device path */
-		ptr_handlers = dev_root_services;
-		found = 1;
-	}
-
-	if (found && (type == DBUS_MESSAGE_TYPE_METHOD_CALL) && (method != NULL)) {
-
-		for (; ptr_handlers->name; ptr_handlers++) {
-			if (strcmp(method, ptr_handlers->name) == 0) {
-				/* resetting unknown method. It's possible handle method overload */
-				result = BLUEZ_EDBUS_WRONG_SIGNATURE; 
-				if (strcmp(ptr_handlers->signature, signature) == 0) {
-					if (ptr_handlers->handler_func) {
-						reply = (ptr_handlers->handler_func) (msg, data);
-						result = 0; /* resetting wrong signature*/
-					} else
-						syslog(LOG_INFO, "Service not implemented");
+	if (dbus_data->id == DEVICE_PATH_ID)
+		return ret;
 
+	if (strcmp(path, DEVICE_PATH) == 0)
+		handlers = device_services;
+	else {
+		child = strrchr(path,'/');
+		if (child && *child) {
+			struct profile_obj_path_data *profile;
+			child++;
+
+			for (profile = obj_path_table ;profile->name != NULL; profile++) {
+				if (strcmp(profile->name, child) == 0) {
+					handlers = profile->get_svc_table();
 					break;
 				}
-				
 			}
-		}
 
-		if (result) {
-			reply = bluez_new_failure_msg(msg, result);
 		}
+	}
+
+	if (handlers) {
+		for (; handlers->name != NULL; handlers++) {
+			if (strcmp(handlers->name, method) == 0) {
+				if (strcmp(handlers->signature, signature) != 0)
+					error = BLUEZ_EDBUS_WRONG_SIGNATURE;
+				else {
+					reply = handlers->handler_func(msg, data);
+					error = 0;
+				}
 
-		ret = DBUS_HANDLER_RESULT_HANDLED;
+				ret = DBUS_HANDLER_RESULT_HANDLED;
+			}
+		}
 	}
 
-	/* send an error or the success reply*/
+	if (error)
+		reply = bluez_new_failure_msg(msg, error);
+
+
 	if (reply) {
 		if (!dbus_connection_send (conn, reply, NULL)) {
 			syslog(LOG_ERR, "Can't send reply message!");
@@ -1254,88 +1227,45 @@
 
 static DBusHandlerResult msg_func_manager(DBusConnection *conn, DBusMessage *msg, void *data)
 {
-	const struct service_data *ptr_handlers = NULL;
+	const struct service_data *handlers;
 	DBusMessage *reply = NULL;
-	int type;
 	const char *iface;
 	const char *method;
 	const char *signature;
 	const char *path;
-	const char *rel_path;
-	struct hci_dbus_data *dbus_data = data;
-	uint32_t result = BLUEZ_EDBUS_UNKNOWN_METHOD;
+	uint32_t error = BLUEZ_EDBUS_UNKNOWN_METHOD;
 	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-	uint8_t found = 0;
 
 	path = dbus_message_get_path(msg);
-	type = dbus_message_get_type(msg);
 	iface = dbus_message_get_interface(msg);
 	method = dbus_message_get_member (msg);
 	signature = dbus_message_get_signature(msg);
 
-	syslog (LOG_INFO, "%s - path:%s, id:0x%X", __PRETTY_FUNCTION__, path, dbus_data->id);
+	syslog (LOG_INFO, "%s - path:%s", __PRETTY_FUNCTION__, path);
 
-	if (strcmp(iface, MANAGER_INTERFACE))
+	if (strcmp(iface, MANAGER_INTERFACE) != 0)
 		return ret;
 
-	if (strcmp(path, MANAGER_PATH) > 0) {
-		/* it is device specific path */
-		if (dbus_data->id == MANAGER_PATH_ID) {
-			/* fallback handling. The child path IS NOT registered */
-			reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_UNKNOWN_PATH);
-			ret = DBUS_HANDLER_RESULT_HANDLED;
-		} else {
-			const struct profile_obj_path_data *mgr_child = obj_path_table;
-			rel_path = strrchr(path,'/');
-			rel_path++;
-
-			if (rel_path) {
-				for ( ;mgr_child->name; mgr_child++) {
-					if (strcmp(mgr_child->name, rel_path) == 0) {
-						ptr_handlers = mgr_child->get_svc_table();
-						found = 1;
-						break;
-					}
-				}
-
+	for (handlers = manager_services; handlers->name != NULL; handlers++) {
+		if (strcmp(handlers->name, method) == 0) {
+			if (strcmp(handlers->signature, signature) != 0)
+				error = BLUEZ_EDBUS_WRONG_SIGNATURE;
+			else {
+				reply = handlers->handler_func(msg, data);
+				error = 0;
 			}
-		}
-	} else {
-		/* it's the manager! path */
-		ptr_handlers = mgr_services;
-		found = 1;
-	}
-
-	if (found && (type == DBUS_MESSAGE_TYPE_METHOD_CALL) && (method != NULL)) {
-
-		for (; ptr_handlers->name; ptr_handlers++) {
-			if (strcmp(method, ptr_handlers->name) == 0) {
-				/* resetting unknown method. It's possible handle method overload */
-				result = BLUEZ_EDBUS_WRONG_SIGNATURE; 
-				if (strcmp(ptr_handlers->signature, signature) == 0) {
-					if (ptr_handlers->handler_func) {
-						reply = (ptr_handlers->handler_func)(msg, data);
-						result = 0; /* resetting wrong signature*/
-					} else 
-						syslog(LOG_INFO, "Service not implemented");
 
-					break;
-				} 
-				
-			}
+			ret = DBUS_HANDLER_RESULT_HANDLED;
 		}
+	}
 
-		if (result) {
-			reply = bluez_new_failure_msg(msg, result);
-		}
+	if (error)
+		reply = bluez_new_failure_msg(msg, error);
 
-		ret = DBUS_HANDLER_RESULT_HANDLED;
-	}
 
-	/* send an error or the success reply*/
 	if (reply) {
 		if (!dbus_connection_send (conn, reply, NULL)) {
-			syslog(LOG_ERR, "Can't send reply message!") ;
+			syslog(LOG_ERR, "Can't send reply message!");
 		}
 		dbus_message_unref (reply);
 	}
@@ -1354,20 +1284,8 @@
 	uint8_t max_period;
 	uint8_t min_period;
 	int dd = -1;
-	int dev_id = -1;
 
-	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
-		dev_id = hci_get_route(NULL);
-		if (dev_id < 0) {
-			syslog(LOG_ERR, "Bluetooth device is not available");
-			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-			goto failed;
-		
-		}
-	} else
-		dev_id =  dbus_data->id;
-
-	dd = hci_open_dev(dev_id);
+	dd = hci_open_dev(dbus_data->id);
 	if (dd < 0) {
 		syslog(LOG_ERR, "HCI device open failed");
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
@@ -1427,19 +1345,8 @@
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
 	int dd = -1;
-	int dev_id = -1;
 
-	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
-		dev_id = hci_get_route(NULL);
-		if (dev_id < 0) {
-			syslog(LOG_ERR, "Bluetooth device is not available");
-			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-			goto failed;
-		}
-	} else
-		dev_id = dbus_data->id;
-
-	dd = hci_open_dev(dev_id);
+	dd = hci_open_dev(dbus_data->id);
 	if (dd < 0) {
 		syslog(LOG_ERR, "HCI device open failed");
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
@@ -1469,19 +1376,10 @@
 	evt_cmd_status rp;
 	struct hci_request rq;
 	struct hci_dbus_data *dbus_data = data;
-	int dev_id = -1, dd = -1;
+	int dd = -1;
 	int8_t length;
 	int8_t num_rsp;
 
-	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
-		if ((dev_id = hci_get_route(NULL)) < 0) {
-			syslog(LOG_ERR, "Bluetooth device is not available");
-			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-			goto failed;
-		}
-	} else
-		dev_id = dbus_data->id;
-
 	dbus_message_iter_init(msg, &iter);
 	dbus_message_iter_get_basic(&iter, &length);
 	dbus_message_iter_next(&iter);
@@ -1492,9 +1390,9 @@
 		goto failed;
 	}
 
-	dd = hci_open_dev(dev_id);
+	dd = hci_open_dev(dbus_data->id);
 	if (dd < 0) {
-		syslog(LOG_ERR, "Unable to open device %d: %s", dev_id, strerror(errno));
+		syslog(LOG_ERR, "Unable to open device %d: %s", dbus_data->id, strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
@@ -1535,20 +1433,11 @@
 	DBusMessage *reply = NULL;
 	struct hci_request rq;
 	struct hci_dbus_data *dbus_data = data;
-	int dev_id = -1, dd = -1;
-
-	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
-		if ((dev_id = hci_get_route(NULL)) < 0) {
-			syslog(LOG_ERR, "Bluetooth device is not available");
-			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-			goto failed;
-		}
-	} else
-		dev_id = dbus_data->id;
+	int dd = -1;
 
-	dd = hci_open_dev(dev_id);
+	dd = hci_open_dev(dbus_data->id);
 	if (dd < 0) {
-		syslog(LOG_ERR, "Unable to open device %d: %s", dev_id, strerror(errno));
+		syslog(LOG_ERR, "Unable to open device %d: %s", dbus_data->id, strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
@@ -1580,8 +1469,7 @@
 	struct hci_dbus_data *dbus_data = data;
 	bdaddr_t bdaddr;
 	uint8_t role;
-	int dev_id = -1;
-	int dd = -1;
+	int dev_id = -1, dd = -1;
 
 	dbus_message_iter_init(msg, &iter);
 	dbus_message_iter_get_basic(&iter, &str_bdaddr);
@@ -1598,7 +1486,7 @@
 		goto failed;
 	}
 
-	if (dbus_data->id != DEFAULT_DEVICE_PATH_ID && dbus_data->id != dev_id) {
+	if (dbus_data->id != dev_id) {
 		syslog(LOG_ERR, "Connection not found\n");
 		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
 		goto failed;
@@ -1631,7 +1519,6 @@
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
-	int dev_id = -1;
 	int dd = -1;
 	const char *str_bdaddr;
 	bdaddr_t bdaddr;
@@ -1644,19 +1531,9 @@
 
 	str2ba(str_bdaddr, &bdaddr);
 
-	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
-		dev_id = hci_get_route(&bdaddr);
-		if (dev_id  < 0) {
-			syslog(LOG_ERR, "Bluetooth device is not available");
-			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-			goto failed;
-		}
-	} else
-		dev_id = dbus_data->id;
-
-	dd = hci_open_dev(dev_id);
+	dd = hci_open_dev(dbus_data->id);
 	if (dd < 0) {
-		syslog(LOG_ERR, "Unable to open device %d: %s", dev_id, strerror(errno));
+		syslog(LOG_ERR, "Unable to open device %d: %s", dbus_data->id, strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
@@ -1701,21 +1578,9 @@
 	const char array_sig[] = HCI_CONN_INFO_STRUCT_SIGNATURE;
 	const char *paddr = addr;
 	struct hci_dbus_data *dbus_data = data;
-	int dev_id = -1;
 	int sk = -1;
 	int i;
 
-	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
-		dev_id = hci_get_route(NULL);
-		if (dev_id < 0) {
-			syslog(LOG_ERR, "Bluetooth device is not available");
-			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-			goto failed;
-		}
-	} else {
-		dev_id = dbus_data->id;
-	}
-
 	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
 	if (sk < 0) {
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
@@ -1728,7 +1593,7 @@
 		goto failed;
 	}
 
-	cl->dev_id = dev_id;
+	cl->dev_id = dbus_data->id;
 	cl->conn_num = MAX_CONN_NUMBER;
 	ci = cl->conn_info;
 
@@ -1791,7 +1656,7 @@
 		goto failed;
 	}
 
-	if (dbus_data->id != DEFAULT_DEVICE_PATH_ID && dbus_data->id != dev_id) {
+	if (dbus_data->id != dev_id) {
 		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
 		goto failed;
 	}
@@ -1849,27 +1714,16 @@
  *  Section reserved to Manager D-Bus message handlers
  *  
  *****************************************************************/
-static DBusMessage* handle_get_devices_req_device(DBusMessage *msg, void *data)
+static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data)
 {
 	DBusMessageIter iter;
 	DBusMessageIter array_iter;
-	DBusMessageIter flag_array_iter;
-	DBusMessageIter  struct_iter;
 	DBusMessage *reply = NULL;
 	struct hci_dev_list_req *dl = NULL;
 	struct hci_dev_req *dr      = NULL;
-	struct hci_dev_info di;
 	int sk = -1;
 	int i;
-	char aname[BLUETOOTH_DEVICE_NAME_LEN+1];
-	char aaddr[BLUETOOTH_DEVICE_ADDR_LEN];
-	char aflag[DEVICE_FLAG_NAME];
-	char *paddr = aaddr;
-	char *pname = aname;
-	char *pflag = aflag;
-	char *ptype;
-	const char array_sig[] = DEV_GET_DEV_REPLY_STRUCT_SIGNATURE;
-	hci_map *mp;
+	const char array_sig[] = MGR_GET_DEV_REPLY_STRUCT_SIGNATURE;
 
 	/* Create and bind HCI socket */
 	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
@@ -1901,6 +1755,16 @@
 	dr = dl->dev_req;
 
 	for (i = 0; i < dl->dev_num; i++, dr++) {
+		char apath[MAX_PATH_LENGTH];
+		char aaddr[BLUETOOTH_DEVICE_ADDR_LEN];
+		char *paddr = aaddr;
+		char *ppath = apath;
+		char *ptype;
+		const char *flag;
+		DBusMessageIter flag_array_iter, struct_iter;
+		struct hci_dev_info di;
+		hci_map *mp;
+
 		mp = dev_flags_map;
 		memset(&di, 0 , sizeof(struct hci_dev_info));
 		di.dev_id = dr->dev_id;
@@ -1908,8 +1772,7 @@
 		if (ioctl(sk, HCIGETDEVINFO, &di) < 0)
 			continue;
 
-		strncpy(aname, di.name, BLUETOOTH_DEVICE_NAME_LEN);
-		aname[BLUETOOTH_DEVICE_NAME_LEN] = '\0';
+		snprintf(apath, sizeof(apath), "%s/%s", DEVICE_PATH, di.name);
 
 		ba2str(&di.bdaddr, aaddr);
 		ptype = hci_dtypetostr(di.type);
@@ -1917,25 +1780,23 @@
 		dbus_message_iter_open_container(&array_iter,
 				DBUS_TYPE_STRUCT, NULL, &struct_iter);
 
-		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING, &pname);
+		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING, &ppath);
 		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING, &paddr);
 		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING, &ptype);
 
-		if (hci_test_bit(HCI_UP, &dr->dev_opt)) {
-			sprintf(pflag, "%s", "UP");
-		} else {
-			sprintf(pflag, "%s", "DOWN");
-		}
-		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING, &pflag);
+		if (hci_test_bit(HCI_UP, &dr->dev_opt))
+			flag = "UP";
+		else
+			flag = "DOWN";
+
+		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING, &flag);
 
 		dbus_message_iter_open_container(&struct_iter,
 					DBUS_TYPE_ARRAY, DBUS_TYPE_STRING_AS_STRING, &flag_array_iter);
 
 		while (mp->str) {
-			if (hci_test_bit(mp->val, &dr->dev_opt)) {
-				sprintf(pflag, "%s", mp->str);
-				dbus_message_iter_append_basic(&flag_array_iter, DBUS_TYPE_STRING, &pflag);
-			}
+			if (hci_test_bit(mp->val, &dr->dev_opt))
+				dbus_message_iter_append_basic(&flag_array_iter, DBUS_TYPE_STRING, &mp->str);
 			mp++;
 		}
 		dbus_message_iter_close_container(&struct_iter, &flag_array_iter);
@@ -1952,86 +1813,28 @@
 	return reply;
 }
 
-
-static DBusMessage* handle_get_devices_req_manager(DBusMessage *msg, void *data)
-{
-	DBusMessageIter iter;
-	DBusMessageIter array_iter;
-	DBusMessageIter  struct_iter;
+static DBusMessage* handle_default_device_req(DBusMessage *msg, void *data) {
+	char path[MAX_PATH_LENGTH];
+	char *pptr = path;
 	DBusMessage *reply = NULL;
 
-	struct hci_dev_list_req *dl = NULL;
-	struct hci_dev_req *dr      = NULL;
-	struct hci_dev_info di;
-	int sk = -1;
-	int i;
-
-	char aname[BLUETOOTH_DEVICE_NAME_LEN];
-	char aaddr[BLUETOOTH_DEVICE_ADDR_LEN];
-	char *paddr = aaddr;
-	char *pname = aname;
-	const char array_sig[] = HCI_DEVICE_STRUCT_SIGNATURE;
-
-	/* Create and bind HCI socket */
-	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
-	if (sk < 0) {
-		syslog(LOG_ERR, "Can't open HCI socket: %s (%d)", strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
-	}
-
-	dl = malloc(HCI_MAX_DEV * sizeof(*dr) + sizeof(*dl));
-	if (!dl) {
-		syslog(LOG_ERR, "Can't allocate memory");
-		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_NO_MEM);
-		goto failed;
-	}
-
-	dl->dev_num = HCI_MAX_DEV;
-	dr = dl->dev_req;
-
-	if (ioctl(sk, HCIGETDEVLIST, dl) < 0) {
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
+	if (default_dev < 0) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+		goto out;
 	}
 
-	/* active bluetooth adapter found */
 	reply = dbus_message_new_method_return(msg);
-	dbus_message_iter_init_append(reply, &iter);
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, array_sig, &array_iter);
-	dr = dl->dev_req;
-
-	for (i = 0; i < dl->dev_num; i++, dr++) {
-		if (!hci_test_bit(HCI_UP, &dr->dev_opt))
-			continue;
-
-		memset(&di, 0 , sizeof(struct hci_dev_info));
-		di.dev_id = dr->dev_id;
-
-		if (ioctl(sk, HCIGETDEVINFO, &di) < 0)
-			continue;
-
-		strcpy(aname, di.name);
-		ba2str(&di.bdaddr, aaddr);
-
-		dbus_message_iter_open_container(&array_iter,
-					DBUS_TYPE_STRUCT, NULL, &struct_iter);
-
-		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING, &pname);
-		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING, &paddr);
-
-		dbus_message_iter_close_container(&array_iter, &struct_iter);
+	if (reply == NULL) {
+		syslog(LOG_ERR, "Out of memory while calling new_method_return");
+		goto out;
 	}
 
-	dbus_message_iter_close_container(&iter, &array_iter);
-
-failed:
-	if (sk >= 0)
-		close(sk);
-
-	if (dl)
-		free(dl);
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, default_dev);
+	dbus_message_append_args(reply,
+				 DBUS_TYPE_STRING, &pptr,
+				 DBUS_TYPE_INVALID);
 
+out:
 	return reply;
 }
 
Index: hcid/dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.11
diff -u -r1.11 dbus.h
--- hcid/dbus.h	31 Oct 2005 15:39:14 -0000	1.11
+++ hcid/dbus.h	1 Nov 2005 15:45:02 -0000
@@ -34,27 +34,31 @@
 
 #define ERROR_INTERFACE		BASE_INTERFACE ".Error"
 
-#define DEFAULT_DEVICE_PATH_ID 		(0xFFFF)
-#define MANAGER_PATH_ID			(0xFFFE)
-#define DEVICE_PATH_ID			(0xFFFD)
-
-#define HCI_DEFAULT_DEVICE_NAME		"default"
-#define HCI_DEVICE_NAME			"hci"
+#define MANAGER_PATH_ID		(0xFFFF)
+#define DEVICE_PATH_ID		(0xFFFE)
 
 /*======================================================================== 
-    BlueZ D-Bus Device service definitions "/org/bluez/Device"
+    BlueZ D-Bus Manager service definitions "/org/bluez/Manager"
  *========================================================================*/
-#define DEV_GET_DEV			"DeviceList"
-#define DEV_UP				"Up"
-#define DEV_DOWN			"Down"
-#define DEV_RESET			"Reset"
-#define DEV_SET_PROPERTY		"SetProperty"
-#define DEV_GET_PROPERTY		"GetProperty"
 
-#define DEV_GET_DEV_SIGNATURE			__END_SIG__
+#define MGR_DEVICE_LIST		"DeviceList"
+#define MGR_DEFAULT_DEVICE	"DefaultDevice"
+#define MGR_INIT		"Init"
+
+/* Enable/Disable services controller, pan, serial, ... */
+#define MGR_ENABLE		"Enable"
+#define MGR_DISABLE		"Disable"
+
+/* Signatures */
+
+#define MGR_GET_DEV_SIGNATURE			__END_SIG__
 
 /* DeviceList Reply: a(devname, addr, type, up/down, a(flags)) - all types strings */
-#define DEV_GET_DEV_REPLY_STRUCT_SIGNATURE	DBUS_STRUCT_BEGIN_CHAR_AS_STRING \
+#define MGR_GET_DEV_REPLY_SIGNATURE		DBUS_TYPE_ARRAY_AS_STRING \
+						DEV_GET_DEV_REPLY_STRUCT_SIGNATURE \
+						__END_SIG__
+
+#define MGR_GET_DEV_REPLY_STRUCT_SIGNATURE	DBUS_STRUCT_BEGIN_CHAR_AS_STRING \
 						DBUS_TYPE_STRING_AS_STRING \
 						DBUS_TYPE_STRING_AS_STRING \
 						DBUS_TYPE_STRING_AS_STRING \
@@ -64,44 +68,23 @@
 						DBUS_STRUCT_END_CHAR_AS_STRING \
 						__END_SIG__
 
-#define DEV_GET_DEV_REPLY_SIGNATURE		DBUS_TYPE_ARRAY_AS_STRING \
-						DEV_GET_DEV_REPLY_STRUCT_SIGNATURE \
-						__END_SIG__
-
-#define DEV_UP_SIGNATURE			__END_SIG__
-#define DEV_DOWN_SIGNATURE			__END_SIG__
-#define DEV_RESET_SIGNATURE			__END_SIG__
-#define DEV_SET_PROPERTY_SIGNATURE		__END_SIG__
-#define DEV_GET_PROPERTY_SIGNATURE		__END_SIG__
-
-/*======================================================================== 
-    BlueZ D-Bus Manager service definitions "/org/bluez/Manager"
- *========================================================================*/
+#define MGR_DEFAULT_DEV_SIGNATURE		__END_SIG__
 
- /* ===== Manager definitions, services under DEVICE_PATH ===== */
-#define MGR_GET_DEV			"DeviceList"
-#define MGR_INIT			"Init"
 
-/* Enable/Disable services controller, pan, serial, ... */
-#define MGR_ENABLE			"Enable"
-#define MGR_DISABLE			"Disable"
+/* Signals sent in the Manager path */
+#define BLUEZ_MGR_DEV_ADDED		"DeviceAdded"
+#define BLUEZ_MGR_DEV_REMOVED		"DeviceRemoved"
 
-/* Signatures */
-#define MGR_GET_DEV_SIGNATURE			__END_SIG__
 
-/* yya(ss) */
-#define MGR_GET_DEV_REPLY_SIGNATURE		DBUS_TYPE_BYTE_AS_STRING \
-						DBUS_TYPE_BYTE_AS_STRING \
-						DBUS_TYPE_ARRAY_AS_STRING \
-						HCI_DEVICE_STRUCT_SIGNATURE \
-						__END_SIG__
+/*======================================================================== 
+    BlueZ D-Bus Device path definitions "/org/bluez/Device"
+ *========================================================================*/
 
-/* ===== HCI definitions ===== */
+/* Interfaces implemented in the "/org/bluez/Device" path */
 #define BLUEZ_HCI			"Controller"
-#define BLUEZ_HCI_PATH			MANAGER_PATH "/" BLUEZ_HCI
-#define BLUEZ_HCI_INTERFACE		MANAGER_INTERFACE "." BLUEZ_HCI
+#define DEV_HCI_INTERFACE		DEVICE_INTERFACE "." BLUEZ_HCI
 
-/* Device based HCI signals */
+/* Control interface signals */
 #define BLUEZ_HCI_INQ_START		"InquiryStart"
 #define BLUEZ_HCI_INQ_COMPLETE		"InquiryComplete"
 #define BLUEZ_HCI_INQ_RESULT		"InquiryResult"
@@ -109,11 +92,7 @@
 #define BLUEZ_HCI_REMOTE_NAME_FAILED	"RemoteNameFailed"
 #define BLUEZ_HCI_AUTH_COMPLETE		"AuthenticationComplete"
 
-/* HCI signals sent in the BLUEZ_HCI_PATH */
-#define BLUEZ_HCI_DEV_ADDED		"DeviceAdded"
-#define BLUEZ_HCI_DEV_REMOVED		"DeviceRemoved"
-
-/* HCI Provided services */
+/* Control interface methods */
 #define HCI_PERIODIC_INQ		"PeriodicInquiry"
 #define HCI_CANCEL_PERIODIC_INQ		"CancelPeriodic"
 #define HCI_INQ				"Inquiry"
@@ -123,6 +102,19 @@
 #define HCI_CONNECTIONS			"Connections"
 #define HCI_AUTHENTICATE		"Authenticate"
 
+/* Control interface methods */
+#define DEV_UP				"Up"
+#define DEV_DOWN			"Down"
+#define DEV_RESET			"Reset"
+#define DEV_SET_PROPERTY		"SetProperty"
+#define DEV_GET_PROPERTY		"GetProperty"
+
+#define DEV_UP_SIGNATURE			__END_SIG__
+#define DEV_DOWN_SIGNATURE			__END_SIG__
+#define DEV_RESET_SIGNATURE			__END_SIG__
+#define DEV_SET_PROPERTY_SIGNATURE		__END_SIG__
+#define DEV_GET_PROPERTY_SIGNATURE		__END_SIG__
+
 
 #define HCI_PERIODIC_INQ_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING \
 							DBUS_TYPE_BYTE_AS_STRING \
Index: hcid/hcid.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/hcid.h,v
retrieving revision 1.29
diff -u -r1.29 hcid.h
--- hcid/hcid.h	29 Oct 2005 22:36:32 -0000	1.29
+++ hcid/hcid.h	1 Nov 2005 15:45:02 -0000
@@ -121,9 +121,9 @@
 gboolean hcid_dbus_init(void);
 void hcid_dbus_exit(void);
 gboolean hcid_dbus_register_device(uint16_t id);
-gboolean hcid_dbus_register_manager(uint16_t id);
+gboolean hcid_dbus_dev_up(uint16_t id);
 gboolean hcid_dbus_unregister_device(uint16_t id);
-gboolean hcid_dbus_unregister_manager(uint16_t id);
+gboolean hcid_dbus_dev_down(uint16_t id);
 void hcid_dbus_request_pin(int dev, struct hci_conn_info *ci);
 void hcid_dbus_inquiry_start(bdaddr_t *local);
 void hcid_dbus_inquiry_complete(bdaddr_t *local);
Index: hcid/main.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/main.c,v
retrieving revision 1.30
diff -u -r1.30 main.c
--- hcid/main.c	29 Oct 2005 22:36:32 -0000	1.30
+++ hcid/main.c	1 Nov 2005 15:45:02 -0000
@@ -401,10 +401,10 @@
 			start_security_manager(dr->dev_id);
 
 #ifdef ENABLE_DBUS
-		if (hci_test_bit(HCI_UP, &dr->dev_opt))
-			hcid_dbus_register_manager(dr->dev_id);
-
 		hcid_dbus_register_device(dr->dev_id);
+
+		if (hci_test_bit(HCI_UP, &dr->dev_opt))
+			hcid_dbus_dev_up(dr->dev_id);
 #endif
 	}
 
@@ -476,7 +476,7 @@
 		if (hcid.security)
 			start_security_manager(sd->dev_id);
 #ifdef ENABLE_DBUS
-		hcid_dbus_register_manager(sd->dev_id);
+		hcid_dbus_dev_up(sd->dev_id);
 #endif
 		break;
 
@@ -485,7 +485,7 @@
 		if (hcid.security)
 			stop_security_manager(sd->dev_id);
 #ifdef ENABLE_DBUS
-		hcid_dbus_unregister_manager(sd->dev_id);
+		hcid_dbus_dev_down(sd->dev_id);
 #endif
 		break;
 	}

--VS++wcV0S1rZb1Fb
Content-Type: text/x-python; charset=us-ascii
Content-Disposition: attachment; filename="dbus-test.py"

#!/usr/bin/env python
 
import dbus

bus = dbus.SystemBus()
manager_object = bus.get_object('org.bluez', '/org/bluez/Manager')
manager_if = dbus.Interface(manager_object, 'org.bluez.Manager')

devices = manager_if.DeviceList ()
print 'Found %d devices:' % len(devices)
print devices

try:
    default = manager_if.DefaultDevice()
    print 'Default device is %s' % default
except dbus.DBusException, e:
    print 'Failed to get default device: %s' % e
    

--VS++wcV0S1rZb1Fb--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
