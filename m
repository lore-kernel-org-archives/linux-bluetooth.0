Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] timeout after rfcomm or pan connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Torens <c.torens@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opr4mgbutyeocfdv@debian>
References: <20040309161702.24407.qmail@web40713.mail.yahoo.com>
	 <opr4mgbutyeocfdv@debian>
Content-Type: text/plain
Message-Id: <1078882388.30990.24.camel@pegasus>
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
Date: Wed, 10 Mar 2004 02:33:08 +0100

Hi Christoph,

> I will upgrade debian to 2.4.25 tomorrow, this can be done with apt-get :-)
> the viper kernel needs special patches I think... i'm not sure if / how  
> this can be done
> I don't think they exist for the newest kernel vversion :-(

build your own Debian kernel package.

	http://www.holtmann.org/linux/kernel/debian.html

> root@viper root# hciconfig -a
> hci0:   Type: USB
>          BD Address: 00:04:3E:C0:8B:30 ACL MTU: 1356:5  SCO MTU: 48:1
>          UP RUNNING PSCAN ISCAN
>          RX bytes:93 acl:0 sco:0 events:12 errors:0
>          TX bytes:296 acl:0 sco:0 commands:12 errors:0
>          Features: 0xff 0x07 0x04 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
>          Link policy: HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
>          Name: 'BlueZ (0) on viper'
>          Class: 0x000100
>          Service Classes: Unspecified
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x86 LMP Ver: 1.1 (0x1) LMP Subver:  
> 0x86
>          Manufacturer: Telencomm Inc. (18)
> 
> This output says nothing about Zeevo, but my win driver definitely says  
> Zeevo.

Yes, it does, because Telencomm is Zeevo. This is the TC2001 as I
expected and maybe this chip is not really a good choice for your
"viper" system. If your problems is still there after you have upgraded
your kernel, try to get a CSR based dongle and see how it goes.

> ehm, i thought writing a programm using bnep would be the same as with a  
> normal network... and the others? where can i get some reading stuff/  
> tutorials on programming each of the three choices?

BlueZ L2CAP and RFCOMM socket programming is mostly the same as if you
are using a UDP or TCP socket.

	http://www.holtmann.org/papers/bluetooth/

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
