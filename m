Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80511221152t2911f513jb28f3944097c1b09@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
In-Reply-To: <1132660308.28644.37.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_14013_14020529.1132689122205"
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com>
	 <20051108222033.GA12368@localhost.localdomain>
	 <1131489534.5544.20.camel@blade>
	 <3013cac80511171116n33c7faech6006e7264821fb16@mail.gmail.com>
	 <3013cac80511171252g4a4f1581l915e364a244ec8ea@mail.gmail.com>
	 <20051118082828.GA16438@localhost.localdomain>
	 <3013cac80511180251w1d2fa8f5s80ce1da7318327e7@mail.gmail.com>
	 <20051118112611.GA17062@localhost.localdomain>
	 <3013cac80511180500h5539d5d9y3f19ce224f9e38b7@mail.gmail.com>
	 <1132660308.28644.37.camel@blade>
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
Date: Tue, 22 Nov 2005 16:52:02 -0300

------=_Part_14013_14020529.1132689122205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

here is the new patch. I've removed the spaces (I hope so). I've also
included the code for the dbus signal for the local name change event.
One thing that remainded open was the timeout for hci_send_req for
name write and name read ops. In the hciconfig this was 2s and 1s. Is
there a reason for this big number?

BR,
Eduardo

On 11/22/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Eduardo,
>
> > here is the patch with a better implementation of dbus-test
> > SetProperty. I've also changed the "pscan" to "connectable" and
> > "iscan" to "discoverable".
>
> I basically missed this thread, but from a first look at the attached
> patch, I can tell that the coding style is wrong. Fix it and re-send it.
>
> Turn the whitespace visualization of editor on ;)
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT

------=_Part_14013_14020529.1132689122205
Content-Type: text/x-patch; name=dbus_device_nameV2.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dbus_device_nameV2.patch"

--- utils.17112005.orig/hcid/hcid.h	2005-11-17 12:57:42.000000000 -0300
+++ utils.22112005/hcid/hcid.h	2005-11-22 15:03:20.000000000 -0300
@@ -134,6 +134,7 @@
 void hcid_dbus_conn_complete(bdaddr_t *local, bdaddr_t *peer);
 void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason);
 void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status);
+void hcid_dbus_setname_complete(bdaddr_t *local);
 #else
 static inline void hcid_dbus_inquiry_start(bdaddr_t *local) {}
 static inline void hcid_dbus_inquiry_complete(bdaddr_t *local) {}
@@ -143,6 +144,7 @@
 static inline void hcid_dbus_conn_complete(bdaddr_t *local, bdaddr_t *peer) {}
 static inline void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason) {}
 static inline void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status) {}
+static inline void hcid_dbus_setname_complete(bdaddr_t *local) {}
 #endif
 
 int write_device_name(bdaddr_t *local, bdaddr_t *peer, char *name);
--- utils.17112005.orig/hcid/security.c	2005-11-17 12:57:42.000000000 -0300
+++ utils.22112005/hcid/security.c	2005-11-22 15:03:20.000000000 -0300
@@ -491,9 +491,14 @@
 static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 {
 	evt_cmd_complete *evt = ptr;
-
-	if (evt->opcode == cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY_CANCEL))
+	switch (evt->opcode) {
+	case cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY_CANCEL):
 		hcid_dbus_inquiry_complete(sba);
+		break;
+	case cmd_opcode_pack(OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME):
+		hcid_dbus_setname_complete(sba);
+		break;
+	};
 }
 
 static inline void remote_name_information(int dev, bdaddr_t *sba, void *ptr)
--- utils.17112005.orig/hcid/dbus.h	2005-11-17 12:57:42.000000000 -0300
+++ utils.22112005/hcid/dbus.h	2005-11-22 15:03:20.000000000 -0300
@@ -99,6 +99,9 @@
 #define BLUEZ_HCI			"Controller"
 #define DEV_HCI_INTERFACE		DEVICE_INTERFACE "." BLUEZ_HCI
 
+/* /org/bluez/Device signals */
+#define BLUEZ_HCI_SET_NAME		"DeviceNameChanged"
+
 /* Control interface signals */
 #define BLUEZ_HCI_INQ_START		"InquiryStart"
 #define BLUEZ_HCI_INQ_COMPLETE		"InquiryComplete"
