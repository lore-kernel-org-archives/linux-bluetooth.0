Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Pierre-Yves Paulus <py@idlum.be>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1156772367.5613.33.camel@aeonflux.holtmann.net>
References: <1156757049.8576.62.camel@localhost>
	<1156772367.5613.33.camel@aeonflux.holtmann.net>
Date: Mon, 28 Aug 2006 15:01:04 +0200
Message-Id: <1156770065.8576.71.camel@localhost>
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


> > I can get the rfcomm connected nicely from the DBus, I only miss how to
> > have it done in "raw".
> 
> this is the job the application using that TTY. It is the same as you
> need to /dev/ttyS0 etc.

Thank you for your answer Marcel. After some investigation, it seems
that switching a virtual TTY into raw mode is not possible in pure JAVA
(a native call (eg JNI) to C code has to be used).

As the DBus interface is meant to be used from various languages which
may or may not have the ability to configure TTYs, wouldn't it make
sense to offer the possibility to get the TTY in one mode or the other
at the time of the DBus "connect" call? Or am  missing other important
points? To make it short, I do not understand why it is a good idea to
offer this option from the "rfcomm" utility, and not from the DBus
interface.

Any light would be appreciated!

Regards

Pierre-Yves


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
