Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles Bueche <charles@bueche.ch>
Cc: Olivier Bornet <Olivier.Bornet@smartdata.ch>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1071341513.4307.36.camel@bluez.bueche.ch>
References: <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag>
	 <1070380907.19169.55.camel@saag> <1070482683.18058.6.camel@bluez.bueche.ch>
	 <1070483755.24159.114.camel@pegasus> <20031204085314.GA1780@smartdata.ch>
	 <1071001915.13464.33.camel@bluez.bueche.ch>
	 <20031209224217.GE26896@smartdata.ch>
	 <1071043970.8979.5.camel@bluez.bueche.ch>
	 <20031210083002.GG26896@smartdata.ch>
	 <1071330995.4307.27.camel@bluez.bueche.ch>
	 <1071333541.27252.177.camel@pegasus>
	 <1071341513.4307.36.camel@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1071342247.1548.6.camel@pegasus>
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
Date: Sat, 13 Dec 2003 20:04:07 +0100

Hi Charles,

> it's a CSR, it's included in my Dell Inspiron 8600. The I8600 is recent,
> but of course it tells nothing about the included bluetooth module. Here
> are the details :
> ---
> # hciconfig -a
> hci0:   Type: USB 
>         BD Address: 00:10:C6:22:54:AF ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:88278 acl:5562 sco:0 events:305 errors:0
>         TX bytes:3779 acl:170 sco:0 commands:54 errors:0
>         Features: 0xff 0xff 0x0f 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: 
>         Link mode: SLAVE ACCEPT 
>         Name: 'laptopcb (0)'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous, 
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x235 LMP Ver: 1.1 (0x1) LMP Subver:
> 0x235
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> ---
> I don't know how to find the firmware version. I have a dual boot with
> XP, so I could look there if there is now way in Linux.

this is a HCI 16.5 with 128 bit encryption and it should work fine. The
problematic part is maybe that you have no link policy set. The minimum
options should be rswitch and sniff. Please use

	http://www.holtmann.org/linux/bluetooth/btdfu-0.2.tar.gz

to extract your firmware and send it to me.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
