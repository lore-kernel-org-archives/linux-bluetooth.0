Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <404C2C25.1080200@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: damou@nexgo.de
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Toshiba Portege M200 internal bluetooth adapter
References: <5926256.1078727778744.JavaMail.ngmail@webmail04.arcor-online.net>
In-Reply-To: <5926256.1078727778744.JavaMail.ngmail@webmail04.arcor-online.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 08 Mar 2004 01:17:41 -0700

Hi

It's a relief to know it works for someone at least.

I think part of the trouble is I'm using libc 2.3. It's clear that the
macro "TOSH_SMM" that won't compile invokes another macro (_IOWR) with
the wrong
arguments, at least for 2.3. In the unmodified sources, the third
argument is the number '24' but the third argument is supposed to be a
type that can be applied to sizeof() to *produce* the size (ends up
being 24).

Even so, It doesn't work for me under 2.4.25-mh1 or 2.6.4rc1-mm2. They
both complain "Can't access Toshiba device /dev/toshiba" and strace 
shows that the error happens with the first ioctl.

/dev/toshiba is there, the "toshiba" module is loaded. I installed
toshutils from debian using apt... I'm not sure what else to try.

ACPI is the only way I could get suspend to work. (but only in 2.6.4). 
The APM module won't load under either kernel, but I thought that was 
because the m200 had no APM bios.

What does lsmod show on your knoppix machine?

Brad

> I just checked the Portege M200 with a BT patched Knoppix 3.2(Kernel 2.4.20) and dmabt is working.
> You should compile dmabt without any changes in the sourcecode! 
> Make sure that you have installed Toshiba Tools before you compile dmabt. 
> AFAIK dmabt doesn't work with an ACPI enabled Kernel.
> 
> I did the following to activate BT
> 
>>dmabt
>>hciconfig hci0 up
>>hciconfig -a    //to get some informations on stdout
> 
> 
> Result:
> hci0:	Type: USB 
> 	BD Address: 00:03:7A:09:AD:06 ACL MTU: 192:8  SCO MTU: 64:8
> 	UP RUNNING PSCAN ISCAN 
> 	RX bytes:376 acl:0 sco:0 events:16 errors:0
> 	TX bytes:305 acl:0 sco:0 commands:15 errors:0
> 	Features: 0xff 0xff 0x0f 0x00
> 	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
> 	Link policy: HOLD SNIFF PARK 
> 	Link mode: SLAVE ACCEPT 
> 	Name: 'BlueZ (0)'
> 	Class: 0x000100
> 	Service Classes: Unspecified
> 	Device Class: Computer, Uncategorized
> 	HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
> 	Manufacturer: Cambridge Silicon Radio (10)
> 
> cu
> Martl
> 
> 
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
