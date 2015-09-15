Return-Path: <cyrus@holtmann.org>
Message-ID: <55F82461.6000805@intel.com>
Date: Tue, 15 Sep 2015 16:00:01 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: btattach: Add auto attach/detach
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I wonder if adding a dynamic attach/detach to btattach could be a good idea.

Since most HCI UART drivers power on/off the Bluetooth controller on 
proto/ldisc open/close.
It could be interesting to attach/detach the line discipline depending 
Bluetooth usage.

A way to do that could be to track rfkill events via the /dev/rfkill device.
I can propose two solutions:

- btattach monitors a specific rfkill node whose index is a passed as 
argument
and ldisc is attached/detached accordingly.

- An other solution could be to create a rfkill node from btattach so 
that if
something blocks/unblocks the node, HCI ldisc is detached/attached 
automatically.
Problem is that we can't create a rfkill node from user-space, but I 
think we can
easily add this support to the rfkill device driver.

On my laptop, the Thinkpad acpi driver exports a rfkill nodes which 
disconnects/reconnects
the USB embedded Bluetooth controller. This is what I would like to 
reproduce for UART here.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
