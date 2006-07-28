Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Wolfram Reda <wolfram_reda@yahoo.de>,
        BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060726211333.50028.qmail@web27904.mail.ukl.yahoo.com>
References: <20060726211333.50028.qmail@web27904.mail.ukl.yahoo.com>
Date: Fri, 28 Jul 2006 03:23:53 +0200
Message-Id: <1154049833.7650.10.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] can't connect EPOX Keyboard BT-KB01B
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

Hi Wolfram,

> I'm trying to connect my Buetooth Keyboard BT-KB01B but without success so far. The error message is:
> 
>  hcitool conf
> Connections:
>         > ACL 00:04:61:81:F7:C8 handle 44 state 1 lm SLAVE
>         < ACL 00:04:61:82:03:4A handle 41 state 1 lm MASTER
> root@woraBox:/home/rw024419# hidd --connect 00:04:61:82:03:4A
> Can't create HID control channel: Connection timed out

run "hcidump -X -V" so see what is really going on.

> and here the info from the bluetooth usb dongle:
> 
> 
> hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:04:61:81:5A:A8 ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:967334 acl:38241 sco:0 events:47990 errors:0
>         TX bytes:244813 acl:260 sco:0 commands:47588 errors:0
>         Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy:
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ linux (0)'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)

Make sure that hcid is running. From this output it doesn't look like it
is running.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
