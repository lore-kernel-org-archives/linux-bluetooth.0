Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Ciro Scognamiglio <moray@libero.it>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] DBT-120
Message-ID: <20030907201314.GA25166@libero.it>
References: <20030907143700.GA9936@libero.it>
Mime-Version: 1.0
In-Reply-To: <20030907143700.GA9936@libero.it>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 7 Sep 2003 22:13:14 +0200
Content-Type: text/plain; CHARSET=us-ascii


Any clues for my problem?

I am still having some tests, but the BT link still dies
after a bit. I do this:

modprobe bluez
modprobe hci_usb
modprobe l2cap
modprobe sco
modprobe rfcomm
hcid
sdpd
hciconfig hci0 piscan noauth up
sdptool add --channel=3 SP
dund --listen --channel 3
rfcomm bind /dev/rfcomm1 00:0a:d9:16:95:bb 1

then I use pppd to connect the p800, everything is fine, I
can download emails or surf the web with opera.
After trasferring some datas (like downloading something)
the link goes down, but neither the p800 nor the linux side
complains.

here is the hcidconfig -a output, as you can see my dbt-120 is
not a broadcomm device (as I read on previous posts about this dongle)

hci0:   Type: USB
        BD Address: 00:40:05:54:A6:59 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN ENCRYPT
        RX bytes:14001 acl:457 sco:0 events:653 errors:0
        TX bytes:133931 acl:1096 sco:0 commands:29 errors:0
        Features: 0xff 0xff 0x0f 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'doroty (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
        Manufacturer: Cambridge Silicon Radio (10)

I really DON'T know where to look :( 

Ciro


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
