Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 11:25:49 -0800 (PST)
From: Mat Martineau <mathewm@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Andre Guedes <andre.guedes@openbossa.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/7] Bluetooth: LE scan infra-structure
In-Reply-To: <1323891366.1965.55.camel@aeonflux>
Message-ID: <alpine.DEB.2.02.1112151101550.24351@mathewm-linux>
References: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>  <1323879926-15971-6-git-send-email-andre.guedes@openbossa.org> <1323891366.1965.55.camel@aeonflux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>


Marcel & Andre -

On Wed, 14 Dec 2011, Marcel Holtmann wrote:

> Hi Andre,
>
>> This patch adds to hci_core an infra-structure to scan LE devices.
>>
>> The LE scan is implemented using a work_struct which is enqueued
>> on hdev->workqueue. The LE scan work sends commands (Set LE Scan
>> Parameters and Set LE Scan Enable) to the controller and waits for
>> its results. If commands were executed successfully a timer is set
>> to disable the ongoing scanning after some amount of time.
>
> so I rather hold off on these until we get the tasklet removal patches
> merged. The mgmt processing will then also be done in process context
> and we can just sleep. This should make code like this a lot simpler.


While execution on a workqueue can sleep, it's not a good idea to 
block for a long time like this patch does.  A single-threaded 
workqueue (like the hdev workqueue) will not run the next scheduled 
work until the current work function returns.  If code executing in a 
workqueue suspends execution by using a wait queue, like 
le_scan_workqueue(), then all other pending work is blocked until 
le_scan_workqueue() returns.

It might be better to think of workqueues as having similar 
restrictions to tasklets, except you can use GFP_KERNEL when 
allocating and can block while acquiring locks.


In getting rid of tasklets, I think we also need to not use timers 
(which also execute in softirq context), and use the delayed_work 
calls instead.  That way we can assume all net/bluetooth code runs in 
process context, except for calls up from the driver layer.


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
