Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4498EB58.3090200@ibmt.fraunhofer.de>
Date: Wed, 21 Jun 2006 08:46:48 +0200
From: =?ISO-8859-1?Q?Harald_Niederl=E4nder?= <harald.niederlaender@ibmt.fraunhofer.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4497CE54.5080305@ibmt.fraunhofer.de>
In-Reply-To: <4497CE54.5080305@ibmt.fraunhofer.de>
Subject: Re: [Bluez-devel] [Fwd: Re:  Problem connecting Bluetooth device]
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,


Marcel Holtmann wrote:
> 
> 
> Hi Harald,
> 
>> here are 2 different outputs of "hcidump -X -V" (i apologize for the length)
> 
> is the device a security mode 3 device or did you enabled auth and
> encrypt in hcid.conf?
>

auth and encrypt are disabled, see my hcid.conf below

> So the PIN code of this device is "111111". 

Yes, the PIN is 111111


What does the manual state
> about Bluetooth pairing etc.

I don't understand exactly what you mean, therefore the hcid.conf file:
(the Bluetooth-Device should be SLAVE)

# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann Exp $
#

# HCId options
options {
         # Automatically initialize new devices
         autoinit yes;

         # Security Manager mode
         #   none - Security manager disabled
         #   auto - Use local PIN for incoming connections
         #   user - Always ask user for a PIN
         #
         security user;

         # Pairing mode
         #   none  - Pairing disabled
         #   multi - Allow pairing with already paired devices
         #   once  - Pair once and deny successive attempts
         pairing multi;

         # PIN helper
         # if you want a interactiv query of your pin use /usr/bin/bluepin
         # /bin/bluepincat is using the pin in the /etc/bluetooth/pin file
         # pin_helper /usr/bin/bluepin;
         pin_helper /bin/bluepincat;

         # D-Bus PIN helper
         # dbus_pin_helper;
}

# Default settings for HCI devices
device {
         # Local device name
         #   %d - device id
         #   %h - host name
         name "BlueZ %h (%d)";

         # Local device class
         # e.g.
         #  0xsss100 = Computer
         #  0xsss104 = Computer Desktop
         #  0xsss108 = Computer Server
         #  0xsss10c = Computer Laptop
         # The 'sss' above defines the service-class (not quite, only the
         # first 11 bits, the next 11 define the device-class, than 2
format bits.)
         # See
https://www.bluetooth.org/foundry/assignnumb/document/baseband
         # for more information.
         # 0x100bbb stands for "Object Transfer  (v-Inbox, v-Folder, ...)"
         # 0x020bbb stands for "Networking (LAN, Ad hoc, ...)"
         class 0x100100;

         # Default packet type
         #pkt_type DH1,DM1,HV1;

         # Inquiry and Page scan
         # valid parameters: enable | disable
         iscan enable;
         pscan enable;

         # Default link mode
         #   none   - no specific policy
         #   accept - always accept incoming connections
         #   master - become master on incoming connections,
         #            deny role switch on outgoing connections
         lm accept;

         # Default link policy
         #   none    - no specific policy
         #   rswitch - allow role switch
         #   hold    - allow hold mode
         #   sniff   - allow sniff mode
         #   park    - allow park mode
         lp rswitch,hold,sniff,park;

         # Authentication and Encryption (Security Mode 3)
         auth disable;
         encrypt disable;
}
doro:/etc/bluetooth #

> 
> The link key you get from the pairing is different from the link key you
> actually use for authentication in the second try. Please check what has
> been stored in /var/lib/bluetooth/<bdaddr>/linkkeys.

The directory /var/lib/bluetooth is empty !!

It exist two directorys:
doro:/usr/var/lib/bluetooth/00:0A:3A:64:97:46 #
doro:/usr/var/lib/bluetooth/00:0B:0D:09:36:E8 #

(it exist two directorys because I use two USB-Bluetooth connectors)

linkkeys exist only in:

doro:/usr/var/lib/bluetooth/00:0A:3A:64:97:46 #

and contain
00:11:B1:A2:01:C9 6F032F60640CF647B6F07173A5A773CD 0

This entry is older (from March) and different from the key output from
hcidump : 060E5E846F8206C5AECD5306622526E6

doro:/usr/var/lib/bluetooth/00:0B:0D:09:36:E8 #
contains only a file names

P.S. :
both connectors are different by the "Features":
Is it important?

hci0:   Type: USB
         BD Address: 00:0A:3A:64:97:46 ACL MTU: 377:10 SCO MTU: 16:0
         UP RUNNING PSCAN ISCAN
         RX bytes:430 acl:0 sco:0 events:23 errors:0
         TX bytes:339 acl:0 sco:0 commands:22 errors:0
         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'BlueZ doro (0)'
         Class: 0x100100
         Service Classes: Object Transfer
         Device Class: Computer, Uncategorized
         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 
0x309
         Manufacturer: Broadcom Corporation (15)

hci1:   Type: USB
         BD Address: 00:0B:0D:09:36:E8 ACL MTU: 120:20 SCO MTU: 64:0
         UP RUNNING PSCAN ISCAN
         RX bytes:111 acl:0 sco:0 events:14 errors:0
         TX bytes:310 acl:0 sco:0 commands:14 errors:0
         Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'BlueZ doro (1)'
         Class: 0x100100
         Service Classes: Object Transfer
         Device Class: Computer, Uncategorized
         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 
0x757
         Manufacturer: Silicon Wave (11)

> 
> Regards
> 
> Marcel
> 

Regards

Harald




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
