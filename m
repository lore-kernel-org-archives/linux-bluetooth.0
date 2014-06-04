Return-Path: <cyrus@holtmann.org>
Message-ID: <538F75A0.8010609@ahsoftware.de>
Date: Wed, 04 Jun 2014 21:38:08 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Use struct delayed_work for HCI command timeout
References: <1401586702-54238-1-git-send-email-marcel@holtmann.org>
In-Reply-To: <1401586702-54238-1-git-send-email-marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 01.06.2014 03:38, schrieb Marcel Holtmann:
> This is an experimental patch that converts hdev->cmd_timer from
> struct timer_list to struct delayed_work.

I don't know what this patch should change.

If I understand it correctly, a workqueue is used instead of a timer. 
But besides that nothing else was changed. So instead of a timer, a work 
now kills the hci-cmd-task and posts an error. And that is exactly what 
happened here. So after one (failed) try, I've gone back to use my 2 
small patches.

Regards,

Alexander Holler
