Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 29 Jul 2017 08:32:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-kernel@vger.kernel.org, Miao-chen Chou <mcchou@chromium.org>,
        Waldemar Rymarkiewicz <ext.waldemar.rymarkiewicz@tieto.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: add ID for LiteOn 04ca:3016
Message-ID: <20170729053245.GA10912@x1c.home>
References: <20170728231623.25232-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170728231623.25232-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Fri, Jul 28, 2017, Brian Norris wrote:
> Contains a QCA6174A-5 chipset, with USB BT. Let's support loading
> firmware on it.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)

Could you also include the relevant usb-devices output for this device
in the commit message? We've followed that convention for all new USB
IDs added to btusb.

Johan
