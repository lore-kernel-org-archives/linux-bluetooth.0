Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_acl_tx_to: hci0 ACL tx timeout, VIA USB HUBS
From: Marcel Holtmann <marcel@holtmann.org>
To: "thomas.schorpp" <t.schorpp@gmx.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3FFAB0C5.4050407@gmx.de>
References: <3FF9E3F2.4040506@gmx.de> <1073393043.2508.50.camel@pegasus>
	 <3FFAB0C5.4050407@gmx.de>
Content-Type: text/plain
Message-Id: <1073396288.2508.72.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 06 Jan 2004 14:38:08 +0100

Hi Thomas,

> hi marcel, thx for your fast acknowledge, heres some extended 
> information, i could provide a hcidump -tsw in afew hours too:

the hcidump won't help here, because I am pretty sure that this is a
problem on the USB bus.

> root@TOM1:~# hciconfig -a
> hci0:   Type: USB
>          BD Address: 00:10:60:A5:0F:EA ACL MTU: 192:8  SCO MTU: 64:8
>          UP RUNNING PSCAN ISCAN
>          RX bytes:99 acl:0 sco:0 events:13 errors:0
>          TX bytes:296 acl:0 sco:0 commands:12 errors:0
>          Features: 0xff 0xff 0x0f 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: HOLD SNIFF PARK
>          Link mode: ACCEPT MASTER
>          Name: 'TOM1'
>          Class: 0x000100
>          Service Classes: Unspecified
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP 
> Subver: 0x20d
>          Manufacturer: Cambridge Silicon Radio (10)

This is HCI 16.4 firmware and it should work fine. Do you use the SCO
audio support for the HCI USB driver? If yes, disable it, because I
heard of problems with ISOC transfers on VIA chips if I remember
correctly.

> root@TOM1:~# uname -r
> 2.4.23

Use 2.4.23-mh1 or 2.4.24-mh1.

> P.S. what linux devenv and kernel debugging env do you use? i wasted 
> years with visual c++ ;)

I use anjuta and vi as editor and for debugging it is simply printk ;)

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
