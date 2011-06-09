Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jun 2011 15:47:47 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: Rename _busy_wq to _l2cap_wq
Message-ID: <20110609184747.GB2533@joana>
References: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
 <1307143270-2655-2-git-send-email-mathewm@codeaurora.org>
 <20110606173153.GA30641@joana>
 <alpine.DEB.2.02.1106081612210.5280@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1106081612210.5280@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Mat Martineau <mathewm@codeaurora.org> [2011-06-08 16:24:05 -0700]:

> 
> On Mon, 6 Jun 2011, Gustavo F. Padovan wrote:
> 
> >* Mat Martineau <mathewm@codeaurora.org> [2011-06-03 16:21:08 -0700]:
> >
> >>This workqueue will be used for general L2CAP work, not just dealing
> >>with "busy" frames.
> >
> >which general L2CAP work are we talking about?
> 
> I'll update the commit message and resubmit, but to immediately
> answer your question:
> 
> * ERTM tx queue callbacks (patch 3/4 in this series)
> * ERTM timers (ack, retrans, monitor) that can utilize proper locking.

What are the problems with ERTM timers? From what I remember it was not using
reference count on them, I fixed this. Patch is on this mailing for review.

> * Updating the ERTM tx queue after an AMP channel move and L2CAP
> reconfiguration
> * Moving various AMP-related work out of interrupt context

Marcel wrote a patch sometime ago the move the whole Bluetooth core work out
of the interrupt context. That will help with many issues we have today,
including these you are talking about. 
We need to take that patch, fix it, and push it no bluetooth-next.
This task is on my TODO list, but my TODO list is getting bigger. ;)

	Gustavo
