Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [RFC 3/5] Bluetooth: hci_uart: Add HCIUARTSETBAUDRATE ioctl
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <551EB5A1.9040409@hurleysoftware.com>
Date: Fri, 3 Apr 2015 10:39:27 -0700
Cc: Loic Poulain <loic.poulain@intel.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
	jslaby@suse.cz
Message-Id: <D74E0673-5A60-4E8F-A050-60DB4A0F43A7@holtmann.org>
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com> <1427985456-31536-4-git-send-email-frederic.danis@linux.intel.com> <551E717A.6040500@hurleysoftware.com> <551E8C6A.8040009@linux.intel.com> <551E9987.9050800@hurleysoftware.com> <551EA13B.7010307@intel.com> <551EB5A1.9040409@hurleysoftware.com>
To: Peter Hurley <peter@hurleysoftware.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

>>> The line discipline is always notified of line rate changes
>>> via the set_termios() method, so if you add that to the hci_ldisc,
>>> you'll be able to keep the BT device in sync with your
>>> vendor-specific commands.
>> If I'm not wrong, line discipline is notified after the tty termios change.
>> So, it's too late to send the  HCI change speed command.
>> Moreover, user space is not aware of the device behavior, the driver should
>> be the only one to manage the device and its serial link.
>> Here, user space is just a bootstrap which hands over to the driver.
> 
> You realize that you're telling me that userspace is unaware of
> this in a thread that begins with a proposed userspace ioctl change to
> the line discipline? An ioctl change that adds a new ioctl to set the
> speed in a line discipline? For which there are already lots of ioctls
> to set the line speed?

actually the problem is a little bit different here. Every Bluetooth UART chip has its default baudrate. Mostly that is 115k, but some actually have others.

The general idea was that userspace deals with opening the TTY, send the HCI commands to change the rate, then change the termios setting, attach the ldisc and then hand it to the kernel.

This is however not how at least two major Bluetooth controllers work when you have to do firmware loading. When they boot into the firmware, then baudrate falls back to default and you have to do that all over again.

So what this ioctl will just tell the kernel about is the desired baudrate that it wants to be set whenever possible. The whenever possible is important here since depending on the manufacturer that might be a total different times. And with firmware download procedures being fully vendor specific this will vary.

> Setting aside the problem with the firmware load, I see no reason why
> this can't be done within the existing line discipline framework.

So far everything has been done in hciattach tool. And it is so ugly and does not even work properly for any complex UART protocols like BCSP or 3-Wire. There is a patch for a modified 3-Wire setup from one vendor that made my eyes bleed. So what you really want is having the kernel take control over HCI from the beginning. Otherwise this goes out of control and handling exceptions like hardware error event becomes impossible.

In summary what we have to do these days is this:

- Send Reset
- Send a few basic HCI commands
- Send baud rate change command
- Change actual baud rate on the TTY
- Download firmware
- Send Reset to boot the firmware
- Change actual baud rate back to default
- Send baud rate change command
- Change actual baud rate
- Send Reset
- Standard init sequence

Now tell me how the line discipline framework helps us here? Keep in mind you have to tell the controller via HCI commands over the old baud rate to change its rate. And then change it on the TTY to match what the controller does on its side.

Regards

Marcel

