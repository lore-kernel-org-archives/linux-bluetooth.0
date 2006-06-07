Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <448733E2.7090602@free.fr>
References: <447B4F98.8020501@free.fr>
	<1148934839.31689.116.camel@localhost> <447C4862.5050205@free.fr>
	<1149189300.28511.61.camel@localhost>  <448733E2.7090602@free.fr>
Date: Wed, 07 Jun 2006 22:30:46 +0200
Message-Id: <1149712246.22472.56.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] SCO flow control
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

Hi Fabien,

> Sorry to be a little late on this answer, however a busy work schedule 
> and a sunny Sunday prevented me to answer my e-mails for a few days :-)

no big deal. I should do this more often by myself ;)

> > Can we change the core and add a hci_stream_sco() without breaking the
> > API. This would make it easier for me to apply the changes.
> 
> I see your point, however i don't see how to bring this feature in 
> without breaking the hci core API for SCO sockets... :-(

No problem. We can break the API, but at least I need some good reason
for it.

> > Another question is if we really should queue the data in sk_write_queue
> > and not directly in the core. I would prefer to send the data to the
> > core and then stream it from there.
> 
> That's an interesting question... :-)
> I asked it myself when i started to design this feature.
> In fact having outgoing packets stored in a socket queue has some 
> advantages:
>    * it makes use of the BSD socket send queue, and thus can reuse some 
> generic socket queue management related functions, which rely on some 
> well known sk_buff variable (sk_sndbuff, sk_wmem_alloc, sk_rcvbuff, 
> sk_rmem_alloc ...)
>    * it makes the thing symetrical, both uplink and downlink path make 
> use socket queues to buffer data.
> 
> As such I thought there were not any valid reason to put in the core... 
> however if you have suggestions i would be very happy to hear them. :-)

Actually I never thought about SCO as socket is the best interface. So
we might wanna move away from it sometime in the future. And in this
case it would be great if it uses simple SKB queues or maybe kfifo for
it. Even if this sounds like more work right now, I might be worth it.

> For now i would suggest we do the following:
>    - for you: have a look at the "whole picture", including the SCO part 
> patch. This way you would be able to better understand the interaction 
> between SCO sockets & hci layer. This way you will be able to send in 
> other comments too. :-)
>    - for me: * port the patch on top of the 2.6.16-mh1 :-)
>              * have it to work also when HZ % 333 != 0 ( i've just seen 
> it wouldn't work properly in this case... )

Let's have another patch on top of 2.6.16-mh1 and maybe you also wanna
adapt scotest for testing it.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
