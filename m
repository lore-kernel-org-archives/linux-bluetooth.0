Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH] Bluetooth: btusb: Fix atheros firmware download error
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD571NjHoR-i48hTNcXLam0FPPEmGNQbhkMB8Y+61_Vf9O+Jbg@mail.gmail.com>
Date: Thu, 6 Oct 2016 12:17:24 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CEF0FBB8-ADCB-4E0E-AC5A-BC83EF55E036@holtmann.org>
References: <CAD571NjHoR-i48hTNcXLam0FPPEmGNQbhkMB8Y+61_Vf9O+Jbg@mail.gmail.com>
To: Ethan Hsieh <ethan.hsieh@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ethan,

> Move usb_autopm_get_interface() ahead of setup_on_usb() to prevent device
> from sending usb control message in usb suspend mode.
> 
> The error message is as below:
> 
> [   83.944103] btusb 1-2:1.1: usb_suspend_interface: status 0
> [   83.944107] btusb 1-2:1.0: usb_suspend_interface: status 0
> [   83.960132] usb 1-2: usb auto-suspend, wakeup 0
> [   83.976156] usb 1-2: usb_suspend_device: status 0
> [   83.976162] usb 1-2: usb_suspend_both: status 0
> [  298.689106] Bluetooth: hci0
> [  298.689399] Bluetooth: hci0: Failed to access otp area (-113)
> 
> Signed-off-by: Ethan Hsieh <ethan.hsieh@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

the patch does not apply. Please send one that actually applies against bluetooth-next tree.

Regards

Marcel

