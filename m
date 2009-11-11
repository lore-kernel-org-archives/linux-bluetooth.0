Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: GPF in run_workqueue()/list_del_init(cwq->worklist.next) on resume (was: Re: Help needed: Resume problems in 2.6.32-rc, perhaps related to preempt_count leakage in keventd)
Date: Wed, 11 Nov 2009 22:15:08 +0100
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mike Galbraith <efault@gmx.de>,
 Ingo Molnar <mingo@elte.hu>,
 LKML <linux-kernel@vger.kernel.org>,
 pm list <linux-pm@lists.linux-foundation.org>,
 Greg KH <gregkh@suse.de>,
 Jesse Barnes <jbarnes@virtuousgeek.org>,
 Tejun Heo <tj@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
References: <200911091250.31626.rjw@sisk.pl> <200911112100.16561.rjw@sisk.pl> <20091111202433.GA5714@redhat.com>
In-Reply-To: <20091111202433.GA5714@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911112215.08126.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch, 11. November 2009 21:24:33 schrieb Oleg Nesterov:
> > So, it looks like the bug is in btusb_destruct(), which should call
> > cancel_work_sync() on data->waker before freeing 'data'.  I guess it
> > should do the same for data->work.
> 
> Or. btusb_suspend() and btusb_close() do cancel_work_sync(data->work),
> perhaps they should cancel data->waker as well, I dunno.
> 
> I added Oliver to cc.

btusb_close() must do it. btusb_suspend() must not do it.

	Regards
		Oliver
