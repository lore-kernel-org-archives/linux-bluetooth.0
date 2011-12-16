Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Fri, 16 Dec 2011 18:05:14 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Does it make sense to have the hdev workqueue serialized?
Message-ID: <20111216200514.GB7046@joana>
References: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>
 <1323879926-15971-6-git-send-email-andre.guedes@openbossa.org>
 <1323891366.1965.55.camel@aeonflux>
 <alpine.DEB.2.02.1112151101550.24351@mathewm-linux>
 <CANq1E4Qc9nrF=aBP8bfN8t4FhkomCoHqkz7h2pEcP5eG+XTJHQ@mail.gmail.com>
 <alpine.DEB.2.02.1112161021100.24351@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <alpine.DEB.2.02.1112161021100.24351@mathewm-linux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-12-16 11:20:21 -0800]:

>=20
>=20
> On Thu, 15 Dec 2011, David Herrmann wrote:
>=20
> >Hi Mat
> >
> >On Thu, Dec 15, 2011 at 8:25 PM, Mat Martineau <mathewm@codeaurora.org> =
wrote:
> >>
> >>Marcel & Andre -
> >>
> >>
> >>On Wed, 14 Dec 2011, Marcel Holtmann wrote:
> >>
> >>>Hi Andre,
> >>>
> >>>>This patch adds to hci_core an infra-structure to scan LE devices.
> >>>>
> >>>>The LE scan is implemented using a work_struct which is enqueued
> >>>>on hdev->workqueue. The LE scan work sends commands (Set LE Scan
> >>>>Parameters and Set LE Scan Enable) to the controller and waits for
> >>>>its results. If commands were executed successfully a timer is set
> >>>>to disable the ongoing scanning after some amount of time.
> >>>
> >>>
> >>>so I rather hold off on these until we get the tasklet removal patches
> >>>merged. The mgmt processing will then also be done in process context
> >>>and we can just sleep. This should make code like this a lot simpler.
> >>
> >>
> >>
> >>While execution on a workqueue can sleep, it's not a good idea to block=
 for
> >>a long time like this patch does. =A0A single-threaded workqueue (like =
the
> >>hdev workqueue) will not run the next scheduled work until the current =
work
> >>function returns. =A0If code executing in a workqueue suspends executio=
n by
> >>using a wait queue, like le_scan_workqueue(), then all other pending wo=
rk is
> >>blocked until le_scan_workqueue() returns.
> >
> >Why do we use a single-threaded workqueue anyway? Why don't we switch
> >to a non-reentrant workqueue? Otherwise, we are just blocking the
> >whole hdev workqueue because we are too lazy to implement proper
> >locking between work-structs that depend on each other.
>=20
> Before 2.6.36, creating a workqueue would create a dedicated thread
> per processor (or just one thread for a single threaded workqueue).
> I think I've seen Marcel comment that we didn't have enough work to
> justify the extra resources for multiple threads.
>=20
> Since 2.6.36, there are dynamic thread pools for each processor that
> do not depend on the number of workqueues.  Threads are instead
> allocated based on the amount of concurrent work present in the
> system.  See http://lwn.net/Articles/403891/
>=20
> >>It might be better to think of workqueues as having similar restriction=
s to
> >>tasklets, except you can use GFP_KERNEL when allocating and can block w=
hile
> >>acquiring locks.
> >
> >That sounds like a lot of work with almost no benefit. If we start the
> >transition from tasklets to workqueues I think we should do it
> >properly so we do not require a single-threaded workqueue.
>=20
> The benefit would be in having no need to keep track of which
> context functions are executing in.  It's been a big headache with
> the ERTM and AMP changes, and there is a bunch of code that could
> work better in process context if it didn't have to also handle
> calls from tasklets.
>=20
> That said, after learning more about how workqueues are implemented
> now, it may be worthwhile to change the "use one single-threaded
> workqueue for everything" assumption.  alloc_workqueue() has a
> max_active parameter, and it is possible to have many work items
> running concurrently.  Some of those threads could be suspended,
> like Andre does in his patch.  Workqueues created with the old
> create_workqueue() or create_singlethread_workqueue() have
> max_active =3D=3D 1, which enforces serialization on each processor.

I didn't know alloc_workqueue() either, I think its a good idea go for it.

>=20
>=20
> So there are two big questions:  Do we want to keep pushing
> everything on the hdev workqueue, since workqueues are not as
> heavyweight as they used to be?  And does it make sense to keep our
> workqueues serialized?
>=20
>=20
> Advantages of serialization:
>  * An HCI device is serialized by the transport anyway, so it makes
> sense to match that model.
>  * Ordering is maintained.  The order of incoming HCI events may
> queue work in a particular order and need to assume the work will be
> executed in that order.
>  * Simplicity.
>  * No lock contention between multiple workers.
>=20
> Advantages of not serializing:
>  * Takes advantage of SMP
>  * Workers can block without affecting the rest of the queue,
> enabling workers to be long-lived and use state on the thread stack
> instead of complicated lists of pending operations and dynamic
> allocation.
>  * We need to have proper locking to deal with user processes
> anyway, so why not allow more concurrency internally.
>  * Some work can proceed while waiting for locks in other workers.
>  * Can use WQ_HIGHPRI to keep tx/rx data moving even when workers
> are waiting for locks
>=20
>=20
> I think what's called for is a hybrid approach that serializes where
> necessary, but uses multiple workqueues.  How about this:
>=20
>  * Use the serialized hdev workqueue for rx/tx only.  This could use
> WQ_HIGHPRI to help performance.

I agree with this one.

>  * Have a serialized workqueue for each L2CAP channel to handle
> per-channel timeouts.

Isn't it too much? maybe one workqueue per l2cap_conn is better.

>  * Have a global, non-serialized workqueue for stuff like sysfs and
> mgmt to use.

Some of the workqueue usage we have today might go away after the workqueue
change patches, we can check later if such workqueue will be really needed.

>=20
>=20
> Does that sound workable?
>=20
>=20
> >>In getting rid of tasklets, I think we also need to not use timers (whi=
ch
> >>also execute in softirq context), and use the delayed_work calls instea=
d.
> >>=A0That way we can assume all net/bluetooth code runs in process contex=
t,
> >>except for calls up from the driver layer.
> >
> >Are there currently any pending patches? I've tried converting the
> >tasklets to workqueues myself but I always ended up with several
> >race-conditions. I haven't found a clean and easy way to fix them,
> >yet. And it's also a quite frustrating work.
>=20
> Gustavo's working on it, starting from Marcel's patch.  I think it's
> this one: http://www.spinics.net/lists/linux-bluetooth/msg06892.html

As I said on the other e-mail, code is here:

http://git.kernel.org/?p=3Dlinux/kernel/git/padovan/bluetooth-testing.git

Comments are welcome!

	Gustavo
