Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Jul 2014 08:46:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use BTUSB_BROKEN_ISOC flag for CSR USB
 sniffer devices
Message-ID: <20140707054603.GA14327@t440s.P-661HNU-F1>
References: <1404684724-21367-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404684724-21367-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jul 07, 2014, Marcel Holtmann wrote:
> Instead of setting data->isoc manually, use BTUSB_BROKEN_ISOC to
> indicate that isochronous endpoints are not needed for CSR USB
> sniffer devices.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
