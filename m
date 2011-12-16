Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Dec 2011 11:20:21 -0800 (PST)
From: Mat Martineau <mathewm@codeaurora.org>
To: David Herrmann <dh.herrmann@googlemail.com>
cc: Marcel Holtmann <marcel@holtmann.org>,
	Andre Guedes <andre.guedes@openbossa.org>,
	padovan@profusion.mobi, linux-bluetooth@vger.kernel.org
Subject: Does it make sense to have the hdev workqueue serialized?
In-Reply-To: <CANq1E4Qc9nrF=aBP8bfN8t4FhkomCoHqkz7h2pEcP5eG+XTJHQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1112161021100.24351@mathewm-linux>
References: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org> <1323879926-15971-6-git-send-email-andre.guedes@openbossa.org> <1323891366.1965.55.camel@aeonflux> <alpine.DEB.2.02.1112151101550.24351@mathewm-linux>
 <CANq1E4Qc9nrF=aBP8bfN8t4FhkomCoHqkz7h2pEcP5eG+XTJHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=ISO-8859-15
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On Thu, 15 Dec 2011, David Herrmann wrote:

> Hi Mat
>
> On Thu, Dec 15, 2011 at 8:25 PM, Mat Martineau <mathewm@codeaurora.org> wrote:
>>
>> Marcel & Andre -
>>
>>
>> On Wed, 14 Dec 2011, Marcel Holtmann wrote:
>>
>>> Hi Andre,
>>>
>>>> This patch adds to hci_core an infra-structure to scan LE devices.
>>>>
>>>> The LE scan is implemented using a work_struct which is enqueued
>>>> on hdev->workqueue. The LE scan work sends commands (Set LE Scan
>>>> Parameters and Set LE Scan Enable) to the controller and waits for
>>>> its results. If commands were executed successfully a timer is set
>>>> to disable the ongoing scanning after some amount of time.
>>>
>>>
>>> so I rather hold off on these until we get the tasklet removal patches
>>> merged. The mgmt processing will then also be done in process context
>>> and we can just sleep. This should make code like this a lot simpler.
>>
>>
>>
>> While execution on a workqueue can sleep, it's not a good idea to block for
>> a long time like this patch does.  A single-threaded workqueue (like the
>> hdev workqueue) will not run the next scheduled work until the current work
>> function returns.  If code executing in a workqueue suspends execution by
>> using a wait queue, like le_scan_workqueue(), then all other pending work is
>> blocked until le_scan_workqueue() returns.
>
> Why do we use a single-threaded workqueue anyway? Why don't we switch
> to a non-reentrant workqueue? Otherwise, we are just blocking the
> whole hdev workqueue because we are too lazy to implement proper
> locking between work-structs that depend on each other.

Before 2.6.36, creating a workqueue would create a dedicated thread 
per processor (or just one thread for a single threaded workqueue). 
I think I've seen Marcel comment that we didn't have enough work to 
justify the extra resources for multiple threads.

Since 2.6.36, there are dynamic thread pools for each processor that 
do not depend on the number of workqueues.  Threads are instead 
allocated based on the amount of concurrent work present in the 
system.  See http://lwn.net/Articles/403891/

>> It might be better to think of workqueues as having similar restrictions to
>> tasklets, except you can use GFP_KERNEL when allocating and can block while
>> acquiring locks.
>
> That sounds like a lot of work with almost no benefit. If we start the
> transition from tasklets to workqueues I think we should do it
> properly so we do not require a single-threaded workqueue.

The benefit would be in having no need to keep track of which context 
functions are executing in.  It's been a big headache with the ERTM 
and AMP changes, and there is a bunch of code that could work better 
in process context if it didn't have to also handle calls from 
tasklets.

That said, after learning more about how workqueues are implemented 
now, it may be worthwhile to change the "use one single-threaded 
workqueue for everything" assumption.  alloc_workqueue() has a 
max_active parameter, and it is possible to have many work items 
running concurrently.  Some of those threads could be suspended, like 
Andre does in his patch.  Workqueues created with the old 
create_workqueue() or create_singlethread_workqueue() have max_active 
== 1, which enforces serialization on each processor.


So there are two big questions:  Do we want to keep pushing everything 
on the hdev workqueue, since workqueues are not as heavyweight as they 
used to be?  And does it make sense to keep our workqueues serialized?


Advantages of serialization:
  * An HCI device is serialized by the transport anyway, so it makes 
sense to match that model.
  * Ordering is maintained.  The order of incoming HCI events may queue 
work in a particular order and need to assume the work will be 
executed in that order.
  * Simplicity.
  * No lock contention between multiple workers.

Advantages of not serializing:
  * Takes advantage of SMP
  * Workers can block without affecting the rest of the queue, enabling 
workers to be long-lived and use state on the thread stack instead of 
complicated lists of pending operations and dynamic allocation.
  * We need to have proper locking to deal with user processes anyway, 
so why not allow more concurrency internally.
  * Some work can proceed while waiting for locks in other workers.
  * Can use WQ_HIGHPRI to keep tx/rx data moving even when workers are 
waiting for locks


I think what's called for is a hybrid approach that serializes where 
necessary, but uses multiple workqueues.  How about this:

  * Use the serialized hdev workqueue for rx/tx only.  This could use 
WQ_HIGHPRI to help performance.
  * Have a serialized workqueue for each L2CAP channel to handle 
per-channel timeouts.
  * Have a global, non-serialized workqueue for stuff like sysfs and 
mgmt to use.


Does that sound workable?


>> In getting rid of tasklets, I think we also need to not use timers (which
>> also execute in softirq context), and use the delayed_work calls instead.
>>  That way we can assume all net/bluetooth code runs in process context,
>> except for calls up from the driver layer.
>
> Are there currently any pending patches? I've tried converting the
> tasklets to workqueues myself but I always ended up with several
> race-conditions. I haven't found a clean and easy way to fix them,
> yet. And it's also a quite frustrating work.

Gustavo's working on it, starting from Marcel's patch.  I think it's 
this one: http://www.spinics.net/lists/linux-bluetooth/msg06892.html



--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


