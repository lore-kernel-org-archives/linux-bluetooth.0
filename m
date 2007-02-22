Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 21 Feb 2007 16:15:50 -0800 (PST)
From: walt shekrota <penguinacity@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <522785.39828.qm@web62315.mail.re1.yahoo.com>
Subject: [Bluez-users] plantronics 320 working minor problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I posted ealier under another id but your list
penalizes those who's provider 
does not respond appropriately with a postmaster
address. Mine is 
optonline.net and they control most of the NY NYC and
LI area.
Funny they would keep us from posting. Trying to get
the provider to 
understand is like feeding a duck nails.

So now to my problems.
dongle == DLINK DBT120 B4
headset == Plantronics Explorer 320

#
# HCI daemon configuration file.
#

# HCId options
options {
        # Automatically initialize new devices
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming
connections
        #   user - Always ask user for a PIN
        #
        security user;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired
devices
        #   once  - Pair once and deny successive
attempts
        pairing multi;

        # PIN helper
        pin_helper /etc/bluetooth/pin;

        # D-Bus PIN helper
        #dbus_pin_helper;
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "BlueZ (%d)";

        # Local device class
        class 0x3e0100;
        
        # Default packet type
        pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        #   none   - no specific policy 
        #   accept - always accept incoming
connections
        #   master - become master on incoming
connections,
        #            deny role switch on outgoing
connections
        lm accept;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        lp rswitch,hold,sniff,park;

        # Authentication and Encryption (Security Mode
3)
        auth enable;
        encrypt enable;
}

#
# RFCOMM configuration file.
#

rfcomm0 {
        # Automatically bind the device at startup
        bind yes;

        # Bluetooth address of the device
         device 00:13:46:47:67:F4;

        # RFCOMM channel for the connection
        channel 1;

        # Description of the connection
#       comment "Example Bluetooth device";
}


 hciconfig -a revision
 hci0:   Type: USB
         BD Address: 00:13:46:47:67:F4 ACL MTU: 192:8
SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
         RX bytes:68484755 acl:2206 sco:1341684
events:2384 errors:0
         TX bytes:68389547 acl:2179 sco:1340183
commands:112 errors:1
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
0x00
         Packet type: DM1 DH1 HV1
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'BlueZ (0)'
         Class: 0x3e0100
         Service Classes: Networking, Rendering,
Capturing
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver:
1.1 (0x1) LMP Subver: 
0x20d
         Manufacturer: Cambridge Silicon Radio (10)

 hcitool inq
Inquiring ...
        00:03:89:F7:A9:78       clock offset: 0x40ac  
 class: 0x200404

 hcitool scan
Scanning ...
        00:03:89:F7:A9:78       320Plantronics

using btsco-0.5
I use it frequently mostly so I could understand the
quirks.
With the headset waiting connect never happens the
first time.
btsco -v  <addr> 
just fails out with only an RFCOMM message
second time it connects....
This is a consistant behavior at every headset
poweron/connect.

Here is a log of this:

btsco -v 00:03:89:F7:A9:78
btsco v0.42
Device is 1:0
Voice setting: 0x0060
Can't connect RFCOMM channel: Connection refused

then on retry

btsco -v 00:03:89:F7:A9:78
btsco v0.42
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
Using interface hci0

I notice that even once connected I have to frequently
hit the button on the 
headset once to get sound thus dropping the channel I
guess making it 
available. But then sometimes it works without this.
This probably relates to a problem after a call when
channel dropped and 
headset is in standby. Frequently if its a long time
in standby I have 
trouble.
Sometimes the only out is stop/start alsa.

Any ideas for these symptoms.
Thanks!
-Walt


 
____________________________________________________________________________________
Finding fabulous fares is fun.  
Let Yahoo! FareChase search your favorite travel sites to find flight and hotel bargains.
http://farechase.yahoo.com/promo-generic-14795097

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
