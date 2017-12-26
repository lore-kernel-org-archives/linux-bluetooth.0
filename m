Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/2] Revert "Bluetooth: btusb: fix QCA Rome
 suspend/resume"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171220110008.11856-1-kai.heng.feng@canonical.com>
Date: Tue, 26 Dec 2017 22:00:22 +0100
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Daniel Drake <drake@endlessm.com>
Message-Id: <B5AD6AAA-970B-468B-8897-E2B161F5AFED@holtmann.org>
References: <20171220110008.11856-1-kai.heng.feng@canonical.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kai-Heng,

> This reverts commit fd865802c66bc451dc515ed89360f84376ce1a56.
> 
> This commit causes a regression on some QCA ROME chips. The USB device
> reset happens in btusb_open(), hence firmware loading gets interrupted.
> 
> Furthermore, this commit stops working after commit
> ("a0085f2510e8976614ad8f766b209448b385492f Bluetooth: btusb: driver to
> enable the usb-wakeup feature"). Reset-resume quirk only gets enabled in
> btusb_suspend() when it's not a wakeup source.
> 
> If we really want to reset the USB device, we need to do it before
> btusb_open(). Let's handle it in drivers/usb/core/quirks.c.
> 
> Cc: stable@vger.kernel.org
> Cc: Leif Liddy <leif.linux@gmail.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> ---
> 
> Daniel, Cc you because this also affects your original quirk patch for
> Realtek btusb.
> 
> drivers/bluetooth/btusb.c | 6 ------
> 1 file changed, 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
