Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 6230: "pairing and conn. rejected for
	security reasons"
From: Marcel Holtmann <marcel@holtmann.org>
To: Lutz Pressler <Lutz.Pressler@SerNet.DE>
Cc: Peter Stephenson <pws@csr.com>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E1BQMRm-0001ot-00@intern.SerNet.DE>
References: <E1BQMRm-0001ot-00@intern.SerNet.DE>
Content-Type: text/plain
Message-Id: <1084957326.4327.25.camel@pegasus>
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
Date: Wed, 19 May 2004 11:02:06 +0200

Hi Lutz,

> I borrowed a CSR based Allnet 1575.
> 
> hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0C:55:FF:DE:7F ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:99 acl:0 sco:0 events:13 errors:0
>         TX bytes:296 acl:0 sco:0 commands:12 errors:0
>         Features: 0xff 0xff 0x0f 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'tux'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> Pairing and RFCOM usage of the Nokia 6230 (PPP via GPRS) does work with
> that one.
> 
> hcitool info 00:E0:03:39:C9:AB   now looks different:
> 
> Requesting information ...
>         BD Address:  00:E0:03:39:C9:AB
>         Device Name: Nokia 6230 LP
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x380
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xbf 0xee 0x0f 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <sniff mode> <RSSI>
>                 <channel quality> <SCO link> <HV3 packets> <u-law log>
>                 <A-law log> <CVSD> <paging scheme> <power control>
>                 <transparent SCO>
> 
> Any further tests/dums to (re)do with that phone?

this all looks correct and so its again the dongle with the stupid Zeevo
TC2001 Bluetooth chip. This is one of the chips that should never made
it into any end user product. But some chip manufacturers don't care and
this makes Bluetooth looking bad :(

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
