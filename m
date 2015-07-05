Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Jul 2015 17:07:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Bluetooth: btintel: Add generic function for
 handling hardware errors
Message-ID: <20150705140705.GA22814@t440s.P-661HNU-F1>
References: <1436099860-77732-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436099860-77732-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 05, 2015, Marcel Holtmann wrote:
> The handling of hardware error has support for providing a vendor
> specific callback to deal with the error. Move the Intel specific
> function out of the USB driver into the generic module so that it
> can also be utilized by the UART driver.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btintel.c | 34 ++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel.h |  5 +++++
>  2 files changed, 39 insertions(+)

All three patches have been applied to bluetooth-next. Thanks.

Johan
