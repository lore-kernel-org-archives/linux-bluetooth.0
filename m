Return-Path: <cyrus@holtmann.org>
Message-ID: <1324083895.1965.87.camel@aeonflux>
Subject: Re: Does it make sense to have the hdev workqueue serialized?
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>,
	Andre Guedes <andre.guedes@openbossa.org>,
	padovan@profusion.mobi, linux-bluetooth@vger.kernel.org
Date: Fri, 16 Dec 2011 17:04:55 -0800
In-Reply-To: <alpine.DEB.2.02.1112161021100.24351@mathewm-linux>
References: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>
	 <1323879926-15971-6-git-send-email-andre.guedes@openbossa.org>
	 <1323891366.1965.55.camel@aeonflux>
	 <alpine.DEB.2.02.1112151101550.24351@mathewm-linux>
	 <CANq1E4Qc9nrF=aBP8bfN8t4FhkomCoHqkz7h2pEcP5eG+XTJHQ@mail.gmail.com>
	 <alpine.DEB.2.02.1112161021100.24351@mathewm-linux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> The benefit would be in having no need to keep track of which context 
> functions are executing in.  It's been a big headache with the ERTM 
> and AMP changes, and there is a bunch of code that could work better 
> in process context if it didn't have to also handle calls from 
> tasklets.
> 
> That said, after learning more about how workqueues are implemented 
> now, it may be worthwhile to change the "use one single-threaded 
> workqueue for everything" assumption.  alloc_workqueue() has a 
> max_active parameter, and it is possible to have many work items 
> running concurrently.  Some of those threads could be suspended, like 
> Andre does in his patch.  Workqueues created with the old 
> create_workqueue() or create_singlethread_workqueue() have max_active 
> == 1, which enforces serialization on each processor.
> 
> 
> So there are two big questions:  Do we want to keep pushing everything 
> on the hdev workqueue, since workqueues are not as heavyweight as they 
> used to be?  And does it make sense to keep our workqueues serialized?
> 
> 
> Advantages of serialization:
>   * An HCI device is serialized by the transport anyway, so it makes 
> sense to match that model.
>   * Ordering is maintained.  The order of incoming HCI events may queue 
> work in a particular order and need to assume the work will be 
> executed in that order.
>   * Simplicity.
>   * No lock contention between multiple workers.
> 
> Advantages of not serializing:
>   * Takes advantage of SMP
>   * Workers can block without affecting the rest of the queue, enabling 
> workers to be long-lived and use state on the thread stack instead of 
> complicated lists of pending operations and dynamic allocation.
>   * We need to have proper locking to deal with user processes anyway, 
> so why not allow more concurrency internally.
>   * Some work can proceed while waiting for locks in other workers.
>   * Can use WQ_HIGHPRI to keep tx/rx data moving even when workers are 
> waiting for locks
> 
> 
> I think what's called for is a hybrid approach that serializes where 
> necessary, but uses multiple workqueues.  How about this:
> 
>   * Use the serialized hdev workqueue for rx/tx only.  This could use 
> WQ_HIGHPRI to help performance.

I think this is what we have to do to ensure that our event, cmd and ACL
and also SCO processing is not affected by anything else.

>   * Have a serialized workqueue for each L2CAP channel to handle 
> per-channel timeouts.

Why per channel? Wouldn't be one per ACL connection by enough?

>   * Have a global, non-serialized workqueue for stuff like sysfs and 
> mgmt to use.

And yes, one global workqueue for random tasks we have to do seems like
a good idea as well.

Regards

Marcel


