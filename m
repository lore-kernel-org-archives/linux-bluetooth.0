Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Matthew Marshall <mmarshall@myrealbox.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200509181632.29044.mmarshall@myrealbox.com>
Subject: [Bluez-users] Audio service class?
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
Date: Sun, 18 Sep 2005 16:32:28 +0000

Hello,

 I am wanting to use a bluetooth headset with bluetooth-alsa.  However, I 
haven't been able get the dongle to pick up the headset.  hciconfig -a gives 
me this output:

hci0:   Type: USB
        BD Address: 00:13:EF:F0:D0:6A ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:404 acl:0 sco:0 events:18 errors:0
        TX bytes:323 acl:0 sco:0 commands:18 errors:0
        Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x639 LMP Ver: 1.2 (0x2) LMP Subver: 0x639
        Manufacturer: Cambridge Silicon Radio (10)

The class is set to 0x3e0100, but Audio is not included in the Service Classes 
list.  (I assume this is the reason why the headset is not being detected.)  
Is the Audio service class not supported by some dongles?  Is there some 
kernel option that needs to be set?

I am using Arch linux with kernel 2.6.12, bluez-lib and bluez-util 2.20.

Anyone know what might be wrong?

Thanks for any help!

MWM


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
