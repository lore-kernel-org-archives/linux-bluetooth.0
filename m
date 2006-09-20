Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d23110170609200748u4d16a947q9cfa716825ea44b7@mail.gmail.com>
Date: Wed, 20 Sep 2006 11:48:49 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1158313791.5233.9.camel@localhost>
MIME-Version: 1.0
References: <450603BA.3090302@vasmac.com>
	<Pine.LNX.4.63.0609121038180.17868@redbean.intranet.gw-instruments.de>
	<1158050613.14015.1.camel@localhost>
	<Pine.LNX.4.63.0609121206040.17868@redbean.intranet.gw-instruments.de>
	<45081402.8020909@vasmac.com>
	<Pine.LNX.4.63.0609141052130.22339@redbean.intranet.gw-instruments.de>
	<1158313791.5233.9.camel@localhost>
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

On 9/15/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> > > > I think the problem is in bt_sock_wait_state(...). This always returns
> > > > -EAGAIN if timeout is zero (which it is if the socket is set non
> > > > blocking). But may be I'm missing something.
> > >
> > > I've come to a similar conclusion. I'm not sure why it's returning -EAGAIN.
> > > However, looking at the x25 transport (af_x25.c), it takes a different
> > > approach;
> > > if O_NONBLOCK is set they don't call the blocking routine at all. Maybe a
> > > similar approach should be taken here.
> > >
> > returning EAGAIN is fine for a listening socket. I first thought the
> > solution of not calling bt_sock_wait_state() for a non blocking connect
> > would be the easiest solution, too. But then you have to correct it on
> > several places. Just changing bt_sock_wait_state() will solve it for
> > various socket types.
>
> sounds like a good idea. Anyone preparing a patch for it?

Sorry, but I'm failing to see why we can't just do a
s/EAGAIN/EINPROGRESS/ inside bt_sock_wait_state(). Does anyone mind to
explain, please?

Regards,

-- Ulisses

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
