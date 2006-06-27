Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6297d67c0606262242q11b6e769r15a48f1edffaa759@mail.gmail.com>
References: <6297d67c0606262242q11b6e769r15a48f1edffaa759@mail.gmail.com>
Date: Tue, 27 Jun 2006 09:37:31 +0200
Message-Id: <1151393851.25011.7.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Kernel Modules for ARM
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

Hi Mayank,

> I am successfully able to cross-compile bluez-libs-2.25 and
> bluez-utils-2.25 for ARM.
>  
> But I feel that the kernel modules (like bluez.o, l2cap.o, rfcomm.o
> etc) have not been built for ARM. (Or if they have been built
> somewhere, but I can't find them)
>  
> So, if I say insmod bluez on my target, it says:
>  
> # insmod bluez
> Using /lib/modules/kernel/bluez.o
> insmod: ELF file not for this architecture
> insmod: Could not load the module: Bad address
>  
> I have the feeling that the bluez.o is not an ELF file and it was not
> generated during the cross compile.

the kernel modules for BlueZ are part of the Linux kernel. Pick a recent
kernel and you get all of them. And you should really go ahead with a
2.6 kernel. It is worth any initial trouble.

Regards

Marcel




Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