@@ -125,40 +128,23 @@
 
 #define DEV_PROPERTY_AUTH		"auth"
 #define DEV_PROPERTY_ENCRYPT		"encrypt"
-#define DEV_PROPERTY_SECMGR		"secmgr"
-#define DEV_PROPERTY_PISCAN		"piscan"
-#define DEV_PROPERTY_PSCAN		"pscan"
-#define DEV_PROPERTY_ISCAN		"iscan"
-#define DEV_PROPERTY_PTYPE		"ptype"
-#define DEV_PROPERTY_LM			"lm"
-#define DEV_PROPERTY_LP			"lp"
+#define DEV_PROPERTY_PSCAN		"connectable"
+#define DEV_PROPERTY_ISCAN		"discoverable"
 #define DEV_PROPERTY_NAME		"name"
-#define DEV_PROPERTY_CLASS		"class"
-#define DEV_PROPERTY_VOICE		"voice"
-#define DEV_PROPERTY_IAC		"iac"
 #define DEV_PROPERTY_INCMODE		"incmode"
-#define DEV_PROPERTY_INCTYPE		"inctype"
-#define DEV_PROPERTY_INCPARMS		"incparms"
-#define DEV_PROPERTY_PAGEPARMS		"pageparms"
-#define DEV_PROPERTY_PAGETO		"pageto"
-#define DEV_PROPERTY_AFHMODE		"afhmode"
-#define DEV_PROPERTY_ACLMTU		"aclmtu"
-#define DEV_PROPERTY_SCOMTU		"scomtu"
-#define DEV_PROPERTY_PUTKEY		"putkey"
-#define DEV_PROPERTY_DELKEY		"delkey"
 #define DEV_PROPERTY_DEV_INFO		"info"
 
 #define DEV_UP_SIGNATURE			__END_SIG__
 #define DEV_DOWN_SIGNATURE			__END_SIG__
 #define DEV_RESET_SIGNATURE			__END_SIG__
-#define DEV_SET_PROPERTY_SIGNATURE_1		DBUS_TYPE_STRING_AS_STRING \
+#define DEV_SET_PROPERTY_SIGNATURE_BOOL		DBUS_TYPE_STRING_AS_STRING \
 						DBUS_TYPE_BOOLEAN_AS_STRING \
 						__END_SIG__
-#define DEV_SET_PROPERTY_SIGNATURE_2		DBUS_TYPE_STRING_AS_STRING \
+#define DEV_SET_PROPERTY_SIGNATURE_STR		DBUS_TYPE_STRING_AS_STRING \
 						DBUS_TYPE_STRING_AS_STRING \
 						__END_SIG__
-#define DEV_SET_PROPERTY_SIGNATURE_3		DBUS_TYPE_STRING_AS_STRING \
-						DBUS_TYPE_UINT16_AS_STRING \
+#define DEV_SET_PROPERTY_SIGNATURE_BYTE		DBUS_TYPE_STRING_AS_STRING \
+						DBUS_TYPE_BYTE_AS_STRING \
 						__END_SIG__
 
 #define DEV_GET_PROPERTY_SIGNATURE		DBUS_TYPE_STRING_AS_STRING \
