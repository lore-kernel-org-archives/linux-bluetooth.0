Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20040616112702.GA898@kone>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Subject: [Bluez-devel] D-BUS fixes for hcid
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 16 Jun 2004 14:27:02 +0300


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There are some problems with the current D-BUS pin-request handling in
hcid. The attached patch tries to address those.

Also, the bluez-pin package will need to provide a D-BUS service file
(bluez.service) so that the D-BUS daemon can activate it when needed.
This file goes usually in /usr/lib/dbus-1.0/services and it's contents
should be something like the following:

[D-BUS Service]
Name=org.bluez.PinAgent
Exec=/usr/bin/bluez-pin

You'll also need the following line in /etc/dbus-1/system.conf (at least
the debian package of D-BUS doesn't have it):
<servicedir>/usr/lib/dbus-1.0/services</servicedir>

br,
Johan

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hcid-dbus.diff"

--- dbus.c.orig	2004-06-16 13:57:51.000000000 +0300
+++ dbus.c	2004-06-16 14:05:51.000000000 +0300
@@ -75,7 +75,8 @@
 
 	message = dbus_pending_call_get_reply(call);
 
-	if (dbus_message_is_error(message, WRONG_ARGS_ERROR))
+	if (message == NULL ||
+	    dbus_message_get_type(message) == DBUS_MESSAGE_TYPE_ERROR)
 		goto error;
 
 	dbus_message_iter_init(message, &iter);
@@ -131,6 +132,8 @@
 	dbus_message_iter_append_byte_array(&iter,
 			(unsigned char *) &ci->bdaddr, sizeof(ci->bdaddr));
 
+	dbus_message_set_auto_activation(message, TRUE);
+
 	if (dbus_connection_send_with_reply(connection, message,
 						&pending, TIMEOUT) == FALSE) {
 		syslog(LOG_ERR, "D-BUS send failed");

--4Ckj6UjgE2iN1+kY--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
