Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] Bluetooth: Use struct delayed_work for HCI command timeout
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <538F8F49.7050501@ahsoftware.de>
Date: Thu, 5 Jun 2014 12:53:59 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <038A5220-47E3-411C-88EE-C4DFE35724BD@holtmann.org>
References: <1401586702-54238-1-git-send-email-marcel@holtmann.org> <538F75A0.8010609@ahsoftware.de> <538F8F49.7050501@ahsoftware.de>
To: Alexander Holler <holler@ahsoftware.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

>>> This is an experimental patch that converts hdev->cmd_timer from
>>> struct timer_list to struct delayed_work.
>> 
>> I don't know what this patch should change.
>> 
>> If I understand it correctly, a workqueue is used instead of a timer.
>> But besides that nothing else was changed. So instead of a timer, a work
>> now kills the hci-cmd-task and posts an error. And that is exactly what
>> happened here. So after one (failed) try, I've gone back to use my 2
>> small patches.
> 
> I assume the reasoning for the patch was to get the load of system queue somehow into the timeout. But that can't work. E.g. if the queue is already very busy when the hci command is (scheduled to) send and the (delayed) timeout is put on the queue (too), then it might happen that the command is send and immediately afterwards the timeout happens. Or the response from the dongle is already in the queue but happens after the timeout happens.

the main reason is that we have to move away from timer_list usage since we want to fully run outside of the interrupt context. It seems that the cmd_timeout was forgotten when we did the switch to workqueue processing. I did not expect that this change will fix anything right away, but it is the ground work to actually move into simpler locking which could potentially an issue for certain delays and unexpected interactions with the USB subsystem.

Keep in mind that we currently are using 3 workqueues. The system wide one, and two per HCI controller. I am pretty certain we need to investigate our general HCI packet processing vs the actual HCI command/event processing. For the HCI command/event processing we do rely on this being single threaded and ordered, but for the general HCI packet processing, we might can go multi-threaded and allow work to move from one CPU/core to another.

Increasing the timeout like you did is just fixing a symptom. We need to figure out the root cause why a system takes so long to report results of the HCI command and/or what it wastes the time. USB might be a bottle neck here for sure, but then this might needs fixing as well.

Johan, did you have a look at my patch and see if it is generally sound. Should we include it and see how good (or bad) it is behaving in general. From there on we can optimize or workqueue usage.

Regards

Marcel

