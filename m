Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80512070429g5fb992b7i7131d570f9023086@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
In-Reply-To: <1133471112.18554.8.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2516_25839534.1133958549069"
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com>
	 <1132872886.3170.3.camel@blade>
	 <e1effdeb0511250547o16e60b21y5c3a81a5639102cc@mail.gmail.com>
	 <1132942092.5577.21.camel@blade>
	 <3013cac80511251034s23d549cbs8a951d64562627b1@mail.gmail.com>
	 <1132944074.5577.28.camel@blade>
	 <e1effdeb0511251152k3bafca4n21125fd1c9f9179@mail.gmail.com>
	 <1132949177.10237.5.camel@blade>
	 <3013cac80512010855v46eeb99dk3a53094238800621@mail.gmail.com>
	 <1133471112.18554.8.camel@blade>
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
Date: Wed, 7 Dec 2005 09:29:09 -0300

------=_Part_2516_25839534.1133958549069
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

here is the patch with the scan property change. Maybe we should
consider improving the syslog error messages to include some more info
to give some clue of where it happened.

BR,
Eduardo.


On 12/1/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Eduardo,
>
> > Johan said on an early email that would be nice to have each changed
> > property to send a "PropertyChanged" signal with "Property name" and
> > "property specific info" params. But for "discoverable" and
> > "connectable" properties, how can we know what changed as both of them
> > trigger a command_complete event with HCI_write_scan_enable OCF?  Or
> > should we trigger a unique signal for pscan and iscan, sending the new
> > scan status?
>
> you need to track the HCI write scan enable command. You issue it with
> specific values and you need to keep this transition state until you
> receive the HCI command complete event. This is how the kernel is doing
> it for some of the commands.
>
> And I like the idea of a PropertyChanged signal.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT

------=_Part_2516_25839534.1133958549069
Content-Type: text/x-patch; name=dbus_device_scan.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dbus_device_scan.patch"

--- utils.05122005.orig/hcid/hcid.h	2005-12-05 11:28:17.000000000 -0300
+++ utils.05122005/hcid/hcid.h	2005-12-07 09:08:05.000000000 -0300
@@ -135,6 +135,7 @@
 void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason);
 void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status);
 void hcid_dbus_setname_complete(bdaddr_t *local);
+void hcid_dbus_setscan_enable_complete(bdaddr_t *local);
 #else
 static inline void hcid_dbus_inquiry_start(bdaddr_t *local) {}
 static inline void hcid_dbus_inquiry_complete(bdaddr_t *local) {}
@@ -145,6 +146,7 @@
 static inline void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason) {}
 static inline void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status) {}
 static inline void hcid_dbus_setname_complete(bdaddr_t *local) {}
+static inline void hcid_dbus_setscan_enable_complete(bdaddr_t *local) {}
 #endif
 
 int write_device_name(bdaddr_t *local, bdaddr_t *peer, char *name);
--- utils.05122005.orig/hcid/security.c	2005-12-05 11:28:17.000000000 -0300
+++ utils.05122005/hcid/security.c	2005-12-05 15:24:50.000000000 -0300
@@ -498,6 +498,8 @@
 	case cmd_opcode_pack(OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME):
 		hcid_dbus_setname_complete(sba);
 		break;
+	case cmd_opcode_pack(OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE):
+		hcid_dbus_setscan_enable_complete(sba);
 	};
 }
 
--- utils.05122005.orig/hcid/dbus.h	2005-12-05 11:28:17.000000000 -0300
+++ utils.05122005/hcid/dbus.h	2005-12-05 15:21:57.000000000 -0300
@@ -100,7 +100,7 @@
 #define DEV_HCI_INTERFACE		DEVICE_INTERFACE "." BLUEZ_HCI
 
 /* /org/bluez/Device signals */
-#define BLUEZ_HCI_SET_NAME		"DeviceNameChanged"
+#define BLUEZ_HCI_PROPERTY_CHANGED	"PropertyChanged"
 
 /* Control interface signals */
 #define BLUEZ_HCI_INQ_START		"InquiryStart"
@@ -227,6 +227,7 @@
 #define BLUEZ_EDBUS_NO_MEM   		(0x05 + BLUEZ_EDBUS_OFFSET)
 #define BLUEZ_EDBUS_CONN_NOT_FOUND	(0x06 + BLUEZ_EDBUS_OFFSET)
 #define BLUEZ_EDBUS_UNKNOWN_PATH	(0x07 + BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_NOT_IMPLEMENTED	(0x08 + BLUEZ_EDBUS_OFFSET)
 
 /* D-Bus error code, class BLUEZ_ESYSTEM_OFFSET */
 #define BLUEZ_ESYSTEM_ENODEV		(ENODEV + BLUEZ_ESYSTEM_OFFSET)
