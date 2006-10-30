Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <000a01c6fc24$9aec56c0$0100a8c0@kayleigh>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <002701c6fa09$92116120$0100a8c0@kayleigh><Pine.LNX.4.63.0610291515210.2243@redbean.intranet.gw-instruments.de><1162152027.4720.2.camel@localhost><Pine.LNX.4.63.0610301338380.5526@redbean.intranet.gw-instruments.de>
	<1162213066.24333.53.camel@localhost>
Date: Mon, 30 Oct 2006 14:09:17 +0100
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Concurrency / Multi processing questions
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi Marcel,

> that is how sockets work. You call listen() to create the actual
> listener and then accept() for every connection. You can't have two
> different listener that wanna listen on the same RFCOMM channel, but
> that is also true for TCP/IP.
>
> However you can bind one listener to BDADDR_ANY and the other one to the
> actual address of the local dongle, but in that case the listener bound
> to the local address always wins.

That's quite similar to TCP server sockets indeed, my concern is about 
channels
reusing in a RFCOMM Service (which is always providing a service on channel 
14
for example). Just wondering if there is something similar to SO_REUSEADDR,
implicitly, or explicitly, so that a Service can concurrently have several 
clients on the
same bluetooth adaptor with read/write operations. And of course, there is 
only
one listen() per adaptator, the fork() is done only for the IO processing 
part.

Does someone know ?

Oli 



-- 
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.408 / Virus Database: 268.13.17/505 - Release Date: 27/10/2006


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
