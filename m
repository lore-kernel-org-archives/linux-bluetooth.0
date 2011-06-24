Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Jun 2011 19:31:09 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: Rename _busy_wq to _l2cap_wq
Message-ID: <20110624223109.GB22619@joana>
References: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
 <1307143270-2655-2-git-send-email-mathewm@codeaurora.org>
 <20110606173153.GA30641@joana>
 <alpine.DEB.2.02.1106081612210.5280@mathewm-linux>
 <20110609184747.GB2533@joana>
 <alpine.DEB.2.02.1106091548010.18748@mathewm-linux>
 <20110615000406.GF2613@joana>
 <alpine.DEB.2.02.1106161438390.17210@mathewm-linux>
 <20110620192346.GB7240@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110620192346.GB7240@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo F. Padovan <padovan@profusion.mobi> [2011-06-20 16:23:46 -0300]:

> Hi Mat,
> 
> * Mat Martineau <mathewm@codeaurora.org> [2011-06-16 14:48:03 -0700]:
> 
> > 
> > On Tue, 14 Jun 2011, Gustavo F. Padovan wrote:
> > 
> > >* Mat Martineau <mathewm@codeaurora.org> [2011-06-09 16:09:52 -0700]:
> > >
> > >>
> > >>On Thu, 9 Jun 2011, Gustavo F. Padovan wrote:
> > >>
> > >>>* Mat Martineau <mathewm@codeaurora.org> [2011-06-08 16:24:05 -0700]:
> > >>>
> > >>>>
> > >>>>On Mon, 6 Jun 2011, Gustavo F. Padovan wrote:
> > >>>>
> > >>>>>* Mat Martineau <mathewm@codeaurora.org> [2011-06-03 16:21:08 -0700]:
> > >>>>>
> > >>>>>>This workqueue will be used for general L2CAP work, not just dealing
> > >>>>>>with "busy" frames.
> > >>>>>
> > >>>>>which general L2CAP work are we talking about?
> > >>>>
> > >>>>I'll update the commit message and resubmit, but to immediately
> > >>>>answer your question:
> > >>>>
> > >>>>* ERTM tx queue callbacks (patch 3/4 in this series)
> > >>>>* ERTM timers (ack, retrans, monitor) that can utilize proper locking.
> > >>>
> > >>>What are the problems with ERTM timers? From what I remember it was not using
> > >>>reference count on them, I fixed this. Patch is on this mailing for review.
> > >>
> > >>The ERTM timer handlers modify l2cap_chan data, but use
> > >>bh_lock_sock() and bh_unlock_sock() instead of lock_sock() and
> > >>release_sock().  The socket might be locked in userspace context,
> > >>but these timers can fire and start executing code concurrently.
> > >>
> > >>See http://article.gmane.org/gmane.linux.bluez.kernel/6808 for the
> > >>full description.
> > >>
> > >>With the refactoring of L2CAP to separate out the socket code, we
> > >>will still need a per-channel lock to protect l2cap_chan data.
> > >
> > >I understand. I'm just having a similar problem with the workqueue patch.
> > >
> > >>
> > >>>>* Updating the ERTM tx queue after an AMP channel move and L2CAP
> > >>>>reconfiguration
> > >>>>* Moving various AMP-related work out of interrupt context
> > >>>
> > >>>Marcel wrote a patch sometime ago the move the whole Bluetooth core work out
> > >>>of the interrupt context. That will help with many issues we have today,
> > >>>including these you are talking about.
> > >>>We need to take that patch, fix it, and push it no bluetooth-next.
> > >>>This task is on my TODO list, but my TODO list is getting bigger. ;)
> > >>
> > >>This would be a big help, do you have a pointer to this patch?
> > >
> > >http://permalink.gmane.org/gmane.linux.bluez.kernel/6966
> > >
> > >It only moves the cmd rx task to workqueue, but it has problems, see the
> > >comments. I took this patches today and changed it to handle all rx events and
> > >data in an workqueue. But it still has a issue with timers, because those run
> > >in interrupt context. I just had no time to think on this, but will tomorrow.
> > >
> > 
> > Could the timers be changed to use the "delayed_work" workqueue
> > APIs? Then all of those timeouts would be handled on workqueues and
> > locking would be much more manageable.
> 
> Yes, that is the solution I found. If everything runs in process context is
> better.

Btw, my latest patches on this are here

http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-testing.git;a=summary

But they are ready for merge yet.

	Gustavo
