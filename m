Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] D-Link DBT 120 B4 + 2.6.6 / 2.6.6-mh1
From: Marcel Holtmann <marcel@holtmann.org>
To: Simon Huggins <huggie@earth.li>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040513202052.GJ14471@paranoidfreak.co.uk>
References: <20040513202052.GJ14471@paranoidfreak.co.uk>
Content-Type: text/plain
Message-Id: <1084485054.25099.153.camel@pegasus>
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
Date: Thu, 13 May 2004 23:50:54 +0200

Hi Simon,

> I've just got a D-link DBT 120 which on the box has a revision of B4
> (not quite sure where to find this when the module is loaded).
> 
> I compiled up 2.6.6 and got the module loaded and everything and it all
> looked fine but it won't see my phone in hcidump.
> 
> So I looked on the site and noticed it said:
> 	This patch brings the long awaited kernel HID support for the
> 	Human Interface Device Protocol and fixes some serious bugs in
> 	the USB based Bluetooth drivers.
> 
> So I tried it with the -mh1 patch to 2.6.6 and didn't get any further.
> 
> I have a Nokia 6310i and I was expecting to see it in hcitool scan but I
> just get:
> huggie@thin:~$ hcitool scan
> Scanning ...
> in spite of the phone having Bluetooth turned on and having a name.
> 
> I tried running hcidump too and it shows me stuff like:
> > HCI Event: Inquiry Complete(0x01) plen 1
> > HCI Event: Command Status(0x0f) plen 4
> when I run the above scan.

run it with -x switch to better see the event content.

> hciconfig -a shows:
> hci0:   Type: USB
>         BD Address: 00:0F:3D:0D:73:5C ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN AUTH 
>         RX bytes:465 acl:0 sco:0 events:32 errors:0
>         TX bytes:622 acl:0 sco:0 commands:27 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'thin-0'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)

You should disable auth in hcid.conf, because this will set the dongle
into security mode 3 and this is not what you want.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
