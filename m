Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602230635j3581adbbwcf20fb60844a5413@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_10172_19044457.1140705335569"
Subject: [Bluez-devel] [DBUS PATCH] SetMinorClass
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
Date: Thu, 23 Feb 2006 11:35:35 -0300

------=_Part_10172_19044457.1140705335569
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is the patch to set the computer minor class.

Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_10172_19044457.1140705335569
Content-Type: text/x-patch; name=set-minor01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek0zxmrh
Content-Disposition: attachment; filename="set-minor01.patch"

Index: hcid/dbus-device.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-device.c,v
retrieving revision 1.10
diff -u -r1.10 dbus-device.c
--- hcid/dbus-device.c	22 Feb 2006 23:41:17 -0000	1.10
+++ hcid/dbus-device.c	23 Feb 2006 14:33:17 -0000
@@ -41,6 +41,16 @@
 
 #include "textfile.h"
 
+static const char *computer_minor_cls[] = {
+	"uncategorized",
+	"desktop",
+	"server",
+	"laptop",
+	"handheld",
+	"palm",
+	"wearable"
+};
+
 static char *get_peer_name(const bdaddr_t *local, const bdaddr_t *peer)
 {
 	char filename[PATH_MAX + 1], addr[18];
@@ -343,6 +353,67 @@
 	return reply;
 }
 
+static DBusMessage* handle_dev_set_minor_class_req(DBusMessage *msg, void *data)
+{
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+	DBusMessageIter iter;
+	const char *minor;
+	int dd = -1, i;
+	uint8_t cls[3];
+	uint32_t minor_value = 0xFFFFFFFF;
+
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &minor);
+
+	if (!minor)
+		return bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
+
+	/* FIXME: currently, only computer minor classes are allowed */
+	for (i = 0; i < sizeof(computer_minor_cls)/sizeof(*computer_minor_cls); i++) {
+		if (strcasecmp(minor, computer_minor_cls[i]) == 0) {
+			/* remove the format type */
+			minor_value = i << 2;
+			break;
+		}
+	}
+
+	/* check if it's a valid minor class */
+	if (minor_value == 0xFFFFFFFF) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
+		goto failed;
+	}
+
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
+		return bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+	}
+
+	if (hci_read_class_of_dev(dd, cls, 1000) < 0) {
+		syslog(LOG_ERR, "Can't read class of device on hci%d: %s(%d)",
+		       			dbus_data->dev_id, strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
+		goto failed;
+	}
+
+	minor_value |= (cls[2] << 16) | (cls[1] << 8);
+
+	if (hci_write_class_of_dev(dd, minor_value, 2000) < 0) {
+		syslog(LOG_ERR, "Can't write class of device on hci%d: %s(%d)",
+		       			dbus_data->dev_id, strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
+		goto failed;
+
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+failed:
+	return reply;
+}
+
 static DBusMessage* handle_dev_set_mode_req(DBusMessage *msg, void *data)
 {
 	const struct hci_dbus_data *dbus_data = data;
@@ -818,6 +889,7 @@
 
 	{ DEV_SET_CLASS,		handle_dev_set_class_req,		DEV_SET_CLASS_SIGNATURE			},
 	{ DEV_SET_DISCOVERABLE_TO,	handle_dev_set_discoverable_to_req,	DEV_SET_DISCOVERABLE_TO_SIGNATURE	},
+	{ DEV_SET_MINOR_CLASS,		handle_dev_set_minor_class_req,		DEV_SET_MINOR_CLASS_SIGNATURE		},
 	{ DEV_SET_MODE,			handle_dev_set_mode_req,		DEV_SET_MODE_SIGNATURE			},
 	{ DEV_SET_NAME,			handle_dev_set_name_req,		DEV_SET_NAME_SIGNATURE			},
 
Index: hcid/dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.28
diff -u -r1.28 dbus.h
--- hcid/dbus.h	22 Feb 2006 23:41:17 -0000	1.28
+++ hcid/dbus.h	23 Feb 2006 14:33:17 -0000
@@ -121,6 +121,7 @@
 #define DEV_IS_DISCOVERABLE		"IsDiscoverable"
 #define DEV_SET_CLASS			"SetClass"
 #define DEV_SET_DISCOVERABLE_TO		"SetDiscoverableTimeout"
+#define DEV_SET_MINOR_CLASS		"SetMinorClass"
 #define DEV_SET_MODE			"SetMode"
 #define DEV_SET_NAME			"SetName"
 #define DEV_DISCOVER			"Discover"
@@ -158,6 +159,8 @@
 							__END_SIG__
 #define DEV_SET_DISCOVERABLE_TO_SIGNATURE		DBUS_TYPE_UINT32_AS_STRING \
 							__END_SIG__
+#define DEV_SET_MINOR_CLASS_SIGNATURE			DBUS_TYPE_STRING_AS_STRING \
+							__END_SIG__
 #define DEV_SET_MODE_SIGNATURE				DBUS_TYPE_STRING_AS_STRING \
 							__END_SIG__
 #define DEV_SET_NAME_SIGNATURE				DBUS_TYPE_STRING_AS_STRING \

------=_Part_10172_19044457.1140705335569--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
