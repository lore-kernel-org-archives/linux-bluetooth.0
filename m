Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1158352238.9960.5.camel@localhost>
References: <1158352238.9960.5.camel@localhost>
Date: Fri, 15 Sep 2006 23:12:44 +0200
Message-Id: <1158354764.5233.59.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] L2CAP Flow Control
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

Hi Martin,

> after some months of coding, testing, deadlocks, debugging,
> book-readings, etc. I present my first working version of L2CAP flow
> control for the BlueZ stack. This is an early alpha release and may
> contain errors -- but hey, it is the first really working version here
> so be lenient toward me :-)

nice stuff and I decided to put out patch-2.6.17-mh6 with your patch
included to open it for a wider testing audience. I will boot up my
development system with this patch and see how it goes.

I haven't done any code review, but the obvious thing you missed is the
"select CRC16" in the Kconfig file.

The rumors have it that the Symbian OS 9.1 already supports L2CAP
retransmission and flow control (RFC) and this might be a good testing
system.

Keep up the good work.

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
