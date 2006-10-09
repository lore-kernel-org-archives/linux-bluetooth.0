Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3f5a9ba20610081957id1408a8m6f1648b8fae14e79@mail.gmail.com>
References: <3f5a9ba20609291930r5b4e4c97g8b33901666fef491@mail.gmail.com>
	<3f5a9ba20610020946v10c99300pee5cc04f3f2597e6@mail.gmail.com>
	<1159972670.1601.25.camel@localhost>
	<3f5a9ba20610072313w41cb4aa1qf0b5a21a7199f737@mail.gmail.com>
	<1160314144.4258.8.camel@aeonflux.holtmann.net>
	<3f5a9ba20610081957id1408a8m6f1648b8fae14e79@mail.gmail.com>
Date: Mon, 09 Oct 2006 11:47:43 +0200
Message-Id: <1160387263.4489.1.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] About the kernel 2.6.18
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

> I am just use the Bluetooth OBEX Object Push client (0.99 beta1).
> ====================================
> Host:
>  Vmware 5.5 
>  OS: Suse 10.1 
>  bluetooth dongle: 1.2 
>  File pushed: testpkg whose size is 137956B
>  
> Target: 
>   Nokia E61 
>  
>   kernel version: 2.6.16.13-4 (built from Suse 10.1) about 11-12s 
>   kernel version: 2.6.16.13-4 (rebuilt from above) about 11-12s 
>   kernel version: 2.6.17 (built from kernel.org)  about 11-12s
>   kernel version: 2.6.18: about  145s
>   kernel version: 2.6.18 with mh4 (built with the patch from bluez):
> 143s  146s

since you are using VMware. Which is running the 2.6.18 kernel. The host
or the guest operating system. This could be bottleneck in the USB part
and not Bluetooth.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
