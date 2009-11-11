Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: GPF in run_workqueue()/list_del_init(cwq->worklist.next) on resume (was: Re: Help needed: Resume problems in 2.6.32-rc, perhaps related to preempt_count leakage in keventd)
Date: Wed, 11 Nov 2009 22:13:30 +0100
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <200911091250.31626.rjw@sisk.pl> <alpine.LFD.2.01.0911111142340.31845@localhost.localdomain> <1257970719.21467.4.camel@violet>
In-Reply-To: <1257970719.21467.4.camel@violet>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200911112213.30673.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch, 11. November 2009 21:18:39 schrieb Marcel Holtmann:
> > I'm looking at btusb_disconnect(), for example. It's one of the few BT 
> > drivers that seem to use workqueues, and I'm not seeing a 
> > cancel_work_sync() in the disconnect routine - but maybe the
> > btusb_close()  routine is called indirectly some way that I just don't
> > see.
> 
> so the btusb_close() should be called before btusb_destruct() and the
> destruct() callback is only when the last reference count gets dropped
> and we do have to free the memory. So it seems we are doing something
> wrong in btusb_close(). The close() callback is triggered via
> hci_unregister_dev() from btusb_disconnect().
> 
> As it seems the btusb_close() only cancels the work workqueue and not
> the waker workqueue. Could that be the problem.

Yes, btusb_close() needs to cancel the waker workqueue, too.
In addition, in order to avoid a memory leak it must call
usb_scuttle_anchored_urbs(&data->deferred)
to make sure any deferred data is destroyed.

	Regards
		Oliver
