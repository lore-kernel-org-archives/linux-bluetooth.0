Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 1 Jun 2006 20:05:04 +0200
From: Filippo Giunchedi <filippo@debian.org>
To: bluez-devel@lists.sf.net
Message-ID: <20060601180504.GE7486@esaurito.net>
MIME-Version: 1.0
Subject: [Bluez-devel] [PATCH] some manual pages patches
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1396756862=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1396756862==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline


--SxgehGEc6vB0cZwN
Content-Type: multipart/mixed; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
attached there are a few patches to manual pages (or corrections) collected in
the debian package, you might want to merge them in the next release.

thanks,
filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

I worked myself up from nothing to a state of extreme poverty.
-- Groucho Marx

--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hciattach.8"
Content-Transfer-Encoding: quoted-printable

--- tools/hciattach.8.orig	2005-12-20 14:13:27.952000000 +0100
+++ tools/hciattach.8	2005-12-20 14:13:45.972000000 +0100
@@ -3,44 +3,41 @@
 hciattach \- attach serial devices via UART HCI to BlueZ stack
 .SH SYNOPSIS
 .B hciattach
-[ -n ] [ -p ] [ -t timeout ] <
+.RB [\| \-n \|]
+.RB [\| \-p \|]
+.RB [\| \-t=20
+.IR timeout \|]
 .I tty
-> <
-.I type
-|
-.I id
-> [
+.IR type \||\| id
 .I speed
-] [
 .I flow
-]
 .SH DESCRIPTION
 .LP
 Hciattach is used to attach a serial UART to the Bluetooth stack as HCI
 transport interface.
 .SH OPTIONS
 .TP
-.BI -n
+.B \-n
 Don't detach from controlling terminal.
 .TP
-.BI -p
+.B \-p
 Print the PID when detaching.
 .TP
-.BI -t timeout
+.BI \-t " timeout"
 Specify an initialization timeout.  (Default is 5 seconds.)
 .TP
-.I <tty>
+.I tty
 This specifies the serial device to attach. A leading
 .B /dev
 can be omitted. Examples:
 .B /dev/ttyS1
 .B ttyS2
 .TP
-.I <type | id>
+.IR type \||\| id
 The
-.B type
+.I type
 or
-.B id
+.I id
 of the Bluetooth device that is to be attached, i.e. vendor or other device
 specific identifier. Currently supported types are
 .RS
@@ -48,45 +45,45 @@
 .B type
 .B description
 .TP
-any
+.B any
 Unspecified HCI_UART interface, no vendor specific options
 .TP
-ericsson
+.B ericsson
 Ericsson based modules
 .TP
-digi
+.B digi
 Digianswer based cards
 .TP
-xircom
+.B xircom
 Xircom PCMCIA cards: Credit Card Adapter and Real Port Adapter
 .TP
-csr
+.B csr
 CSR Casira serial adapter or BrainBoxes serial dongle (BL642)
 .TP
-bboxes
+.B bboxes
 BrainBoxes PCMCIA card (BL620)
 .TP
-swave
+.B swave
 Silicon Wave kits
 .TP
-bcsp
+.B bcsp
 Serial adapters using CSR chips with BCSP serial protocol
 .RE
=20
 Supported IDs are (manufacturer id, product id)
 .RS
 .TP
-0x0105, 0x080a
+.B 0x0105, 0x080a
 Xircom PCMCIA cards: Credit Card Adapter and Real Port Adapter
 .TP
-0x0160, 0x0002
+.B 0x0160, 0x0002
 BrainBoxes PCMCIA card (BL620)
 .RE
=20
 .TP
-.I <speed>
+.I speed
 The
-.B speed
+.I speed
 specifies the UART speed to use. Baudrates higher than 115.200bps require
 vendor specific initializations that are not implemented for all types of
 devices. In general the following speeds are supported:
@@ -96,9 +93,9 @@
 Supported vendor devices are automatically initialised to their respective
 best settings.
 .TP
-.I <flow>
+.I flow
 If the keyword