--- utils.05122005.orig/hcid/dbus.c	2005-12-05 11:28:17.000000000 -0300
+++ utils.05122005/hcid/dbus.c	2005-12-07 09:16:40.000000000 -0300
@@ -75,6 +75,7 @@
 struct hci_dbus_data {
 	uint16_t dev_id;
 	uint16_t path_id;
+	uint32_t path_data;
 };
 
 typedef int register_function_t(DBusConnection *conn, uint16_t id);
@@ -132,6 +133,7 @@
 	{ BLUEZ_EDBUS_NO_MEM,		"No memory"			},
 	{ BLUEZ_EDBUS_CONN_NOT_FOUND,	"Connection not found"		},
 	{ BLUEZ_EDBUS_UNKNOWN_PATH,	"Unknown D-BUS path"		},
+	{ BLUEZ_EDBUS_NOT_IMPLEMENTED,	"Method not implemented"	},
 	{ 0, NULL }
 };
 
@@ -270,34 +272,36 @@
  */
 static DBusMessage* handle_device_up_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_device_down_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_set_propety_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_get_propety_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_set_propety_req_name(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_get_propety_req_name(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_set_property_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_get_property_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_set_property_req_name(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_get_property_req_name(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_set_property_req_pscan(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_set_property_req_iscan(DBusMessage *msg, void *data);
 
 static const struct service_data device_services[] = {
 	{ DEV_UP,		handle_device_up_req,		DEV_UP_SIGNATURE		},
 	{ DEV_DOWN,		handle_device_down_req,		DEV_DOWN_SIGNATURE		},
-	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_BOOL	},
-	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_STR	},
-	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_BYTE	},
-	{ DEV_GET_PROPERTY,	handle_device_get_propety_req,	DEV_GET_PROPERTY_SIGNATURE	},
+	{ DEV_SET_PROPERTY,	handle_device_set_property_req,	DEV_SET_PROPERTY_SIGNATURE_BOOL	},
+	{ DEV_SET_PROPERTY,	handle_device_set_property_req,	DEV_SET_PROPERTY_SIGNATURE_STR	},
+	{ DEV_SET_PROPERTY,	handle_device_set_property_req,	DEV_SET_PROPERTY_SIGNATURE_BYTE	},
+	{ DEV_GET_PROPERTY,	handle_device_get_property_req,	DEV_GET_PROPERTY_SIGNATURE	},
 	{ NULL, NULL, NULL}
 };
 
 static const struct service_data set_property_services[] = {
 	{ DEV_PROPERTY_AUTH,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
 	{ DEV_PROPERTY_ENCRYPT,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
-	{ DEV_PROPERTY_PSCAN,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
-	{ DEV_PROPERTY_ISCAN,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
-	{ DEV_PROPERTY_NAME,		handle_device_set_propety_req_name,	DEV_SET_PROPERTY_SIGNATURE_STR		},
+	{ DEV_PROPERTY_PSCAN,		handle_device_set_property_req_pscan,	DEV_SET_PROPERTY_SIGNATURE_BOOL		},
+	{ DEV_PROPERTY_ISCAN,		handle_device_set_property_req_iscan,	DEV_SET_PROPERTY_SIGNATURE_BOOL		},
+	{ DEV_PROPERTY_NAME,		handle_device_set_property_req_name,	DEV_SET_PROPERTY_SIGNATURE_STR		},
 	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BYTE		},
 	{ NULL, NULL, NULL}
 };
 
 static const struct service_data get_property_services[] = {
 	{ DEV_PROPERTY_DEV_INFO,	handle_not_implemented_req,		DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_NAME,		handle_device_get_propety_req_name,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_NAME,		handle_device_get_property_req_name,	DEV_GET_PROPERTY_SIGNATURE 	},
 	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,		DEV_GET_PROPERTY_SIGNATURE 	},
 	{ NULL, NULL, NULL}
 };
@@ -936,12 +940,44 @@
 	char *pptr = path;
 	gboolean ret;
 	DBusMessage *message = NULL;
+	int dd = -1;
+	read_scan_enable_rp rp;
+	struct hci_request rq;
+	struct hci_dbus_data* pdata;
 
 	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
+	ret = register_dbus_path(path, DEVICE_PATH_ID, id, &obj_dev_vtable, FALSE);
+
+	dd = hci_open_dev(id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", id);
+		rp.enable = SCAN_PAGE|SCAN_INQUIRY;
+	} else {
+		memset(&rq, 0, sizeof(rq));
+		rq.ogf    = OGF_HOST_CTL;
+		rq.ocf    = OCF_READ_SCAN_ENABLE;
+		rq.rparam = &rp;
+		rq.rlen   = READ_SCAN_ENABLE_RP_SIZE;
+	
+		if (hci_send_req(dd, &rq, 500) < 0) {
+			syslog(LOG_ERR, "Sending read scan enable command failed: %s (%d)",
+								strerror(errno), errno);
+			rp.enable = SCAN_PAGE|SCAN_INQUIRY;
+		} else if (rp.status) {
+			syslog(LOG_ERR, "Getting scan enable failed with status 0x%02x",
+										rp.status);
+			rp.enable = SCAN_PAGE|SCAN_INQUIRY;
+		}
+	}
+
+	if (!dbus_connection_get_object_path_data(connection, path, (void*)&pdata))
+		syslog(LOG_ERR, "Getting path data failed!");
+	else
+		pdata->path_data = rp.enable; /* Keep the current scan status */
+
 
 	message = dbus_message_new_signal(MANAGER_PATH, MANAGER_INTERFACE,
 							BLUEZ_MGR_DEV_ADDED);
-
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
 		goto failed;
@@ -959,12 +995,13 @@
 	dbus_connection_flush(connection);
 
 failed:
-	dbus_message_unref(message);
-
-	ret = register_dbus_path(path, DEVICE_PATH_ID, id, &obj_dev_vtable, FALSE);
-
+	if (message)
+		dbus_message_unref(message);
+	
 	if (ret && default_dev < 0)
 		default_dev = id;
+	if (dd >= 0)
+		close(dd);
 
 	return ret;
 }
@@ -1934,7 +1971,7 @@
 	return reply;
 }
 
-static DBusMessage* handle_device_set_propety_req(DBusMessage *msg, void *data)
+static DBusMessage* handle_device_set_property_req(DBusMessage *msg, void *data)
 {
 	const struct service_data *handlers = set_property_services;
 	DBusMessageIter iter;
@@ -1968,7 +2005,7 @@
 	return reply;
 }
 
-static DBusMessage* handle_device_get_propety_req(DBusMessage *msg, void *data)
+static DBusMessage* handle_device_get_property_req(DBusMessage *msg, void *data)
 {
 	const struct service_data *handlers = get_property_services;
 	DBusMessageIter iter;
@@ -1994,7 +2031,7 @@
 	return reply;
 }
 
-static DBusMessage* handle_device_set_propety_req_name(DBusMessage *msg, void *data)
+static DBusMessage* handle_device_set_property_req_name(DBusMessage *msg, void *data)
 {
 	struct hci_dbus_data *dbus_data = data;
 	DBusMessageIter iter;
@@ -2065,7 +2102,8 @@
 	struct hci_request rq;
 	const char *pname = (char*) rp.name;
 	char name[249];
-
+	char prop_name[64];
+	char *pprop_name = prop_name;
 	baswap(&tmp, local); local_addr = batostr(&tmp);
 
 	id = hci_devid(local_addr);
@@ -2077,7 +2115,7 @@
 	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
 	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
-						BLUEZ_HCI_SET_NAME);
+						BLUEZ_HCI_PROPERTY_CHANGED);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
 		goto failed;
@@ -2107,11 +2145,14 @@
 	}
 
 	strncpy(name,pname,sizeof(name)-1);
