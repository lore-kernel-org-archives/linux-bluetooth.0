Return-Path: <z.dia@gmx.de>
Message-ID: <000b01c3fa66$4dccee30$4c4bb850@ULLA>
From: "Zbigniew Diaczyszyn \(gmx\)" <z.dia@gmx.de>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: <bluez-users@lists.sourceforge.net>
References: <000d01c3f343$d89f1ad0$e04db850@ULLA> <1076855680.14758.55.camel@pegasus>  <000b01c3f599$04aaf520$de4bb850@ULLA> <1077058491.2665.131.camel@pegasus>  <003b01c3f65e$371ef400$dc4db850@ULLA> <1077147114.2685.11.camel@pegasus>  <000601c3f8c9$98e2c820$3d4bb850@ULLA> <1077415764.2716.21.camel@pegasus>  <000b01c3f98e$697f79a0$494db850@ULLA> <1077486947.2832.20.camel@pegasus>
Subject: Re: [Bluez-users] rfcomm socket message: function not implemented
Date: Tue, 24 Feb 2004 00:39:37 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0009_01C3FA6E.AE1C9080"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_0009_01C3FA6E.AE1C9080
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> I am pretty sure that you have the same PIN helper problem like many
> others do.

So I will not lose hope to get working the BT interface ...

Attached you will find the binary file in hcidump.log and the files for =
the pinhelper-stuff: bluepin is just an cat-command.

Thanks in advance!

Zbigniew




------=_NextPart_000_0009_01C3FA6E.AE1C9080
Content-Type: application/octet-stream;
	name="hcidump.log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="hcidump.log"

EQAAAOSKOkDr3wUAAQUEDSysKWAQABjMAQAAAAEHAAEA5Io6QMf3BQAEDwQAAQUECQABAOeKOkBg
9gAABBcGLKwpYBAADgABAAWLOkDYbwAABAMLIikALKwpYBAAAQA=

------=_NextPart_000_0009_01C3FA6E.AE1C9080
Content-Type: application/octet-stream;
	name="bluepin"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bluepin"

#!/bin/bash=0A=
cat /etc/bluetooth/pin=0A=

------=_NextPart_000_0009_01C3FA6E.AE1C9080
Content-Type: application/octet-stream;
	name="hcid.conf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hcid.conf"

#=0A=
# HCI daemon configuration file.=0A=
#=0A=
# $Id: hcid.conf,v 1.3 2002/07/18 18:12:46 maxk Exp $=0A=
#=0A=
=0A=
# HCId options=0A=
options {=0A=
	# Automatically initialize new devices=0A=
	autoinit yes;=0A=
=0A=
	# Security Manager mode=0A=
	#   none - Security manager disabled=0A=
	#   auto - Use local PIN for incoming connections=0A=
	#   user - Always ask user for a PIN=0A=
	#=0A=
	# security auto;=0A=
=0A=
	# Pairing mode=0A=
	#   none  - Pairing disabled=0A=
	#   multi - Allow pairing with already paired devices=0A=
	#   once  - Pair once and deny successive attempts=0A=
	pairing multi;=0A=
=0A=
	# PIN helper=0A=
	pin_helper /bin/bluepin;=0A=
}=0A=
=0A=
# Default settings for HCI devices=0A=
device {=0A=
	# Local device name=0A=
	#   %d - device id=0A=
	#   %h - host name=0A=
	name "Typhoon (%d)";=0A=
=0A=
	# Local device class=0A=
	class 0x100;=0A=
=0A=
	# Default packet type=0A=
	#pkt_type DH1,DM1,HV1;=0A=
=0A=
	# Inquiry and Page scan=0A=
	iscan enable; pscan enable;=0A=
=0A=
	# Default link mode=0A=
	#   none   - no specific policy =0A=
	#   accept - always accept incoming connections=0A=
	#   master - become master on incoming connections,=0A=
	#            deny role switch on outgoing connections=0A=
	#=0A=
	#lm accept,master;=0A=
	#=0A=
	lm accept;=0A=
=0A=
	# Default link policy=0A=
	#   none    - no specific policy=0A=
	#   rswitch - allow role switch=0A=
	#   hold    - allow hold mode=0A=
	#   sniff   - allow sniff mode=0A=
	#   park    - allow park mode=0A=
	#=0A=
	#lp hold,sniff;=0A=
	#=0A=
	lp hold,sniff,park;=0A=
=0A=
	# Authentication and Encryption=0A=
	#auth enable;=0A=
	#encrypt enable;=0A=
}=0A=

------=_NextPart_000_0009_01C3FA6E.AE1C9080--
