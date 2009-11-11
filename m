Return-Path: <cyrus@holtmann.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GPF in run_workqueue()/list_del_init(cwq->worklist.next) on resume (was: Re: Help needed: Resume problems in 2.6.32-rc, perhaps related to preempt_count leakage in keventd)
Date: Wed, 11 Nov 2009 22:18:50 +0100
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mike Galbraith <efault@gmx.de>,
 Ingo Molnar <mingo@elte.hu>,
 LKML <linux-kernel@vger.kernel.org>,
 pm list <linux-pm@lists.linux-foundation.org>,
 Greg KH <gregkh@suse.de>,
 Jesse Barnes <jbarnes@virtuousgeek.org>,
 Tejun Heo <tj@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Oliver Neukum <oliver@neukum.org>,
 linux-bluetooth@vger.kernel.org
References: <200911091250.31626.rjw@sisk.pl> <1257970719.21467.4.camel@violet> <alpine.LFD.2.01.0911111222400.31845@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.01.0911111222400.31845@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911112218.50616.rjw@sisk.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 11 November 2009, Linus Torvalds wrote:
> 
> On Wed, 11 Nov 2009, Marcel Holtmann wrote:
> > 
> > As it seems the btusb_close() only cancels the work workqueue and not
> > the waker workqueue. Could that be the problem.
> 
> It's the waker workqueue that Rafael apparently sees with the debug patch 
> from Oleg, so yeah, that sounds possible.
> 
> Rafael, since apparently htusb_close() _is_ called, does the following 
> simpler patch fix it for you? I bet your patch does it too.

Yes and yes.

And in fact this is a post-2.6.31 regression introduced by commit
7bee549e197c9c0e92b89857a409675c1d5e9dff (Bluetooth: Add USB autosuspend
support to btusb driver).

Thanks,
Rafael
