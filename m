Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80510310653s14dd0fceu7241b89137208262@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [D-BUS PATCH] Authentication
In-Reply-To: <1130433108.16380.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2949_4228323.1130770420187"
References: <e1effdeb0510201045w5ebf17afh87897564184ce9f9@mail.gmail.com>
	 <1129986496.11428.36.camel@blade>
	 <e1effdeb0510240606l1998f61dhc2fe813c48b1e6db@mail.gmail.com>
	 <1130159970.19317.28.camel@blade>
	 <e1effdeb0510251203i7cb20240ua03a7f9aff38917d@mail.gmail.com>
	 <1130373447.32634.8.camel@blade>
	 <e1effdeb0510270733q23c9cf01u9b3a597d1adbe258@mail.gmail.com>
	 <1130424788.5163.15.camel@localhost.localdomain>
	 <e1effdeb0510270933q4cc1e108of143a86d46c8b750@mail.gmail.com>
	 <1130433108.16380.0.camel@localhost.localdomain>
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
Date: Mon, 31 Oct 2005 11:53:40 -0300

------=_Part_2949_4228323.1130770420187
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

here is the patch for /org/bluez/Device. It adds the function
DeviceList that returns the list of registered devices in the machine.
For each device I'm returning (device name, addr, type, up/down, and
an array of capability). I've also splitted some functions that was
used in conjuction with  /org/bluez/Manager. I've also included a
python client for test.

BR,
Eduardo.


On 10/27/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > The signal has two arguments now:
> > - String: peer address
> > - Byte: authentication status
>
> the patch is in the CVS now.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT

------=_Part_2949_4228323.1130770420187
Content-Type: text/x-patch; name=dbus_devices01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dbus_devices01.patch"

--- bluez-cvs-new.2/utils/hcid/dbus.h	2005-10-31 11:30:46.706609400 -0300
+++ bluez-cvs-new/utils/hcid/dbus.h	2005-10-31 11:31:30.393967912 -0300
@@ -44,17 +44,36 @@
 /*======================================================================== 
     BlueZ D-Bus Device service definitions "/org/bluez/Device"
  *========================================================================*/
+#define DEV_GET_DEV			"DeviceList"
 #define DEV_UP				"Up"
 #define DEV_DOWN			"Down"
 #define DEV_RESET			"Reset"
 #define DEV_SET_PROPERTY		"SetProperty"
 #define DEV_GET_PROPERTY		"GetProperty"
 
