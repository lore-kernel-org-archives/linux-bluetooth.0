Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Missing Linux Bluetooth Headers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALkxMhEJxUXaKZgSQ4BSa-UvuEx1uFwVbr4yikH+qB81cUkvDw@mail.gmail.com>
Date: Fri, 28 Mar 2014 10:08:35 -0700
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <5B9B1FB0-A822-4B5E-A040-42920D336457@holtmann.org>
References: <CALkxMhEJxUXaKZgSQ4BSa-UvuEx1uFwVbr4yikH+qB81cUkvDw@mail.gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> Could you explain why Linux kernel do not provide any header files for
> its sockets?

because we have Bluetooth support since 2.4.6 kernel and that is over 10 years old. Back in the days the kernel headers were done differently and including kernel headers was not as clean as it is today.

> For example: "socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI)"
> I do not need a userspace (BlueZ [and do not want it]) to communicate
> with kernel, but no Linux headers is a problem. Add dependency to
> BlueZ is ugly, because  I do not depend on BlueZ, but Linux kernel.
> Also BlueZ is not used in project like "libpcap".
> 
> I see that BlueZ have those headers in "lib" directory (sources).
> Linux have them in "include/net/bluetooth" but they are not installed
> (by "make headers_install").
> 
> I think Linux should provide Bluetooth headers files. I see that CAN
> (#include <linux/can.h>) do that.

In the long term we should provide uapi header for Bluetooth. We just have not gotten there yet. Some of the current kernel headers are not clean. They can not be easily exported.

Regards

Marcel

