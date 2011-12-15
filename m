Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1112151101550.24351@mathewm-linux>
References: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>
	<1323879926-15971-6-git-send-email-andre.guedes@openbossa.org>
	<1323891366.1965.55.camel@aeonflux>
	<alpine.DEB.2.02.1112151101550.24351@mathewm-linux>
Date: Thu, 15 Dec 2011 21:05:22 +0100
Message-ID: <CANq1E4Qc9nrF=aBP8bfN8t4FhkomCoHqkz7h2pEcP5eG+XTJHQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] Bluetooth: LE scan infra-structure
From: David Herrmann <dh.herrmann@googlemail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat

On Thu, Dec 15, 2011 at 8:25 PM, Mat Martineau <mathewm@codeaurora.org> wro=
te:
>
> Marcel & Andre -
>
>
> On Wed, 14 Dec 2011, Marcel Holtmann wrote:
>
>> Hi Andre,
>>
>>> This patch adds to hci_core an infra-structure to scan LE devices.
>>>
>>> The LE scan is implemented using a work_struct which is enqueued
>>> on hdev->workqueue. The LE scan work sends commands (Set LE Scan
>>> Parameters and Set LE Scan Enable) to the controller and waits for
>>> its results. If commands were executed successfully a timer is set
>>> to disable the ongoing scanning after some amount of time.
>>
>>
>> so I rather hold off on these until we get the tasklet removal patches
>> merged. The mgmt processing will then also be done in process context
>> and we can just sleep. This should make code like this a lot simpler.
>
>
>
> While execution on a workqueue can sleep, it's not a good idea to block f=
or
> a long time like this patch does. =A0A single-threaded workqueue (like th=
e
> hdev workqueue) will not run the next scheduled work until the current wo=
rk
> function returns. =A0If code executing in a workqueue suspends execution =
by
> using a wait queue, like le_scan_workqueue(), then all other pending work=
 is
> blocked until le_scan_workqueue() returns.

Why do we use a single-threaded workqueue anyway? Why don't we switch
to a non-reentrant workqueue? Otherwise, we are just blocking the
whole hdev workqueue because we are too lazy to implement proper
locking between work-structs that depend on each other.

> It might be better to think of workqueues as having similar restrictions =
to
> tasklets, except you can use GFP_KERNEL when allocating and can block whi=
le
> acquiring locks.

That sounds like a lot of work with almost no benefit. If we start the
transition from tasklets to workqueues I think we should do it
properly so we do not require a single-threaded workqueue.

> In getting rid of tasklets, I think we also need to not use timers (which
> also execute in softirq context), and use the delayed_work calls instead.
> =A0That way we can assume all net/bluetooth code runs in process context,
> except for calls up from the driver layer.

Are there currently any pending patches? I've tried converting the
tasklets to workqueues myself but I always ended up with several
race-conditions. I haven't found a clean and easy way to fix them,
yet. And it's also a quite frustrating work.

Cheers
David
