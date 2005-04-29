Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Something strange with minicom
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200504291833.26111@ByZsA>
References: <200504291833.26111@ByZsA>
Content-Type: text/plain
Message-Id: <1114794975.8836.106.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 29 Apr 2005 19:16:15 +0200

Hi Attila,

> I'm trying to connect to my new mobile phone via a usb bluetooth 
> dongle. I solved many problems (and learned a lot) but I'm 
> stuck. I downloaded and installed the latest bluez stuff. 
> (Version 2.16 at this time) It seems to work but I still can not 
> comminicate with my phone. I can start everything and could pair 
> my phone with my PC. When I start minicom to test the 
> connection, I can type anything but phone answers with "error". 
> I tried it with hyperterminal under windows and it works. So we 
> shouldn't talk about hardware problems.
> 
> Here is my hciconfig -a output:
> hci0:   Type: USB
>         BD Address: 00:09:DD:10:6D:32 ACL MTU: 192:8 SCO MTU: 
> 64:8
>         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>         RX bytes:1990 acl:51 sco:0 events:91 errors:0
>         TX bytes:1174 acl:49 sco:0 commands:28 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'Cornflower'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x460 LMP Ver: 1.1 (0x1) LMP 
> Subver: 0x460
>         Manufacturer: Cambridge Silicon Radio (10)

are you sure that you wanna be in security mode 3. Using auth and
encrypt is not advisable.

> And here is the "hcidump -x" result when I enter an "atz" modem 
> command in minicom:
> HCI sniffer - Bluetooth packet analyzer ver 1.20
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < ACL data: handle 41 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0041 len 5 [psm 0]
>       0B EF 03 61 9A

Make sure that you grep the initial HCI and L2CAP connection setup,
because otherwise hcidump is not able to decode RFCOMM. Or specific the
--psm=3 option on the command line.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