--- utils.17112005.orig/hcid/dbus.c	2005-11-17 12:57:42.000000000 -0300
+++ utils.22112005/hcid/dbus.c	2005-11-22 16:31:26.000000000 -0300
@@ -272,59 +272,33 @@
 static DBusMessage* handle_device_down_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_device_set_propety_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_device_get_propety_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_set_propety_req_name(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_get_propety_req_name(DBusMessage *msg, void *data);
 
 static const struct service_data device_services[] = {
 	{ DEV_UP,		handle_device_up_req,		DEV_UP_SIGNATURE		},
 	{ DEV_DOWN,		handle_device_down_req,		DEV_DOWN_SIGNATURE		},
-	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_1	},
-	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_2	},
-	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_3	},
+	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_BOOL	},
+	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_STR	},
+	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_BYTE	},
 	{ DEV_GET_PROPERTY,	handle_device_get_propety_req,	DEV_GET_PROPERTY_SIGNATURE	},
 	{ NULL, NULL, NULL}
 };
 
 static const struct service_data set_property_services[] = {
-	{ DEV_PROPERTY_AUTH,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_ENCRYPT,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_SECMGR,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_PISCAN,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_PSCAN,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_ISCAN,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_PTYPE,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_LM,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_LP,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_NAME,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_CLASS,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_VOICE,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_IAC,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_INCTYPE,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_INCPARMS,	handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_PAGEPARMS,	handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_PAGETO,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_AFHMODE,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_ACLMTU,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_SCOMTU,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_PUTKEY,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
-	{ DEV_PROPERTY_DELKEY,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_AUTH,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
+	{ DEV_PROPERTY_ENCRYPT,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
+	{ DEV_PROPERTY_PSCAN,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
+	{ DEV_PROPERTY_ISCAN,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
+	{ DEV_PROPERTY_NAME,		handle_device_set_propety_req_name,	DEV_SET_PROPERTY_SIGNATURE_STR		},
+	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BYTE		},
 	{ NULL, NULL, NULL}
 };
 
 static const struct service_data get_property_services[] = {
-	{ DEV_PROPERTY_DEV_INFO,	handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_PTYPE,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_LM,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_LP,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_NAME,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_CLASS,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_VOICE,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_IAC,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_INCTYPE,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_INCPARMS,	handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_PAGEPARMS,	handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_PAGETO,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_AFHMODE,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_DEV_INFO,	handle_not_implemented_req,		DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_NAME,		handle_device_get_propety_req_name,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,		DEV_GET_PROPERTY_SIGNATURE 	},
 	{ NULL, NULL, NULL}
 };
 
@@ -435,8 +409,6 @@
 	gboolean ret = FALSE;
 	struct hci_dbus_data *data = NULL;
 
-	syslog(LOG_INFO, "Registering DBUS Path: %s", path);
-
 	data = malloc(sizeof(struct hci_dbus_data));
 	if (data == NULL) {
 		syslog(LOG_ERR, "Failed to alloc memory to DBUS path register data (%s)", path);
@@ -471,9 +443,7 @@
 {
 	void *data;
 
-	syslog(LOG_INFO, "Unregistering DBUS Path: %s", path);
-
-	if (dbus_connection_get_object_path_data(connection, path, &data) && data) 
+	if (dbus_connection_get_object_path_data(connection, path, &data) && data)
 		free(data);
 
 	if (!dbus_connection_unregister_object_path (connection, path)) {
@@ -1296,9 +1266,6 @@
 	method = dbus_message_get_member(msg);
 	signature = dbus_message_get_signature(msg);
 
-	syslog(LOG_INFO, "%s - path:%s, path_id:0x%04x dev_id:0x%04x", __PRETTY_FUNCTION__,
-			path, dbus_data->path_id, dbus_data->dev_id);
-
 	if (dbus_data->path_id == DEVICE_ROOT_ID) {
 		/* Device is down(path unregistered) or the path is wrong */
 		ret = DBUS_HANDLER_RESULT_HANDLED;
@@ -1369,8 +1336,6 @@
 	method = dbus_message_get_member(msg);
 	signature = dbus_message_get_signature(msg);
 
-	syslog (LOG_INFO, "%s - path:%s", __PRETTY_FUNCTION__, path);
-
 	if (strcmp(iface, MANAGER_INTERFACE) != 0)
 		return ret;
 
@@ -1976,7 +1941,7 @@
 	DBusMessage *reply = NULL;
 	const char *signature;
 	char *str_name;
-	uint32_t error = BLUEZ_EDBUS_UNKNOWN_METHOD;
+	uint32_t error = BLUEZ_EDBUS_WRONG_PARAM;
 
 	signature = dbus_message_get_signature(msg);
 
@@ -2009,7 +1974,7 @@
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	char *str_name;
-	uint32_t error = BLUEZ_EDBUS_UNKNOWN_METHOD;
+	uint32_t error = BLUEZ_EDBUS_WRONG_PARAM;
 
 
 	dbus_message_iter_init(msg, &iter);
@@ -2029,6 +1994,195 @@
 	return reply;
 }
 
+static DBusMessage* handle_device_set_propety_req_name(DBusMessage *msg, void *data)
+{
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	char *str_name;
+	int dd = -1;
+	uint8_t status;
+	change_local_name_cp cp;
+	struct hci_request rq;
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_get_basic(&iter, &str_name);
+
+	if(strlen(str_name) == 0) {
+		syslog(LOG_ERR, "HCI change name failed - Invalid Name!");
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
+		goto failed;
+	}
+
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+		goto failed;
+	}
+
+	memset(&rq, 0, sizeof(rq));
+	strncpy((char *) cp.name, str_name, sizeof(cp.name));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_CHANGE_LOCAL_NAME;
+	rq.cparam = &cp;
+	rq.clen   = CHANGE_LOCAL_NAME_CP_SIZE;
+	rq.rparam = &status;
+	rq.rlen   = sizeof(status);
+
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Sending change name command failed: %s (%d)",
+							strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	if (status) {
+		syslog(LOG_ERR, "Setting name failed with status 0x%02x", status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + status);
+		goto failed;
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+failed:
+	if (dd >= 0)
+		close(dd);
+
+	return reply;
+}
+
+void hcid_dbus_setname_complete(bdaddr_t *local)
+{
+	DBusMessage *message = NULL;
+	char path[MAX_PATH_LENGTH];
+	char *local_addr;
+	bdaddr_t tmp;
+	int id;
+	int dd = -1;
+	read_local_name_rp rp;
+	struct hci_request rq;
+	const char *pname = (char*) rp.name;
+	char name[249];
+
+	baswap(&tmp, local); local_addr = batostr(&tmp);
+
+	id = hci_devid(local_addr);
+	if (id < 0) {
+		syslog(LOG_ERR, "No matching device id for %s", local_addr);
+		goto failed;
+	}
+
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
+
+	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
+						BLUEZ_HCI_SET_NAME);
+	if (message == NULL) {
+		syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
+		goto failed;
+	}
+
+	dd = hci_open_dev(id);
+	memset(&rq, 0, sizeof(rq));
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", id);
+	} else {
+		rq.ogf    = OGF_HOST_CTL;
+		rq.ocf    = OCF_READ_LOCAL_NAME;
+		rq.rparam = &rp;
+		rq.rlen   = READ_LOCAL_NAME_RP_SIZE;
+		if (hci_send_req(dd, &rq, 100) < 0) {
+			syslog(LOG_ERR,
+				"Sending getting name command failed: %s (%d)",
+				strerror(errno), errno);
+			rp.name[0] = '\0';
+		}
+		if (rp.status) {
+			syslog(LOG_ERR,
+				"Getting name failed with status 0x%02x",
+				rp.status);
+			rp.name[0] = '\0';
+		}
+	}
+
+	strncpy(name,pname,sizeof(name)-1);
+	name[248]='\0';
+	pname = name;
+
+	dbus_message_append_args(message,
+				DBUS_TYPE_STRING, &pname,
+				DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send(connection, message, NULL) == FALSE) {
+		syslog(LOG_ERR, "Can't send D-BUS NameChanged signal");
+		goto failed;
+	}
+	dbus_connection_flush(connection);
+
+failed:
+	if (dd >= 0)
+		close(dd);
+	dbus_message_unref(message);
+	bt_free(local_addr);
+}
+
+static DBusMessage* handle_device_get_propety_req_name(DBusMessage *msg, void *data)
+{
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+	int dd = -1;
+	read_local_name_rp rp;
+	struct hci_request rq;
+	const char *pname = (char*) rp.name;
+	char name[249];
+
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+		goto failed;
+	}
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_READ_LOCAL_NAME;
+	rq.rparam = &rp;
+	rq.rlen   = READ_LOCAL_NAME_RP_SIZE;
+
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Sending getting name command failed: %s (%d)",
+							strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	if (rp.status) {
+		syslog(LOG_ERR, "Getting name failed with status 0x%02x", rp.status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + rp.status);
+		goto failed;
+        }
+
+	reply = dbus_message_new_method_return(msg);
+	if (reply == NULL) {
+		syslog(LOG_ERR, "Out of memory while calling dbus_message_new_method_return");
+		goto failed;
+	}
+
+	strncpy(name,pname,sizeof(name)-1);
+	name[248]='\0';
+	pname = name;
+
+	dbus_message_append_args(reply,
+				DBUS_TYPE_STRING, &pname,
+				DBUS_TYPE_INVALID);
+
+failed:
+	if (dd >= 0)
+		close(dd);
+
+	return reply;
+}
+
 static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data)
 {
 	DBusMessageIter iter;
--- utils.17112005.orig/hcid/dbus-test	2005-11-17 12:57:42.000000000 -0300
+++ utils.22112005/hcid/dbus-test	2005-11-22 15:21:53.000000000 -0300
@@ -1,6 +1,7 @@
 #!/usr/bin/env python
 
 import dbus
+import dbus.decorators
 import dbus.glib
 import gobject
 import sys
@@ -8,9 +9,11 @@
 from signal import *
 
 mgr_cmds = [ "DeviceList", "DefaultDevice" ]
-dev_cmds = [ "Up", "Down", "Inquiry", "CancelInquiry", "PeriodicInquiry",
-             "CancelPeriodic", "RemoteName", "Connections", "Authenticate",
-             "RoleSwitch" ]
+dev_cmds = [ "Up", "Down", "SetProperty", "GetProperty", "Inquiry",
+             "CancelInquiry", "PeriodicInquiry","CancelPeriodic", "RemoteName",
+             "Connections", "Authenticate", "RoleSwitch" ]
+dev_setprop_bool = [ "auth", "encrypt", "discoverable", "connectable" ]
+dev_setprop_byte = [ "incmode" ]
 
 class Tester:
     exit_events = []
@@ -78,6 +81,9 @@
 
                 self.dev.connect_to_signal('Up', self.dev_up)
                 self.dev.connect_to_signal('Down', self.dev_down)
+                self.bus.add_signal_receiver(self.dev_name_changed, 'DeviceNameChanged',
+                                             'org.bluez.Device', 'org.bluez',
+                                             '/org/bluez/Device/hci0')
 
                 obj = self.bus.get_object('org.bluez', '%s/Controller' % self.dev_path)
                 self.ctl = dbus.Interface(obj, 'org.bluez.Device.Controller')
@@ -150,6 +156,12 @@
     def dev_down(self):
         print 'Down'
 
+    @dbus.decorators.explicitly_pass_message
+    def dev_name_changed(*args, **keywords):
+        name = args[1]
+        dbus_message = keywords["dbus_message"]
+        print 'Device %s name changed: %s' % (dbus_message.get_path(), name)
+
     def signal_cb(self, sig, frame):
         print 'Caught signal, exiting'
         if self.at_interrupt:
@@ -179,7 +191,29 @@
             except dbus.DBusException, e:
                 print 'Sending %s failed: %s' % (self.cmd, e)
                 sys.exit(1)
-
+        elif self.cmd == 'SetProperty':
+            if len(self.cmd_args) < 2:
+                print 'Usage: %s -i <dev> SetProperty strPropName arg' % self.name
+                sys.exit(1)
+            try:
+                if self.cmd_args[0].lower() in dev_setprop_bool:
+                    self.dev.SetProperty(self.cmd_args[0], dbus.Boolean(self.cmd_args[1]))
+                elif self.cmd_args[0].lower() in dev_setprop_byte:
+                    self.dev.SetProperty(self.cmd_args[0], dbus.Byte(self.cmd_args[1]))
+                else:
+                    self.dev.SetProperty(self.cmd_args[0], self.cmd_args[1])
+            except dbus.DBusException, e:
+                print 'Sending %s failed: %s' % (self.cmd, e)
+                sys.exit(1)
+        elif self.cmd == 'GetProperty':
+            if len(self.cmd_args) < 1:
+                print 'Usage: %s -i <dev> GetProperty strPropName' % self.name
+                sys.exit(1)
+            try:
+                print self.dev.GetProperty(self.cmd_args[0])
+            except dbus.DBusException, e:
+                print 'Sending %s failed: %s' % (self.cmd, e)
+                sys.exit(1)
         # Device.Controller methods
         elif self.cmd == 'Inquiry':
             try:

------=_Part_14013_14020529.1132689122205--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