-#define DEV_UP_SIGNATURE		__END_SIG__
-#define DEV_DOWN_SIGNATURE		__END_SIG__
-#define DEV_RESET_SIGNATURE		__END_SIG__
-#define DEV_SET_PROPERTY_SIGNATURE	__END_SIG__
-#define DEV_GET_PROPERTY_SIGNATURE	__END_SIG__
+#define DEV_GET_DEV_SIGNATURE			__END_SIG__
+
+/* DeviceList Reply: a(devname, addr, type, up/down, a(flags)) - all types strings */
+#define DEV_GET_DEV_REPLY_STRUCT_SIGNATURE	DBUS_STRUCT_BEGIN_CHAR_AS_STRING\
+						DBUS_TYPE_STRING_AS_STRING\
+						DBUS_TYPE_STRING_AS_STRING\
+						DBUS_TYPE_STRING_AS_STRING\
+						DBUS_TYPE_STRING_AS_STRING\
+						DBUS_TYPE_ARRAY_AS_STRING\
+						DBUS_TYPE_STRING_AS_STRING\
+						DBUS_STRUCT_END_CHAR_AS_STRING\
+						__END_SIG__
+
+#define DEV_GET_DEV_REPLY_SIGNATURE		DBUS_TYPE_ARRAY_AS_STRING\
+						DEV_GET_DEV_REPLY_STRUCT_SIGNATURE\
+						__END_SIG__
+		    
+
+#define DEV_UP_SIGNATURE			__END_SIG__
+#define DEV_DOWN_SIGNATURE			__END_SIG__
+#define DEV_RESET_SIGNATURE			__END_SIG__
+#define DEV_SET_PROPERTY_SIGNATURE		__END_SIG__
+#define DEV_GET_PROPERTY_SIGNATURE		__END_SIG__
 
 /*======================================================================== 
     BlueZ D-Bus Manager service definitions "/org/bluez/Manager"
--- bluez-cvs-new.2/utils/hcid/dbus.c	2005-10-31 11:30:46.706609400 -0300
+++ bluez-cvs-new/utils/hcid/dbus.c	2005-10-31 11:39:21.725314656 -0300
@@ -53,6 +53,7 @@
 #define MAX_PATH_LENGTH   (64)
 #define READ_REMOTE_NAME_TIMEOUT	(25000)
 #define MAX_CONN_NUMBER			(10)
+#define DEVICE_FLAG_NAME		(16)
 
 #define PINAGENT_SERVICE_NAME BASE_INTERFACE ".PinAgent"
 #define PINAGENT_INTERFACE PINAGENT_SERVICE_NAME
@@ -106,6 +107,24 @@
 	const char *str;
 }bluez_error_t;
 
+typedef struct {
+	char *str;
+	unsigned int val;
+} hci_map;
+
+static hci_map dev_flags_map[] = {
+	{ "INIT",    HCI_INIT    },
+	{ "RUNNING", HCI_RUNNING },
+	{ "RAW",     HCI_RAW     },
+	{ "PSCAN",   HCI_PSCAN   },
+	{ "ISCAN",   HCI_ISCAN   },
+	{ "INQUIRY", HCI_INQUIRY },
+	{ "AUTH",    HCI_AUTH    },
+	{ "ENCRYPT", HCI_ENCRYPT },
+	{ "SECMGR",  HCI_SECMGR  },
+	{ NULL }
+};
+
 static const bluez_error_t dbus_error_array[] = {
 	{ BLUEZ_EDBUS_UNKNOWN_METHOD,	"Method not found"		},
 	{ BLUEZ_EDBUS_WRONG_SIGNATURE,	"Wrong method signature"	},
@@ -234,13 +253,20 @@
 /*
  * Device Message handler functions object table declaration
  */
-static DBusHandlerResult msg_func(DBusConnection *conn, DBusMessage *msg, void *data);
+static DBusHandlerResult msg_func_device(DBusConnection *conn, DBusMessage *msg, void *data);
+static DBusHandlerResult msg_func_manager(DBusConnection *conn, DBusMessage *msg, void *data);
 
-static DBusMessage* handle_get_devices_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_get_devices_req_device(DBusMessage *msg, void *data);
+static DBusMessage* handle_get_devices_req_manager(DBusMessage *msg, void *data);
 static DBusMessage* handle_not_implemented_req(DBusMessage *msg, void *data);
 
