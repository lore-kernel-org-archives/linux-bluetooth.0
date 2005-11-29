Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0511291401p2b10092cx74cc8354cff921e@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_75767_9234994.1133301720471"
Subject: [Bluez-devel] l2ping manpage
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
Date: Tue, 29 Nov 2005 17:02:00 -0500

------=_Part_75767_9234994.1133301720471
Content-Type: multipart/alternative;
	boundary="----=_Part_75768_23302007.1133301720471"

------=_Part_75768_23302007.1133301720471
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

the attached patch updates the l2ping manpage.

-albert

------=_Part_75768_23302007.1133301720471
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

the attached patch updates the l2ping manpage.<br>
<br>
-albert<br>

------=_Part_75768_23302007.1133301720471--

------=_Part_75767_9234994.1133301720471
Content-Type: application/octet-stream; name=051129-albert-l2ping.1.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="051129-albert-l2ping.1.diff"

Index: l2ping.1
===================================================================
RCS file: /cvsroot/bluez/utils/tools/l2ping.1,v
retrieving revision 1.2
diff -u -r1.2 l2ping.1
--- l2ping.1	11 Oct 2004 10:31:33 -0000	1.2
+++ l2ping.1	29 Nov 2005 22:00:24 -0000
@@ -4,7 +4,7 @@
 .SH SYNOPSIS
 .B l2ping
 [
-.I -S source addr
+.I -i <hciX>
 ] [
 .I -s size
 ] [
@@ -23,8 +23,13 @@
 given in dotted hex notation.
 .SH OPTIONS
 .TP
-.I -S source addr
-Select address to be used as source address for the request.
+.I -i " <hciX>"
+The command is applied to device
+.I
+hciX
+, which must be the name of an installed Bluetooth device (X = 0, 1, 2, ...)
+If not specified, the command will be sent to the first available Bluetooth
+device.
 .TP
 .I -s size
 The
@@ -36,10 +41,10 @@
 .B count
 number of packets then exit.
 .TP
-.I -c timeout
+.I -c \fBtimeout\fP
 Wait
-.B timeout
-for the response.
+.B \fBtimeout\fP
+seconds for the response.
 .TP
 .I -f
 Kind of flood ping. Use with care! It reduces the delay time between packets
@@ -53,4 +58,4 @@
 .SH AUTHORS
 Written by Maxim Krasnyansky <maxk@qualcomm.com> and Marcel Holtmann <marcel@holtmann.org>
 .PP
-man page by Nils Faerber <nils@kernelconcepts.de>
+man page by Nils Faerber <nils@kernelconcepts.de>.

------=_Part_75767_9234994.1133301720471--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
