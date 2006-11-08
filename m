Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455235ED.4060403@xmission.com>
Date: Wed, 08 Nov 2006 12:54:21 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1111743.1162822095031.JavaMail.root@mail.prologistik.com>
	<loom.20061108T184308-176@post.gmane.org>
In-Reply-To: <loom.20061108T184308-176@post.gmane.org>
Subject: Re: [Bluez-devel] btsco/alsa-plugins Kernel 2.6.18-mh7 (and mh4-fch)
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

Chafik

> finally after digging around i found the solution to "alsa-plugin (sco) not
> working with 2.6.18-mh>4 kernels ... ("Operation still in progress" ... 
> opening L2CAP/RFCOMM sockets)
> 
> after modifying freshly checkedout btsco sources NOW SCO-ALSASOUND
> (plugin-method) WORKS (testet with 2.6.18-mh7-sco AND 2.6.18-mh4-fch ... 
> but still not chop free :( ) 

Can you show us what you had to change? What hardware are you using? Are 
you using other devices that might create a scatternet?

> hint : fabien chevalier forgot to take care of EINPROGRESS 
> (in addition to EAGAIN) in his headsetd sources ... 
> still to check : his pcm_sco.c ... 
> and why the timeout parameter has NO effect ...

which timeout are you looking at? for the initial connection?

> forget about my previous posting (as no one seems to be interested anyway) 

There's a lot to do in addition to helping people use what's there... 
finish off the old btsco, redesign and docs, combining the a2dpd and 
headsetd daemons, wiring up dbus. I definitely appreciate what you have 
done to hunt things down.

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
