Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Apr 2014 14:27:29 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Revert "Bluetooth: Enable autosuspend for Intel
 Bluetooth device"
Message-ID: <20140423172729.GA7832@joana>
References: <1398200656-55480-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398200656-55480-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2014-04-22 Marcel Holtmann <marcel@holtmann.org>:

> This reverts commit d2bee8fb6e18f6116aada39851918473761f7ab1.
> 
> Enabling autosuspend for Intel Bluetooth devices has been shown to not
> work reliable. It does work for some people with certain combinations
> of USB host controllers, but for others it puts the device to sleep and
> it will not wake up for any event.
> 
> These events can be important ones like HCI Inquiry Complete or HCI
> Connection Request. The events will arrive as soon as you poke the
> device with a new command, but that is not something we can do in
> these cases.
> 
> Initially there were patches to the xHCI USB controller that fixed
> this for some people, but not for all. This could be well a problem
> somewhere in the USB subsystem or in the USB host controllers or
> just plain a hardware issue somewhere. At this moment we just do
> not know and the only safe action is to revert this patch.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Cc: Tedd Ho-Jeong An <tedd.an@intel.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/bluetooth/btusb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
