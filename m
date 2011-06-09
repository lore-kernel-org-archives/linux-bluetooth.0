Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jun 2011 13:30:21 +0900
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Corrected udev rule for Logitech devices
Message-ID: <20110609043021.GA28914@dell.ccr.corp.intel.com>
References: <1307134383.2622.89.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307134383.2622.89.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Fri, Jun 03, 2011, Peter Hurley wrote:
> The *real* history of this file is a nightmare. Now that it's
> back in the bluez project, fix the problems that were added
> while it was in udev.
> 
> 1) Only hiddev* devices provide the ioctl interface hid2hci uses
> to switch from HID->HCI for --method=logitech-hid.  (inquiring
> minds can look in the kernel git tree at drivers/hid/usbhid/hiddev.c)
> 2) hidraw* devices don't belong to subsystem=usb (they are
> subsystem=hidraw).  This means that the udev rule that matched based on
> hidraw* would never have been run anyway because of the early-out
> subsystem!=usb on line 4.
> 
> This fix is going to cause major regressions in distros because there
> is currently no way provided by bluez to *NOT* run hid2hci.
> 
> Many, many users (and maintainers) mistakenly believe that because
> the keyboard and mouse works when the vid/pid of their device is matched
> by the hidraw* rule, that "bluetooth" must be working. Of course, what's
> really happening is the keyboard and mouse are working as HID input
> devices instead.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  scripts/bluetooth-hid2hci.rules |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

Applied (without the signed-off-by line since we don't use that).
Thanks!

Johan
