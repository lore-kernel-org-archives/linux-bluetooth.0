Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80511171116n33c7faech6006e7264821fb16@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
In-Reply-To: <1131489534.5544.20.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_14225_1678309.1132254970344"
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com>
	 <1131119054.11673.1.camel@localhost.localdomain>
	 <e1effdeb0511081241w20503576id78ab38764b8b96b@mail.gmail.com>
	 <20051108222033.GA12368@localhost.localdomain>
	 <1131489534.5544.20.camel@blade>
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
Date: Thu, 17 Nov 2005 16:16:10 -0300

------=_Part_14225_1678309.1132254970344
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

here is a patch with SetProperty and GetProperty for Name. I've also
updated the dbus-test.
Marcel, in the hciconfig you set the ext inquire parameter in the
cmd_name function. Is this needed here?
The "local name changed"  signal is still missing. I'll do that for
the next patch.

BR,
Eduardo.

--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT


On 11/8/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Johan,
>
> > >   name       [name]  Get/Set local name
> >
> > This is good to have. A "local name changed" signal might also be usefu=
l
> > so that other applications can update their UI. Actually now that I
> > think about it, maybe thare should be a generic "property changed"
> > signal for all properties.
>
> sounds like a good idea and easy to extend in the future.
>
> > >   auth                   Enable/Disable Authentication
> > >   encrypt               Enable/Disable Encryption
> > >   secmgr               Enable/Disable Security Manager
> > >   piscan                Enable/Disable Page and Inquiry scan
> > >   iscan                  Enable/Disable Inquiry scan
> > >   pscan                 Enable/Disable Page scan
> >
> > I think the piscan can be dropped so that we have two boolean
> > properties: iscan and pscan.
> >
> > Also, I think it would be good to have the possibility to set the
> > inquiry mode (standard, with RSSI, RSSI + extended inq. result).
> > Currently the mode is always set inquiry with rssi when PeriodicInquiry
> > is called (I'm thinking of sending a patch to remove it), but it should
> > probably be set once at device initialization and then changed only by
> > the SetProperty method call.
>
> Totally agree.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
> it for free - -and be entered to win a 42" plasma tv or your very own
> Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_14225_1678309.1132254970344
Content-Type: text/x-patch; name=dbus_device_name.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dbus_device_name.patch"

--- utils.17112005.orig/hcid/dbus.h	2005-11-17 12:57:42.000000000 -0300
+++ utils.17112005/hcid/dbus.h	2005-11-17 13:04:05.000000000 -0300
@@ -126,39 +126,23 @@
 #define DEV_PROPERTY_AUTH		"auth"
 #define DEV_PROPERTY_ENCRYPT		"encrypt"
 #define DEV_PROPERTY_SECMGR		"secmgr"
-#define DEV_PROPERTY_PISCAN		"piscan"
 #define DEV_PROPERTY_PSCAN		"pscan"
 #define DEV_PROPERTY_ISCAN		"iscan"
-#define DEV_PROPERTY_PTYPE		"ptype"
-#define DEV_PROPERTY_LM			"lm"
-#define DEV_PROPERTY_LP			"lp"
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
+++ utils.17112005/hcid/dbus.c	2005-11-17 13:04:05.000000000 -0300
@@ -272,59 +272,34 @@
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
+	{ DEV_PROPERTY_SECMGR,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL 	},
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
 
@@ -1976,7 +1951,7 @@
 	DBusMessage *reply = NULL;
 	const char *signature;
 	char *str_name;
-	uint32_t error = BLUEZ_EDBUS_UNKNOWN_METHOD;
+	uint32_t error = BLUEZ_EDBUS_WRONG_PARAM;
 
 	signature = dbus_message_get_signature(msg);
 
@@ -2009,7 +1984,7 @@
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	char *str_name;
-	uint32_t error = BLUEZ_EDBUS_UNKNOWN_METHOD;
+	uint32_t error = BLUEZ_EDBUS_WRONG_PARAM;
 
 
 	dbus_message_iter_init(msg, &iter);
@@ -2029,6 +2004,123 @@
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
+	syslog(LOG_INFO, "Setting hci%d name: %s",
+					dbus_data->dev_id, str_name);
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
+		syslog(LOG_ERR, "Periodic inquiry failed with status 0x%02x", status);
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
+        read_local_name_rp rp;
+        struct hci_request rq;
+	const char *pname = rp.name;
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
+		syslog(LOG_ERR, "Getting name command failed: %s (%d)",
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
+	syslog(LOG_INFO, "Got hci%d name: %s",dbus_data->dev_id, rp.name);
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
+++ utils.17112005/hcid/dbus-test	2005-11-17 13:04:05.000000000 -0300
@@ -8,7 +8,7 @@
 from signal import *
 
 mgr_cmds = [ "DeviceList", "DefaultDevice" ]
-dev_cmds = [ "Up", "Down", "Inquiry", "CancelInquiry", "PeriodicInquiry",
+dev_cmds = [ "Up", "Down", "SetProperty", "GetProperty", "Inquiry", "CancelInquiry", "PeriodicInquiry",
              "CancelPeriodic", "RemoteName", "Connections", "Authenticate",
              "RoleSwitch" ]
 
@@ -179,7 +179,29 @@
             except dbus.DBusException, e:
                 print 'Sending %s failed: %s' % (self.cmd, e)
                 sys.exit(1)
-
+	elif self.cmd == 'SetProperty':
+            if len(self.cmd_args) < 2:
+	        print 'Usage: %s -i <dev> SetProperty strPropName arg' % self.name
+                sys.exit(1)
+            try:
+	    	if self.cmd_args[0].lower() == 'name': 
+	            self.dev.SetProperty(dbus.String("name"), dbus.String(self.cmd_args[1]))
+                else:
+	            self.dev.SetProperty(dbus.String(self.cmd_args[0]), dbus.String(self.cmd_args[1]));
+            except dbus.DBusException, e:
+                print 'Sending %s failed: %s' % (self.cmd, e)
+                sys.exit(1)
+        # Device.Controller methods
+	elif self.cmd == 'GetProperty':
+            if len(self.cmd_args) < 1:
+	        print 'Usage: %s -i <dev> GetProperty strPropName' % self.name
+                sys.exit(1)
+            try:
+	        name = self.cmd_args[0]
+	        print self.dev.GetProperty(name)
+            except dbus.DBusException, e:
+                print 'Sending %s failed: %s' % (self.cmd, e)
+                sys.exit(1)
         # Device.Controller methods
         elif self.cmd == 'Inquiry':
             try:

------=_Part_14225_1678309.1132254970344--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
