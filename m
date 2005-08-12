Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Porting BlueZ on embedded uClinux
In-Reply-To: <E64BAD5A8AD46740828069A678D9DD73011A88@netbe01.net.unimis>
Message-ID: <Pine.LNX.4.33.0508121131460.3858-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 12 Aug 2005 11:38:29 +0200 (CEST)


Hi AL,

On Fri, 12 Aug 2005, Al wrote:

> Hi,
>
>       Thanks for reply.
>
>      1. kernel version is 2.4.20.
Ok, I haven't tried BlueZ embedded with a 2.4 Kernel, only with 2.6. But I
know from some other project that it works well when compiled in and not
as a module with 2.4.x

>      2. I don't really change Makefile. Just make sure all
>          BlueZ are enabled and force them to be compiled
>         with kernel. Somehow the original package
>          can't find bluetooth support using make menuconfig.
Strange ! What "package" are you using ??

>      3. Basic networking support is enabled for sure.
>
>      4. I compiled bluetooth USB driver. My email program seems
>          to misplace the message.
>
>     5. I just think making BlueZ to be part of kernel instead of modules
>         should be easier for my embedded platform. (So I don't need
>        commands like modprobe in romdisk, it saves space)
>         Can I do this (part of kernel instead of modules)
>         without changing the source codes?
It will save you some space on your ramdisk. But if you use busybox for
your standard commands not that much. It depends on your system if it
makes sense that all drivers are always loaded to RAM. In general, all
drivers shall work without sourcecode changes when compiled in.

Is the USB dongle detected by the USB subsystem ???

>
> Al
>
>
>
> 	Hi AL,
>
> 	first question : what kernel version you are using ??
>
> 	Second: why you change the Makefile ??? Simply do a make menuconfig or
> 	what ever you prefer and configure that Bluetooth is compiled build in and
> 	not as a module.
>
> 	Make sure you have basic networking support enabled for your kernel.
>
> 	I can't see that you compiled in the bluetooth USB driver. So this is
> 	required when you use a USB adapter. But you don't need the *_cs drivers.
>
> 	Why do you think an embedded system can't support modules ????
>
> 	Ciao,
>
> 	Peter
>
>
>
>
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
