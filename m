Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Jul 2014 10:34:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Support HCI_QUIRK_RAW_DEVICE for hci_vhci
 driver
Message-ID: <20140703073445.GB3275@t440s.lan>
References: <1404344110-4468-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404344110-4468-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jul 03, 2014, Marcel Holtmann wrote:
> This adds support for configuring the hci_vhci virtual controllers
> as a raw-only device using HCI_QUIRK_RAW_DEVICE. This is useful for
> testing the kernel internal infrastructure.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_vhci.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
