Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <003201c4161f$d37a2050$4000fe0a@rtsviec64>
From: "Harald Meier" <meh1@rts.at>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002D_01C41630.942B8D60"
Subject: [Bluez-users] PAND and RFCOMM simultaneously
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 30 Mar 2004 08:25:37 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_002D_01C41630.942B8D60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi Marcel,

All PCs in the PAN are equipped with G+W Instruments PICO Bluetooth PCI
Adapter (class 1).
The Serial Devices are equipped with G+W Instruments Blue Serial Bluetooth
Adapter.
(www.gw-instruments.de)

The init script does the following:

        insmod bt-pci.o            # the driver for the BT-PCI card
        insmod bluez.o
        insmod hci_usb.o
        insmod l2cap.o
        insmod bnep.o
       insmod rfcomm.o

        hcid

        sdpd

        pand --listen --role NAP                                         #
on the NAP
        pand --connect <BT-address-of-NAP> --persist    # in the PANU

The hcid.conf is attached (same for NAP and PANU).

When this is running, I get a "Function not implemented" if I try to connect
to
a different NAP (using pand) or if I try to establish a RFCOMM connection.

Is the sequence of loading the modules ok?


Thanks for help!
Harald.

------=_NextPart_000_002D_01C41630.942B8D60
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
	security auto;=0A=
=0A=
	# Pairing mode=0A=
	#   none  - Pairing disabled=0A=
	#   multi - Allow pairing with already paired devices=0A=
	#   once  - Pair once and deny successive attempts=0A=
	pairing multi;=0A=
=0A=
	# PIN helper=0A=
	#pin_helper /bin/bluepin;=0A=
	pin_helper /etc/bluetooth/bluepin;=0A=
}=0A=
=0A=
# Default settings for HCI devices=0A=
device {=0A=
	# Local device name=0A=
	#   %d - device id=0A=
	#   %h - host name=0A=
	name "%h (%d)";=0A=
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
	lm accept,master;=0A=
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
	lp rswitch,hold,sniff,park;=0A=
=0A=
	# Authentication and Encryption=0A=
	auth enable;=0A=
	encrypt enable;=0A=
}=0A=

------=_NextPart_000_002D_01C41630.942B8D60--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
