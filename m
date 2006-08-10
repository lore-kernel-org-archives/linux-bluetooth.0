Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulissesf@gmail.com>
In-Reply-To: <d23110170608091452k5b03cf2aoda2e6ee3801168e3@mail.gmail.com>
References: <44D88EC1.7010009@pracucci.com> <44D8815D.4000108@infitsrl.com>
	<d23110170608090806j2b39e87eqd84ba9843d216153@mail.gmail.com>
	<1155160601.4492.10.camel@aeonflux.holtmann.net>
	<d23110170608091452k5b03cf2aoda2e6ee3801168e3@mail.gmail.com>
Date: Thu, 10 Aug 2006 02:49:43 +0200
Message-Id: <1155170983.4492.25.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] "File descriptor in bad state" on sdp_connect()
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

Hi Ulisses,

> > > I've done some modifications (and also included some bits from -mh)
> > > and it seems to be working. However, I'm hitting a kernel bug at
> > > kernel/timer.c inside cascade() from time to time. I haven't found
> > > what is causing this yet, but the patch I'm sending is against 2.6.17
> > > and I haven't tested with latest git snapshot so maybe this issue is
> > > already fixed upstream (kernel/timer.c:cascade() was changed [1]).
> >
> > please redo the patch against 2.6.18-rc4 and I will do some additional
> > testing.
> 
> Done. Here is the same patch against 2.6.18-rc4.

I tested this patch on my Quad G5. I don't see any timer issues, but it
also doesn't work either.

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
