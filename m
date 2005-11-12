Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4375F049.6020300@gmx.de>
From: Maik Zumstrull <Maik.Zumstrull@gmx.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco: Not working...but almost
References: <437514D5.7040300@gmx.de>
In-Reply-To: <437514D5.7040300@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 12 Nov 2005 14:38:17 +0100

Maik Zumstrull wrote:
> Okay, I'm in the situation I've seen reportet a few times on the List:
> 
> Everything seems as if it were working, but I can't actually hear any
> sound sent to the Headset. I suspect it's the unsupported Bluetooth
> adapter in my laptop, which ist, unfortunately, Broadcom-based.

The good news: I just went and bought an additional BT dongle, nice and
CSR-based:

sp8472@Maik-2013:~$ sudo hciconfig -a
hci0:   Type: USB
        BD Address: 00:80:5A:46:05:E3 ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:695 acl:0 sco:0 events:57 errors:0
        TX bytes:800 acl:0 sco:0 commands:44 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Maik-2013-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver:
0x7a6
        Manufacturer: Cambridge Silicon Radio (10)

sp8472@Maik-2013:~$ sudo hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:80:5A:46:05:E3 ACL MTU: 384:8 SCO MTU: 64:8
        HCI 19.2
        Chip version: BlueCore4-ROM
        Max key size: 128 bit
        SCO mapping:  HCI


The bad news: Suddenly things work even less than before. I must have
badly fucked up my configuration along the way. I can't even talk to the
Headset now. hcitool scan works, nothing else, not even hcitool info:

sp8472@Maik-2013:~$ sudo /etc/init.d/bluez-utils stop
Stopping bluez-utils: rfcomm sdpd hcid.
sp8472@Maik-2013:~$ sudo /etc/init.d/bluez-utils start
Starting bluez-utils: hcid sdpd rfcomm.
sp8472@Maik-2013:~$ hcitool scan
Scanning ...
        00:07:A4:C0:25:A5       Jabra BT500
sp8472@Maik-2013:~$ hcitool info 00:07:A4:C0:25:A5
Requesting information ...
Can't create connection: Operation not permitted
sp8472@Maik-2013:~$ sudo hcitool info 00:07:A4:C0:25:A5
Requesting information ...
Can't create connection: Connection timed out


Any idea how to get things working now?


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
