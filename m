Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Johannes Kapune <listen@kapune.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <448EFA00.3030000@xmission.com>
References: <1150148335.7372.7.camel@johannes_01.kapune.local>
	<448DEA20.5000806@stfw.eu>
	<1150219383.7401.5.camel@johannes_01.kapune.local>
	<448EFA00.3030000@xmission.com>
Date: Wed, 14 Jun 2006 10:14:51 +0200
Message-Id: <1150272891.7398.28.camel@johannes_01.kapune.local>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Can't play mp3, what I'm missing?
Reply-To: bluez-users@lists.sourceforge.net
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

Hi all.

I'm not sure but I see in the "connection-display" that my headphone is
master. Is this right or should it be slave?


an for hciconfig -a I read that the dongle is slave?

How do I change this? (I need to?)


# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0A:94:02:7D:A0 ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1324 acl:9 sco:0 events:91 errors:0
        TX bytes:834 acl:8 sco:0 commands:57 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ linux (0)'
        Class: 0x700100
        Service Classes:
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x5dc LMP Ver: 1.1 (0x1) LMP Subver:
0x5dc
        Manufacturer: Cambridge Silicon Radio (10)



I also can't connect a rfcomm socket

# rfcomm -i hci0 connect 0 00:0A:94:A0:59:3B 1
Can't connect RFCOMM socket: Resource temporarily unavailable


What ca I do, step by step, do get more informations to let the
headphone work? I think there is something wrong with my configuration
but I don't know what.


Thanks 


Johannes



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
