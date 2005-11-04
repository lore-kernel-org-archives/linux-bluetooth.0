Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5482_17654252.1131113017761"
Subject: [Bluez-devel] [DBUS Patch] Device Property
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
Date: Fri, 4 Nov 2005 11:03:37 -0300

------=_Part_5482_17654252.1131113017761
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

here is the patch with the initial development of setproperty and
getproperty for /org/bluez/Device/hciX. As this is only the fundation,
I didn't update the python script.

BR,
Eduardo.

--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT

------=_Part_5482_17654252.1131113017761
Content-Type: text/x-patch; name=dbus_devices_prop.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dbus_devices_prop.patch"

--- utils.orig/hcid/dbus.h	2005-11-03 14:34:02.798246064 -0300
+++ utils/hcid/dbus.h	2005-11-04 10:30:18.051748984 -0300
@@ -120,15 +120,49 @@
 /* Control interface methods */
 #define DEV_UP				"Up"
 #define DEV_DOWN			"Down"
-#define DEV_RESET			"Reset"
 #define DEV_SET_PROPERTY		"SetProperty"
 #define DEV_GET_PROPERTY		"GetProperty"
 
+#define DEV_PROPERTY_AUTH		"auth"
+#define DEV_PROPERTY_ENCRYPT		"encrypt"
+#define DEV_PROPERTY_SECMGR		"secmgr"
+#define DEV_PROPERTY_PISCAN		"piscan"
+#define DEV_PROPERTY_PSCAN		"pscan"
+#define DEV_PROPERTY_ISCAN		"iscan"
+#define DEV_PROPERTY_PTYPE		"ptype"
+#define DEV_PROPERTY_LM			"lm"
+#define DEV_PROPERTY_LP			"lp"
+#define DEV_PROPERTY_NAME		"name"
+#define DEV_PROPERTY_CLASS		"class"
+#define DEV_PROPERTY_VOICE		"voice"
+#define DEV_PROPERTY_IAC		"iac"
+#define DEV_PROPERTY_INCMODE		"incmode"
+#define DEV_PROPERTY_INCTYPE		"inctype"
+#define DEV_PROPERTY_INCPARMS		"incparms"
+#define DEV_PROPERTY_PAGEPARMS		"pageparms"
+#define DEV_PROPERTY_PAGETO		"pageto"
+#define DEV_PROPERTY_AFHMODE		"afhmode"
+#define DEV_PROPERTY_ACLMTU		"aclmtu"
+#define DEV_PROPERTY_SCOMTU		"scomtu"
+#define DEV_PROPERTY_PUTKEY		"putkey"
+#define DEV_PROPERTY_DELKEY		"delkey"
+#define DEV_PROPERTY_DEV_INFO		"info"
+
 #define DEV_UP_SIGNATURE			__END_SIG__
 #define DEV_DOWN_SIGNATURE			__END_SIG__
 #define DEV_RESET_SIGNATURE			__END_SIG__
-#define DEV_SET_PROPERTY_SIGNATURE		__END_SIG__
-#define DEV_GET_PROPERTY_SIGNATURE		__END_SIG__
+#define DEV_SET_PROPERTY_SIGNATURE_1		DBUS_TYPE_STRING_AS_STRING \
+						DBUS_TYPE_BOOLEAN_AS_STRING \
+						__END_SIG__
+#define DEV_SET_PROPERTY_SIGNATURE_2		DBUS_TYPE_STRING_AS_STRING \
+						DBUS_TYPE_STRING_AS_STRING \
+						__END_SIG__
+#define DEV_SET_PROPERTY_SIGNATURE_3		DBUS_TYPE_STRING_AS_STRING \
+						DBUS_TYPE_UINT16_AS_STRING \
+						__END_SIG__
+
+#define DEV_GET_PROPERTY_SIGNATURE		DBUS_TYPE_STRING_AS_STRING \
+						__END_SIG__
 
 
 #define HCI_PERIODIC_INQ_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING \
