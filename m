Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] Device specific configuration
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075827176.13285.82.camel@pegasus>
References: <1075827176.13285.82.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-iKUR9JqrMpLABdogSVYj"
Message-Id: <1075829711.25472.22.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Tue, 03 Feb 2004 18:35:11 +0100
List-ID: <bluez-devel.lists.sourceforge.net>


--=-iKUR9JqrMpLABdogSVYj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Marcel,

tis 2004-02-03 klockan 17.52 skrev Marcel Holtmann:
> this is the patch for the device specific configuration of hcid, that I
> am going to apply. Comments?

Here's a new draft for the hcid.1 man page. It includes a description of
hcid.conf. I propose a few modifications, detailed in the the draft, all
possible to make backwards compatible:

   1. Device and security settings in the "options" section becomes
      deprecated and an alias in favour of "device default". These
      parameters are default unless specified in the "device", "device
      <hci>" and "device <bdaddr>" sections.

   2. "enable" and "disable" becomes deprecated and aliases for
      "yes" and "no" respectively.

Fredrik


--=-iKUR9JqrMpLABdogSVYj
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
\fB/etc/bluetooth/hcid.conf\fP. It consists of sections and
parameters. A section begins with the name of the section followed by
optional specifiers and the parameters inside curly brackets. Sections
contain parameters of the form:

.TP
\fIname\fP \fIvalue1\fP, \fIvalue2\fP ... ;

.PP
Any character after a hash ('#') character is ignored until newline.
Whitespace is also ignored.

.SH SECTION DESCRIPTION

Sections can be any number of \fBdevice\fP sections. If no specifier
is provided, the parameters are applied to devices that do not match
any other section section. The following optional specifiers are
supported:

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

Parameters specified within this section will be applied to all device
sections where these are unspecified.

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

.SH SIGNALS

.SH EXAMPLE
Example of \fBhcid.conf\fP file:

.nf
# These parameters are applied to all device sections unless
# specified in those sections.
device default {
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
	# pkt_type DH1, DM1, HV1;

	# Inquiry and Page scan
	iscan yes;
	pscan yes;

	# Default link mode
	#   none   - no specific policy 
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	# lm accept, master;
	lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	# lp hold, sniff;
	lp hold, sniff, park;

	# Authentication and Encryption
	# auth yes;
	# encrypt yes;
}

# Parameters for a device with address 00:11:22:33:44:55
device 00:11:22:33:44:55 {
	encrypt yes;
}

# Parameters for all other devices
device {
	pairing multi;
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

--=-iKUR9JqrMpLABdogSVYj--
