Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Aug 2011 16:14:16 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org, peter@hurleysoftware.com
Subject: Re: [PATCH 0/3] RFC: prioritizing data over HCI
Message-ID: <20110805191416.GB2537@joana>
References: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
 <alpine.DEB.2.02.1108040901420.13578@mathewm-linux>
 <CABBYNZ+OPDnR=e2sPx=mLmOkd80z2sPNAPX+ss7GCh+7rndH1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CABBYNZ+OPDnR=e2sPx=mLmOkd80z2sPNAPX+ss7GCh+7rndH1g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-08-05 09:09:38 +0300]:

> Hi Mat,
> 
> On Thu, Aug 4, 2011 at 8:37 PM, Mat Martineau <mathewm@codeaurora.org> wrote:
> > One concern I have is that an application that changes sk_priority while it
> > has data in the HCI tx queue could have its frames delivered out of order.
> >  While we can't control when sk_priority is set, it is possible to make a
> > choice when setting the priority of each skb.  Does it make sense to detect
> > an sk_priority change and only apply the new value when there are no skbs
> > for the channel in the HCI tx queue?
> 
> Yep, if we need to maintain the order I guess this would make sense,
> the problem is that this could be a bit expensive.
> 
> > I had a recent discussion with Gustavo about HCI queuing issues with ERTM:
> >
> > http://www.spinics.net/lists/linux-bluetooth/msg13774.html
> >
> > My proposal is to move tx queuing up to L2CAP, and have the HCI tx task only
> > handle scheduling.  Senders would tell HCI they have data to send, and HCI
> > would call back to pull data.  I've been focused on L2CAP - it would be
> > possible to make a similar queuing change to SCO/eSCO/LE, but not strictly
> > necessary.
> 
> > This is different from the problem you're solving, but as long as we're
> > talking about big changes to HCI tx, I think we could make some changes that
> > help out with prioritization and queuing across all channels (whether
> > they're going to the same remote device or different remote devices).
> >
> > It could be more efficient to schedule this way since HCI wouldn't have to
> > iterate over all of the connections and queues - it would only have to
> > review the prioritized list of pending sends. Might be a more fitting
> > structure for QoS too.
> >
> > Since HCI wouldn't have a bunch of queued-up skbs, it would also eliminate
> > the sk_priority change problem I noted above.
> >
> > Your thoughts?
> 
> If the idea is to have a list of chan/sockets and each having its own
> queue, I guess that would make sense and we could possible preserve
> the packet order in that case, but we still have to maintain the
> fairness when dealing with the same priority so I would still have to
> iterate to each connection and then to each channel evaluating their
> priority. This way we don't have to defined any arbitrary number of
> queues which is probably less items to visit on tx task, but the
> locking may be a lot more complicated.

Only ERTM needs to have its own queue, Basic and Streaming mode doesn't need
to change, they can use the same queue they are using now.

	Gustavo
