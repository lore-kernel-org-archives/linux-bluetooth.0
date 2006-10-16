Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3f5a9ba20610152225h7e020518m3c6062ce9be25044@mail.gmail.com>
References: <3f5a9ba20610152225h7e020518m3c6062ce9be25044@mail.gmail.com>
Date: Mon, 16 Oct 2006 14:15:50 +0200
Message-Id: <1161000951.10392.26.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] the effect of linux 2.6.18 to the bluez
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

Am Montag, den 16.10.2006, 13:25 +0800 schrieb Mingfan.Lu:
> the following is my test result in a real machine:
> [...]

Okay, due to your tenacious demand, I compiled and installed a plain
2.6.18.1 vanilla kernel as well as a 2.6.18.1 kernel with the latest
-mh5 patch applied.
I will show you my test results for two files, the first being 1376034
bytes (1,31MB) in size and the second being 2397995 bytes (2,29MB) in
size.
Let me at first mention the results that I got. I didn't encounter any
slowness by using a 2.6.18.1 vanilla kernel. However it looks like the
newly introduced and applied flow control may slow down the transfer
speed. But be aware that (L2CAP) flow control mode is in action only by
using two Linux kernels that have one of the latest -mh* patches
applied! This mode is not(!) used by transmission between a Linux
computer and another one that uses a proprietary Bluetooth software
stack (even if the new Symbian OS may be able to use flow control mode,
too), or say two Linux computers of which one has a kernel without this
new patch applied.
You didn't specify your exact settings -> did you apply one of the
latest -mh* patches to you 2.6.18 kernel or not? Which computers did you
use (one is the Linux computer but who is the other one)?

So here are my results. The first three tests were done between a Linux
computer and an Apple iMac G4 with the Apple Bluetooth stack that comes
with Mac OS X 10.4:

Test with kernel 2.6.18.1 and Apple Bluetooth Stack:
Retrieval:
1376034 bytes -> 58 sec -> 23KB/s
2397995 bytes -> 95 sec -> 25KB/s

Transmission:
1376034 bytes -> 42 sec -> 32KB/s
2397995 bytes -> 73 sec -> 32KB/s


Test with kernel 2.6.15 (Ubuntu Dapper Drake) and Apple Bluetooth Stack:
Retrieval:
1376034 bytes -> 57 sec -> 24KB/s
2397995 bytes -> 99 sec -> 24KB/s

Transmission:
1376034 bytes -> 46 sec -> 29KB/s
2397995 bytes -> 77 sec -> 30KB/s


Test with kernel 2.6.18.1-mh5 and Apple Bluetooth Stack:
Retrieval:
1376034 bytes -> 54 sec -> 25KB/s
2397995 bytes -> 94 sec -> 25KB/s

Transmission:
1376034 bytes -> 43 sec -> 31KB/s
2397995 bytes -> 73 sec -> 32KB/s


------------(now between two Linux computers)---------
Test with kernel 2.6.18.1-mh5 to kernel 2.6.18.1-mh5
Retrieval:
1376034 bytes -> 88 sec -> 15KB/s
2397995 bytes -> 154 sec -> 15KB/s

Transmission:
1376034 bytes -> 82 sec -> 16KB/s
2397995 bytes -> 140 sec -> 17KB/s


Test with kernel 2.6.18.1-mh5 to kernel 2.6.15 (Ubuntu Dapper Drake)
Retrieval:
1376034 bytes -> 57 sec -> 24KB/s
2397995 bytes -> 99 sec -> 24KB/s

Transmission:
1376034 bytes -> 68 sec -> 20KB/s
2397995 bytes -> 114 sec -> 21KB/s


As you can see -- the transmission speed is quite constant between the
same setups. Two things would need more investigations:
(1) Why is it that a file transfer from Linux to Apple is faster than 
    between two Linux entities?
(2) Is it really L2CAP Flow Control Mode that slows down the connection 
    with its protocol overhead?

If Flow Control Mode really slows down the connection, we should try to
implement a user interface to enable or disable this mode. But currently
this is not urgent as no other device makes use of it.

Martin


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