--- utils.orig/hcid/dbus.c	2005-11-03 14:34:02.798246064 -0300
+++ utils/hcid/dbus.c	2005-11-04 10:36:19.361821504 -0300
@@ -268,13 +268,61 @@
  */
 static DBusMessage* handle_device_up_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_device_down_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_set_propety_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_get_propety_req(DBusMessage *msg, void *data);
 
 static const struct service_data device_services[] = {
 	{ DEV_UP,		handle_device_up_req,		DEV_UP_SIGNATURE		},
 	{ DEV_DOWN,		handle_device_down_req,		DEV_DOWN_SIGNATURE		},
-	{ DEV_RESET,		handle_not_implemented_req,	DEV_RESET_SIGNATURE		},
-	{ DEV_SET_PROPERTY,	handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE	},
-	{ DEV_GET_PROPERTY,	handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE	},
+	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_1	},
+	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_2	},
+	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_3	},
+	{ DEV_GET_PROPERTY,	handle_device_get_propety_req,	DEV_GET_PROPERTY_SIGNATURE	},
+	{ NULL, NULL, NULL}
+};
+
+static const struct service_data set_property_services[] = {
+	{ DEV_PROPERTY_AUTH,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_ENCRYPT,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_SECMGR,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_PISCAN,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_PSCAN,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_ISCAN,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_PTYPE,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_LM,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_LP,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_NAME,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_CLASS,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_VOICE,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_IAC,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_INCTYPE,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_INCPARMS,	handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_PAGEPARMS,	handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_PAGETO,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_AFHMODE,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_ACLMTU,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_SCOMTU,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_PUTKEY,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ DEV_PROPERTY_DELKEY,		handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE_1 	},
+	{ NULL, NULL, NULL}
+};
+
+static const struct service_data get_property_services[] = {
+	{ DEV_PROPERTY_DEV_INFO,	handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_PTYPE,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_LM,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_LP,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_NAME,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_CLASS,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_VOICE,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_IAC,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_INCTYPE,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_INCPARMS,	handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_PAGEPARMS,	handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_PAGETO,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_AFHMODE,		handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE 	},
 	{ NULL, NULL, NULL}
 };
 
@@ -1174,16 +1222,16 @@
 	}
 
 	if (handlers) {
+		error = BLUEZ_EDBUS_WRONG_SIGNATURE;
 		for (; handlers->name != NULL; handlers++) {
 			if (strcmp(handlers->name, method) == 0) {
-				if (strcmp(handlers->signature, signature) != 0)
-					error = BLUEZ_EDBUS_WRONG_SIGNATURE;
-				else {
+				if (strcmp(handlers->signature, signature) == 0) {
 					reply = handlers->handler_func(msg, data);
 					error = 0;
+					ret = DBUS_HANDLER_RESULT_HANDLED;
+					break;
 				}
 
-				ret = DBUS_HANDLER_RESULT_HANDLED;
 			}
 		}
 	}
@@ -1768,6 +1816,66 @@
 	return reply;
 }
 
+static DBusMessage* handle_device_set_propety_req(DBusMessage *msg, void *data)
+{
+	const struct service_data *handlers = set_property_services;
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	const char *signature;
+	char *str_name;
+	uint32_t error = BLUEZ_EDBUS_UNKNOWN_METHOD;
+
+	signature = dbus_message_get_signature(msg);
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &str_name);
+
+	for (; handlers->name != NULL; handlers++) {
+		if (strcasecmp(handlers->name, str_name) == 0) {
+			if (strcmp(handlers->signature, signature) == 0) {
+				reply = handlers->handler_func(msg, data);
+				error = 0;
+				break;
+			} else {
+				error = BLUEZ_EDBUS_WRONG_SIGNATURE;
+				break;
+			}
+
+		}
+	}
+
+	if (error)
+		reply = bluez_new_failure_msg(msg, error);
+
+	return reply;
+}
+
+static DBusMessage* handle_device_get_propety_req(DBusMessage *msg, void *data)
+{
+	const struct service_data *handlers = get_property_services;
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	char *str_name;
+	uint32_t error = BLUEZ_EDBUS_UNKNOWN_METHOD;
+
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &str_name);
+
+	for (; handlers->name != NULL; handlers++) {
+		if (strcasecmp(handlers->name, str_name) == 0) {
+			reply = handlers->handler_func(msg, data);
+			error = 0;
+			break;
+		}
+	}
+
+	if (error)
+		reply = bluez_new_failure_msg(msg, error);
+
+	return reply;
+}
+
 static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data)
 {
 	DBusMessageIter iter;

------=_Part_5482_17654252.1131113017761--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
