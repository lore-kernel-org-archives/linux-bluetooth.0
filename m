Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0601300944i45664a73v999c155298825117@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Cleaning up the D-Bus interface
In-Reply-To: <1138304710.5901.106.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_15003_17732616.1138643051138"
References: <1135111693.26233.11.camel@localhost>
	 <3013cac80512211216r3918594dv676e03480d83f5b3@mail.gmail.com>
	 <1135196479.3781.10.camel@localhost>
	 <3013cac80512220511u9ecac97haf7278614bfe085a@mail.gmail.com>
	 <1135271815.6002.96.camel@localhost>
	 <3013cac80512230528y5b879d2bh2dbcb4e0fe18e974@mail.gmail.com>
	 <1135350634.3985.2.camel@localhost>
	 <1135434294.1008.3.camel@localhost>
	 <e1effdeb0601251054m6ac203ceu4901dca319212d2@mail.gmail.com>
	 <1138304710.5901.106.camel@localhost>
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
Date: Mon, 30 Jan 2006 15:44:11 -0200

------=_Part_15003_17732616.1138643051138
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is the patch following your suggestion.

Now, we introduced a problem. How handle scenarios where other
application/or hciconfig changes the scan mode, enabling the Inquiry
Scan only? :) In the current patch, I am ignoring the HCI command
complete event for this case.

When we close this discussion I can start play with the discoverable time s=
tuff.

Regards,
Claudio.

On 1/26/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > This patch is based on your discussion, but there are some changes:
> > 1. The scan enable values are based on the Bluetooth Spec in order to
> > make the logic more clear:
> > mode 0x00       =3D Off (means down or deep-sleep)
> > mode 0x01       =3D Discoverable (NOT ALLOWED)
> > mode 0x02       =3D Connectable
> > mode 0x03       =3D Connectable and Discoverable
>
> actually I didn't used the values from the specification on purpose. On
> future idea is that we support discoverable for them time and the client
> doesn't have to take care when to switch inquiry scan off again. As I
> sometimes mentioned, it might be good to not follow the specification
> for the D-Bus API. The hcid/bluetoothd will hide all implementation
> details.
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
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_15003_17732616.1138643051138
Content-Type: text/x-patch; name=scan02.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="scan02.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2006-01-03 11:28:58.000000000 -0200
+++ bluez-utils-cvs-scan/hcid/dbus.h	2006-01-30 11:56:17.000000000 -0200
@@ -101,6 +101,7 @@
 
 /* /org/bluez/Device signals */
 #define BLUEZ_HCI_PROPERTY_CHANGED	"PropertyChanged"
+#define BLUEZ_HCI_SCAN_MODE_CHANGED	"ModeChanged"
 
 /* Control interface signals */
 #define BLUEZ_HCI_INQ_START		"InquiryStart"
@@ -125,6 +126,13 @@
 #define DEV_DOWN			"Down"
 #define DEV_SET_PROPERTY		"SetProperty"
 #define DEV_GET_PROPERTY		"GetProperty"
+#define DEV_SET_MODE			"SetMode"
+#define DEV_GET_MODE			"GetMode"
+
+/* SetMode constants, see Bluetooth spec write scan enable command section */
+#define MODE_SCAN_OFF			0x00
+#define MODE_CONNECTABLE		0x01
+#define MODE_CONNECTABLE_DISCOVERABLE	0x02
 
 #define DEV_PROPERTY_AUTH		"auth"
 #define DEV_PROPERTY_ENCRYPT		"encrypt"
@@ -136,7 +144,9 @@
 
 #define DEV_UP_SIGNATURE			__END_SIG__
 #define DEV_DOWN_SIGNATURE			__END_SIG__
-#define DEV_RESET_SIGNATURE			__END_SIG__
+#define DEV_SET_MODE_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING\
+						__END_SIG__
+#define DEV_GET_MODE_SIGNATURE			__END_SIG__
 #define DEV_SET_PROPERTY_SIGNATURE_BOOL		DBUS_TYPE_STRING_AS_STRING \
 						DBUS_TYPE_BOOLEAN_AS_STRING \
 						__END_SIG__
