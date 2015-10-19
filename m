Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Oct 2015 14:33:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btbcm: Read USB product information for Apple
 devices
Message-ID: <20151019113322.GB16940@t440s.lan>
References: <1445201308-127022-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445201308-127022-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 18, 2015, Marcel Holtmann wrote:
> For the Apple Bluetooth devices, read the USB product information and
> print them. This allows for easy mapping of chip and USB details.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btbcm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