-	name[248]='\0';
+	name[248] = '\0';
 	pname = name;
+	strncpy(prop_name, DEV_PROPERTY_NAME, sizeof(prop_name)-1);
+	prop_name[63] = '\0';
 
 	dbus_message_append_args(message,
 				DBUS_TYPE_STRING, &pname,
+				DBUS_TYPE_STRING, &pprop_name,
 				DBUS_TYPE_INVALID);
 
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {
@@ -2123,11 +2164,12 @@
 failed:
 	if (dd >= 0)
 		close(dd);
-	dbus_message_unref(message);
+	if (message)
+		dbus_message_unref(message);
 	bt_free(local_addr);
 }
 
-static DBusMessage* handle_device_get_propety_req_name(DBusMessage *msg, void *data)
+static DBusMessage* handle_device_get_property_req_name(DBusMessage *msg, void *data)
 {
 	struct hci_dbus_data *dbus_data = data;
 	DBusMessage *reply = NULL;
@@ -2183,6 +2225,220 @@
 	return reply;
 }
 
+static DBusMessage* write_scan_enable(DBusMessage *msg, void *data, gboolean ispscan)
+{
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	int dd = -1;
+	read_scan_enable_rp rp;
+	uint8_t enable;
+	uint8_t status;
+	struct hci_request rq;
+	gboolean scan;
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_get_basic(&iter, &scan);
+
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+		goto failed;
+	}
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_READ_SCAN_ENABLE;
+	rq.rparam = &rp;
+	rq.rlen   = READ_SCAN_ENABLE_RP_SIZE;
+
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Sending read scan enable command failed: %s (%d)",
+							strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	if (rp.status) {
+		syslog(LOG_ERR, "Getting scan enable failed with status 0x%02x",
+								 	rp.status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + rp.status);
+		goto failed;
+        }
+
+	if (ispscan) {
+		if (scan && !(rp.enable & SCAN_PAGE))
+			enable = (rp.enable & SCAN_INQUIRY) | SCAN_PAGE;
+		else if (!scan && (rp.enable & SCAN_PAGE))
+			enable = (rp.enable & SCAN_INQUIRY);
+		else {
+			reply = dbus_message_new_method_return(msg);
+			goto failed;
+		}
+	} else {
+		if (scan && !(rp.enable & SCAN_INQUIRY))
+			enable = (rp.enable & SCAN_PAGE) | SCAN_INQUIRY;
+		else if (!scan && (rp.enable & SCAN_INQUIRY))
+			enable = (rp.enable & SCAN_PAGE);
+		else {
+			reply = dbus_message_new_method_return(msg);
+			goto failed;
+		}
+	}
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_WRITE_SCAN_ENABLE;
+	rq.cparam = &enable;
+	rq.clen   = sizeof(enable);
+	rq.rparam = &status;
+	rq.rlen   = sizeof(status);
+
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Sending write scan enable command failed: %s (%d)",
+							strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+	if (status) {
+		syslog(LOG_ERR, "Setting scan enable failed with status 0x%02x", rp.status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + rp.status);
+		goto failed;
+	}
+	reply = dbus_message_new_method_return(msg);
+
+failed:
+	if (dd >= 0)
+		close(dd);
+	return reply;
+
+}
+
+void hcid_dbus_setscan_enable_complete(bdaddr_t *local)
+{
+	DBusMessage *message = NULL;
+	char path[MAX_PATH_LENGTH];
+	char *local_addr;
+	bdaddr_t tmp;
+	int id;
+	int dd = -1;
+	char prop_name[64];
+	char *pprop_name = prop_name;
+	gboolean se;
+	read_scan_enable_rp rp;
+	struct hci_request rq;
+	struct hci_dbus_data *pdata = NULL;
+	uint32_t old_data;
+
+	baswap(&tmp, local); local_addr = batostr(&tmp);
+	id = hci_devid(local_addr);
+	if (id < 0) {
+		syslog(LOG_ERR, "No matching device id for %s", local_addr);
+		goto failed;
+	}
+
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
+
+	dd = hci_open_dev(id);
+	memset(&rq, 0, sizeof(rq));
+
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", id);
+		goto failed;
+	} else {
+		rq.ogf    = OGF_HOST_CTL;
+		rq.ocf    = OCF_READ_SCAN_ENABLE;
+		rq.rparam = &rp;
+		rq.rlen   = READ_SCAN_ENABLE_RP_SIZE;
+		if (hci_send_req(dd, &rq, 100) < 0) {
+			syslog(LOG_ERR,
+				"Sending read scan enable command failed: %s (%d)",
+				strerror(errno), errno);
+			goto failed;
+		}
+		if (rp.status) {
+			syslog(LOG_ERR,
+				"Getting scan enable failed with status 0x%02x",
+				rp.status);
+			goto failed;
+		}
+	}
+
+	if (!dbus_connection_get_object_path_data(connection, path, (void*)&pdata)) {
+		syslog(LOG_ERR, "Getting path data failed!");
+		goto failed;
+	}
+
+	old_data = pdata->path_data;
+	pdata->path_data = rp.enable;
+
+	if((rp.enable & SCAN_PAGE) != (old_data & SCAN_PAGE)) {
+		message = dbus_message_new_signal(path, DEVICE_INTERFACE,
+							BLUEZ_HCI_PROPERTY_CHANGED);
+		if (message == NULL) {
+			syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
+			goto failed;
+		}
+
+		strncpy(prop_name,DEV_PROPERTY_PSCAN,sizeof(prop_name)-1);
+		prop_name[sizeof(prop_name)-1]='\0';
+
+		se = (rp.enable & SCAN_PAGE)?1:0;
+
+		dbus_message_append_args(message,
+					DBUS_TYPE_STRING, &pprop_name,
+					DBUS_TYPE_BOOLEAN, &se,
+					DBUS_TYPE_INVALID);
+
+		if (dbus_connection_send(connection, message, NULL) == FALSE) {
+			syslog(LOG_ERR, "Can't send D-BUS NameChanged signal");
+		}
+		dbus_message_unref(message);
+
+	}
+	if ((rp.enable & SCAN_INQUIRY) != (old_data & SCAN_INQUIRY)) {
+		message = dbus_message_new_signal(path, DEVICE_INTERFACE,
+							BLUEZ_HCI_PROPERTY_CHANGED);
+		if (message == NULL) {
+			syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
+			goto failed;
+		}
+
+		strncpy(prop_name,DEV_PROPERTY_ISCAN,sizeof(prop_name)-1);
+		prop_name[sizeof(prop_name)-1]='\0';
+
+		se = (rp.enable & SCAN_INQUIRY)?1:0;
+
+		dbus_message_append_args(message,
+					DBUS_TYPE_STRING, &pprop_name,
+					DBUS_TYPE_BOOLEAN, &se,
+					DBUS_TYPE_INVALID);
+
+		if (dbus_connection_send(connection, message, NULL) == FALSE) {
+			syslog(LOG_ERR, "Can't send D-BUS NameChanged signal");
+		}
+		dbus_message_unref(message);
+	}
+	dbus_connection_flush(connection);
+
+failed:
+	if (dd >= 0)
+		close(dd);
+	bt_free(local_addr);
+}
+
+static DBusMessage* handle_device_set_property_req_pscan(DBusMessage *msg, void *data)
+{
+	return write_scan_enable(msg, data, TRUE);
+}
+
+static DBusMessage* handle_device_set_property_req_iscan(DBusMessage *msg, void *data)
+{
+	return write_scan_enable(msg, data, FALSE);
+}
+
 static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data)
 {
 	DBusMessageIter iter;
@@ -2328,5 +2584,5 @@
 	syslog(LOG_INFO, "Not Implemented - path %s iface %s method %s",
 							path, iface, method);
 
-	return NULL;
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
 }
