Return-Path: <cyrus@holtmann.org>
Message-ID: <551EB5A1.9040409@hurleysoftware.com>
Date: Fri, 03 Apr 2015 11:45:37 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Loic Poulain <loic.poulain@intel.com>,
	Frederic Danis <frederic.danis@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
	jslaby@suse.cz
Subject: Re: [RFC 3/5] Bluetooth: hci_uart: Add HCIUARTSETBAUDRATE ioctl
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com> <1427985456-31536-4-git-send-email-frederic.danis@linux.intel.com> <551E717A.6040500@hurleysoftware.com> <551E8C6A.8040009@linux.intel.com> <551E9987.9050800@hurleysoftware.com> <551EA13B.7010307@intel.com>
In-Reply-To: <551EA13B.7010307@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

On 04/03/2015 10:18 AM, Loic Poulain wrote:
> Hi Peter,
> 
> On 03/04/2015 15:45, Peter Hurley wrote:
>> The line discipline is always notified of line rate changes
>> via the set_termios() method, so if you add that to the hci_ldisc,
>> you'll be able to keep the BT device in sync with your
>> vendor-specific commands.
> If I'm not wrong, line discipline is notified after the tty termios change.
> So, it's too late to send the  HCI change speed command.
> Moreover, user space is not aware of the device behavior, the driver should
> be the only one to manage the device and its serial link.
> Here, user space is just a bootstrap which hands over to the driver.

You realize that you're telling me that userspace is unaware of
this in a thread that begins with a proposed userspace ioctl change to
the line discipline? An ioctl change that adds a new ioctl to set the
speed in a line discipline? For which there are already lots of ioctls
to set the line speed?

Setting aside the problem with the firmware load, I see no reason why
this can't be done within the existing line discipline framework.

Regards,
Peter Hurley

