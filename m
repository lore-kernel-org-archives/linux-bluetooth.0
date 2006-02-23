Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602230419p2e9c503ev7fca43499cb13fed@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8575_33148962.1140697176926"
Subject: [Bluez-devel] [DBUS PATCH]GetMajorClass
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
Date: Thu, 23 Feb 2006 09:19:36 -0300

------=_Part_8575_33148962.1140697176926
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is the GetMajorClass service implemented according to your
suggestion: it is returning "computer" for now.

Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_8575_33148962.1140697176926
Content-Type: text/x-patch; name=get-major01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek0uyaep
Content-Disposition: attachment; filename="get-major01.patch"

Index: hcid/dbus-device.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-device.c,v
retrieving revision 1.10
diff -u -r1.10 dbus-device.c
--- hcid/dbus-device.c	22 Feb 2006 23:41:17 -0000	1.10
+++ hcid/dbus-device.c	23 Feb 2006 12:12:35 -0000
@@ -100,6 +100,20 @@
 	return reply;
 }
 
+static DBusMessage* handle_dev_get_major_class_req(DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	const char *str_ptr = "computer";
+
+	reply = dbus_message_new_method_return(msg);
+
+	/*FIXME: Check the real device major class */
+	dbus_message_append_args(reply, DBUS_TYPE_STRING, &str_ptr,
+					DBUS_TYPE_INVALID);
+
+	return reply;
+}
+
 static DBusMessage* handle_dev_get_manufacturer_req(DBusMessage *msg, void *data)
 {
 	struct hci_dbus_data *dbus_data = data;
@@ -807,6 +821,7 @@
 	{ DEV_GET_COMPANY,		handle_dev_get_company_req,		DEV_GET_COMPANY_SIGNATURE		},
 	{ DEV_GET_DISCOVERABLE_TO,	handle_dev_get_discoverable_to_req,	DEV_GET_DISCOVERABLE_TO_SIGNATURE	},
 	{ DEV_GET_FEATURES,		handle_dev_get_features_req,		DEV_GET_FEATURES_SIGNATURE		},
+	{ DEV_GET_MAJOR_CLASS,		handle_dev_get_major_class_req,		DEV_GET_MAJOR_CLASS_SIGNATURE		},
 	{ DEV_GET_MANUFACTURER,		handle_dev_get_manufacturer_req,	DEV_GET_MANUFACTURER_SIGNATURE		},
 	{ DEV_GET_MODE,			handle_dev_get_mode_req,		DEV_GET_MODE_SIGNATURE			},
 	{ DEV_GET_NAME,			handle_dev_get_name_req,		DEV_GET_NAME_SIGNATURE			},
Index: hcid/dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.28
diff -u -r1.28 dbus.h
--- hcid/dbus.h	22 Feb 2006 23:41:17 -0000	1.28
+++ hcid/dbus.h	23 Feb 2006 12:12:35 -0000
@@ -112,6 +112,7 @@
 #define DEV_GET_COMPANY			"GetCompany"
 #define DEV_GET_DISCOVERABLE_TO		"GetDiscoverableTimeout"
 #define DEV_GET_FEATURES		"GetFeatures"
+#define DEV_GET_MAJOR_CLASS		"GetMajorClass"
 #define DEV_GET_MANUFACTURER		"GetManufacturer"
 #define DEV_GET_MODE			"GetMode"
 #define DEV_GET_NAME			"GetName"
@@ -146,6 +147,7 @@
 #define DEV_GET_COMPANY_SIGNATURE			__END_SIG__
 #define DEV_GET_DISCOVERABLE_TO_SIGNATURE		__END_SIG__
 #define DEV_GET_FEATURES_SIGNATURE			__END_SIG__
+#define DEV_GET_MAJOR_CLASS_SIGNATURE			__END_SIG__
 #define DEV_GET_MANUFACTURER_SIGNATURE			__END_SIG__
 #define DEV_GET_MODE_SIGNATURE				__END_SIG__
 #define DEV_GET_NAME_SIGNATURE				__END_SIG__

------=_Part_8575_33148962.1140697176926--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
