Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602231250q18912898td65b1ff0edf278@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7377_30434921.1140727836079"
Subject: [Bluez-devel] [DBUS PATCH] GetServiceClasses
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
Date: Thu, 23 Feb 2006 17:50:36 -0300

------=_Part_7377_30434921.1140727836079
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is the GetServiceClasses service.

There are some shared constants(major classes, minor classes and
service classes) used by hciconfig.c and dbus-device.c. Maybe we could
put it in a common place.

Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_7377_30434921.1140727836079
Content-Type: text/x-patch; name=svc-class01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek1jqy2m
Content-Disposition: attachment; filename="svc-class01.patch"

Index: hcid/dbus-device.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-device.c,v
retrieving revision 1.15
diff -u -r1.15 dbus-device.c
--- hcid/dbus-device.c	23 Feb 2006 19:12:36 -0000	1.15
+++ hcid/dbus-device.c	23 Feb 2006 20:41:42 -0000
@@ -51,6 +51,17 @@
 	"wearable"
 };
 
+static const char *service_cls[] = {
+	"positioning",
+	"networking",
+	"rendering",
+	"capturing",
+	"object transfer",
+	"audio",
+	"telephony",
+	"information"
+};
+
 static char *get_peer_name(const bdaddr_t *local, const bdaddr_t *peer)
 {
 	char filename[PATH_MAX + 1], addr[18];
@@ -110,6 +121,50 @@
 	return reply;
 }
 
+static DBusMessage *handle_dev_get_service_classes_req(DBusMessage *msg, void *data)
+{
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter array_iter;
+	const char *str_ptr;
+	uint8_t cls[3];
+	int dd, i;
+
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
+		return bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+	}
+
+	if (hci_read_class_of_dev(dd, cls, 1000) < 0) {
+		syslog(LOG_ERR, "Can't read class of device on hci%d: %s(%d)",
+				dbus_data->dev_id, strerror(errno), errno);
+		hci_close_dev(dd);
+		return bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+						DBUS_TYPE_STRING_AS_STRING, &array_iter);
+
+	for (i = 0; i < (sizeof(service_cls) / sizeof(*service_cls)); i++) {
+		if ( cls[2] & ( 1 << i)) {
+			str_ptr = service_cls[i];
+			dbus_message_iter_append_basic(&array_iter, DBUS_TYPE_STRING, &str_ptr);
+		}
+	}
+
+	dbus_message_iter_close_container(&iter, &array_iter);
+
+	hci_close_dev(dd);
+
+	return reply;
+}
+
 static DBusMessage *handle_dev_get_major_class_req(DBusMessage *msg, void *data)
 {
 	DBusMessage *reply;
@@ -986,6 +1041,7 @@
 	{ DEV_GET_MODE,			handle_dev_get_mode_req,		DEV_GET_MODE_SIGNATURE			},
 	{ DEV_GET_NAME,			handle_dev_get_name_req,		DEV_GET_NAME_SIGNATURE			},
 	{ DEV_GET_REVISION,		handle_dev_get_revision_req,		DEV_GET_REVISION_SIGNATURE		},
+	{ DEV_GET_SERVICE_CLASSES,	handle_dev_get_service_classes_req,	DEV_GET_SERVICE_CLASSES_SIGNATURE	},
 	{ DEV_GET_VERSION,		handle_dev_get_version_req,		DEV_GET_VERSION_SIGNATURE		},
 
 	{ DEV_IS_CONNECTABLE,		handle_dev_is_connectable_req,		DEV_IS_CONNECTABLE_SIGNATURE		},
Index: hcid/dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.31
diff -u -r1.31 dbus.h
--- hcid/dbus.h	23 Feb 2006 19:11:02 -0000	1.31
+++ hcid/dbus.h	23 Feb 2006 20:41:42 -0000
@@ -118,6 +118,7 @@
 #define DEV_GET_MODE			"GetMode"
 #define DEV_GET_NAME			"GetName"
 #define DEV_GET_REVISION		"GetRevision"
+#define DEV_GET_SERVICE_CLASSES		"GetServiceClasses"
 #define DEV_GET_VERSION			"GetVersion"
 #define DEV_IS_CONNECTABLE		"IsConnectable"
 #define DEV_IS_DISCOVERABLE		"IsDiscoverable"
@@ -155,6 +156,7 @@
 #define DEV_GET_MODE_SIGNATURE				__END_SIG__
 #define DEV_GET_NAME_SIGNATURE				__END_SIG__
 #define DEV_GET_REVISION_SIGNATURE			__END_SIG__
+#define DEV_GET_SERVICE_CLASSES_SIGNATURE		__END_SIG__
 #define DEV_GET_VERSION_SIGNATURE			__END_SIG__
 #define DEV_IS_CONNECTABLE_SIGNATURE			__END_SIG__
 #define DEV_IS_DISCOVERABLE_SIGNATURE			__END_SIG__



------=_Part_7377_30434921.1140727836079--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
