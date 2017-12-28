Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 2/2] usb: quirks: Add reset-resume quirk for Dell DW1820
 QCA Rome Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171220110008.11856-2-kai.heng.feng@canonical.com>
Date: Thu, 28 Dec 2017 21:15:43 +0100
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Daniel Drake <drake@endlessm.com>
Message-Id: <446583FE-6E63-47A0-921B-6FF2EC9C452C@holtmann.org>
References: <20171220110008.11856-1-kai.heng.feng@canonical.com>
 <20171220110008.11856-2-kai.heng.feng@canonical.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kai-Heng,

> Commit ("fd865802c66bc451dc515ed89360f84376ce1a56 Bluetooth: btusb: fix
> QCA Rome suspend/resume") enables reset_resume in btusb_probe(). This
> makes the device resets during btusb_open(), firmware loading gets
> interrupted as a result.
> 
> We still want to reset the device to solve the original issue, but we
> should do it before btusb_open().
> 
> Hence, add reset-resume quirk in usb core intead of btusb.
> 
> Cc: stable@vger.kernel.org
> Cc: Leif Liddy <leif.linux@gmail.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> ---
> drivers/usb/core/quirks.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel
