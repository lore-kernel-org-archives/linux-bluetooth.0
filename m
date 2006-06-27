Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6297d67c0606270126k2217235fwbc7fd3b56b1007dc@mail.gmail.com>
References: <6297d67c0606262242q11b6e769r15a48f1edffaa759@mail.gmail.com>
	<1151393851.25011.7.camel@localhost>
	<6297d67c0606270126k2217235fwbc7fd3b56b1007dc@mail.gmail.com>
Date: Tue, 27 Jun 2006 10:47:48 +0200
Message-Id: <1151398068.25011.10.camel@localhost>
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

> I already have a 2.4.21 kernel running, but I cannot see any of the
> kernel modules for BlueZ, e.g. bluez.o, l2cap.o, rfcomm.o in the
> directory /lib/modules/kernel.
>  
> So does that mean that my kernel was compiled without Bluetooth
> support?
> - If yes, is there any way with which I can enable Bluetooth support?
> (Will I have to recompile the kernel?)
> - Or can I directly apply some patch by which I can get those kernel
> modules?

you will have to re-compile the kernel if no additional kernel modules
package is available.

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
