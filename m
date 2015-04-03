Return-Path: <cyrus@holtmann.org>
Message-ID: <551E9987.9050800@hurleysoftware.com>
Date: Fri, 03 Apr 2015 09:45:43 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Frederic Danis <frederic.danis@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
	jslaby@suse.cz
Subject: Re: [RFC 3/5] Bluetooth: hci_uart: Add HCIUARTSETBAUDRATE ioctl
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com> <1427985456-31536-4-git-send-email-frederic.danis@linux.intel.com> <551E717A.6040500@hurleysoftware.com> <551E8C6A.8040009@linux.intel.com>
In-Reply-To: <551E8C6A.8040009@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/03/2015 08:49 AM, Frederic Danis wrote:
> [ +cc GregKH, JiriS ]
> 
> On 03/04/2015 12:54, Peter Hurley wrote:
>> On 04/02/2015 10:37 AM, Frederic Danis wrote:
>>> This allows user space application to set final speed requested for UART
>>> device. UART port is open at init speed by user space application.
>>
>> If userspace opened the tty and knows this is a UART, why can it not
>> use the for-purpose tty ioctls to change the line rate?
> 
> The purpose of this Bluetooth set of patches is to move device setup for Bluetooth UART devices into the kernel.
> The idea is that userspace only needs to open the tty at initial speed and set correct line discipline, then userspace has no more to do, its up to HCI UART driver to manage the device (including firmware loading, bluetooth address and device speed setup).
> 
> However the driver may want to modify device speed (by using vendor specific HCI commands) to operate at full speed. Moreover, in case of firmware loading, some devices reset their speed to the default one, which will imply to change UART host speed to be able to continue communication.
> 
> Userspace can not know when all those speed changes occur.

The line discipline is always notified of line rate changes
via the set_termios() method, so if you add that to the hci_ldisc,
you'll be able to keep the BT device in sync with your
vendor-specific commands.

I'd like to be able to help out with the firmware download problem
but it's not clear to me at what point that is being executed since
the patch that adds a setup() method to the protocol doesn't compile:

/home/peter/src/kernels/mainline/drivers/bluetooth/hci_ldisc.c: In function ‘hci_uart_set_proto’:
/home/peter/src/kernels/mainline/drivers/bluetooth/hci_ldisc.c:485:11: error: ‘struct hci_uart_proto’ has no member named ‘setup’
  hu->proto->setup = NULL;
           ^
/home/peter/src/kernels/mainline/drivers/bluetooth/hci_ldisc.c:488:13: error: ‘struct hci_uart_proto’ has no member named ‘setup’
    hu->proto->setup = devtypes[i].setup;
             ^
make[3]: *** [drivers/bluetooth/hci_ldisc.o] Error 1

Regards,
Peter Hurley

