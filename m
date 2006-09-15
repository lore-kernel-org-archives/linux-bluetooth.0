Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0609141052130.22339@redbean.intranet.gw-instruments.de>
References: <450603BA.3090302@vasmac.com>
	<Pine.LNX.4.63.0609121038180.17868@redbean.intranet.gw-instruments.de>
	<1158050613.14015.1.camel@localhost>
	<Pine.LNX.4.63.0609121206040.17868@redbean.intranet.gw-instruments.de>
	<45081402.8020909@vasmac.com>
	<Pine.LNX.4.63.0609141052130.22339@redbean.intranet.gw-instruments.de>
Date: Fri, 15 Sep 2006 11:49:51 +0200
Message-Id: <1158313791.5233.9.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] socket connect returns EAGAIN
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

Hi Peter,

> > > I think the problem is in bt_sock_wait_state(...). This always returns 
> > > -EAGAIN if timeout is zero (which it is if the socket is set non 
> > > blocking). But may be I'm missing something. 
> > 
> > I've come to a similar conclusion. I'm not sure why it's returning -EAGAIN.
> > However, looking at the x25 transport (af_x25.c), it takes a different 
> > approach;
> > if O_NONBLOCK is set they don't call the blocking routine at all. Maybe a
> > similar approach should be taken here.
> > 
> returning EAGAIN is fine for a listening socket. I first thought the 
> solution of not calling bt_sock_wait_state() for a non blocking connect 
> would be the easiest solution, too. But then you have to correct it on 
> several places. Just changing bt_sock_wait_state() will solve it for 
> various socket types. 

sounds like a good idea. Anyone preparing a patch for it?

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
