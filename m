Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6297d67c0606272204g1a70d1ew2763d51002f44383@mail.gmail.com>
References: <6297d67c0606272204g1a70d1ew2763d51002f44383@mail.gmail.com>
Date: Wed, 28 Jun 2006 09:30:31 +0200
Message-Id: <1151479831.9544.5.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] BlueZ not on Linux
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

> I was wondering if the BlueZ stack can be ported onto some other OS
> apart from Linux?
> Has anyone done that so far?
> How much of effort will that involve?

not again. BlueZ is highly integrated into the Linux kernel and it is
very unlikely to get it ported to any other OS without a massive shim
layer. So in all cases it should be easier to start from scratch for
these operating systems. And the GPL might not even allow it to port it
to another non-GPL OS.

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
