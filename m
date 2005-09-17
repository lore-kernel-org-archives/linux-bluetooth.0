Return-Path: <noring@nocrew.org>
Subject: [PATCH] Updated man page for hcid.conf
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-xW2yt8eACS3M0F0RyR79"
Date: Sat, 17 Sep 2005 22:18:10 +0200
Message-Id: <1126988290.14893.35.camel@yeti>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>


--=-xW2yt8eACS3M0F0RyR79
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Marcel,

Attached is a patch to update the man page for hcid.conf as well.

Fredrik


--=-xW2yt8eACS3M0F0RyR79
Content-Disposition: attachment; filename=hcid.conf.5-updates.patch
Content-Type: text/x-patch; name=hcid.conf.5-updates.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- bluez-utils-2.21.orig/hcid/hcid.conf.5	2004-12-25 19:06:00.000000000 +0100
+++ bluez-utils-2.21.new/hcid/hcid.conf.5	2005-09-17 22:15:05.000000000 +0200
@@ -58,11 +58,17 @@
 ERR
 
 .TP 
+\fBdbus_pin_helper\fP
+
+Declaring this parameter enables the D-BUS message bus system for PIN
+requests.
+
+.TP 
 \fBsecurity\fP  none|auto|user
 
 \fInone\fP means the security manager is disabled. \fIauto\fP uses
-local PIN for incoming connections. \fIuser\fP always asks the user
-for a PIN.
+local PIN, by default from /etc/bluetooth/pin, for incoming
+connections. \fIuser\fP always asks the user for a PIN.
 
 .SH "DEVICE SECTION"
 Parameters within a device section with no specifier, the default
@@ -230,5 +236,11 @@
 .I /etc/bluetooth/hcid.conf
 Default location of the global configuration file.
 
+.TP 
+.I /etc/bluetooth/pin
+Default location of local PIN file, used for incoming connections in
+security mode \fIauto\fP. The file contains the PIN code terminated by
+newline.
+
 .SH "AUTHOR"
 This manual page was written by Edouard Lafargue, Fredrik Noring and Maxim Krasnyansky.

--=-xW2yt8eACS3M0F0RyR79--
