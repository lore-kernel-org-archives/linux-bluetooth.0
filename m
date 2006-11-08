Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Chafik Moalem <c.moalem@perdictum.com>
Date: Wed, 8 Nov 2006 17:44:56 +0000 (UTC)
Message-ID: <loom.20061108T184308-176@post.gmane.org>
References: <1111743.1162822095031.JavaMail.root@mail.prologistik.com>
Mime-Version: 1.0
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

Chafik Moalem <Chafik.Moalem <at> perdictum.com> writes:

Dear All,

finally after digging around i found the solution to "alsa-plugin (sco) not
working with 2.6.18-mh>4 kernels ... ("Operation still in progress" ... 
opening L2CAP/RFCOMM sockets)

after modifying freshly checkedout btsco sources NOW SCO-ALSASOUND
(plugin-method) WORKS (testet with 2.6.18-mh7-sco AND 2.6.18-mh4-fch ... 
but still not chop free :( ) 

hint : fabien chevalier forgot to take care of EINPROGRESS 
(in addition to EAGAIN) in his headsetd sources ... 
still to check : his pcm_sco.c ... 
and why the timeout parameter has NO effect ...

forget about my previous posting (as no one seems to be interested anyway) 

regards,
Chafik



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
