Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42DE3EAA.30705@toughguy.net>
From: Ola Benderius <radaway@toughguy.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Permission problems, Bluetooth Headset
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
Date: Wed, 20 Jul 2005 14:08:10 +0200

Hi,
got a problem when trying to connect my Bluetooth headset (it's a
Plantronics 2500) with Linux.

I'm using Gentoo Linux so I followed the guide in this thread when
pairing the device to the computer:
http://forums.gentoo.org/viewtopic-t-194183.html

I follow this guide and this is my hcid.conf:

/    #
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
            security auto;

            # Pairing mode
            #   none  - Pairing disabled
            #   multi - Allow pairing with already paired devices
            #   once  - Pair once and deny successive attempts
            pairing multi;

            # PIN helper
            # pin_helper /usr/bin/bluepin;
            pin_helper /etc/bluetooth/pin-helper;

            # D-Bus PIN helper
            #dbus_pin_helper;
    }

    # Default settings for HCI devices
    device {
            # Local device name
            #   %d - device id
            #   %h - host name
            name "BlueZ at %h (%d)";

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
            lp   rswitch,hold,sniff,park;

            # Authentication and Encryption (Security Mode 3)
            auth enable;
            encrypt enable;
    }/

But the PIN is set to '0000' since that the PIN of the headset.
(according to the manual)

/    echo "0000" > /etc/bluetooth/pin/

With 'hcitool scan' I get:

/    Scanning ...
        00:03:89:B7:E5:F7       M2500 by Plantronics/


And with 'hcitool inq' I get:

/    Inquiring ...
        00:03:89:B7:E5:F7       clock offset: 0x623f    class: 0x200404/


So far so good. But now I get problems.

'l2ping 00:03:89:B7:E5:F7' returns this:

 /   Can't connect: Permission denied/

8O


That ain't too good. I saved a hcidump for the l2ping and here it comes:

/    < HCI Command: Create Connection (0x01|0x0005) plen 13
    > HCI Event: Command Status (0x0f) plen 4
    > HCI Event: Link Key Request (0x17) plen 6
    < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    > HCI Event: Command Complete (0x0e) plen 10
    > HCI Event: Connect Complete (0x03) plen 11/


Another thing I noticed was this. In the guide the 'hciconfig -a'
command returned the following output:

/    hci0:   Type: USB
            BD Address: 00:10:60:A3:CB:41 ACL MTU: 192:8 SCO MTU: 64:8
            UP RUNNING PSCAN ISCAN AUTH ENCRYPT
            RX bytes:125 acl:0 sco:0 events:17 errors:0
            TX bytes:565 acl:0 sco:0 commands:17 errors:0
            Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
            Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
            Link policy: RSWITCH HOLD SNIFF PARK
            Link mode: SLAVE ACCEPT
            Name: 'BlueZ at bluehat (0)'
            Class: 0x3e0100
            Service Classes: Networking, Rendering, Capturing, Object
Transfer, Audio
            Device Class: Computer, Uncategorized
            HCI Ver: 1.1 (0x1) HCI Rev: 0x1e7 LMP Ver: 1.1 (0x1) LMP
Subver: 0x1e7
            Manufacturer: Cambridge Silicon Radio (10)/


Mine returned this:

/    hci0:   Type: USB
            BD Address: 00:0A:3A:51:BF:D7 ACL MTU: 192:8 SCO MTU: 64:8
            UP RUNNING AUTH ENCRYPT
            RX bytes:9060 acl:271 sco:0 events:332 errors:0
            TX bytes:5093 acl:235 sco:0 commands:51 errors:0
            Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
            Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
            Link policy: RSWITCH HOLD SNIFF PARK
            Link mode: SLAVE ACCEPT
            Name: 'BlueZ at turtlepond (0)'
            Class: 0x3e0100
            Service Classes: Networking, Rendering, Capturing
            Device Class: Computer, Uncategorized
            HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP
Subver: 0x20d
            Manufacturer: Cambridge Silicon Radio (10)/


There are some differences here. I'm thinking about PSCAN ISCAN and the
service classes (mainly 'audio' since I got a headset). First I thought
there was problems reading the hcid.conf file. But then I noticed that
the 'Name' output was the one I set in that file. But still, might this
be a problem?


This problem is really annoying and I would be happy if I got some help!
Not even google can save me here...


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