--- utils.05122005.orig/hcid/dbus-test	2005-12-05 11:28:17.000000000 -0300
+++ utils.05122005/hcid/dbus-test	2005-12-07 08:47:23.000000000 -0300
@@ -14,6 +14,9 @@
              "Connections", "Authenticate", "RoleSwitch" ]
 dev_setprop_bool = [ "auth", "encrypt", "discoverable", "connectable" ]
 dev_setprop_byte = [ "incmode" ]
+dev_prop_filter = ["/org/bluez/Device/hci0", "/org/bluez/Device/hci1",
+                   "/org/bluez/Device/hci2", "/org/bluez/Device/hci3",
+                   "/org/bluez/Device/hci4", "/org/bluez/Device/hci5"]
 
 class Tester:
     exit_events = []
@@ -81,10 +84,10 @@
 
                 self.dev.connect_to_signal('Up', self.dev_up)
                 self.dev.connect_to_signal('Down', self.dev_down)
-                self.bus.add_signal_receiver(self.dev_name_changed, 'DeviceNameChanged',
-                                             'org.bluez.Device', 'org.bluez',
-                                             '/org/bluez/Device/hci0')
-
+                for path in dev_prop_filter:
+                    self.bus.add_signal_receiver(self.dev_property_changed,
+                                             'PropertyChanged','org.bluez.Device',
+                                             'org.bluez',path)
                 obj = self.bus.get_object('org.bluez', '%s/Controller' % self.dev_path)
                 self.ctl = dbus.Interface(obj, 'org.bluez.Device.Controller')
 
@@ -157,10 +160,17 @@
         print 'Down'
 
     @dbus.decorators.explicitly_pass_message
-    def dev_name_changed(*args, **keywords):
-        name = args[1]
+    def dev_property_changed(*args, **keywords):
+        property = args[1]
+        param = args[2]
         dbus_message = keywords["dbus_message"]
-        print 'Device %s name changed: %s' % (dbus_message.get_path(), name)
+        if property == 'name':
+            print 'Device %s name changed: %s' % (dbus_message.get_path(), param)
+        elif property == 'connectable':
+            print 'Device %s connectable scan property changed: %d' % (dbus_message.get_path(), param)
+        elif property == 'discoverable':
+            print 'Device %s discoverable scan property changed: %d' % (dbus_message.get_path(), param)
+
 
     def signal_cb(self, sig, frame):
         print 'Caught signal, exiting'



------=_Part_2516_25839534.1133958549069--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
