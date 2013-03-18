Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Mar 2013 12:13:35 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Christopher Waid <chris@thinkpenguin.com>
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode) causing
 crashes
Message-ID: <20130318191335.GA11242@kroah.com>
References: <514763A7.4020800@thinkpenguin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <514763A7.4020800@thinkpenguin.com>
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 18, 2013 at 02:57:43PM -0400, Christopher Waid wrote:
> 
> Bus 001 Device 007: ID 0a12:0001 Cambridge Silicon Radio, Ltd
> Bluetooth Dongle (HCI mode)
> 
> Code for a CSR bluetooth chipset appears broken in recent kernel
> releases. After a device is paired the kernel panics. This has been
> tested with a dozen USB dongles / systems and is consistently a
> problem. On the rare occasion it might not cause a kernel panic
> although it will definitely still crash after a few minutes. This
> does not happen with older kernel releases.

What kernel version is crashing, and what is the exact text of the
kernel panic?

> Please let me know how I can help solve this issue. We have lots of
> dongles and can try and get any information needed to fix it.

You might want to ask the Linux bluetooth developers (now added to the
cc of this response.)

thanks,

greg k-h