-static const DBusObjectPathVTable obj_vtable = {
-	.message_function = &msg_func,
+static const DBusObjectPathVTable obj_dev_vtable = {
+	.message_function = &msg_func_device,
+	.unregister_function = NULL
+};
+
+static const DBusObjectPathVTable obj_mgr_vtable = {
+	.message_function = &msg_func_manager,
 	.unregister_function = NULL
 };
 
@@ -248,6 +274,11 @@
  * Service provided under the path DEVICE_PATH
  * TODO add the handlers
  */
+static const struct service_data dev_root_services[] = {
+	{ DEV_GET_DEV,          handle_get_devices_req_device,     DEV_GET_DEV_SIGNATURE           },
+	{ NULL, NULL, NULL}
+};
+
 static const struct service_data dev_services[] = {
 	{ DEV_UP,		handle_not_implemented_req,	DEV_UP_SIGNATURE		},
 	{ DEV_DOWN,		handle_not_implemented_req,	DEV_DOWN_SIGNATURE		},
@@ -262,7 +293,7 @@
  *
  */
 static const struct service_data mgr_services[] = {
-	{ MGR_GET_DEV,		handle_get_devices_req,		MGR_GET_DEV_SIGNATURE	},
+	{ MGR_GET_DEV,		handle_get_devices_req_manager,	MGR_GET_DEV_SIGNATURE	},
 	{ MGR_INIT,		handle_not_implemented_req,	NULL			},
 	{ MGR_ENABLE,		handle_not_implemented_req,	NULL			},
 	{ MGR_DISABLE,		handle_not_implemented_req,	NULL			},
@@ -352,7 +383,7 @@
 	free(req);
 }
 
-static gboolean register_dbus_path(char *path, uint16_t id)
+static gboolean register_dbus_path(char *path, uint16_t id, const DBusObjectPathVTable *pvtable)
 {
 	struct hci_dbus_data *data;
 	syslog(LOG_INFO,"Registering DBUS Path: %s", path);
@@ -363,7 +394,7 @@
 	}
 	data->id = id;
 
-	if (!dbus_connection_register_object_path(connection, path, &obj_vtable, data)) {
+	if (!dbus_connection_register_object_path(connection, path, pvtable, data)) {
 		syslog(LOG_ERR,"DBUS failed to register %s object", path);
 		free(data);
 		return FALSE;
@@ -811,7 +842,7 @@
 	data->id = DEVICE_PATH_ID;
 
 	if (!dbus_connection_register_fallback(connection, DEVICE_PATH,
-						&obj_vtable, data)) {
+						&obj_dev_vtable, data)) {
 		syslog(LOG_ERR, "Can't register %s object", DEVICE_PATH);
 		return FALSE;
 	}
@@ -823,7 +854,7 @@
 	data->id = MANAGER_PATH_ID;
 
 	if (!dbus_connection_register_fallback(connection, MANAGER_PATH,
-						&obj_vtable, data)) {
+						&obj_mgr_vtable, data)) {
 		syslog(LOG_ERR, "Can't register %s object", MANAGER_PATH);
 		return FALSE;
 	}
@@ -936,7 +967,7 @@
 	snprintf(path, sizeof(path), "%s/%s", DEVICE_PATH, pdev);
 
 	/* register the default path*/
-	return register_dbus_path(path, id);
+	return register_dbus_path(path, id, &obj_dev_vtable);
 }
 
 gboolean hcid_dbus_unregister_device(uint16_t id)
@@ -1066,12 +1097,12 @@
 	/* register the default path*/
 	if (!dft_reg) {
 		snprintf(path, sizeof(path), "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
-		register_dbus_path(path, DEFAULT_DEVICE_PATH_ID);
+		register_dbus_path(path, DEFAULT_DEVICE_PATH_ID, &obj_mgr_vtable);
 	}
 
 	/* register the default path*/
 	snprintf(path, sizeof(path), "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
-	register_dbus_path(path, id);
+	register_dbus_path(path, id, &obj_mgr_vtable);
 
 	return 0;
 }
@@ -1146,7 +1177,81 @@
  *
  */
 
-static DBusHandlerResult msg_func(DBusConnection *conn, DBusMessage *msg, void *data)
+static DBusHandlerResult msg_func_device(DBusConnection *conn, DBusMessage *msg, void *data)
+{
+	const struct service_data *ptr_handlers = NULL;
+	DBusMessage *reply = NULL;
+	int type;
+	const char *iface;
+	const char *method;
+	const char *signature;
+	const char *path;
+	struct hci_dbus_data *dbus_data = data;
+	uint32_t result = BLUEZ_EDBUS_UNKNOWN_METHOD;
+	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	uint8_t found = 0;
+
+	path = dbus_message_get_path(msg);
+	type = dbus_message_get_type(msg);
+	iface = dbus_message_get_interface(msg);
+	method = dbus_message_get_member (msg);
+	signature = dbus_message_get_signature(msg);
+
+	if (strcmp(iface, DEVICE_INTERFACE)) 
+		return ret;
+
+	if (strcmp(path, DEVICE_PATH) > 0) {
+		if ( dbus_data->id == DEVICE_PATH_ID ) {
+			/* fallback handling. The child path IS NOT registered */
+			reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_UNKNOWN_PATH);
+			ret = DBUS_HANDLER_RESULT_HANDLED;
+		} else {
+			/* hciX code */
+
+		}
+
+	} else {
+		/* it's the device path */
+		ptr_handlers = dev_root_services;
+		found = 1;
+	}
+	if (found && (type == DBUS_MESSAGE_TYPE_METHOD_CALL) && (method != NULL)) {
+
+		for (; ptr_handlers->name; ptr_handlers++) {
+			if (strcmp(method, ptr_handlers->name) == 0) {
+				/* resetting unknown method. It's possible handle method overload */
+				result = BLUEZ_EDBUS_WRONG_SIGNATURE; 
+				if (strcmp(ptr_handlers->signature, signature) == 0) {
+					if (ptr_handlers->handler_func) {
+						reply = (ptr_handlers->handler_func)(msg, data);
+						result = 0; /* resetting wrong signature*/
+					} else 
+						syslog(LOG_INFO, "Service not implemented");
+
+					break;
+				} 
+				
+			}
+		}
+
+		if (result) {
+			reply = bluez_new_failure_msg(msg, result);
+		}
+
+		ret = DBUS_HANDLER_RESULT_HANDLED;
+	}
+
+	/* send an error or the success reply*/
+	if (reply) {
+		if (!dbus_connection_send (conn, reply, NULL)) {
+			syslog(LOG_ERR, "Can't send reply message!") ;
+		}
+		dbus_message_unref (reply);
+	}
+	return ret;
+}
+
+static DBusHandlerResult msg_func_manager(DBusConnection *conn, DBusMessage *msg, void *data)
 {
 	const struct service_data *ptr_handlers = NULL;
 	DBusMessage *reply = NULL;
@@ -1156,7 +1261,6 @@
 	const char *signature;
 	const char *path;
 	const char *rel_path;
-	const char *tmp_iface = NULL;
 	struct hci_dbus_data *dbus_data = data;
 	uint32_t result = BLUEZ_EDBUS_UNKNOWN_METHOD;
 	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
@@ -1170,43 +1274,38 @@
 
 	syslog (LOG_INFO, "%s - path:%s, id:0x%X", __PRETTY_FUNCTION__, path, dbus_data->id);
 
-	if (strcmp(path, DEVICE_PATH) == 0) {
-		ptr_handlers = dev_services;
-		tmp_iface = DEVICE_INTERFACE;
-		found = 1;
-	} else {
-		if (strcmp(path, MANAGER_PATH) > 0) {
-			/* it is device specific path */
-			if ( dbus_data->id == MANAGER_PATH_ID ) {
-				/* fallback handling. The child path IS NOT registered */
-				reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_UNKNOWN_PATH);
-				ret = DBUS_HANDLER_RESULT_HANDLED;
-			} else {
-				const struct profile_obj_path_data *mgr_child = obj_path_table;
-				rel_path = strrchr(path,'/');
-				rel_path++;
-
-				if (rel_path) {
-					for ( ;mgr_child->name; mgr_child++) {
-						if (strcmp(mgr_child->name, rel_path) == 0) {
-							ptr_handlers = mgr_child->get_svc_table();
-							found = 1;
-						}
-					}
+	if (strcmp(iface, MANAGER_INTERFACE)) 
+		return ret;
 
-					tmp_iface = MANAGER_INTERFACE;
+	if (strcmp(path, MANAGER_PATH) > 0) {
+		/* it is device specific path */
+		if ( dbus_data->id == MANAGER_PATH_ID ) {
+			/* fallback handling. The child path IS NOT registered */
+			reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_UNKNOWN_PATH);
+			ret = DBUS_HANDLER_RESULT_HANDLED;
+		} else {
+			const struct profile_obj_path_data *mgr_child = obj_path_table;
+			rel_path = strrchr(path,'/');
+			rel_path++;
+
+			if (rel_path) {
+				for ( ;mgr_child->name; mgr_child++) {
+					if (strcmp(mgr_child->name, rel_path) == 0) {
+						ptr_handlers = mgr_child->get_svc_table();
+						found = 1;
+						break;
+					}
 				}
+
 			}
-		} else {
-			/* it's the manager path */
-			ptr_handlers = mgr_services;
-			tmp_iface = MANAGER_INTERFACE;
-			found = 1;
 		}
+	} else {
+		/* it's the manager! path */
+		ptr_handlers = mgr_services;
+		found = 1;
 	}
 
-	if (found && (type == DBUS_MESSAGE_TYPE_METHOD_CALL) && 
-		(strcmp(iface, tmp_iface) == 0) && (method != NULL)) {
+	if (found && (type == DBUS_MESSAGE_TYPE_METHOD_CALL) && (method != NULL)) {
 
 		for (; ptr_handlers->name; ptr_handlers++) {
 			if (strcmp(method, ptr_handlers->name) == 0) {
@@ -1748,8 +1847,111 @@
  *  Section reserved to Manager D-Bus message handlers
  *  
  *****************************************************************/
+static DBusMessage* handle_get_devices_req_device(DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter;
+	DBusMessageIter array_iter;
+	DBusMessageIter flag_array_iter;
+	DBusMessageIter  struct_iter;
+	DBusMessage *reply = NULL;
+	struct hci_dev_list_req *dl = NULL;
+	struct hci_dev_req *dr      = NULL;
+	struct hci_dev_info di;
+	int sk = -1;
+	int i;
+	char aname[BLUETOOTH_DEVICE_NAME_LEN+1];
+	char aaddr[BLUETOOTH_DEVICE_ADDR_LEN];
+	char aflag[DEVICE_FLAG_NAME];
+	char *paddr = aaddr;
+	char *pname = aname;
+	char *pflag = aflag;
+	char *ptype;
+	const char array_sig[] = DEV_GET_DEV_REPLY_STRUCT_SIGNATURE;
+	hci_map *mp;
+
+	/* Create and bind HCI socket */
+	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (sk < 0) {
+		syslog(LOG_ERR, "Can't open HCI socket: %s (%d)", strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	dl = malloc(HCI_MAX_DEV * sizeof(*dr) + sizeof(*dl));
+	if (!dl) {
+		syslog(LOG_ERR, "Can't allocate memory");
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_NO_MEM);
+		goto failed;
+	}
+
+	dl->dev_num = HCI_MAX_DEV;
+	dr = dl->dev_req;
+
+	if (ioctl(sk, HCIGETDEVLIST, dl) < 0) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	/* active bluetooth adapter found */
+	reply = dbus_message_new_method_return(msg);
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, array_sig, &array_iter);
+	dr = dl->dev_req;
+
+	for (i = 0; i < dl->dev_num; i++, dr++) {
+		mp = dev_flags_map;
+		memset(&di, 0 , sizeof(struct hci_dev_info));
+		di.dev_id = dr->dev_id;
+
+		if (ioctl(sk, HCIGETDEVINFO, &di) < 0)
+			continue;
+
+		strncpy(aname, di.name, BLUETOOTH_DEVICE_NAME_LEN);
+		aname[BLUETOOTH_DEVICE_NAME_LEN] = '\0';
+
+		ba2str(&di.bdaddr, aaddr);
+		ptype = hci_dtypetostr(di.type);
+
+		dbus_message_iter_open_container(&array_iter,
+				DBUS_TYPE_STRUCT, NULL, &struct_iter);
+
+		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING, &pname);
+		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING, &paddr);
+		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING, &ptype);
+
+		if (hci_test_bit(HCI_UP, &dr->dev_opt)) {
+			sprintf(pflag, "%s", "UP");
+		} else {
+			sprintf(pflag, "%s", "DOWN");
+		}
+		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING, &pflag);
+
+		dbus_message_iter_open_container(&struct_iter,
+					DBUS_TYPE_ARRAY, DBUS_TYPE_STRING_AS_STRING, &flag_array_iter);
+
+		while (mp->str) {
+			if (hci_test_bit(mp->val, &dr->dev_opt)) {
+				sprintf(pflag, "%s", mp->str);
+				dbus_message_iter_append_basic(&flag_array_iter, DBUS_TYPE_STRING, &pflag);
+			}
+			mp++;
+		}
+		dbus_message_iter_close_container(&struct_iter, &flag_array_iter);
+		dbus_message_iter_close_container(&array_iter, &struct_iter);
+	}
+
+	dbus_message_iter_close_container(&iter, &array_iter);
+
+failed:
+	if (sk >= 0)
+		close(sk);
+	if (dl)
+		free(dl);
+	return reply;
+}
+
 
-static DBusMessage* handle_get_devices_req(DBusMessage *msg, void *data)
+static DBusMessage* handle_get_devices_req_manager(DBusMessage *msg, void *data)
 {
 	DBusMessageIter iter;
 	DBusMessageIter array_iter;

------=_Part_2949_4228323.1130770420187
Content-Type: text/x-python; name=devlistdev.py; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="devlistdev.py"

import dbus

bus = dbus.SystemBus()
proxy_obj = bus.get_object('org.bluez', '/org/bluez/Device')
dbus_iface = dbus.Interface(proxy_obj, 'org.bluez.Device')

print dbus_iface.DeviceList()

------=_Part_2949_4228323.1130770420187--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
