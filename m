Return-Path: <noring@nocrew.org>
Subject: hcid man page update
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075815135.25472.8.camel@kalkyl.roxen.com>
References: <AGELIJDLJNOPFNMOHHIFKECLCAAA.nosve@libero.it>
	 <1075575863.2720.74.camel@pegasus>
	 <1075815135.25472.8.camel@kalkyl.roxen.com>
Content-Type: multipart/mixed; boundary="=-4ZUpB5dhkZfmmeozmEHF"
Message-Id: <1076415720.2758.18.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Tue, 10 Feb 2004 13:22:00 +0100
List-ID: <bluez-devel.lists.sourceforge.net>


--=-4ZUpB5dhkZfmmeozmEHF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

Attached is a new hcid man page update. Except for default device
paramater inheritance and the device specific "autoinit" paramater,
it should be accurate but somewhat incomplete for hcid-2.4-fn8 at:

   http://noring.nocrew.org/bluetooth/

Next I plan to implement persistent DBus device configuration
management. This will make hcid and the Gnome Bluetooth Configuration
tool ready, feature wise, for an initial release, I think.

I suspect Marcel has more comments on the extended interfaces etc. so
these will probably be adjusted in the future.

Fredrik


--=-4ZUpB5dhkZfmmeozmEHF
Content-Disposition: attachment; filename=hcid.1
Content-Type: text/x-troff-man; name=hcid.1; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

.\" 
.\" hcid manual page.
.\" Copyright (C) 2004 Fredrik Noring
.\"
.TH hcid 1
.SH NAME
hcid \- Bluetooth HCI daemon
.SH SYNOPSIS
.PP
\fBhcid\fP [\fIoption\fP]...

.SH DESCRIPTION

\fIhcid\fP is the Bluetooth interface daemon. See
http://www.bluez.org/ for more information about Bluetooth for Linux.
The main purpose of \fIhcid\fP is to automatically configure Bluetooth
interfaces (hci0, hci1 ...).

\fIhcid\fP also provides Bluetooth device pairing services.

.SH OPTIONS
The following options are supported:
.TP
\fB-f\fP=\fIfile\fP, \fB--config-file\fP=\fIfile\fP
Use the given configuration file.
.TP
\fB-h\fP, \fB--help\fP
Print on the standard output a description of the command line options.
.TP
\fB-n\fP, \fB--no-daemon\fP
Do not fork as a daemon.
.TP
\fB--version\fP
Print the version of the daemon.

.SH CONFIGURATION FILE

The \fIhcid\fP configuration file is located in
/etc/bluetooth/hcid.conf. It consists of sections and parameters. A
section begins with the name of the section followed by optional
specifiers and the parameters inside curly brackets. Sections contain
parameters of the form:

.TP
\fIname\fP \fIvalue1\fP, \fIvalue2\fP ... ;

.PP
Any character after a hash ('#') character is ignored until newline.
Whitespace is also ignored.

.SH SECTION DESCRIPTION

Sections can be one \fBoption\fP section and any number of
\fBdevice\fP sections.

.SH OPTION SECTION DESCRIPTION

The following parameters may be present in an option section:

.TP
\fBpair_name\fP = yes|no

Request and store the names of remote devices in the nametab file when
pairing. The default is \fIyes\fP.

.TP
\fBpairing\fP = none|multi|once

\fInone\fP means that pairing is disabled. \fImulti\fP allows pairing
with already paired devices. \fIonce\fP allows pairing once and denies
successive attempts. The default is \fI???\fP.

.TP
\fBpin_file\fP = "\fIfile\fP"

The path to the PIN file. It is a plain text file where the first row
contains the PIN. The default is "/etc/bluetooth/pin".

.TP
\fBpin_helper\fP = "\fIfile\fP"

The path to the PIN helper application. The default is "/bin/bluepin".
The following output is expected from the PIN helper:

PIN:12345678

Or, when no PIN is available:

ERR

.TP
\fBsecurity\fP = none|auto|user

\fInone\fP means the security manager is disabled. \fIauto\fP uses
local PIN for incoming connections. \fIuser\fP always asks the user
for a PIN. The default is \fI???\fP.

.SH DEVICE SECTION DESCRIPTION

Parameters within a device section with no specifier will be applied
to all devices and device sections where these are unspecified. The
following optional device specifiers are supported:

.TP
\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP

Parameters specified within this section will be applied to the device
with this \fIdevice address\fP. All other parameters are applied from
the default section.

.TP
\fBhci\fIn\fP

Parameters specified within this section will be applied to the device
with this \fIdevice interface\fP, unless that device is matched by a
\fIdevice address\fP section. All other parameters are applied from
the default section.

.PP

The following parameters may be present in a device section:

.TP
\fBauth\fP = yes|no

.TP
\fBautoinit\fP = yes|no

Automatically initialize the device. The default is \fIno\fP.

.TP
\fBclass\fP = 0x\fIhhh\FP

.TP
\fBencrypt\fP = yes|no

.TP
\fBiscan\fP = yes|no
.TP
\fBlm\fP = none|accept,master

"none" means no specific policy. "accept" means always accept incoming
connections. "master" means become master on incoming connections and
deny role switch on outgoing connections. Default is \fI???\fP.

.TP
\fBlp\fP = none|rswitch,hold,sniff,park

"none" means no specific policy. "rswitch" means allow role switch.
"hold" means allow hold mode. "sniff" means allow sniff mode. "park"
means allow park mode. Several options can be combined. The default is
\fI???\fP.

.TP
\fBname\fP = "\fIname\fP"

The device name. \fI%d\fP inserts device id. \fI%h\fP inserts host
name.

.TP
\fBpkt_type\fP = DH1,DM1,HV1

.TP
\fBpscan\fP = yes|no

.SH SIGNALS

.SH EXAMPLE
Example of \fBhcid.conf\fP file:

.nf
options {
	security auto;
	pairing multi;
}

# These parameters are applied to all devices and device sections
# unless specified in those sections.
device {
	autoinit yes;

	name "%h (%d)";

	class 0x100;

	iscan yes;
	pscan yes;

	lm accept;

	lp hold, sniff, park;
}

# Parameters for a device with address 00:11:22:33:44:55.
device 00:11:22:33:44:55 {
	name "My device";
}

.SH FILES
.nf
/etc/bluetooth/hcid.conf
/etc/bluetooth/pin
/etc/bluetooth/keytab
/etc/bluetooth/keytab.shadow
/etc/bluetooth/nametab
/bin/bluepin

.SH AUTHORS
Written by Fredrik Noring and Maxim Krasnyansky.

.SH BUGS
Please send bug reports to <bluez-devel@lists.sf.net>.

--=-4ZUpB5dhkZfmmeozmEHF--
