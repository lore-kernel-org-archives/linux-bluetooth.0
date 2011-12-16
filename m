Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Fri, 16 Dec 2011 17:13:49 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/7] Bluetooth: LE scan infra-structure
Message-ID: <20111216191349.GA7046@joana>
References: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>
 <1323879926-15971-6-git-send-email-andre.guedes@openbossa.org>
 <1323891366.1965.55.camel@aeonflux>
 <alpine.DEB.2.02.1112151101550.24351@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1112151101550.24351@mathewm-linux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-12-15 11:25:49 -0800]:

> 
> Marcel & Andre -
> 
> On Wed, 14 Dec 2011, Marcel Holtmann wrote:
> 
> >Hi Andre,
> >
> >>This patch adds to hci_core an infra-structure to scan LE devices.
> >>
> >>The LE scan is implemented using a work_struct which is enqueued
> >>on hdev->workqueue. The LE scan work sends commands (Set LE Scan
> >>Parameters and Set LE Scan Enable) to the controller and waits for
> >>its results. If commands were executed successfully a timer is set
> >>to disable the ongoing scanning after some amount of time.
> >
> >so I rather hold off on these until we get the tasklet removal patches
> >merged. The mgmt processing will then also be done in process context
> >and we can just sleep. This should make code like this a lot simpler.
> 
> 
> While execution on a workqueue can sleep, it's not a good idea to
> block for a long time like this patch does.  A single-threaded
> workqueue (like the hdev workqueue) will not run the next scheduled
> work until the current work function returns.  If code executing in
> a workqueue suspends execution by using a wait queue, like
> le_scan_workqueue(), then all other pending work is blocked until
> le_scan_workqueue() returns.

Yes, we know this issue, I'll be looking to this issue quite soon.
Btw, having a single-threaded is not the real problem if we use
create_workqueue() instead but in system with only one CPU we will have the
same problem.

> 
> It might be better to think of workqueues as having similar
> restrictions to tasklets, except you can use GFP_KERNEL when
> allocating and can block while acquiring locks.
> 
> 
> In getting rid of tasklets, I think we also need to not use timers
> (which also execute in softirq context), and use the delayed_work
> calls instead.  That way we can assume all net/bluetooth code runs
> in process context, except for calls up from the driver layer.

I'm taking care of that as well, timers are a problem if we run the rest of
the code in process context.

If you wanna take a look to the work I've been doing I pushing it to this
tree:
http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-testing.git

This is in an unstable state, I still see some locking issues like
deadlocks in the code, but I plan to move fast and merge this into
bluetooth-next soon.

Comments are welcome!

	Gustavo
