Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Dec 2011 10:21:01 -0800 (PST)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andre Guedes <andre.guedes@openbossa.org>
cc: Marcel Holtmann <marcel@holtmann.org>, padovan@profusion.mobi,
    dh.herrmann@googlemail.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/7] Bluetooth: LE scan infra-structure
In-Reply-To: <C7FEB13E-1C6B-4220-AF1A-7A8F5208E5D1@openbossa.org>
Message-ID: <alpine.DEB.2.02.1112160912540.24351@mathewm-linux>
References: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>  <1323879926-15971-6-git-send-email-andre.guedes@openbossa.org> <1323891366.1965.55.camel@aeonflux> <alpine.DEB.2.02.1112151101550.24351@mathewm-linux>
 <C7FEB13E-1C6B-4220-AF1A-7A8F5208E5D1@openbossa.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>


On Thu, 15 Dec 2011, Andre Guedes wrote:

> Hi Mat,
>
> On Dec 15, 2011, at 4:25 PM, Mat Martineau wrote:
>
>>
>> Marcel & Andre -
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
>>> so I rather hold off on these until we get the tasklet removal patches
>>> merged. The mgmt processing will then also be done in process context
>>> and we can just sleep. This should make code like this a lot simpler.
>>
>>
>> While execution on a workqueue can sleep, it's not a good idea to 
>> block for a long time like this patch does.  A single-threaded 
>> workqueue (like the hdev workqueue) will not run the next scheduled 
>> work until the current work function returns.  If code executing in 
>> a workqueue suspends execution by using a wait queue, like 
>> le_scan_workqueue(), then all other pending work is blocked until 
>> le_scan_workqueue() returns.
>
> Yes, I'm aware of it. This is why we have the schedule_timeout(). Most
> of the time, we sleep for a short time since the controller sends the
> command result event just after we send the command. If the controller
> takes too long or simply doesn't send the command event we timeout
> and abort the le scan work. This way we don't starve other works
> enqueued on hdev->workqueue.

I did some work to verify what I'm asserting about workqueue 
serialization in a single-threaded workqueue, and I still think I'm on 
the right track for our current use of workqueues.

My initial understanding was based on what I had read in Linux Device 
Drivers (3rd ed), which dates back to 2.6.10.  Workqueues have since 
been updated to use a thread pool (http://lwn.net/Articles/355700/), 
but our hdev workqueue is still serialized.  From that LWN article: 
"Code which requires that workqueue tasks be executed in the order in 
which they are submitted can use a WQ_UNBOUND workqueue with 
max_active set to one."  Look at process_one_work() in workqueue.c, 
the submitted work is run in the middle ("f(work);"), and the next 
work is not started until cwq_dec_nr_in_flight() is called at the end 
-- after f(work) returns.

So, using schedule_timeout() doesn't help, unless we switch away 
from the single threaded workqueue.  I'll reply to David's email on 
that point.

> Do you mean "block for a long time" the time we wait for the command
> result or the timeout?

Both.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
