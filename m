Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Jouni.Lohikoski@iki.fi
Subject: Re: [Bluez-users] HID mouse doesnt reconnect after sleep if bemused-bemusedlinuxserver connection is open
References: <20041017125132.GA274769@kosh.hut.fi> <1098018136.4911.87.camel@pegasus> <20041017133034.GC274769@kosh.hut.fi>
In-Reply-To: <20041017133034.GC274769@kosh.hut.fi>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200410171534.33635.cijoml@volny.cz>
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
Date: Sun, 17 Oct 2004 15:34:33 +0200

Switch off security mode 3 and everything will work like a charm. And stop=
=20
that sh*t, if it knows nothing about security :D

M.

Dne ne 17. =F8=EDjna 2004 15:30 Jouni.Lohikoski@iki.fi napsal(a):
> On Sun, Oct 17, 2004 at 03:02:17PM +0200, Marcel Holtmann wrote:
> > > hcid is in security mode 3, auth+encryption turned on.
> >
> > as I always said, do this only if you know what you are doing ;)
>
> I have a hint of what I am doing? :-)
> If I take the authentication off, with current bemused implementation
> anyone could download ogg and mp3-files from my computer. I could not
> claim I did not know this was possible or I didn't know that would be
> illegal :P
>
> > What does "hciconfig -a" and "hcitool info <phone>" say?
>
> Now, in this moment when I have both HID-mouse and Bemused working, it
> looks like this:
>
>
>
> # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:04:61:80:5D:88 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>         RX bytes:1311977 acl:89435 sco:0 events:7161 errors:0
>         TX bytes:21978 acl:295 sco:0 commands:89 errors:0
>         Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x110 LMP Ver: 1.1 (0x1) LMP Subver:
> 0x110 Manufacturer: Cambridge Silicon Radio (10)
>
> # hcitool info 00:60:57:BE:C9:88
> Requesting information ...
>         BD Address:  00:60:57:BE:C9:88
>         Device Name: SayHelloNG
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x248
>         Manufacturer: Nokia Mobile Phones (1)
>         Features: 0xbf 0x28 0x21 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot
> offset> <timing accuracy> <role switch> <sniff mode> <SCO link> <HV3
> packets> <CVSD>
>
> When the HID mouse next time goes to sleep (and if I remember), I try to
> run those commands again to see if there is a difference.
> The Nokia phone do show though it has "role switch"-capability.
>
> // jouni
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out mo=
re
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
