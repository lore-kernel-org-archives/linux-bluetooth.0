Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] link_key pairing problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200505251724.23452.RJenster@web.de>
References: <200505211500.37962.ruben@hotheads.de>
	 <200505251447.42486.RJenster@web.de> <1117027586.30044.209.camel@pegasus>
	 <200505251724.23452.RJenster@web.de>
Content-Type: text/plain
Message-Id: <1117036303.30044.236.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 25 May 2005 17:51:43 +0200

Hi Ruben,

> > what does "hciconfig -a" and "hcitool info" say?
> 
> root@thinkpad [/etc] hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0C:55:FD:8E:6B ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:306 acl:0 sco:0 events:41 errors:0
>         TX bytes:900 acl:0 sco:0 commands:39 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'Thinkpad (0)'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> root@thinkpad [/etc] hcitool info 00:0D:B5:80:21:04
> Requesting information ...
> 1       BD Address:  00:0D:B5:80:21:04
>         Device Name: BT808 Headset
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x434
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
>                 <power control> <transparent SCO>
> 

both are CSR based and they should work without any problems. If you
find a note about "full reset" of your headset in its manual, then you
maybe should try that.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
