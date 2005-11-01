Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80511011105y2be7647bi4fb0994efd6f8a31@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Some thoughts on the current D-BUS interface
In-Reply-To: <1130863617.31561.74.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5183_1743968.1130871941812"
References: <20051031224006.GA14057@localhost.localdomain>
	 <1130799900.31561.38.camel@blade>
	 <20051031233610.GA14937@localhost.localdomain>
	 <e1effdeb0511010433x11bbef22q8648e30b565cf41c@mail.gmail.com>
	 <20051101155447.GA26044@localhost.localdomain>
	 <1130863617.31561.74.camel@blade>
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
Date: Tue, 1 Nov 2005 16:05:41 -0300

------=_Part_5183_1743968.1130871941812
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

here is the device Up and Down dbus methods.

br,
Eduardo.


On 11/1/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Johan,
>
> > Here's the patch which implements the interface redesign. The change
> > ended up being a little bigger than I originally thought, but I think
> > the code and interface become more understandable this way. Attached is
> > also a simple python app which tests the DeviceList and DefaultDevice
> > methods.
>
> let's test this new interface. The patch is in the CVS now and we will
> see how it works out.
>
> I also like to add a test script that can utilize the complete API. I
> don't wanna replace hciconfig or hcitool, but an easy script for testing
> is really needed.
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


--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT

------=_Part_5183_1743968.1130871941812
Content-Type: text/x-patch; name=dbus_devices02.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dbus_devices02.patch"

--- utils.old/hcid/dbus.c	2005-11-01 14:28:37.721258256 -0300
+++ utils/hcid/dbus.c	2005-11-01 15:56:54.976952984 -0300
@@ -258,6 +258,8 @@
 static DBusHandlerResult msg_func_device(DBusConnection *conn, DBusMessage *msg, void *data);
 static DBusHandlerResult msg_func_manager(DBusConnection *conn, DBusMessage *msg, void *data);
 
+static DBusMessage* handle_device_up_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_down_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_default_device_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_not_implemented_req(DBusMessage *msg, void *data);
@@ -273,8 +275,8 @@
 };
 
 static const struct service_data device_services[] = {
-	{ DEV_UP,		handle_not_implemented_req,	DEV_UP_SIGNATURE		},
-	{ DEV_DOWN,		handle_not_implemented_req,	DEV_DOWN_SIGNATURE		},
+	{ DEV_UP,		handle_device_up_req,		DEV_UP_SIGNATURE		},
+	{ DEV_DOWN,		handle_device_down_req,		DEV_DOWN_SIGNATURE		},
 	{ DEV_RESET,		handle_not_implemented_req,	DEV_RESET_SIGNATURE		},
 	{ DEV_SET_PROPERTY,	handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE	},
 	{ DEV_GET_PROPERTY,	handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE	},
@@ -1187,14 +1189,16 @@
 		if (child && *child) {
 			struct profile_obj_path_data *profile;
 			child++;
-
-			for (profile = obj_path_table ;profile->name != NULL; profile++) {
-				if (strcmp(profile->name, child) == 0) {
-					handlers = profile->get_svc_table();
-					break;
+			if (!strncmp(child, "hci", 3)) {
+				handlers = device_services;
+			} else {
+				for (profile = obj_path_table ;profile->name != NULL; profile++) {
+					if (strcmp(profile->name, child) == 0) {
+						handlers = profile->get_svc_table();
+						break;
+					}
 				}
 			}
-
 		}
 	}
 
@@ -1716,6 +1720,78 @@
  *  Section reserved to Manager D-Bus message handlers
  *  
  *****************************************************************/
+static DBusMessage* handle_device_up_req(DBusMessage *msg, void *data)
+{
+	DBusMessage *reply = NULL;
+	struct hci_dbus_data *dbus_data = data;
+	struct hci_dev_info di;
+	struct hci_dev_req dr;
+	int sk = -1;
+
+	/* Create and bind HCI socket */
+	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (sk < 0) {
+		syslog(LOG_ERR, "Can't open HCI socket: %s (%d)", strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	if ((ioctl(sk, HCIDEVUP, dbus_data->id) < 0) && (errno != EALREADY)) {
+		syslog(LOG_ERR, "Can't init device hci%d: %s (%d)\n",
+			dbus_data->id, strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	if (ioctl(sk, HCIGETDEVINFO, (void *) &di) >= 0 && 
+	    !hci_test_bit(HCI_RAW, &di.flags)) {
+		dr.dev_id  = dbus_data->id;
+		dr.dev_opt = SCAN_PAGE | SCAN_INQUIRY; /* piscan */
+		if (ioctl(sk, HCISETSCAN, (unsigned long) &dr) < 0) {
+			syslog(LOG_ERR, "Can't set scan mode on hci%d: %s (%d)\n",
+					dbus_data->id, strerror(errno), errno);
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+			goto failed;
+		}
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+failed:
+	if (sk >= 0)
+		close(sk);
+	return reply;
+}
+
+static DBusMessage* handle_device_down_req(DBusMessage *msg, void *data)
+{
+	DBusMessage *reply = NULL;
+	struct hci_dbus_data *dbus_data = data;
+	int sk = -1;
+
+	/* Create and bind HCI socket */
+	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (sk < 0) {
+		syslog(LOG_ERR, "Can't open HCI socket: %s (%d)", strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	if ((ioctl(sk, HCIDEVDOWN, dbus_data->id) < 0) ) {
+		syslog(LOG_ERR, "Can't down device hci%d: %s (%d)\n",
+			dbus_data->id, strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+failed:
+	if (sk >= 0)
+		close(sk);
+	return reply;
+}
+
 static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data)
 {
 	DBusMessageIter iter;

------=_Part_5183_1743968.1130871941812
Content-Type: text/x-python; name=devdown.py; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="devdown.py"

import dbus
import sys

print '/org/bluez/Device/' + str(sys.argv[1])
bus = dbus.SystemBus()
proxy_obj = bus.get_object('org.bluez', '/org/bluez/Device/' + str(sys.argv[1]))
dbus_iface = dbus.Interface(proxy_obj, 'org.bluez.Device')

print dbus_iface.Down()

------=_Part_5183_1743968.1130871941812
Content-Type: text/x-python; name=devup.py; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="devup.py"

import dbus
import sys

print '/org/bluez/Device/' + str(sys.argv[1])
bus = dbus.SystemBus()
proxy_obj = bus.get_object('org.bluez', '/org/bluez/Device/' + str(sys.argv[1]))
dbus_iface = dbus.Interface(proxy_obj, 'org.bluez.Device')

print dbus_iface.Up()

------=_Part_5183_1743968.1130871941812--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
