Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: help me
From: Marcel Holtmann <marcel@holtmann.org>
To: Vitaliy <pub@mifki.ru>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20040523T170840-699@post.gmane.org>
References: <loom.20040523T164826-243@post.gmane.org>
	 <1085324502.8309.19.camel@pegasus>
	 <loom.20040523T170840-699@post.gmane.org>
Content-Type: text/plain
Message-Id: <1085326200.8309.22.camel@pegasus>
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
Date: Sun, 23 May 2004 17:30:00 +0200

Hi,

> The problem is that I have laptop and usb-bt dongle, I can initiate any
> connection with any device or pairing from laptop, but can't initiate connection
> from devices to laptop. Device (Pocket PC for example) simply can't get list of
> services from laptop. But! When I use the same dongle with desktop machine
> everything works well (with the same /etc/bluetooth/ config).
> 
> # uname -a
> Linux n-vit 2.4.26_pre6-gentoo #34 Fri Apr 23 18:47:35 MSD 2004 i686 Intel(R)
> Pentium(R) M processor 1400MHz GenuineIntel GNU/Linux
> 
> On desktop I use 2.6, but here I have to use 2.4 because sound driver works only
> with it.
> 
> # hciconfig -a
> hci0:   Type: USB
>  BD Address: 00:03:2F:FF:EA:27 ACL MTU: 192:8  SCO MTU: 64:8
>  UP RUNNING PSCAN ISCAN
>  RX bytes:99 acl:0 sco:0 events:13 errors:0
>  TX bytes:296 acl:0 sco:0 commands:12 errors:0
>  Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>  Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>  Link policy:
>  Link mode: SLAVE ACCEPT
>  Name: 'n-vit'
>  Class: 0x00010c
>  Service Classes: Unspecified
>  Device Class: Computer, Laptop
>  HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
>  Manufacturer: Cambridge Silicon Radio (10)
> 
> # qpkg -I -i | grep bluez
> net-wireless/bluez-libs-2.5 *
> net-wireless/bluez-pan-1.1 *
> net-wireless/bluez-sdp-1.5 *
> net-wireless/bluez-utils-2.5 *
> 
> hcid and sdpd are running.

think about installing bluez-libs-2.7 and bluez-utils-2.7. In that case
you don't need the bluez-pan or bluez-sdp anymore, because they are
deprecated.

Run "hcidump -w <file>" as root and send us the resulting file after you
tried to connect from your PDA.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
