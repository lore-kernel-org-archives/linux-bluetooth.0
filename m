Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1151066205.6247.19.camel@addu>
References: <1151066205.6247.19.camel@addu>
Date: Mon, 26 Jun 2006 14:17:27 +0200
Message-Id: <1151324247.7694.10.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] L2CAP MTU and packet fragmentation?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Stephen,

> Forgive me if this has been answered time and again, but I can't seem to
> access the archives just now. Google's not helping me much either.
> 
> I have a bit of BlueZ code, which I have to make use of L2CAP sockets to
> communicate between devices. I've seen that I can alter the MTU for
> packets, but I'm surprised that packets don't get fragmented as per
> plain UDP when a packet larger than the MTU is passed to send().
> 
> Have I missed a configuration option somewhere?

the L2CAP socket is a SOCK_SEQPACKET and you have to honor that MTU. It
is not a stream or a connection-less socket.

> I could live with the MTU being 64k with no fragmentation, but I seem to
> get quite a lot of corrupt packets over around 2kB.

I have no idea what you are talking about. The L2CAP layer is reliable
and the underlaying ACL link, too.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
