Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech diNovo hub not recognized?
From: Marcel Holtmann <marcel@holtmann.org>
To: Holger Frydrych <h.frydrych@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40EFB4C7.3040509@gmx.de>
References: <40EEC9CD.8030003@gmx.de> <1089396942.22528.10.camel@pegasus>
	 <40EF0F10.8050302@gmx.de> <1089413516.13519.16.camel@pegasus>
	 <40EFABCE.7000503@gmx.de> <1089449283.13519.35.camel@pegasus>
	 <40EFB4C7.3040509@gmx.de>
Content-Type: text/plain
Message-Id: <1089451515.13519.49.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 10 Jul 2004 11:25:15 +0200

Hi Holger,

> > Don't use "hcitool cc ...", because this is only for development. What
> > does "hciconfig -a" show?
> This is the output:
> 
> hci0:   Type: USB
>          BD Address: 00:07:61:0D:C4:DF ACL MTU: 192:8  SCO MTU: 64:8
>          UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>          RX bytes:19699 acl:854 sco:0 events:334 errors:0
>          TX bytes:3722 acl:122 sco:0 commands:64 errors:0
>          Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: RSWITCH HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
>          Name: 'BlueZ (0)'
>          Class: 0x000100
>          Service Classes: Unspecified
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x34e LMP Ver: 1.1 (0x1) LMP 
> Subver: 0x34e
>          Manufacturer: Cambridge Silicon Radio (10)
> 
> 
> Well, this reminded me of the fact that I had auth and encrypt options 
> in the hcid config file enabled because I considered that to be good 
> things. Well, but I disabled them, and guess what? My diNovo hardware 
> can now connect to the hub. So far, so good, I guess, though I still 
> thought that hid2hci was not necessary anymore?
> Well ok, it does work so far, but only without auth and encrypt. Is 
> there anything special I must do to get it working with both?

actually I thought that you enabled auth and encrypt ;)

Setting auth and encrypt in hcid.conf or with hciconfig sets your device
into security mode 3 and this is not what you want. The basic security
mode should be 2 which means service level security. I explained this
some times, so check the mailing list archive or the Bluetooth spec. for
more details.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
