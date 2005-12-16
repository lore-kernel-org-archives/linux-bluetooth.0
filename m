Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80512161037q19c19ecamafe77a379fec2ed0@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
In-Reply-To: <3013cac80512141102k2dbe40c9q7b25deebb9e4fae9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_897_18941015.1134758230792"
References: <1132872886.3170.3.camel@blade>
	 <3013cac80512010855v46eeb99dk3a53094238800621@mail.gmail.com>
	 <1133471112.18554.8.camel@blade>
	 <3013cac80512070429g5fb992b7i7131d570f9023086@mail.gmail.com>
	 <20051207125556.GA13152@localhost.localdomain>
	 <1133960579.3752.17.camel@blade>
	 <3013cac80512070801o5b60cc20y7098dc36f2326458@mail.gmail.com>
	 <3013cac80512130927k1d83978ey33be0540e15a08ba@mail.gmail.com>
	 <1134511385.24447.15.camel@blade>
	 <3013cac80512141102k2dbe40c9q7b25deebb9e4fae9@mail.gmail.com>
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
Date: Fri, 16 Dec 2005 15:37:10 -0300

------=_Part_897_18941015.1134758230792
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

here is the patch for set auth enable. This patch should be applied
after the last scan patch. Let me know if there is any problem.

BR,
Eduardo

On 12/14/05, Eduardo Rocha <folhabranca@gmail.com> wrote:
> Hi Marcel,
>
> here is the new patch.
>
> BR,
> Eduardo.
>
>
> On 12/13/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Eduardo,
> >
> > > here is the patch with the send_property_changed_signal function incl=
uded.
> >
> > nice, but please follow the coding style. I don't wanna correct the
> > whitespaces in all patches. Some examples what should be changed:
> >
> > (void*)&pdata                           =3D=3D> (void *) &pdata
> > =3D SCAN_PAGE|SCAN_INQUIRY;               =3D=3D> =3D SCAN_PAGE | SCAN_=
INQUIRY;
> > se =3D (rp.enable & SCAN_PAGE)?1:0;       se =3D (rp.enable & SCAN_PAGE=
) ? 1 : 0;
> >
> > This is also bad coding style:
> >
> >        if (dd < 0) {
> >                syslog(LOG_ERR, "HCI device open failed: hci%d", id);
> >                goto failed;
> >        } else {
> >
> > We don't need the else branch. I results in an needless indentation.
> >
> > I also think that we need some more newlines in your code, but I am
> > going to fix it when applying the patch.
> >
> > This part might work, but I don't like it:
> >
> >        if (ispscan) {
> >                if (scan && !(rp.enable & SCAN_PAGE))
> >                        enable =3D (rp.enable & SCAN_INQUIRY) | SCAN_PAG=
E;
> >                else if (!scan && (rp.enable & SCAN_PAGE))
> >                        enable =3D (rp.enable & SCAN_INQUIRY);
> >                else {
> >                        reply =3D dbus_message_new_method_return(msg);
> >                        goto failed;
> >                }
> >        } else {
> >                if (scan && !(rp.enable & SCAN_INQUIRY))
> >                        enable =3D (rp.enable & SCAN_PAGE) | SCAN_INQUIR=
Y;
> >                else if (!scan && (rp.enable & SCAN_INQUIRY))
> >                        enable =3D (rp.enable & SCAN_PAGE);
> >                else {
> >                        reply =3D dbus_message_new_method_return(msg);
> >                        goto failed;
> >                }
> >        }
> >
> > And this includes this:
> >
> >        if((rp.enable & SCAN_PAGE) !=3D (old_data & SCAN_PAGE)) {
> >                se =3D (rp.enable & SCAN_PAGE)?1:0;
> >                send_property_changed_signal(id, DEV_PROPERTY_PSCAN, DBU=
S_TYPE_BOOLEAN, &se);
> >        }
> >        if ((rp.enable & SCAN_INQUIRY) !=3D (old_data & SCAN_INQUIRY)) {
> >                se =3D (rp.enable & SCAN_INQUIRY)?1:0;
> >                send_property_changed_signal(id, DEV_PROPERTY_ISCAN, DBU=
S_TYPE_BOOLEAN, &se);
> >        }
> >        dbus_connection_flush(connection);
> >
> > I don't have any better idea to solve this at the moment, but if you
> > read this code it takes too much time too understand what it is actuall=
y
> > doing. And normally this is not a good idea. However we might fix it
> > later and get the patch in now for further testing. So please correct
> > the other parts and resend it.
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: Splunk Inc. Do you grep through log =
files
> > for problems?  Stop!  Download the new AJAX search engine that makes
> > searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> > http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>
>
> --
> Eduardo Rocha
> Instituto Nokia de Tecnologia - INdT
>
>
>


--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT

------=_Part_897_18941015.1134758230792
Content-Type: text/x-patch; name=dbus_device_auth.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dbus_device_auth.patch"

--- utils.15122005.orig/hcid/hcid.h	2005-12-15 10:38:12.000000000 -0300
+++ utils.15122005/hcid/hcid.h	2005-12-15 12:13:31.000000000 -0300
@@ -136,6 +136,7 @@
 void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status);
 void hcid_dbus_setname_complete(bdaddr_t *local);
 void hcid_dbus_setscan_enable_complete(bdaddr_t *local);
