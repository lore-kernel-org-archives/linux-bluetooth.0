Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Need help with PAND between 2  linux boxes
From: Marcel Holtmann <marcel@holtmann.org>
To: Paul Ionescu <i_p_a_u_l@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040816121411.26419.qmail@web50203.mail.yahoo.com>
References: <20040816121411.26419.qmail@web50203.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1092659558.4375.145.camel@pegasus>
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
Date: Mon, 16 Aug 2004 14:32:38 +0200

Hi Paul,

> Here is the info:
>  hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:20:E0:75:21:DA ACL MTU: 192:8 
> SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:200 acl:0 sco:0 events:26 errors:0
>         TX bytes:621 acl:0 sco:0 commands:22 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
> 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
> HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: ACCEPT MASTER 
>         Name: 't41-0'
>         Class: 0x120104
>         Service Classes: Networking, Object Transfer
>         Device Class: Computer, Desktop workstation
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1
> (0x1) LMP Subver: 0x222
>         Manufacturer: Cambridge Silicon Radio (10)

leave "security auto;" and use "lm accept;" in hcid.conf. After that you
should read the comment in hcid.conf:

        #   master - become master on incoming connections,
        #            deny role switch on outgoing connections

How can it work if you set "master" on both sides ;)

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
