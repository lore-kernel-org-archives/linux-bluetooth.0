Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1151334192.29221.7.camel@addu>
References: <1151066205.6247.19.camel@addu>
	<1151324247.7694.10.camel@localhost>  <1151334192.29221.7.camel@addu>
Date: Mon, 26 Jun 2006 17:47:45 +0200
Message-Id: <1151336865.7694.37.camel@localhost>
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

> > > I could live with the MTU being 64k with no fragmentation, but I seem to
> > > get quite a lot of corrupt packets over around 2kB.
> > 
> > I have no idea what you are talking about. The L2CAP layer is reliable
> > and the underlaying ACL link, too.
> 
> Sorry, correction, I get a lot of lost packets. I assume either because
> they've become corrupted, or perhaps because they never arrive.
> 
> I get between 20-40% packet loss with packet sizes around 3000 bytes,
> and more loss as packet sizes increase. l2ping says 56% loss at 3500
> bytes.
> 
> This loss is what prompted my question. This behaviour, actually, is why
> I'm using L2CAP -- because it was likened to UDP in what I'd read
> previously. Ironically, perhaps, it's just a little *too* lossy  :-)

with l2ping you use the L2CAP signal channel and it happens that some
remote implementation don't handle this very well. Hence you might see a
loss percentage. This actually means unanswered echo requests.

If you actually use L2CAP data channel with SOCK_SEQPACKET then you
won't see a loss at all. It is a reliable channel.

> I'll either bolt on some packet segmentation to my app, or use RFCOMM
> for now.

Or help Martin Roehricht to extend L2CAP with retransmission and flow
control. Once this has been implemented it will be possible to have a
SOCK_STREAM on L2CAP like you have with RFCOMM.

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
