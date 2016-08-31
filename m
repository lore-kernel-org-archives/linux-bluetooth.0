Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/4] Bluetooth: hci_uart: various fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160830192250.40eea3cf@bbrezillon>
Date: Tue, 30 Aug 2016 19:08:58 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, jason.abele@gmail.com
Message-Id: <4EE01E7C-BFD0-4A18-B4B1-6648BD8E4585@holtmann.org>
References: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com> <0649B498-A8BC-42D1-8F70-07B3C8CAB8E2@holtmann.org> <20160830192250.40eea3cf@bbrezillon>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Boris,

>>> We recently faced some problems when using an BT uart chip interfaced
>>> through the H5 proto (rtk_h5). Here are the logs of the 2 different
>>> issues we had when closing the line discipline (actually, restoring
>>> the previous one) [1][2]. I know the kernel is Tainted in those logs,
>>> but after some investigations I found a few potential issues that might
>>> explain what we're seeing.  
>> 
>> while I can look through these patches, but I wonder when we are finally getting a full and proper RTK support that doesn't use these hackish hciattach code I have seen.
>> 
>> I mean the only thing userspace should be doing is attaching the line discipline and then everything else should run inside the kernel. Attaching the line discipline is the same as plugging in an USB dongle. Detaching it is the same as unplugging the dongle. That is how we should treat it. So for the lifetime of a system it should never detach. All the power control etc. should be done inside the kernel. Same as how we have done it for Broadcom and Intel devices.
> 
> Well, I'm completely new to the bluetooth stack, and while the
> 'hciattach/in-kernel driver' interaction does seem weird to me, I
> definitely can't tell whether it's good or bad.

if it is the hciattach_rtk.c that uses kernel struct sk_buff in userspace, then it is hackish like no tomorrow. I am still surprised that this works for anybody.

> I just sent those patches because I was facing kernel panics.
> 
> Still, I don't get your argument about allowing a user to attach the
> line discipline, but preventing him from detaching it. The races exist,
> so even if you decide that the line discipline cannot be detached, how
> do you plan to handle module unloading (maybe you don't want to allow
> that either)?

The point is that btattach (which we like to use now) is suppose to be plug/unplug action. You should be able to keep the line discipline attached over hciconfig hci0 up/down interaction. Meaning the kernel can do its proper work without having to resort to detach the line discipline to bring the device down or in low power mode.

> One last comment. Even after applying those fixes I'm still facing
> panics [1], so there are probably other racy portions in the code.

I am not fully surprised. It would be great if you have time to add full RTK support to the kernel side that just uses btattach in userspace to open the TTY and attach the line discipline. And then drive vendor setup + firmware loading from the kernel.

Regards

Marcel
