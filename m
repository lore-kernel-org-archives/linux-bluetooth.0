Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: class 1 bluetooth 1.2 dongles with CSR
	chipset?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051005152912.GA2686@intevation.de>
References: <20050930124108.GA26157@intevation.de>
	 <1128087233.4955.43.camel@localhost.localdomain>
	 <20051005152912.GA2686@intevation.de>
Content-Type: text/plain
Message-Id: <1128534616.5447.32.camel@localhost.localdomain>
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
Date: Wed, 05 Oct 2005 19:50:16 +0200

Hi Thomas,

> > try to get a Cellink BlueCore4 based dongle with EDR support.
> 
> The two Cellink BTA6030 arrived today, here the output of
> hciconfig hci1 features version revision:
> 
> hci1:   Type: USB
>         BD Address: 00:0A:94:xx:xx:xx ACL MTU: 384:8 SCO MTU: 64:8
>         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset> 
>                 <timing accuracy> <role switch> <hold mode> <sniff mode> 
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
>                 <power control> <transparent SCO> <broadcast encrypt> 
>                 <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan> 
>                 <interlaced iscan> <interlaced pscan> <inquiry with RSSI> 
>                 <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave> 
>                 <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL> 
>                 <AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps> 
>                 <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features> 
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x5dc LMP Ver: 1.1 (0x1) LMP Subver: 0x5dc
>         Manufacturer: Cambridge Silicon Radio (10)
>         Build 1500
>         Chip version: BlueCore4-External
>         Max key size: 56 bit
>         SCO mapping:  HCI
> 
> The version numbers look strange.

the version numbers can be corrected with the pskey tool. Check version
and remver PS keys.

> Unfortunately the dongles only support 56bit encryption.

You can flash a 128-bit firmware into it, but currently no such firmware
is not available in the public.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
