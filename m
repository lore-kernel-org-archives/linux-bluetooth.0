Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAND and RFCOMM simultaneously
From: Marcel Holtmann <marcel@holtmann.org>
To: Harald Meier <meh1@rts.at>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <004501c417b0$76df38c0$4000fe0a@rtsviec64>
References: <003201c4161f$d37a2050$4000fe0a@rtsviec64>
	 <1080630888.4094.5.camel@pegasus>
	 <004501c417b0$76df38c0$4000fe0a@rtsviec64>
Content-Type: text/plain
Message-Id: <1080803375.2565.7.camel@pegasus>
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
Date: Thu, 01 Apr 2004 09:09:36 +0200

Hi Harald,

> the output of hciconfig -a is:
>     hci0: Type: PCIBD Address: 00:02:78:02:2E:C3 ACL MTU: 192:8 SCO MTU:
> 64:8
>     UP RUNNING PSCAN ISCAN
>     RX bytes:70 acl:0 sco:0 events:7 errors:0
>     TX bytes:34 acl:0 sco:0 commands:7 errors:0
>     Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>     Link policy:
>     Link mode: SLAVE ACCEPT
>     Name: 'ka0009 (0)'
>     Class: 0x000000
>     Service Classes: Unspecified
>     Device Class: Miscellaneous,
>     HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver:
>     0x175
>     Manufacturer: Cambridge Silicon Radio (10)
> 
> Sorry for the last unformatted output, I pressed accidentally the send
> button.

I thought I already answered this, but it seems that I didn't :(

To run an inquiry while you already have an ACL link open, you need at
least the HCI 16.4 firmware on your Bluetooth chip.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
