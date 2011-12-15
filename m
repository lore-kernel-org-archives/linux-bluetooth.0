Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 5/7] Bluetooth: LE scan infra-structure
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <alpine.DEB.2.02.1112151101550.24351@mathewm-linux>
Date: Thu, 15 Dec 2011 17:00:28 -0300
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <C7FEB13E-1C6B-4220-AF1A-7A8F5208E5D1@openbossa.org>
References: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>  <1323879926-15971-6-git-send-email-andre.guedes@openbossa.org> <1323891366.1965.55.camel@aeonflux> <alpine.DEB.2.02.1112151101550.24351@mathewm-linux>
To: Mat Martineau <mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Dec 15, 2011, at 4:25 PM, Mat Martineau wrote:

> 
> Marcel & Andre -
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
>> so I rather hold off on these until we get the tasklet removal patches
>> merged. The mgmt processing will then also be done in process context
>> and we can just sleep. This should make code like this a lot simpler.
> 
> 
> While execution on a workqueue can sleep, it's not a good idea to block for a long time like this patch does.  A single-threaded workqueue (like the hdev workqueue) will not run the next scheduled work until the current work function returns.  If code executing in a workqueue suspends execution by using a wait queue, like le_scan_workqueue(), then all other pending work is blocked until le_scan_workqueue() returns.

Yes, I'm aware of it. This is why we have the schedule_timeout(). Most
of the time, we sleep for a short time since the controller sends the
command result event just after we send the command. If the controller
takes too long or simply doesn't send the command event we timeout
and abort the le scan work. This way we don't starve other works
enqueued on hdev->workqueue.

Do you mean "block for a long time" the time we wait for the command
result or the timeout?

BR,

Andre

