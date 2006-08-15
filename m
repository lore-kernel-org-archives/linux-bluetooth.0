Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44E1F035.3050305@csr.com>
Date: Tue, 15 Aug 2006 17:03:01 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <056BF200E9632F4285220E570FEED673D7AE42@GBMDDMH202AMSX.gb001.siemens.net>	<44D8A430.6080502@palmsource.com>	<5256d0b0608080813r4d47ca8p6e55fcd91a2175df@mail.gmail.com>
	<44D8BE3E.3000308@palmsource.com>
In-Reply-To: <44D8BE3E.3000308@palmsource.com>
Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX)
 plus	xmmserror(trials and tribulations) how cool is this!!! new patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fr=E9d=E9ric DALLEAU wrote:
> certainly, but for now i'm not used to gdb, this will come
> moreover, i will still have to wait 36 minutes before it crashes

Call me paranoid, but 36 minutes is the time after which a 32 bit
microsecond counter will half-wrap.

So, if you were doing 32 bit calculations from a base time in units
of microseconds then after 36 minutes the calculations will wrap
giving negative results. This might make your system think that it has
to do some work now as opposed to at some time in the future. This
could lead to a busy loop (which will then stop after another 36
minutes).

	- Steven
-- =



To access the latest news from CSR copy this link into a web browser:  http=
://www.csr.com/email_sig.php

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
