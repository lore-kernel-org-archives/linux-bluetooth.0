Return-Path: <cyrus@holtmann.org>
Message-ID: <551E8C6A.8040009@linux.intel.com>
Date: Fri, 03 Apr 2015 14:49:46 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Peter Hurley <peter@hurleysoftware.com>
CC: linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
	jslaby@suse.cz
Subject: Re: [RFC 3/5] Bluetooth: hci_uart: Add HCIUARTSETBAUDRATE ioctl
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com> <1427985456-31536-4-git-send-email-frederic.danis@linux.intel.com> <551E717A.6040500@hurleysoftware.com>
In-Reply-To: <551E717A.6040500@hurleysoftware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[ +cc GregKH, JiriS ]

On 03/04/2015 12:54, Peter Hurley wrote:
> On 04/02/2015 10:37 AM, Frederic Danis wrote:
>> This allows user space application to set final speed requested for UART
>> device. UART port is open at init speed by user space application.
>
> If userspace opened the tty and knows this is a UART, why can it not
> use the for-purpose tty ioctls to change the line rate?

The purpose of this Bluetooth set of patches is to move device setup for 
Bluetooth UART devices into the kernel.
The idea is that userspace only needs to open the tty at initial speed 
and set correct line discipline, then userspace has no more to do, its 
up to HCI UART driver to manage the device (including firmware loading, 
bluetooth address and device speed setup).

However the driver may want to modify device speed (by using vendor 
specific HCI commands) to operate at full speed. Moreover, in case of 
firmware loading, some devices reset their speed to the default one, 
which will imply to change UART host speed to be able to continue 
communication.

Userspace can not know when all those speed changes occur.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