-.B flow
+.I flow
 is appended to the list of options then hardware flow control is forced on
 the serial link (
 .B CRTSCTS

--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hciconfig.8"
Content-Transfer-Encoding: quoted-printable

--- tools/hciconfig.8.orig	2005-11-06 23:44:47.859378000 +0100
+++ tools/hciconfig.8	2005-12-20 14:13:45.976000000 +0100
@@ -2,89 +2,95 @@
 .SH NAME
 hciconfig \- configure Bluetooth devices
 .SH SYNOPSIS
-.B hciconfig -h
+.B hciconfig
+.B \-h
 .br
-.B hciconfig [-a]
+.B hciconfig
+.RB [\| \-a \|]
 .br
-.B hciconfig [-a] <hciX> [command [command parameters]]
+.B hciconfig
+.RB [\| \-a \|]
+.RI [\| command
+.RI [\| "command parameters" \|]\|]
=20
 .SH DESCRIPTION
 .LP
-.B
-hciconfig
-is used to configure Bluetooth devices. <hciX> is the name of a Bluetooth
-device installed in the system. If <hciX> is not given,
-.B
-hciconfig
+.B hciconfig
+is used to configure Bluetooth devices.
+.I hciX
+is the name of a Bluetooth device installed in the system. If
+.I hciX
+is not given,
+.B hciconfig
 prints name and basic information about all the Bluetooth devices installe=
d in
-the system. If <hciX> is given but no command is given,
-it prints basic information on device <hciX> only. Basic information is=20
+the system. If
+.I hciX
+is given but no command is given, it prints basic information on device
+.I hciX
+only. Basic information is=20
 interface type, BD address, ACL MTU, SCO MTU, flags (up, init, running, ra=
w,
 page scan enabled, inquiry scan enabled, inquiry, authentication enabled,
 encryption enabled).
 .SH OPTIONS
 .TP
-.BI -h
+.B \-h, \-\-help
 Gives a list of possible commands.
 .TP
-.BI -a
+.B \-a, \-\-all
 Other than the basic info, print features, packet type, link policy, link =
mode,
 name, class, version.
 .SH COMMANDS
 .TP
-.BI up
+.B up
 Open and initialize HCI device.
 .TP
-.BI down
+.B down
 Close HCI device.
 .TP
-.BI reset
+.B reset
 Reset HCI device.
 .TP
-.BI rstat
+.B rstat
 Reset statistic counters.
 .TP
-.BI auth
+.B auth
 Enable authentication (sets device to security mode 3).
 .TP
-.BI noauth
+.B noauth
 Disable authentication.
 .TP
-.BI encrypt
+.B encrypt
 Enable encryption (sets device to security mode 3).
 .TP
-.BI noencrypt
+.B noencrypt
 Disable encryption.
 .TP
-.BI secmgr
+.B secmgr
 Enable security manager (current kernel support is limited).
 .TP
-.BI nosecmgr
+.B nosecmgr
 Disable security manager.
 .TP
-.BI piscan
+.B piscan
 Enable page and inquiry scan.
 .TP
-.BI noscan
+.B noscan
 Disable page and inquiry scan.
 .TP
-.BI iscan
+.B iscan
 Enable inquiry scan, disable page scan.
 .TP
-.BI pscan
+.B pscan
 Enable page scan, disable inquiry scan.
 .TP
-.BI ptype " [type]"
+\fBptype\fP [\fItype\fP]
 With no
-.I
-type
+.I type
 , displays the current packet types. Otherwise, all the packet types speci=
fied
 by
-.I
-type
+.I type
 are set.
-.I
-type
+.I type
 is a comma-separated list of packet types, where the possible packet types=
 are
 .BR DM1 ,
 .BR DM3 ,
@@ -117,8 +123,7 @@
 .IR voice ,
 prints voice setting. Otherwise, sets voice setting to
 .IR voice .
-.I
-voice
+.I voice
 is a 16-bit hex number describing the voice setting.
 .TP
 .BI iac " [iac]"
@@ -145,9 +150,9 @@
 prints out the current inquiry scan type. Otherwise, sets inquiry scan typ=
e to
 .IR type .
 .TP
-.BI inqparms " [win:int]"
+\fBinqparams\fP [\fIwin\fP:\fIint\fP]
 With no
-.IR win:int ,
+.IR win : int ,
 prints inquiry scan window and interval. Otherwise, sets inquiry scan wind=
ow
 to
 .I win
@@ -155,23 +160,20 @@
 .I int
 slots.
 .TP
-.BI pageparms " [win:int]"
+\fBpageparms\fP [\fIwin\fP:\fIint\fP]
 With no
-.IR win:int ,
+.IR win : int ,
 prints page scan window and interval. Otherwise, sets page scan window to
-.I
-win
+.I win
 slots and page scan interval to
-.I=20
-int
+.I int
 slots.
 .TP
 .BI pageto " [to]"
 With no
 .IR to ,
 prints page timeout. Otherwise, sets page timeout
-to
-.I
+to .I
 to
 slots.
 .TP
@@ -181,19 +183,16 @@
 prints out the current AFH mode. Otherwise, sets AFH mode to
 .IR mode .
 .TP
-.BI aclmtu " <mtu:pkt>"
+\fBaclmtu\fP \fImtu\fP:\fIpkt\fP
 Sets ACL MTU to
 to
-.I
-mtu
+.I mtu
 bytes and ACL buffer size to
-.I
-pkt
+.I pkt
 packets.
 .TP
-.BI scomtu " <mtu:pkt>"
+\fBscomtu\fP \fImtu\fP:\fIpkt\fP
 Sets SCO MTU to
-to
 .I mtu
 bytes and SCO buffer size to
 .I pkt
@@ -223,43 +222,34 @@
 .TP
 .BI lm " [mode]"
 With no
-.I
-mode
+.I mode
 , prints link mode.
-.B
-MASTER
+.B MASTER
 or
-.B
-SLAVE
+.B SLAVE
 mean, respectively, to ask to become master or to remain slave when a
 connection request comes in. The additional keyword
-.B
-ACCEPT
+.B ACCEPT
 means that baseband  connections will be accepted even if there are no
 listening
 .I AF_BLUETOOTH
 sockets.
 .I mode
 is
-.B
-NONE
+.B NONE
 or a comma-separated list of keywords, where possible keywords are
-.B=20
-MASTER
+.B MASTER
 and
 .B "ACCEPT" .
-.B
-NONE
+.B NONE
 sets link policy to the default behaviour of remaining slave and not accep=
ting
 baseband connections when there are no listening
 .I AF_BLUETOOTH
 sockets. If
-.B
-MASTER
+.B MASTER
 is present, the device will ask to become master if a connection request c=
omes
 in. If
-.B
-ACCEPT
+.B ACCEPT
 is present, the device will accept baseband connections even when there ar=
e no
 listening
 .I AF_BLUETOOTH

--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="l2ping.1"

--- tools/l2ping.1.orig	2005-12-20 14:13:39.272000000 +0100
+++ tools/l2ping.1	2005-12-20 14:13:45.976000000 +0100
@@ -1,4 +1,4 @@
-.TH L2PING 1 "Jan 22 2002" BlueZ "Linux System Administration"
+.TH L2PING 8 "Jan 22 2002" BlueZ "Linux System Administration"
 .SH NAME
 l2ping \- Send L2CAP echo request and receive answer
 .SH SYNOPSIS
@@ -3,50 +3,48 @@
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
 .I bd_addr
->
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
-.I -c \fBtimeout\fP
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

--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pand.1"
Content-Transfer-Encoding: quoted-printable

--- pand/pand.1	(revision 153)
+++ pand/pand.1	(working copy)
@@ -66,3 +66,6 @@
 \fB\-\-pidfile\fR \fB\-P <pidfile>\fR
 Create PID file
=20
+.SH SCRIPTS
+pand will execute \fB/etc/bluetooth/pan/dev-up\fR \fIdevice\fR \fIdestinat=
ion\fR when
+the interface becomes available.

--u5E4XgoOPWr4PD9E--

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEfyxQABzeamt51AERAtgSAKCqC6nI7zMtAy6M/UiTBsQUmGUj9gCeO80r
LD2Zr8qjCLUNROgCvEwDfaA=
=MG/a
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--


--===============1396756862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1396756862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1396756862==--
