Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 3 Jun 2006 15:40:11 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: bluez-devel@lists.sf.net
Message-ID: <20060603134011.GA13263@esaurito.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Subject: Re: [Bluez-devel] [PATCH] some manual pages patches
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


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,
the two attached patches for l2ping and pand apply against current CVS.

The pand patch is really easy, it just appends a SCRIPTS section to explain the
/etc/bluetooth/pan/dev-up usage, it may be worth including it in a file to be
--included to help2man:

[SCRIPTS]
pand will execute \fB/etc/bluetooth/pan/dev-up\fR \fIdevice\fR \fIdestination\fR
when the interface becomes available.


You may want to discard the first chunk of l2ping.1.patch as it changes the
l2ping section from 1 to 8.

IMO section 8 (system administration commands) is more suitable at least for
pand,hcid and hidd, being them daemons. The l2ping (for example) case is tricky, on
a normal system it would require root privileges so it is not really a user
command.

thanks,
filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

Man was made at the end of the week's work when God was tired.
-- Mark Twain

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="l2ping.1.patch"

Index: l2ping.1
===================================================================
RCS file: /cvsroot/bluez/utils/tools/l2ping.1,v
retrieving revision 1.5
diff -u -r1.5 l2ping.1
--- l2ping.1	20 Mar 2006 22:24:24 -0000	1.5
+++ l2ping.1	3 Jun 2006 13:10:40 -0000
@@ -1,58 +1,59 @@
-.TH L2PING 1 "Jan 22 2002" BlueZ "Linux System Administration"
+.TH L2PING 8 "Jan 22 2002" BlueZ "Linux System Administration"
 .SH NAME
 l2ping \- Send L2CAP echo request and receive answer
 .SH SYNOPSIS
 .B l2ping
-[
-.I -i <hciX>
-] [
-.I -s size
-] [
-.I -c count
-] [
-.I -t timeout
-] [
-.I -f
-] [
-.I -r
-] <
+.RB [\| \-i
+.IR <hciX> \|]
+.RB [\| \-s
+.IR size \|]
+.RB [\| \-c
+.IR count \|]
+.RB [\| \-t
+.IR timeout \|]
+.RB [\| \-f \|]
+.RB [\| \-r \|]
 .I bd_addr
->
+
+.SH DESCRIPTION
+.LP
+.I bd_addr
+
 .SH DESCRIPTION
 .LP
 L2ping sends a L2CAP echo request to the Bluetooth MAC address
-.B bd_addr
+.I bd_addr
 given in dotted hex notation.
 .SH OPTIONS
 .TP
-.I -i " <hciX>"
+.BI \-i " <hciX>"
 The command is applied to device
-.I
+.BI
 hciX
 , which must be the name of an installed Bluetooth device (X = 0, 1, 2, ...)
 If not specified, the command will be sent to the first available Bluetooth
 device.
 .TP
-.I -s size
+.BI \-s " size"
 The
-.B size
+.I size
 of the data packets to be sent.
 .TP
-.I -c count
+.BI \-c " count"
 Send
-.B count
+.I count
 number of packets then exit.
 .TP
-.I -t \fBtimeout\fP
+.BI \-t " timeout"
 Wait
-.B \fBtimeout\fP
+.I timeout
 seconds for the response.
 .TP
-.I -f
+.B \-f
 Kind of flood ping. Use with care! It reduces the delay time between packets
 to 0.
 .TP
-.I -r
+.B \-r
 Reverse ping (gnip?). Send echo response instead of echo request.
 .TP
 .I bd_addr

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pand.1.patch"

Index: pand.1
===================================================================
RCS file: /cvsroot/bluez/utils/pand/pand.1,v
retrieving revision 1.5
diff -u -r1.5 pand.1
--- pand.1	20 Jan 2006 01:42:21 -0000	1.5
+++ pand.1	3 Jun 2006 13:22:37 -0000
@@ -68,3 +68,7 @@
 .TP
 \fB\-\-autozap\fR \fB\-z\fR
 Disconnect automatically on exit
+
+.SH SCRIPTS
+pand will execute \fB/etc/bluetooth/pan/dev-up\fR \fIdevice\fR \fIdestination\fR when
+the interface becomes available.

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--bp/iNruPH9dso1Pn--
