Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80511180500h5539d5d9y3f19ce224f9e38b7@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
In-Reply-To: <20051118112611.GA17062@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1372_10537713.1132318822064"
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com>
	 <1131119054.11673.1.camel@localhost.localdomain>
	 <e1effdeb0511081241w20503576id78ab38764b8b96b@mail.gmail.com>
	 <20051108222033.GA12368@localhost.localdomain>
	 <1131489534.5544.20.camel@blade>
	 <3013cac80511171116n33c7faech6006e7264821fb16@mail.gmail.com>
	 <3013cac80511171252g4a4f1581l915e364a244ec8ea@mail.gmail.com>
	 <20051118082828.GA16438@localhost.localdomain>
	 <3013cac80511180251w1d2fa8f5s80ce1da7318327e7@mail.gmail.com>
	 <20051118112611.GA17062@localhost.localdomain>
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
Date: Fri, 18 Nov 2005 10:00:22 -0300

------=_Part_1372_10537713.1132318822064
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

here is the patch with a better implementation of dbus-test
SetProperty. I've also changed the "pscan" to "connectable" and
"iscan" to "discoverable".

BR,
Eduardo

On 11/18/05, Johan Hedberg <johan.hedberg@nokia.com> wrote:
> On Fri, Nov 18, 2005, Eduardo Rocha wrote:
> > Could you give any comments about the hci_send_req timeout (maybe is
> > too high)
>
> I'd guess that the command should take max. 100ms, so 2s timeout is
> probably unnecessarely big. However, Marcel might have had a good reason
> to use the current timeout in hciconfig.
>
> > and the extended inquire parameters that is set cmd_name function in
> > hciconfig app (is that needed here?).
>
> If it's not there, then we should at least provide a D-BUS method to set
> the extended inquiry parameters (which is probably a good thing as the
> user might want to have other informantion there besides the name, e.g.
> SDP UUID list).
>
> > About the parameters, I've done an if to detect each property name so
> > we can treat  the parameter diferently.
>
> Yeah, you're right, that works also. However, I was thinking of
> solutions where dbus-send wouldn't need to know the property name -
> property type mapping.
>
> Johan
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

------=_Part_1372_10537713.1132318822064
Content-Type: text/x-patch; name=dbus_device_name.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dbus_device_name.patch"

--- utils.17112005.orig/hcid/dbus.h	2005-11-17 12:57:42.000000000 -0300
+++ utils.17112005/hcid/dbus.h	2005-11-18 06:50:55.000000000 -0300
@@ -125,40 +125,23 @@
 
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
+++ utils.17112005/hcid/dbus.c	2005-11-18 06:50:21.000000000 -0300
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
+	{ DEV_PROPERTY_AUTH,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL 	},
+	{ DEV_PROPERTY_ENCRYPT,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL 	},
+	{ DEV_PROPERTY_PSCAN,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL 	},
+	{ DEV_PROPERTY_ISCAN,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL 	},
+	{ DEV_PROPERTY_NAME,		handle_device_set_propety_req_name,	DEV_SET_PROPERTY_SIGNATURE_STR	 	},
+	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BYTE 	},
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
 
@@ -1976,7 +1950,7 @@
 	DBusMessage *reply = NULL;
 	const char *signature;
 	char *str_name;
-	uint32_t error = BLUEZ_EDBUS_UNKNOWN_METHOD;
+	uint32_t error = BLUEZ_EDBUS_WRONG_PARAM;
 
 	signature = dbus_message_get_signature(msg);
 
@@ -2009,7 +1983,7 @@
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	char *str_name;
-	uint32_t error = BLUEZ_EDBUS_UNKNOWN_METHOD;
+	uint32_t error = BLUEZ_EDBUS_WRONG_PARAM;
 
 
 	dbus_message_iter_init(msg, &iter);
@@ -2029,6 +2003,120 @@
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
+	if (hci_send_req(dd, &rq, 2000) < 0) {
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
+static DBusMessage* handle_device_get_propety_req_name(DBusMessage *msg, void *data)
+{
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessageIter iter;
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
+        memset(&rq, 0, sizeof(rq));
+        rq.ogf    = OGF_HOST_CTL;
+        rq.ocf    = OCF_READ_LOCAL_NAME;
+        rq.rparam = &rp;
+        rq.rlen   = READ_LOCAL_NAME_RP_SIZE;
+
+        if (hci_send_req(dd, &rq, 1000) < 0) {
+		syslog(LOG_ERR, "Sending getting name command failed: %s (%d)",
+							strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+        if (rp.status) {
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
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &pname);
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
+++ utils.17112005/hcid/dbus-test	2005-11-18 06:39:06.000000000 -0300
@@ -8,9 +8,11 @@
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
@@ -179,7 +181,29 @@
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


------=_Part_1372_10537713.1132318822064--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