+void hcid_dbus_setauth_enable_complete(bdaddr_t *local);
 #else
 static inline void hcid_dbus_inquiry_start(bdaddr_t *local) {}
 static inline void hcid_dbus_inquiry_complete(bdaddr_t *local) {}
@@ -147,6 +148,7 @@
 static inline void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status) {}
 static inline void hcid_dbus_setname_complete(bdaddr_t *local) {}
 static inline void hcid_dbus_setscan_enable_complete(bdaddr_t *local) {}
+static inline void hcid_dbus_setauth_enable_complete(bdaddr_t *local) {}
 #endif
 
 int write_device_name(bdaddr_t *local, bdaddr_t *peer, char *name);
--- utils.15122005.orig/hcid/security.c	2005-12-15 10:38:12.000000000 -0300
+++ utils.15122005/hcid/security.c	2005-12-15 12:15:00.000000000 -0300
@@ -500,6 +500,10 @@
 		break;
 	case cmd_opcode_pack(OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE):
 		hcid_dbus_setscan_enable_complete(sba);
+		break;
+	case cmd_opcode_pack(OGF_HOST_CTL, OCF_WRITE_AUTH_ENABLE):
+		hcid_dbus_setauth_enable_complete(sba);
+		break;
 	};
 }
 
--- utils.15122005.orig/hcid/dbus.h	2005-12-15 10:38:12.000000000 -0300
+++ utils.15122005/hcid/dbus.h	2005-12-15 12:11:46.000000000 -0300
@@ -131,7 +131,7 @@
 #define DEV_PROPERTY_PSCAN		"connectable"
 #define DEV_PROPERTY_ISCAN		"discoverable"
 #define DEV_PROPERTY_NAME		"name"
-#define DEV_PROPERTY_INCMODE		"incmode"
+#define DEV_PROPERTY_INCMODE		"inqmode"
 #define DEV_PROPERTY_DEV_INFO		"info"
 
 #define DEV_UP_SIGNATURE			__END_SIG__
--- utils.15122005.orig/hcid/dbus.c	2005-12-15 10:38:12.000000000 -0300
+++ utils.15122005/hcid/dbus.c	2005-12-16 12:24:29.000000000 -0300
@@ -112,6 +112,12 @@
 	unsigned int val;
 } hci_map;
 
+typedef struct {
+	uint8_t status;
+	uint8_t enable;
+} __attribute__ ((packed)) read_auth_enable_rp;
+#define READ_AUTH_ENABLE_RP_SIZE 2
+
 static hci_map dev_flags_map[] = {
 	{ "INIT",	HCI_INIT	},
 	{ "RUNNING",	HCI_RUNNING	},
@@ -278,6 +284,7 @@
 static DBusMessage* handle_device_get_property_req_name(DBusMessage *msg, void *data);
 static DBusMessage* handle_device_set_property_req_pscan(DBusMessage *msg, void *data);
 static DBusMessage* handle_device_set_property_req_iscan(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_set_property_req_auth(DBusMessage *msg, void *data);
 
 static const struct service_data device_services[] = {
 	{ DEV_UP,		handle_device_up_req,		DEV_UP_SIGNATURE		},
@@ -290,7 +297,7 @@
 };
 
 static const struct service_data set_property_services[] = {
-	{ DEV_PROPERTY_AUTH,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
+	{ DEV_PROPERTY_AUTH,		handle_device_set_property_req_auth,	DEV_SET_PROPERTY_SIGNATURE_BOOL		},
 	{ DEV_PROPERTY_ENCRYPT,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
 	{ DEV_PROPERTY_PSCAN,		handle_device_set_property_req_pscan,	DEV_SET_PROPERTY_SIGNATURE_BOOL		},
 	{ DEV_PROPERTY_ISCAN,		handle_device_set_property_req_iscan,	DEV_SET_PROPERTY_SIGNATURE_BOOL		},
@@ -2241,7 +2248,7 @@
 	uint8_t status;
 	uint8_t scan_change, scan_keep;
 	struct hci_request rq;
-	gboolean prop_value; /* new requested value for the iscan or pscan */
+	dbus_bool_t prop_value; /* new requested value for the iscan or pscan */
 
 	dbus_message_iter_init(msg, &iter);
 	dbus_message_iter_next(&iter);
@@ -2332,7 +2339,7 @@
 	bdaddr_t tmp;
 	int id;
 	int dd = -1;
-	gboolean se;
+	dbus_bool_t se;
 	read_scan_enable_rp rp;
 	struct hci_request rq;
 	struct hci_dbus_data *pdata = NULL;
@@ -2408,6 +2415,130 @@
 	return write_scan_enable(msg, data, FALSE);
 }
 
+static DBusMessage* handle_device_set_property_req_auth(DBusMessage *msg, void *data)
+{
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	int dd = -1;
+	uint8_t enable;
+	uint8_t status;
+	struct hci_request rq;
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_get_basic(&iter, &enable);
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
+	rq.ocf    = OCF_WRITE_AUTH_ENABLE;
+	rq.cparam = &enable;
+	rq.clen   = sizeof(enable);
+	rq.rparam = &status;
+	rq.rlen   = sizeof(status);
+
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Sending auth enable command failed: %s (%d)",
+							strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	if (status) {
+		syslog(LOG_ERR, "Enable authentication command failed with status 0x%02x",
+								 	status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + status);
+		goto failed;
+        }
+	reply = dbus_message_new_method_return(msg);
+
+failed:
+	if (dd >= 0)
+		close(dd);
+	return reply;
+}
+
+void hcid_dbus_setauth_enable_complete(bdaddr_t *local)
+{
+	DBusMessage *message = NULL;
+	char *local_addr;
+	char path[MAX_PATH_LENGTH];
+	char *ppath = path;
+	bdaddr_t tmp;
+	int id;
+	int dd = -1;
+	read_auth_enable_rp rp;
+	struct hci_request rq;
+	dbus_bool_t outparam;
+
+	baswap(&tmp, local); local_addr = batostr(&tmp);
+	id = hci_devid(local_addr);
+	if (id < 0) {
+		syslog(LOG_ERR, "No matching device id for %s", local_addr);
+		goto failed;
+	}
+
+	snprintf(path, sizeof(path) - 1, "%s/hci%d", DEVICE_PATH, id);
+	path[MAX_PATH_LENGTH-1]='\0';
+
+	dd = hci_open_dev(id);
+	memset(&rq, 0, sizeof(rq));
+
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", id);
+		goto failed;
+	}
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_READ_AUTH_ENABLE;
+	rq.rparam = &rp;
+	rq.rlen   = READ_AUTH_ENABLE_RP_SIZE;
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR,
+			"Sending read auth enable command failed: %s (%d)",
+			strerror(errno), errno);
+		goto failed;
+	}
+	if (rp.status) {
+		syslog(LOG_ERR,
+			"Getting auth enable failed with status 0x%02x",
+			rp.status);
+		goto failed;
+	}
+
+	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
+						BLUEZ_HCI_PROPERTY_CHANGED);
+	if (message == NULL) {
+		syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
+		goto failed;
+	}
+
+	strcpy(path, DEV_PROPERTY_AUTH);
+	outparam = rp.enable;
+	dbus_message_append_args(message,
+				DBUS_TYPE_STRING, &ppath,
+				DBUS_TYPE_BOOLEAN, &outparam,
+				DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send(connection, message, NULL) == FALSE) {
+		syslog(LOG_ERR, "Can't send D-BUS PropertChanged(%s) signal", DEV_PROPERTY_AUTH);
+		goto failed;
+	}
+
+	dbus_connection_flush(connection);
+
+failed:
+	if (dd >= 0)
+		close(dd);
+	bt_free(local_addr);
+}
+
 static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data)
 {
 	DBusMessageIter iter;

------=_Part_897_18941015.1134758230792--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
