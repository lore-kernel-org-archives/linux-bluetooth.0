Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4375F60C.7090608@gmx.de>
From: Maik Zumstrull <Maik.Zumstrull@gmx.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco: Not working...but almost
References: <437514D5.7040300@gmx.de>  <4375F049.6020300@gmx.de> <1131802872.29461.19.camel@blade>
In-Reply-To: <1131802872.29461.19.camel@blade>
Content-Type: text/plain; charset=windows-1252
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
Date: Sat, 12 Nov 2005 15:02:52 +0100

Marcel Holtmann wrote:

>>sp8472@Maik-2013:~$ sudo hciconfig -a
>>hci0:   Type: USB
>>        BD Address: 00:80:5A:46:05:E3 ACL MTU: 384:8 SCO MTU: 64:8
>>        UP RUNNING PSCAN ISCAN
>>        RX bytes:695 acl:0 sco:0 events:57 errors:0
>>        TX bytes:800 acl:0 sco:0 commands:44 errors:0
>>        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
>>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>        Link policy: RSWITCH HOLD SNIFF PARK
>>        Link mode: SLAVE ACCEPT
>>        Name: 'Maik-2013-0'
>>        Class: 0x3e0100
>>        Service Classes: Networking, Rendering, Capturing
>>        Device Class: Computer, Uncategorized
>>        HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver:
>>0x7a6
>>        Manufacturer: Cambridge Silicon Radio (10)
>>
>>sp8472@Maik-2013:~$ sudo hciconfig hci0 revision
>>hci0:   Type: USB
>>        BD Address: 00:80:5A:46:05:E3 ACL MTU: 384:8 SCO MTU: 64:8
>>        HCI 19.2
>>        Chip version: BlueCore4-ROM
>>        Max key size: 128 bit
>>        SCO mapping:  HCI
> 
> 
> what kind of dongle is this? I like to get one with a BlueCore4-ROM chip
> for myself.

Conceptronic Bluetooth 2.0 USB Adapter 200M
Part-No CBT200U2

I got it for EUR 19,99 at my local Arlt.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
