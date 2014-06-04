Return-Path: <cyrus@holtmann.org>
Message-ID: <538F8F49.7050501@ahsoftware.de>
Date: Wed, 04 Jun 2014 23:27:37 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Use struct delayed_work for HCI command timeout
References: <1401586702-54238-1-git-send-email-marcel@holtmann.org> <538F75A0.8010609@ahsoftware.de>
In-Reply-To: <538F75A0.8010609@ahsoftware.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 04.06.2014 21:38, schrieb Alexander Holler:
> Am 01.06.2014 03:38, schrieb Marcel Holtmann:
>> This is an experimental patch that converts hdev->cmd_timer from
>> struct timer_list to struct delayed_work.
>
> I don't know what this patch should change.
>
> If I understand it correctly, a workqueue is used instead of a timer.
> But besides that nothing else was changed. So instead of a timer, a work
> now kills the hci-cmd-task and posts an error. And that is exactly what
> happened here. So after one (failed) try, I've gone back to use my 2
> small patches.

I assume the reasoning for the patch was to get the load of system queue 
somehow into the timeout. But that can't work. E.g. if the queue is 
already very busy when the hci command is (scheduled to) send and the 
(delayed) timeout is put on the queue (too), then it might happen that 
the command is send and immediately afterwards the timeout happens. Or 
the response from the dongle is already in the queue but happens after 
the timeout happens.

Regards,

Alexander Holler
