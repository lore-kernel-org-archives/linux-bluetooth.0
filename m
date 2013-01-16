Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Jan 2013 16:36:00 -0800 (PST)
From: Mat Martineau <mathewm@codeaurora.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/4] Bluetooth: Fix workqueue related issues
In-Reply-To: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
Message-ID: <alpine.DEB.2.02.1301151626330.32732@mathewm-linux>
References: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Johan -

On Mon, 14 Jan 2013, Johan Hedberg wrote:

> Hi,
>
> I was initially only going to fix the thing in the last patch of this
> set but after starting to look at the code I found several other issues
> and hence the rest of the patches.
>
> The first three patches fix work queue handling. We should, whenever
> possible, avoid the system-global workqueue (the schedule_*work
> functions) and use hdev-specific ones instead.

There are also multiple system workqueues beyond the default 
system_wq, like system_long_wq and system_unbound_wq.  Those may be a 
better fit and you wouldn't have to manage additional per-device 
workqueues.

> However, we can't use
> hci_request() with the usual workqueue since that would block e.g.
> hci_send_cmd from completing so a second work queue is needed.
>
> The last patch fixes a race with setting the scan mode that I was
> seeing every once in a while through a connectable or discoverable test
> case of mgmt-tester failing. There are several other HCI commands with
> the same potential issue (like the class of device and the local name)
> but I haven't gotten around to fixing those yet.

Regards,

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation


