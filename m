Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GPF in run_workqueue()/list_del_init(cwq->worklist.next) on resume (was: Re: Help needed: Resume problems in 2.6.32-rc, perhaps related to preempt_count leakage in keventd)
Date: Wed, 11 Nov 2009 22:44:35 +0100
Cc: Marcel Holtmann <marcel@holtmann.org>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mike Galbraith <efault@gmx.de>,
 Ingo Molnar <mingo@elte.hu>,
 LKML <linux-kernel@vger.kernel.org>,
 pm list <linux-pm@lists.linux-foundation.org>,
 Greg KH <gregkh@suse.de>,
 Jesse Barnes <jbarnes@virtuousgeek.org>,
 Tejun Heo <tj@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 linux-bluetooth@vger.kernel.org
References: <200911091250.31626.rjw@sisk.pl> <200911112213.30673.oliver@neukum.org> <alpine.LFD.2.01.0911111335410.31845@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.01.0911111335410.31845@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911112244.35320.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch, 11. November 2009 22:38:08 schrieb Linus Torvalds:
> On Wed, 11 Nov 2009, Oliver Neukum wrote:
> > Yes, btusb_close() needs to cancel the waker workqueue, too.
> > In addition, in order to avoid a memory leak it must call
> > usb_scuttle_anchored_urbs(&data->deferred)
> > to make sure any deferred data is destroyed.
> 
> Ok. I committed the one-liner patch to fix the oops (confirmed by Rafael),
> but I'm leaving the memory leak for you as I'm not going to commit some
> untested patch at this stage.
> 
> Thanks to everybody involved, I was personally very nervous that this was
> something much more fundamental (we've had some scary bugs during the
> 32-rc series), and am relieved that it was "just" a silly driver bug.

Thanks. A patch is in the works.

	Regards
		Oliver
