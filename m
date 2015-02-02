Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Feb 2015 10:18:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Set HCI_QUIRK_STRICT_DUPLICATE_FILTER for
 BTUSB_INTEL_NEW
Message-ID: <20150202081820.GA24390@t440s.lan>
References: <1422863838-32388-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422863838-32388-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Feb 01, 2015, Marcel Holtmann wrote:
> The Intel Snowfield Peak Bluetooth controllers use a strict scanning
> filter policy that filters based on Bluetooth device addresses and
> not on RSSI.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to bluetooth-next. Thanks.

Johan
