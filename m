Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Does the Trust BT180 (Broadcom 0x200a) work? and
	question on bnep0 device.
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4235806E.4020008@gmx.it>
References: <4235806E.4020008@gmx.it>
Content-Type: text/plain
Message-Id: <1110803012.629.5.camel@pegasus>
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
Date: Mon, 14 Mar 2005 13:23:32 +0100

Hi Lorenzo,

> 1) Does the Trust BT180 Class 1 Bluetooth Adapter work correctly, 
> without loading any firmware?

it should work without loading any firmware.

> 2) I tried to configure my Adapter so I could run ifconfing bnep0 ....
> The only problem is that I don't have a bnep0 device. I read that I
> need at list 2 working computers with a bluetooth adapter (working)
> on both, and that I will have the bnep0 adapter only after I have run
> 
> pand --connect xx:xx:xx:xx:xx:xx --service GN
> 
>                |__SERVER ADDRESS_|
> 
> Is that true?

On one side you need "pand --connect" on the other "pand --listen".

> hciconfig :
> 
> hci0:   Type: USB
>          BD Address: 00:0B:0D:60:49:E8 ACL MTU: 377:10  SCO MTU: 16:0
>          UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>          RX bytes:338 acl:0 sco:0 events:48 errors:0
>          TX bytes:1440 acl:0 sco:0 commands:46 errors:0

Don't use "auth" and "encrypt". Use the options of the pand server
instead.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
