Return-Path: <cyrus@holtmann.org>
Date: Sat, 12 Jul 2014 18:38:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix HCIUARTGETDEVICE ioctl when UART is not
 registered
Message-ID: <20140712153833.GA3127@t440s.P-661HNU-F1>
References: <1405177229-13849-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405177229-13849-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jul 12, 2014, Marcel Holtmann wrote:
> The protocol for the UART might be configured, but that does not
> mean the HCI device is registered. Return an error in that case
> and only return the index number when HCI_UART_REGISTERED is set.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ldisc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
