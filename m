Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602231101r28356778q72c02d66b67d549b@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5106_25622430.1140721277695"
Subject: [Bluez-devel] [DBUS PATCH]GetMinorClass
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
Date: Thu, 23 Feb 2006 16:01:17 -0300

------=_Part_5106_25622430.1140721277695
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is the GetMinorClass service. For major classes diferent than
Computer an empty reply is returned.

Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_5106_25622430.1140721277695
Content-Type: text/x-patch; name=get-minor01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek19fkp0
Content-Disposition: attachment; filename="get-minor01.patch"

Index: hcid/dbus-device.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-device.c,v
retrieving revision 1.13
diff -u -r1.13 dbus-device.c
--- hcid/dbus-device.c	23 Feb 2006 17:20:36 -0000	1.13
+++ hcid/dbus-device.c	23 Feb 2006 18:55:51 -0000
@@ -140,6 +140,50 @@
 	return reply;
 }
 
+static DBusMessage* handle_dev_get_minor_class_req(DBusMessage *msg, void *data)
+{
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply;
+	const char *str_ptr;
+	uint8_t cls[3];
+	uint8_t minor_class;
+	int dd;
+
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
+		return bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+	}
+
+	if (hci_read_class_of_dev(dd, cls, 1000) < 0) {
+		syslog(LOG_ERR, "Can't read class of device on hci%d: %s(%d)",
+				       dbus_data->dev_id, strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
+		goto failed;
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+	/* FIXME: Currently, only computer major class is supported */
+	if ((cls[1] & 0x1F) != 1)
+		goto failed;
+
+	minor_class = cls[0] >> 2;
+	/* validate computer minor class */
+	if (minor_class > (sizeof(computer_minor_cls) / sizeof(*computer_minor_cls)))
+		goto failed;
+
+	str_ptr = computer_minor_cls[minor_class];
+
+	dbus_message_append_args(reply, DBUS_TYPE_STRING, &str_ptr,
+				 	DBUS_TYPE_INVALID);
+failed:
+	if (dd >= 0)
+		hci_close_dev(dd);
+
+	return reply;
+}
+
 static DBusMessage* handle_dev_get_company_req(DBusMessage *msg, void *data)
 {
 	struct hci_dbus_data *dbus_data = data;
@@ -937,6 +981,7 @@
 	{ DEV_GET_FEATURES,		handle_dev_get_features_req,		DEV_GET_FEATURES_SIGNATURE		},
 	{ DEV_GET_MAJOR_CLASS,		handle_dev_get_major_class_req,		DEV_GET_MAJOR_CLASS_SIGNATURE		},
 	{ DEV_GET_MANUFACTURER,		handle_dev_get_manufacturer_req,	DEV_GET_MANUFACTURER_SIGNATURE		},
+	{ DEV_GET_MINOR_CLASS,		handle_dev_get_minor_class_req,		DEV_GET_MINOR_CLASS_SIGNATURE		},
 	{ DEV_GET_MODE,			handle_dev_get_mode_req,		DEV_GET_MODE_SIGNATURE			},
 	{ DEV_GET_NAME,			handle_dev_get_name_req,		DEV_GET_NAME_SIGNATURE			},
 	{ DEV_GET_REVISION,		handle_dev_get_revision_req,		DEV_GET_REVISION_SIGNATURE		},
Index: hcid/dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.30
diff -u -r1.30 dbus.h
--- hcid/dbus.h	23 Feb 2006 17:17:18 -0000	1.30
+++ hcid/dbus.h	23 Feb 2006 18:55:51 -0000
@@ -114,6 +114,7 @@
 #define DEV_GET_FEATURES		"GetFeatures"
 #define DEV_GET_MAJOR_CLASS		"GetMajorClass"
 #define DEV_GET_MANUFACTURER		"GetManufacturer"
+#define DEV_GET_MINOR_CLASS		"GetMinorClass"
 #define DEV_GET_MODE			"GetMode"
 #define DEV_GET_NAME			"GetName"
 #define DEV_GET_REVISION		"GetRevision"
@@ -150,6 +151,7 @@
 #define DEV_GET_FEATURES_SIGNATURE			__END_SIG__
 #define DEV_GET_MAJOR_CLASS_SIGNATURE			__END_SIG__
 #define DEV_GET_MANUFACTURER_SIGNATURE			__END_SIG__
+#define DEV_GET_MINOR_CLASS_SIGNATURE                   __END_SIG__
 #define DEV_GET_MODE_SIGNATURE				__END_SIG__
 #define DEV_GET_NAME_SIGNATURE				__END_SIG__
 #define DEV_GET_REVISION_SIGNATURE			__END_SIG__

------=_Part_5106_25622430.1140721277695--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
