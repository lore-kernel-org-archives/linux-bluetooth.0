Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <a63d67fe0601260006y5d252801n@mail.gmail.com>
From: Dan Carpenter <error27@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Patch manpage
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
Date: Thu, 26 Jan 2006 00:06:21 -0800

Before:
$ whatis sdpd
sdpd (8)             - SDP daemon

After:
$ whatis sdpd
sdpd (8)             - Bluetooth SDP daemon

regards,
dan carpenter

--- sdpd/sdpd.8 31 Mar 2004 21:39:10 -0000      1.1
+++ sdpd/sdpd.8 26 Jan 2006 07:58:05 -0000
@@ -53,7 +53,7 @@
 .ta 8n 16n 24n 32n 40n 48n 56n 64n 72n
 .TH "sdpd" "8"
 .SH "NAME"
-sdpd \(em SDP daemon
+sdpd \(em Bluetooth SDP daemon
 .SH "SYNOPSIS"
 .PP
 \fBsdpd\fR [\fIoptions\fR]


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
