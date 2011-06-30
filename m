Return-Path: <cyrus@holtmann.org>
From: "Ilia, Kolominsky" <iliak@ti.com>
To: Peter Hurley <peter@hurleysoftware.com>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Thu, 30 Jun 2011 16:55:52 +0200
Subject: RE: [PATCH] Bluetooth: Fix hidp disconnect deadlock
Message-ID: <AC090B9732AB2B4DB7FF476E907FE66001316415C9@dnce02.ent.ti.com>
References: <1309037555.2143.5.camel@THOR>
	 <AC090B9732AB2B4DB7FF476E907FE66001315315BF@dnce02.ent.ti.com>
	 <20110629202456.GA6490@joana>  <20110629205202.GB6490@joana>
 <1309444475.2276.96.camel@THOR>
In-Reply-To: <1309444475.2276.96.camel@THOR>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> -----Original Message-----
> From: Peter Hurley [mailto:peter@hurleysoftware.com]
> Sent: Thursday, June 30, 2011 5:35 PM
> To: Gustavo F. Padovan
> Cc: Ilia, Kolominsky; linux-bluetooth
> Subject: Re: [PATCH] Bluetooth: Fix hidp disconnect deadlock
> 
> On Wed, 2011-06-29 at 16:52 -0400, Gustavo F. Padovan wrote:
> > * Gustavo F. Padovan <padovan@profusion.mobi> [2011-06-29 17:24:56 -
> 0300]:
> >
> > > * Ilia, Kolominsky <iliak@ti.com> [2011-06-26 09:16:58 +0200]:
> > >
> > > > Hi!
> > > > IMHO the fix isnt good due to possible race condition which
> > > > will destroy session/task objects - either by a call to
> kthread_stop
> > > > from the timer func or reentry to hidp_del_connection() on
> > > > smp platforms.
> ....
> > This should fix the timer issue. Please test.
> >
> > 	Gustavo
> 
> Hi Ilia & Gustavo,
> 
> After Ilia pointed out the problem with the timer function, I went back
> and reviewed *all* the synchronization code relevant to the hid session
> thread.
> 
> A number of problems were introduced with commit aabf6f89 - when the
> session thread was converted from a kernel_thread to a kthread.
> Although
> a kthread is a better choice for representing the session thread, the
> naive conversion of atomic/wakeup to kthread_stop() was inappropriate.
> 
> kthread_stop() has usage semantics that different significantly from
> atomic/wakeup. As we already know, because kthread_stop() blocks on
> thread completion, it can introduce deadlocks in code that already uses
> exclusion mechanisms. Even with Ilia's new patch, consider the
> following
> sequence:
> 
> Thread 0                 Thread 1                 Thread 2
> in hidp_del_connection                            in hidp session
>   claim r/w sem                                     .
>                          timer triggers             .
>                            kthread_stop() --------->.
>                            *blocks on thread 2*     exits loop
>                                                     *blocks for r/w

Guys, as far as I know - it is not possible to use kthread_stop from
The timer func - since it may sleep and we are in soft_irq...
What I did is added kthread_stop_async in the kthread use it in both 
Timer func and hidp_del_connection(). I am still polishing the code
though...
Gustavo, is adding the new api to kthread feasible?
How to upstream such change?

> sem*
>   in hidp_del_timer
>     del_timer_sync()
>       *blocks on thread 1*
> 
> Deadlock occurs because:
> + thread 0 holds reader lock but is waiting for the timer function on
> thread 1 to finish
> + thread 1 has stopped kthread and is waiting for thread completion
> + thread 2 (aka kthread) is waiting to claim writer lock held by thread
> 0
> 
> In addition to the deadlocks and races, kthread_stop() is being called
> by hidp_process_hid_control() which is *in the session thread context*
> -
> kthread_stop() cannot be called on itself!
> 
> I've been testing patch v2 since Monday which continues to use kthread
> but reverts back to the old behavior of atomic/wakeup. It also fixes
> the
> potential for a lost wakeup. Of course, "testing" means running it and
> looking at it carefully - as someone on IRC pointed out, kthread really
> needs to get instrumented with lockdep.
> 
> Regards,
> Peter Hurley
