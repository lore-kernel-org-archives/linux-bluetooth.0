Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1156770065.8576.71.camel@localhost>
References: <1156757049.8576.62.camel@localhost>
	<1156772367.5613.33.camel@aeonflux.holtmann.net>
	<1156770065.8576.71.camel@localhost>
Date: Mon, 28 Aug 2006 21:15:34 +0200
Message-Id: <1156792534.5613.42.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] rfcomm in TTY raw mode from DBus
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

Hi Pierre-Yves,

> > > I can get the rfcomm connected nicely from the DBus, I only miss how to
> > > have it done in "raw".
> > 
> > this is the job the application using that TTY. It is the same as you
> > need to /dev/ttyS0 etc.
> 
> Thank you for your answer Marcel. After some investigation, it seems
> that switching a virtual TTY into raw mode is not possible in pure JAVA
> (a native call (eg JNI) to C code has to be used).
> 
> As the DBus interface is meant to be used from various languages which
> may or may not have the ability to configure TTYs, wouldn't it make
> sense to offer the possibility to get the TTY in one mode or the other
> at the time of the DBus "connect" call? Or am  missing other important
> points? To make it short, I do not understand why it is a good idea to
> offer this option from the "rfcomm" utility, and not from the DBus
> interface.

the rfcomm utility has this capability, because I needed it for some
early kernel RFCOMM demonstrations. I wrote that tool back in 2002 and
in general the application should set the TTY in the needed mode. Only
cat is too stupid for this.

If Java or any other language is too stupid to handle a TTY correctly
then it also will have problems with serial ports and other TTY based
services. This is a problem of the language you choose. So in this case
you have to fix the language and not make our D-Bus API workaround these
problems.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
