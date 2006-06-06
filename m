Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44859045.7090208@palmsource.com>
Date: Tue, 06 Jun 2006 16:25:09 +0200
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------070505050303040009040800"
Subject: [Bluez-devel] [PATCH] Minor classes support
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070505050303040009040800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

You can find attached a patch to support minor classes with the new DBus 
API.
This patch updates functions : GetMajorClass, ListAvailableMinorClasses, 
GetMinorClass, GetRemoteMajorClass, GetRemoteMinorClass and dbus-api.txt.
It also adds some call to exerce them (and discoveries) in dbus-test 
program.

Hope this helps

Regards

Fred

-- 
-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic            PalmSource Europe
Software engineer
Mail : mailto:frederic.danis@palmsource.com
-----------------------------------------------


--------------070505050303040009040800
Content-Type: text/plain;
 name="update_dbus_minor_classes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="update_dbus_minor_classes.patch"

diff -aur hcid.orig/dbus-adapter.c hcid/dbus-adapter.c
--- hcid.orig/dbus-adapter.c	2006-06-06 11:35:32.000000000 +0200
+++ hcid/dbus-adapter.c	2006-06-06 16:04:48.000000000 +0200
@@ -87,6 +87,79 @@
 	"isdn"
 };
 
+static const char *access_point_minor_cls[] = {
+	"fully",
+	"1-17 percent",
+	"17-33 percent",
+	"33-50 percent",
+	"50-67 percent",
+	"67-83 percent",
+	"83-99 percent",
+	"not available"
+};
+
+static const char *audio_video_minor_cls[] = {
+	"uncategorized",
+	"headset",
+	"handsfree",
+	"unknown",
+	"microphone",
+	"loudspeaker",
+	"headphones",
+	"portable audio",
+	"car audio",
+	"set-top box",
+	"hifi audio",
+	"vcr",
+	"video camera",
+	"camcorder",
+	"video monitor",
+	"video display and loudspeaker",
+	"video conferencing",
+	"unknown",
+	"gaming/toy"
+};
+
+static const char *peripheral_minor_cls[] = {
+	"uncategorized",
+	"keyboard",
+	"pointing",
+	"combo"
+};
+
+static const char *peripheral_2_minor_cls[] = {
+	"uncategorized",
+	"joystick",
+	"gamepad",
+	"remote control",
+	"sensing",
+	"digitizer tablet",
+	"card reader"
+};
+
+static const char *imaging_minor_cls[] = {
+	"display",
+	"camera",
+	"scanner",
+	"printer"
+};
+
+static const char *wearable_minor_cls[] = {
+	"wrist watch",
+	"pager",
+	"jacket",
+	"helmet",
+	"glasses"
+};
+
+static const char *toy_minor_cls[] = {
+	"robot",
+	"vehicle",
+	"doll",
+	"controller",
+	"game"
+};
+
 static int check_address(const char *addr)
 {
 	char tmp[18];
@@ -548,18 +621,35 @@
 
 static DBusHandlerResult handle_dev_get_major_class_req(DBusConnection *conn, DBusMessage *msg, void *data)
 {
-	DBusMessage *reply;
-	const char *str_ptr = "computer";
+	const struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+	int dd;
+	uint8_t cls[3];
+	uint8_t major_class;
 
 	if (!dbus_message_has_signature(msg, DBUS_TYPE_INVALID_AS_STRING))
 		return error_invalid_arguments(conn, msg);
 
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0)
+		return error_no_such_adapter(conn, msg);
+
+	if (hci_read_class_of_dev(dd, cls, 1000) < 0) {
+		error("Can't read class of device on hci%d: %s(%d)",
+				dbus_data->dev_id, strerror(errno), errno);
+		hci_close_dev(dd);
+		return error_failed(conn, msg, errno);
+	}
+
+	hci_close_dev(dd);
+
+	major_class = cls[1] & 0x1F;
+
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 
-	/*FIXME: Check the real device major class */
-	dbus_message_append_args(reply, DBUS_TYPE_STRING, &str_ptr,
+	dbus_message_append_args(reply, DBUS_TYPE_STRING, &major_cls[major_class],
 					DBUS_TYPE_INVALID);
 
 	return send_reply_and_unref(conn, reply);
@@ -603,6 +693,30 @@
 		minor_ptr = phone_minor_cls;
 		size = sizeof(phone_minor_cls) / sizeof(*phone_minor_cls);
 		break;
+	case 3: /* access point */
+		minor_ptr = access_point_minor_cls;
+		size = sizeof(access_point_minor_cls) / sizeof(*access_point_minor_cls);
+		break;
+	case 4: /* audio/video */
+		minor_ptr = audio_video_minor_cls;
+		size = sizeof(audio_video_minor_cls) / sizeof(*audio_video_minor_cls);
+		break;
+	case 5: /* peripheral */
+		minor_ptr = peripheral_minor_cls;
+		size = sizeof(peripheral_minor_cls) / sizeof(*peripheral_minor_cls);
+		break;
+	case 6: /* imaging */
+		minor_ptr = imaging_minor_cls;
+		size = sizeof(imaging_minor_cls) / sizeof(*imaging_minor_cls);
+		break;
+	case 7: /* wearable */
+		minor_ptr = wearable_minor_cls;
+		size = sizeof(wearable_minor_cls) / sizeof(*wearable_minor_cls);
+		break;
+	case 8: /* toy */
+		minor_ptr = toy_minor_cls;
+		size = sizeof(toy_minor_cls) / sizeof(*toy_minor_cls);
+		break;
 	default:
 		return error_unsupported_major_class(conn, msg);
 	}
@@ -629,7 +743,8 @@
 	const char *str_ptr = "";
 	uint8_t cls[3];
 	uint8_t minor_class;
-	int dd;
+	const char **minor_ptr;
+	int dd, size;
 
 	if (!dbus_message_has_signature(msg, DBUS_TYPE_INVALID_AS_STRING))
 		return error_invalid_arguments(conn, msg);
@@ -651,17 +766,56 @@
 	if (!reply)
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 
-	/* FIXME: Currently, only computer major class is supported */
-	if ((cls[1] & 0x1f) != 1)
+	switch ((cls[1] & 0x1f)) {
+	case 1: /* computer */
+		minor_class = cls[0] >> 2;
+		minor_ptr = computer_minor_cls;
+		size = sizeof(computer_minor_cls) / sizeof(*computer_minor_cls);
+		break;
+	case 2: /* phone */
+		minor_class = cls[0] >> 2;
+		minor_ptr = phone_minor_cls;
+		size = sizeof(phone_minor_cls) / sizeof(*phone_minor_cls);
+		break;
+	case 3: /* access point */
+		minor_class = cls[0] >> 5;
+		minor_ptr = access_point_minor_cls;
+		size = sizeof(access_point_minor_cls) / sizeof(*access_point_minor_cls);
+		break;
+	case 4: /* audio/video */
+		minor_class = cls[0] >> 2;
+		minor_ptr = audio_video_minor_cls;
+		size = sizeof(audio_video_minor_cls) / sizeof(*audio_video_minor_cls);
+		break;
+	case 5: /* peripheral */
+		minor_class = cls[0] >> 6;
+		minor_ptr = peripheral_minor_cls;
+		size = sizeof(peripheral_minor_cls) / sizeof(*peripheral_minor_cls);
+		break;
+	case 6: /* imaging */
+		minor_class = cls[0] >> 4;
+		minor_ptr = imaging_minor_cls;
+		size = sizeof(imaging_minor_cls) / sizeof(*imaging_minor_cls);
+		break;
+	case 7: /* wearable */
+		minor_class = cls[0] >> 2;
+		minor_ptr = wearable_minor_cls;
+		size = sizeof(wearable_minor_cls) / sizeof(*wearable_minor_cls);
+		break;
+	case 8: /* toy */
+		minor_class = cls[0] >> 2;
+		minor_ptr = toy_minor_cls;
+		size = sizeof(toy_minor_cls) / sizeof(*toy_minor_cls);
+		break;
+	default:
 		goto failed;
+	}
 
-	minor_class = cls[0] >> 2;
-
-	/* Validate computer minor class */
-	if (minor_class > (sizeof(computer_minor_cls) / sizeof(*computer_minor_cls)))
+	/* Validate minor class */
+	if (minor_class > size)
 		goto failed;
 
-	str_ptr = computer_minor_cls[minor_class];
+	str_ptr = minor_ptr[minor_class];
 
 failed:
 	dbus_message_append_args(reply, DBUS_TYPE_STRING, &str_ptr,
@@ -2173,13 +2327,33 @@
 const char *minor_class_str(uint32_t class)
 {
 	uint8_t major_index = (class >> 8) & 0x1F;
-	uint8_t minor_index = (class >> 2) & 0x3F;
+	uint8_t minor_index;
 
 	switch (major_index) {
 	case 1: /* computer */
+		minor_index = (class >> 2) & 0x3F;
 		return computer_minor_cls[minor_index];
 	case 2: /* phone */
+		minor_index = (class >> 2) & 0x3F;
 		return phone_minor_cls[minor_index];
+	case 3: /* access point */
+		minor_index = (class >> 5) & 0x07;
+		return access_point_minor_cls[minor_index];
+	case 4: /* audio/video */
+		minor_index = (class >> 2) & 0x3F;
+		return audio_video_minor_cls[minor_index];
+	case 5: /* peripheral */
+		minor_index = (class >> 6) & 0x03;
+		return peripheral_minor_cls[minor_index];
+	case 6: /* imaging */
+		minor_index = (class >> 4) & 0x0F;
+		return imaging_minor_cls[minor_index];
+	case 7: /* wearable */
+		minor_index = (class >> 2) & 0x3F;
+		return wearable_minor_cls[minor_index];
+	case 8: /* toy */
+		minor_index = (class >> 2) & 0x3F;
+		return toy_minor_cls[minor_index];
 	}
 
 	return "";
diff -aur hcid.orig/dbus-api.txt hcid/dbus-api.txt
--- hcid.orig/dbus-api.txt	2006-06-06 11:35:33.000000000 +0200
+++ hcid/dbus-api.txt	2006-06-06 16:01:33.000000000 +0200
@@ -28,6 +28,23 @@
 Minor classes phone	uncategorized, cellular, cordless, smart phone,
 			modem, isdn
 
+Minor classes access point	fully, 1-17 percent, 17-33 percent,
+			33-50 percent, 50-67 percent, 67-83 percent,
+			83-99 percent, not available
+
+Minor classes audio video	uncategorized, headset, handsfree,microphone,
+			loudspeaker, headphones, portable audio, car audio,
+			set-top box, hifi audio, vcr, video camera, camcorder,
+			video monitor, video display and loudspeaker,
+			video conferencing, gaming/toy, unknown
+
+Minor classes peripheral	uncategorized, keyboard, pointing, combo
+
+Minor classes imaging	display, camera, scanner, printer
+
+Minor classes wearable	wrist watch, pager, jacket, helmet, glasses
+
+Minor classes toy	robot, vehicle, doll, controller, game
 
 Error hierarchy
 ===============
@@ -291,7 +308,7 @@
 		string GetMajorClass()
 
 			Returns the current major class value for this
-			system. This value is set to "computer" for now.
+			system.
 
 			If the major class can't be matched by a string
 			the decimal value as string should be returned.
@@ -301,27 +318,14 @@
 		array{string} ListAvailableMinorClasses()
 
 			Returns a list of available minor classes for the
-			currently used major class. At the moment this should
-			only return a list of minor classes if the major
-			class is set to "computer".
-
-			If the major class is not "computer" an error should
-			be returned.
+			currently used major class.
 
 			Possible errors: org.bluez.Error.UnsupportedMajorClass
 
 		string GetMinorClass()
 
 			Returns the current minor class value for this
-			system where the default major class is "computer".
-
-			If the major class is not "computer" an error should
-			be returned.
-
-			Valid values: "uncategorized", "desktop", "server",
-			              "laptop", "handheld", "palm", "wearable"
-
-			The default value is "uncategorized".
+			system.
 
 			Possible errors: org.bluez.Error.UnsupportedMajorClass
 
diff -aur hcid.orig/dbus-test hcid/dbus-test
--- hcid.orig/dbus-test	2006-06-01 14:28:41.000000000 +0200
+++ hcid/dbus-test	2006-06-06 15:21:19.000000000 +0200
@@ -36,6 +36,9 @@
              "GetRemoteManufacturer",
              "GetRemoteCompany",
              "GetRemoteName",
+             "GetRemoteMajorClass",
+             "GetRemoteMinorClass",
+             "GetRemoteServiceClasses",
              "GetRemoteAlias",
              "SetRemoteAlias",
              "ClearRemoteAlias",
@@ -276,7 +279,7 @@
                    print 'Usage: %s -i <dev> SetName newname' % self.name
            elif self.cmd == 'GetRemoteName':
                if len(self.cmd_args) == 1:
-                   print self.device.GetRemoteName()
+                   print self.device.GetRemoteName(self.cmd_args[0])
                else:
                    print 'Usage: %s -i <dev> GetRemoteName address' % self.name
            elif self.cmd == 'GetRemoteVersion':
@@ -304,6 +307,21 @@
                    print self.device.GetRemoteAlias(self.cmd_args[0])
                else:
                    print 'Usage: %s -i <dev> GetRemoteAlias address' % self.name
+           elif self.cmd == 'GetRemoteMajorClass':
+               if len(self.cmd_args) == 1:
+                   print self.device.GetRemoteMajorClass(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> GetRemoteMajorClass address' % self.name
+           elif self.cmd == 'GetRemoteMinorClass':
+               if len(self.cmd_args) == 1:
+                   print self.device.GetRemoteMinorClass(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> GetRemoteMinorClass address' % self.name
+           elif self.cmd == 'GetRemoteServiceClasses':
+               if len(self.cmd_args) == 1:
+                   print self.device.GetRemoteServiceClasses(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> GetRemoteServiceClasses address' % self.name
            elif self.cmd == 'SetRemoteAlias':
                if len(self.cmd_args) == 2:
                    self.device.SetRemoteAlias(self.cmd_args[0], self.cmd_args[1])
@@ -363,6 +381,10 @@
                    print self.device.GetEncryptionKeySize(self.cmd_args[0])
                else:
                    print 'Usage: %s -i <dev> GetEncryptionKeySize address' % self.name
+           elif self.cmd == 'DiscoverDevices':
+               print self.device.DiscoverDevices()
+           elif self.cmd == 'DiscoverDevicesWithoutNameResolving':
+               print self.device.DiscoverDevicesWithoutNameResolving()
            else:
                 # FIXME: remove at future version
                 print 'Script Error: Method %s not found. Maybe a mispelled word.' % (self.cmd_args)

--------------070505050303040009040800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070505050303040009040800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------070505050303040009040800--
