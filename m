Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Stefan Quandt <Stefan.Quandt@bardenheuer.de>
Message-ID: <dkqh8j$3ct$1@sea.gmane.org>
References: <dkq0na$agk$1@sea.gmane.org> <1131454229.5824.163.camel@blade> <dkqb18$cek$1@sea.gmane.org> <1131460505.5824.183.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Re: flooded with "SCO data: handle 0 dlen 0"
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
Date: Tue, 08 Nov 2005 16:46:27 +0100

Hi Marcel,

doing "hciconfig -a" (a few seconds after connecting the dongle) gives me
hci0:   Type: USB
        BD Address: 00:0C:78:30:B9:1A ACL MTU: 339:4 SCO MTU: 60:9
        UP RUNNING
        RX bytes:441632 acl:0 sco:129750 events:27 errors:0
        TX bytes:345 acl:0 sco:0 commands:24 errors:0
        Features: 0xff 0xff 0x81 0x00 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x222 LMP Ver: 1.2 (0x2) LMP Subver:
0x222
        Manufacturer: RTX Telecom A/S (21)

Thanks
   Stefan

Marcel Holtmann wrote:

> Hi Stefan,
> 
>> >> As soon as I connect my Bluetooth-Dongle (Abe UB 20S, BlueSoleil) my
>> >> syslog are flooded with empty SCO packets.
>> > check if this is a Silicon Wave based dongle.
>> How may I do this?
>> 
>> http://www.holtmann.org/linux/bluetooth/features.html
>> says the manufacturer is RTX Telecom.
>> 
>> Maybe this helps:
>> /sys/bus/usb/devices/1-1/idProduct contains 080a
>> /sys/bus/usb/devices/1-1/idVendor contains  0400
> 
> call "hciconfig -a".
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download it for free - -and be entered to win a 42" plasma tv or your very
> own
> Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
