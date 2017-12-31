Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] usb: quirks: Add reset-resume quirk for QCA6174 Rome
 Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171231171335.12020-1-leif.linux@gmail.com>
Date: Sun, 31 Dec 2017 21:09:34 +0100
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, kai.heng.feng@canonical.com,
        stable@vger.kernel.org, mka@chromium.org, briannorris@chromium.org,
        drake@endlessm.com
Message-Id: <EE575DB4-6097-4FED-84AA-25E6EA1DEA03@holtmann.org>
References: <20171231171335.12020-1-leif.linux@gmail.com>
To: Leif Liddy <leif.linux@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Leif,

> This is a rework of reverted commit fd865802c66bc451dc515ed89360f84376ce1a56
> The issue is that some QCA Rome bluetooth controllers stop functioning upon resume from suspend.
> These devices seem to be losing power during suspend. This patch will enable
> reset_resume in usb core (instead of btusb) and will target the specific device 0x0cf3:0xe300
> 
> Signed-off-by: Leif Liddy <leif.linux@gmail.com>
> ---
> drivers/usb/core/quirks.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