--- bluez-utils-cvs.orig/hcid/dbus.c	2006-01-03 11:28:58.000000000 -0200
+++ bluez-utils-cvs-scan/hcid/dbus.c	2006-01-30 12:17:15.000000000 -0200
@@ -276,16 +276,18 @@
  */
 static DBusMessage* handle_device_up_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_device_down_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_get_mode_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_set_mode_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_device_set_property_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_device_get_property_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_device_set_property_req_name(DBusMessage *msg, void *data);
 static DBusMessage* handle_device_get_property_req_name(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_set_property_req_pscan(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_set_property_req_iscan(DBusMessage *msg, void *data);
 
 static const struct service_data device_services[] = {
 	{ DEV_UP,		handle_device_up_req,		DEV_UP_SIGNATURE		},
 	{ DEV_DOWN,		handle_device_down_req,		DEV_DOWN_SIGNATURE		},
+	{ DEV_GET_MODE,		handle_device_get_mode_req,	DEV_GET_MODE_SIGNATURE		},
+	{ DEV_SET_MODE,		handle_device_set_mode_req,	DEV_SET_MODE_SIGNATURE		},
 	{ DEV_SET_PROPERTY,	handle_device_set_property_req,	DEV_SET_PROPERTY_SIGNATURE_BOOL	},
 	{ DEV_SET_PROPERTY,	handle_device_set_property_req,	DEV_SET_PROPERTY_SIGNATURE_STR	},
 	{ DEV_SET_PROPERTY,	handle_device_set_property_req,	DEV_SET_PROPERTY_SIGNATURE_BYTE	},
@@ -296,8 +298,6 @@
 static const struct service_data set_property_services[] = {
 	{ DEV_PROPERTY_AUTH,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
 	{ DEV_PROPERTY_ENCRYPT,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
-	{ DEV_PROPERTY_PSCAN,		handle_device_set_property_req_pscan,	DEV_SET_PROPERTY_SIGNATURE_BOOL		},
-	{ DEV_PROPERTY_ISCAN,		handle_device_set_property_req_iscan,	DEV_SET_PROPERTY_SIGNATURE_BOOL		},
 	{ DEV_PROPERTY_NAME,		handle_device_set_property_req_name,	DEV_SET_PROPERTY_SIGNATURE_STR		},
 	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BYTE		},
 	{ NULL, NULL, NULL}
@@ -1993,6 +1993,106 @@
 	return reply;
 }
 
+static DBusMessage* handle_device_get_mode_req(DBusMessage *msg, void *data)
+{
+	const struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+	const uint8_t hci_mode = dbus_data->path_data;
+	uint8_t scan_mode;
+
+	switch (hci_mode) {
+	case SCAN_DISABLED:
+		scan_mode = MODE_SCAN_OFF;
+	case SCAN_PAGE:
+		scan_mode = MODE_CONNECTABLE;
+	case (SCAN_PAGE | SCAN_INQUIRY):
+		scan_mode = MODE_CONNECTABLE_DISCOVERABLE;
+	case SCAN_INQUIRY:
+	default:
+		/* reserved */
+		scan_mode = 0xff;
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_append_args(reply,
+				 DBUS_TYPE_BYTE, &scan_mode,
+				 DBUS_TYPE_INVALID);
+
+	return reply;
+}
+
+static DBusMessage* handle_device_set_mode_req(DBusMessage *msg, void *data)
+{
+	const struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+	struct hci_request rq;
+	int dd = -1;
+	const uint8_t scan_mode;
+	uint8_t hci_mode;
+	uint8_t status = 0;
+	const uint8_t current_mode = dbus_data->path_data;
+
+	dbus_message_get_args(msg, NULL,
+			      DBUS_TYPE_BYTE, &scan_mode,
+			      DBUS_TYPE_INVALID);
+
+	switch (scan_mode) {
+	case MODE_SCAN_OFF:
+		hci_mode = SCAN_DISABLED;
+		break;
+	case MODE_CONNECTABLE:
+		hci_mode = SCAN_PAGE;
+		break;
+	case MODE_CONNECTABLE_DISCOVERABLE:
+		hci_mode = (SCAN_PAGE | SCAN_INQUIRY);
+		break;
+	default:
+		/* invalid mode */
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
+	/* Check if the new requested mode is different from the current */
+	if (current_mode != hci_mode) {
+		memset(&rq, 0, sizeof(rq));
+		rq.ogf    = OGF_HOST_CTL;
+		rq.ocf    = OCF_WRITE_SCAN_ENABLE;
+		rq.cparam = &hci_mode;
+		rq.clen   = sizeof(hci_mode);
+		rq.rparam = &status;
+		rq.rlen   = sizeof(status);
+
+		if (hci_send_req(dd, &rq, 100) < 0) {
+			syslog(LOG_ERR, "Sending write scan enable command failed: %s (%d)",
+			       strerror(errno), errno);
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
+			goto failed;
+		}
+		if (status) {
+			syslog(LOG_ERR, "Setting scan enable failed with status 0x%02x", status);
+			reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET | status);
+			goto failed;
+		}
+
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
 static DBusMessage* handle_device_set_property_req(DBusMessage *msg, void *data)
 {
 	const struct service_data *handlers = set_property_services;
@@ -2258,113 +2358,18 @@
 	return reply;
 }
 
-static DBusMessage* write_scan_enable(DBusMessage *msg, void *data, gboolean ispscan)
-{
-	struct hci_dbus_data *dbus_data = data;
-	DBusMessageIter iter;
-	DBusMessage *reply = NULL;
-	int dd = -1;
-	read_scan_enable_rp rp;
-	uint8_t enable;
-	uint8_t status;
-	uint8_t scan_change, scan_keep;
-	struct hci_request rq;
-	gboolean prop_value; /* new requested value for the iscan or pscan */
-
-	dbus_message_iter_init(msg, &iter);
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_get_basic(&iter, &prop_value);
-
-	dd = hci_open_dev(dbus_data->dev_id);
-	if (dd < 0) {
-		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-		goto failed;
-	}
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_HOST_CTL;
-	rq.ocf    = OCF_READ_SCAN_ENABLE;
-	rq.rparam = &rp;
-	rq.rlen   = READ_SCAN_ENABLE_RP_SIZE;
-
-	if (hci_send_req(dd, &rq, 100) < 0) {
-		syslog(LOG_ERR, "Sending read scan enable command failed: %s (%d)",
-							strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
-	}
-
-	if (rp.status) {
-		syslog(LOG_ERR, "Getting scan enable failed with status 0x%02x",
-								 	rp.status);
-		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + rp.status);
-		goto failed;
-        }
-
-	if (ispscan) { /* Page scan */
-		scan_change = SCAN_PAGE;
-		scan_keep = SCAN_INQUIRY;
-	} else { /* Inquiry scan */
-		scan_change = SCAN_INQUIRY;
-		scan_keep = SCAN_PAGE;
-	}
-
-	/* This is an optimization. We want to avoid overwrite the value
-	if the requested scan property will not change. */
-	if (prop_value && !(rp.enable & scan_change))
-		/* Enable the requested scan type (e.g. page scan). Keep the
-		the other type untouched. */
-		enable = (rp.enable & scan_keep) | scan_change;
-	else if (!prop_value && (rp.enable & scan_change))
-		/* Disable the requested scan type (e.g. page scan). Keep the
-		the other type untouched. */
-		enable = (rp.enable & scan_keep);
-	else { /* Property not changed. Do nothing. Return ok. */
-		reply = dbus_message_new_method_return(msg);
-		goto failed;
-	}
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_HOST_CTL;
-	rq.ocf    = OCF_WRITE_SCAN_ENABLE;
-	rq.cparam = &enable;
-	rq.clen   = sizeof(enable);
-	rq.rparam = &status;
-	rq.rlen   = sizeof(status);
-
-	if (hci_send_req(dd, &rq, 100) < 0) {
-		syslog(LOG_ERR, "Sending write scan enable command failed: %s (%d)",
-							strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
-	}
-	if (status) {
-		syslog(LOG_ERR, "Setting scan enable failed with status 0x%02x", rp.status);
-		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + rp.status);
-		goto failed;
-	}
-	reply = dbus_message_new_method_return(msg);
-
-failed:
-	if (dd >= 0)
-		close(dd);
-	return reply;
-
-}
-
 void hcid_dbus_setscan_enable_complete(bdaddr_t *local)
 {
+	DBusMessage *message = NULL;
+	struct hci_dbus_data *pdata = NULL;
 	char *local_addr;
 	char path[MAX_PATH_LENGTH];
 	bdaddr_t tmp;
-	int id;
-	int dd = -1;
-	gboolean se;
 	read_scan_enable_rp rp;
 	struct hci_request rq;
-	struct hci_dbus_data *pdata = NULL;
-	uint32_t old_data;
+	int id;
+	int dd = -1;
+	uint8_t scan_mode;
 
 	baswap(&tmp, local); local_addr = batostr(&tmp);
 	id = hci_devid(local_addr);
@@ -2405,39 +2410,55 @@
 		goto failed;
 	}
 
-	old_data = pdata->path_data;
+	/* update the current scan mode value */
 	pdata->path_data = rp.enable;
 
-	/* If the new page scan flag is different from what we had, send a signal. */
-	if((rp.enable & SCAN_PAGE) != (old_data & SCAN_PAGE)) {
-		se = (rp.enable & SCAN_PAGE);
-		send_property_changed_signal(id, DEV_PROPERTY_PSCAN, DBUS_TYPE_BOOLEAN, &se);
-	}
-	/* If the new inquity scan flag is different from what we had, send a signal. */
-	if ((rp.enable & SCAN_INQUIRY) != (old_data & SCAN_INQUIRY)) {
-		se = (rp.enable & SCAN_INQUIRY);
-		send_property_changed_signal(id, DEV_PROPERTY_ISCAN, DBUS_TYPE_BOOLEAN, &se);
+	switch (rp.enable) {
+	case SCAN_DISABLED:
+		scan_mode = MODE_SCAN_OFF;
+		break;
+	case SCAN_PAGE:
+		scan_mode = MODE_CONNECTABLE;
+		break;
+	case (SCAN_PAGE | SCAN_INQUIRY):
+		scan_mode = MODE_CONNECTABLE_DISCOVERABLE;
+		break;
+	case SCAN_INQUIRY:
+	default:
+		/* ignore */
+		goto failed;
+	}
+
+	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
+						BLUEZ_HCI_SCAN_MODE_CHANGED);
+	if (message == NULL) {
+		syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
+		goto failed;
+	}
+
+	dbus_message_append_args(message,
+				DBUS_TYPE_BYTE, &scan_mode,
+				DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send(connection, message, NULL) == FALSE) {
+		syslog(LOG_ERR, "Can't send D-BUS ModeChanged(%x) signal", rp.enable);
+		goto failed;
 	}
 
+
 	dbus_connection_flush(connection);
 
 failed:
+
+	if (message)
+		dbus_message_unref(message);
+
 	if (dd >= 0)
 		close(dd);
 
 	bt_free(local_addr);
 }
 
-static DBusMessage* handle_device_set_property_req_pscan(DBusMessage *msg, void *data)
-{
-	return write_scan_enable(msg, data, TRUE);
-}
-
-static DBusMessage* handle_device_set_property_req_iscan(DBusMessage *msg, void *data)
-{
-	return write_scan_enable(msg, data, FALSE);
-}
-
 static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data)
 {
 	DBusMessageIter iter;
--- bluez-utils-cvs.orig/hcid/dbus-test	2005-12-24 10:45:37.000000000 -0200
+++ bluez-utils-cvs-scan/hcid/dbus-test	2006-01-30 09:02:39.000000000 -0200
@@ -9,10 +9,10 @@
 from signal import *
 
 mgr_cmds = [ "DeviceList", "DefaultDevice" ]
-dev_cmds = [ "Up", "Down", "SetProperty", "GetProperty", "Inquiry",
+dev_cmds = [ "Up", "Down", "SetProperty", "GetProperty", "SetMode", "GetMode", "Inquiry",
              "CancelInquiry", "PeriodicInquiry","CancelPeriodic", "RemoteName",
              "Connections", "Authenticate", "RoleSwitch" ]
-dev_setprop_bool = [ "auth", "encrypt", "discoverable", "connectable" ]
+dev_setprop_bool = [ "auth", "encrypt" ]
 dev_setprop_byte = [ "incmode" ]
 dev_prop_filter = ["/org/bluez/Device/hci0", "/org/bluez/Device/hci1",
                    "/org/bluez/Device/hci2", "/org/bluez/Device/hci3",
@@ -88,6 +88,10 @@
                     self.bus.add_signal_receiver(self.dev_property_changed,
                                              'PropertyChanged','org.bluez.Device',
                                              'org.bluez',path)
+                for path in dev_prop_filter:
+                    self.bus.add_signal_receiver(self.dev_mode_changed,
+                                             'ModeChanged','org.bluez.Device',
+                                             'org.bluez',path)
                 obj = self.bus.get_object('org.bluez', '%s/Controller' % self.dev_path)
                 self.ctl = dbus.Interface(obj, 'org.bluez.Device.Controller')
 
@@ -166,11 +170,12 @@
         dbus_message = keywords["dbus_message"]
         if property == 'name':
             print 'Device %s name changed: %s' % (dbus_message.get_path(), param)
-        elif property == 'connectable':
-            print 'Device %s connectable scan property changed: %d' % (dbus_message.get_path(), param)
-        elif property == 'discoverable':
-            print 'Device %s discoverable scan property changed: %d' % (dbus_message.get_path(), param)
 
+    @dbus.decorators.explicitly_pass_message
+    def dev_mode_changed(*args, **keywords):
+        mode = args[1]
+        dbus_message = keywords["dbus_message"]
+        print 'Device %s scan mode changed: %x' % (dbus_message.get_path(), mode)
 
     def signal_cb(self, sig, frame):
         print 'Caught signal, exiting'
@@ -224,6 +229,25 @@
             except dbus.DBusException, e:
                 print 'Sending %s failed: %s' % (self.cmd, e)
                 sys.exit(1)
+        elif self.cmd == 'SetMode':
+            if len(self.cmd_args) != 1:
+                print 'Usage: %s -i <dev> SetMode scan_enable' % self.name
+                print 'scan_enable values: 0(no scan), 1(connectable), 2(connectable and discoverable)' % self.name
+                sys.exit(1)
+            try:
+                print self.dev.SetMode(dbus.Byte(self.cmd_args[0]))
+            except dbus.DBusException, e:
+                print 'Sending %s failed: %s' % (self.cmd, e)
+                sys.exit(1)
+        elif self.cmd == 'GetMode':
+            if len(self.cmd_args) != 0:
+                print 'Usage: %s -i <dev> GetMode' % self.name
+                sys.exit(1)
+            try:
+                print self.dev.GetMode()
+            except dbus.DBusException, e:
+                print 'Sending %s failed: %s' % (self.cmd, e)
+                sys.exit(1)
         # Device.Controller methods
         elif self.cmd == 'Inquiry':
             try:





------=_Part_15003_17732616.1138643051138--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
