Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <39673606050813203174545cc1@mail.gmail.com>
From: Robert Brewer <rwb123@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] pairing problem - please help
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 13 Aug 2005 23:31:08 -0400

Hi all,

A few weeks ago I successfully paired my headset with my broadcom dongle
under bluez.  I was able to l2ping the headset, and btsco was able to make
the headset ring.  I couldn't get audio data through, but now I know that
is because bluez doesn't support SCO for broadcom.

Now I can't get the headset paired.  The past week I've been pairing the he=
adset
with the same dongle under WinXP.  Any thoughts on what is going wrong?
Here is what I'm doing:

<plug in dongle>

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:72:C4:25:E4 ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:1605 acl:0 sco:0 events:84 errors:0
        TX bytes:693 acl:0 sco:0 commands:43 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'wiz-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0xc LMP Ver: 1.2 (0x2) LMP Subver: 0x30=
9
        Manufacturer: Broadcom Corporation (15)

<turn on headset in pairing mode>

# hcitool scan
Scanning ...
        00:0D:44:37:57:F2       Logitech HS02-V07

# hcitool inq
Inquiring ...
        00:0D:44:37:57:F2       clock offset: 0x488c    class: 0x200404

# l2ping 00:0D:44:37:57:F2
Can't connect: Permission denied

At no time does a PIN request window pop up.  I know that when I previously
got it to work a PIN window popped up and I type in the headset's PIN.
 I thought
that sometime during the scan or inq command the PIN window would pop up
and I would be paired.

Here is the hcidump log that happens during the previous session:

# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.23
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'wiz-0'
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
> HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 1
    status 0x00 class 0x3e0100
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 1.2 (0x2) HCI Revision: 0xc
    LMP Version: 1.2 (0x2) LMP Subversion: 0x309
    Manufacturer: Broadcom Corporation (15)
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:0D:44:37:57:F2 mode 1 clkoffset 0x488d class 0x200404
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:0D:44:37:57:F2 mode 1 clkoffset 0x488c class 0x200404
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:0D:44:37:57:F2 mode 1 clkoffset 0x488c class 0x200404
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:0D:44:37:57:F2 mode 1 clkoffset 0x488c class 0x200404
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:0D:44:37:57:F2 mode 1 clkoffset 0x488c (valid)
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:0D:44:37:57:F2 name 'Logitech HS02-V07'
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0D:44:37:57:F2 ptype 0xcc18 rswitch 0x01 clkoffset 0x488c (va=
lid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0D:44:37:57:F2
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0D:44:37:57:F2 key 21751F10ED96C2A142D28C142C725168
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0D:44:37:57:F2
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 6 bdaddr 00:0D:44:37:57:F2 type ACL encrypt 0x00
    Error: Authentication Failure

Here are my config files:

/etc/bluetooth/hcid.conf:
#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann Exp $
#

# HCId options
options {
        # Automatically initialize new devices
#       autoinit no;
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming connections
        #   user - Always ask user for a PIN
        #
        security auto;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # PIN helper
#       pin_helper /usr/bin/bluez-pin;
        pin_helper /usr/bin/bluepin;

        # D-Bus PIN helper
        #dbus_pin_helper;
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "%h-%d";

        # Local device class
        class 0x3e0100;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

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
        #auth enable;
        #encrypt enable;
}

/etc/bluetooth/pin:
1234

How do I get my headset to pair?  Why won't it work now when it worked
previously?  Thanks!

-Rob
--=20
Robert W. Brewer


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
