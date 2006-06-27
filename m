Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6297d67c0606262140ie16e662w155c5d014caacfec@mail.gmail.com>
References: <6297d67c0606260404kc22d718u4561df45147624e@mail.gmail.com>
	<449FC543.2090507@andric.com>
	<6297d67c0606260453ud6da167ic88d8ddee45ca072@mail.gmail.com>
	<1151323323.7694.7.camel@localhost>
	<6297d67c0606262140ie16e662w155c5d014caacfec@mail.gmail.com>
Date: Tue, 27 Jun 2006 09:35:52 +0200
Message-Id: <1151393752.25011.4.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluez-utils do not cross compile
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

> It works!!
> But one question: why don't I get this error when I am not cross
> compiling? 
> Is it specific to arm-linux-gcc?

this happens all the time. A different architecture has different
default includes and on i386/x86_64 something works even if you forget
the correct header.
 
> Also, the same error was coming in tools/hciconfig.c and hidd/sdp.c as
> well.

I fixed all the other places, too.

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
