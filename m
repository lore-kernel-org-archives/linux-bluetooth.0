Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Jul 2013 13:07:33 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Sujith Manoharan <sujith@msujith.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] ath3k: Add support for ID 0x13d3/0x3402
Message-ID: <20130725120732.GC9913@joana>
References: <1373860743-8073-1-git-send-email-sujith@msujith.org>
 <20130715201413.GB21442@joana>
 <20964.29171.211422.614690@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20964.29171.211422.614690@gargle.gargle.HOWL>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sujith,

* Sujith Manoharan <sujith@msujith.org> [2013-07-16 03:34:35 +0530]:

> Gustavo Padovan wrote:
> > I would need the output of /sys/kernel/debug/usb/devices for this devices.
> > We need to keep track of the devices we support. Could you please resend this
> > patch with this information in the commit message? Thanks.
> 
> I don't have the hardware, but the kernel bug report has the details from
> lsusb - if that's enough, I can send a v2.

I picked the information from the bug report, patch is now on
bluetooth.git.

	Gustavo
