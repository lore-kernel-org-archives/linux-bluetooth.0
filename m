Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D8AC0E.1080308@palmsource.com>
Date: Tue, 08 Aug 2006 17:21:50 +0200
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44859045.7090208@palmsource.com>	<1150263854.5359.1.camel@aeonflux.holtmann.net>	<44969FA3.7030805@palmsource.com>
	<1151325308.7694.16.camel@localhost>
In-Reply-To: <1151325308.7694.16.camel@localhost>
Content-Type: multipart/mixed; boundary="------------040504060404030601090301"
Subject: Re: [Bluez-devel] [PATCH] Minor classes support
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
--------------040504060404030601090301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

We found a bug in DBus function GetRemoteMinorClass when major class is 
"imaging". In this case, the minor class can be a combo of minor values 
(minor part of the class is not an "index" in a table but a "field of 
bit", e.g. "scanner printer").
The patch attached returns the first matching value. It may be useful to 
change this API to allow it to return multiple values.

Regards

Fred

-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic            PalmSource Europe
Software engineer
Mail : mailto:frederic.danis@palmsource.com
-----------------------------------------------


--------------040504060404030601090301
Content-Type: text/plain;
 name="minor_imaging_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="minor_imaging_fix.patch"

--- dbus-adapter.c.orig	2006-08-08 15:35:30.000000000 +0200
+++ dbus-adapter.c	2006-08-08 15:37:42.000000000 +0200
@@ -1222,19 +1222,19 @@
 								void *data)
 {
 	DBusMessage *reply;
-	const char *major_class;
+	const char *minor_class;
 	uint32_t class;
 
 	if (get_remote_class(conn, msg, data, &class) < 0)
 		return DBUS_HANDLER_RESULT_HANDLED;
 
-	major_class = minor_class_str(class);
+	minor_class = minor_class_str(class);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 
-	dbus_message_append_args(reply, DBUS_TYPE_STRING, &major_class,
+	dbus_message_append_args(reply, DBUS_TYPE_STRING, &minor_class,
 					DBUS_TYPE_INVALID);
 
 	return send_reply_and_unref(conn, reply);
@@ -2275,8 +2275,17 @@
 		minor_index = (class >> 6) & 0x03;
 		return peripheral_minor_cls[minor_index];
 	case 6: /* imaging */
-		minor_index = (class >> 4) & 0x0F;
-		return imaging_minor_cls[minor_index];
+		{
+			uint8_t shift_minor = 0;
+
+			minor_index = (class >> 4) & 0x0F;
+			while (shift_minor < (sizeof(imaging_minor_cls) / sizeof(*imaging_minor_cls))) {
+				if (((minor_index >> shift_minor) & 0x01) == 0x01)
+					return imaging_minor_cls[shift_minor];
+				shift_minor++;
+			}
+		}
+		break;
 	case 7: /* wearable */
 		minor_index = (class >> 2) & 0x3F;
 		return wearable_minor_cls[minor_index];

--------------040504060404030601090301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------040504060404030601090301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------040504060404030601090301--
