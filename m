Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] [PATCH] Bluetooth address specific device
	configuration
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Nosve <nosve@libero.it>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075575863.2720.74.camel@pegasus>
References: <AGELIJDLJNOPFNMOHHIFKECLCAAA.nosve@libero.it>
	 <1075575863.2720.74.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-iNVHfnrng59RF5r3kjHN"
Message-Id: <1075815135.25472.8.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Tue, 03 Feb 2004 14:32:15 +0100
List-ID: <bluez-devel.lists.sourceforge.net>


--=-iNVHfnrng59RF5r3kjHN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Nosve and Marcel

Attached is a draft for a hcid.1 man page.

The hcid.conf format is slightly changed to make it more useful
and flexible but these changes are not implemented in hcid yet.

Please comment.

Fredrik


--=-iNVHfnrng59RF5r3kjHN
Content-Disposition: attachment; filename=hcid.1
Content-Type: text/x-troff-man; name=hcid.1; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

.\" 
.\" hcid manual page.
.\" Copyright (C) 2004 Fredrik Noring
.\"
.TH hcid 1
.SH NAME
hcid \- Bluetooth interface daemon
.SH SYNOPSIS
.PP
.B hcid
hcid [-f=\fIfile\fP, \-\-config-file=\fIfile\fP] [-n, --no-daemon] [\-\-version]

.SH DESCRIPTION

\fIhcid\fP is the Bluetooth interface daemon. See
http://www.bluez.org/ for more information about Bluetooth for Linux.
The main purpose of \fIhcid\fP is to automatically configure Bluetooth
interfaces (hci0, hci1 ...). \fIhcid\fP also provides Bluetooth device
pairing services.

.SH OPTIONS
The following options are supported:
.TP
\fB-f\fP=\fIfile\fP, \fB--config-file\fP=\fIfile\fP
Use the given configuration file.
.TP
\fB-n\fP, \fB--no-daemon\fP
Do not fork as a daemon.
.TP
\fB--version\fP
Print the version of the daemon.

.SH CONFIGURATION FILE

The \fIhcid\fP configuration file is located in
\fB/etc/bluetooth/hcid.conf\fP. It consists of sections and
parameters. A section begins with the name of the section followed by
optional specifiers and the parameters inside curly brackets. Sections
contain parameters of the form:

.TP
\fIname\fP \fIvalue1\fP, \fIvalue2\fP, ... ;

.PP
Any character after a hash ('#') character is ignored until newline.
Whitespace is also ignored.

.SH SECTION DESCRIPTION

Sections can be one or more \fBdevice\fP sections. The following
optional specifiers are supported:

.TP
\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP

Parameters specified within this section will be applied to the device
with this \fIdevice address\fP.

.TP
\fBhci\fIn\fP

Parameters specified within this section will be applied to the device
with this \fIdevice interface\fP, unless that device is matched by a
\fIdevice address\fP section.

.TP
\fBdefault\fP

Parameters specified within this section will be applied to all
devices that do not match any other device section.

.TP
\fBglobal\fP

Parameters specified within this section will be applied to all device
sections where these are unspecified.

.PP

If no specifier is provided, the parameters are applied to the
\fBdefault\fP section.

.PP

The following parameters may be present in a \fBdevice\fP section\fB:\fP

.TP
\fBautoinit\fP = yes|no

Automatically initialize new devices. The default is \fBno\fP.

.TP
\fBauth\fP = yes|no

.TP
\fBclass\fP = 0x\fIhhh\FP

.TP
\fBencrypt\fP = yes|no

.TP
\fBiscan\fP = yes|no
.TP
\fBlm\fP = none|accept,master

.TP
\fBlp\fP = none|rswitch,hold,sniff,park

.TP
\fBname\fP = "\fIname\fP"

.TP
\fBpairing\fP = none|multi|once

.TP
\fBpin_helper\fP = \fIfile\fP

.TP
\fBpkt_type\fP = DH1,DM1,HV1

.TP
\fBpscan\fP = yes|no

.TP
\fBsecurity\fP = none|auto|user

.SH EXAMPLE
Example of \fBhcid.conf\fP file:

.nf
# These parameters are applied to all device sections unless
# specified in those sections.
device global {
	# Automatically initialize new devices
	autoinit yes;

	# Local device name
	#   %d - device id
	#   %h - host name
	name "%h";

	# Security Manager mode
	#   none - Security manager disabled
	#   auto - Use local PIN for incoming connections
	#   user - Always ask user for a PIN
	security auto;

	# Pairing mode
	#   none  - Pairing disabled
	#   multi - Allow pairing with already paired devices
	#   once  - Pair once and deny successive attempts
	pairing once;

	# PIN helper
	pin_helper /bin/bluepin;

	# Local device class
	class 0x100;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	iscan enable; pscan enable;

	# Default link mode
	#   none   - no specific policy 
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	#
	lm accept,master;
	#
	#lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	#
	#lp hold,sniff;
	#
	lp hold,sniff,park;

	# Authentication and Encryption
	# auth enable;
	# encrypt enable;
}

# Default parameters
device {
	pairing multi;
}

# Parameters for a device with address 00:11:22:33:44:55
device 00:11:22:33:44:55 {
	encrypt enable;
}

.SH FILES
.nf
/etc/bluetooth/hcid.conf
/etc/bluetooth/keytab
/etc/bluetooth/keytab.shadow

.SH AUTHORS
Written by Fredrik Noring and Maxim Krasnyansky.

.SH BUGS
Please send bug reports to <bluez-devel@bluez.org>.

--=-iNVHfnrng59RF5r3kjHN--
