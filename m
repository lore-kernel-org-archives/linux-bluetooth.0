Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Jouni.Lohikoski@iki.fi" <jlohikos@cc.hut.fi>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040917202651.GA485579@kosh.hut.fi>
Reply-To: Jouni.Lohikoski@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Epox BT-MS02B Bluetooth HID mouse, authorization and encryption?
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
Date: Fri, 17 Sep 2004 23:26:51 +0300

Thanks (marcel) for the page:
[URI1] < http://www.holtmann.org/linux/bluetooth/hid.html >
                                                                                
That gave me courage to buy and try EPoX BT-MS02B mouse. Have to decide
in 14 days if I will keep this.
                                                                                
I got it working, but few things (3) I'd need to find out still. hidd
program seems to be so new, there is no yet any documentation with it.
Maybe later there will FAQ for Linux HID.
                                                                                
I used to have authorization and encryption on in
/etc/bluetooth/hcid.conf before, but I noticed "hidd --search"
wanted a PIN then for outgoing connection. I have no idea what would be the
Bluetooth PIN-code for my mouse, neither was it mentioned anywhere in the
package or in the Windows-documentation which came with the mouse.

I'd still like to have authorization and encryption on, because I have also
Bluetooth OBEX-server on the machine and someone could now easily without
authorization write to my home directory. (gnome-obex-server)

1)
How one turns encryption off just for HID devices, preferrably only for
this one mouse,...or should I somehow be able to get the PID-code for 
my mouse from somewhere? Is the VID:PID column in the table of the first URI
meant for that PID-code information?

2) After 11 minutes 
(I assume from [URI2] <http://www.holtmann.org/linux/bluetooth/epox.html>)
the mouse has disconnected and went to the sleep mode. Is there some
way to reconnect it automaticly? Now I seem to need to push the mysterous
grey button on the bottom of the mouse always, and do `hidd --search` again
to get it reconnected. 

[This 2. one I seem to have solved by upgrading to bluez-utils-2.10, now
hidd --server does accept reconnection after the power saving sleep, but
only if auth+encryption is disabled.]

I need to ask EPoX technical support what exactly is
the little grey button on the bottom of the mouse for. Or would you know?

I don't quite understand what hidd --server is for, [can guess now]
as again, there was no documentation, at least in the rpm packages
(bluez-utils-2.8*rpm) I also looked the newest bluez-utils-2.10 for
hidd documentation, no luck. Is it suppose to accept and re-attach connection
from the HID device which comes out of idle-state?

3)
What is the column "AFH" in the table of the first URI?
(and VID:PID ?)

Other info about the system:
OS Fedora Core 2, Kernel 2.6.8, bluez-libs-2.8, bluez-utils-2.8

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:04:61:80:5D:88 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1021048 acl:69685 sco:0 events:5583 errors:0
        TX bytes:17089 acl:124 sco:0 commands:48 errors:0
        Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x110 LMP Ver: 1.1 (0x1) LMP Subver: 0x110
        Manufacturer: Cambridge Silicon Radio (10)

# hidd --show
00:04:61:82:00:88 HID Boot Device [0000:0000] connected [boot-protocol]

# hcitool info 00:04:61:82:00:88
Requesting information ...
        BD Address:  00:04:61:82:00:88
        Device Name: Bluetooth-Mouse 82007B
        LMP Version: 1.1 (0x1) LMP Subversion: 0x356
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <transparent SCO>



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
