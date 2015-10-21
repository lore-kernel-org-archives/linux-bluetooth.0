Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Oct 2015 07:30:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Provide initial manufacturer
 information
Message-ID: <20151021043047.GA12268@t440s.P-661HNU-F1>
References: <1445369445-83359-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445369445-83359-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 20, 2015, Marcel Holtmann wrote:
> Provide an early indication about the manufacturer information so that
> it can be forwarded into monitor channel.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ath.c   | 1 +
>  drivers/bluetooth/hci_bcm.c   | 1 +
>  drivers/bluetooth/hci_intel.c | 1 +
>  drivers/bluetooth/hci_ldisc.c | 7 +++++++
>  drivers/bluetooth/hci_qca.c   | 1 +
>  drivers/bluetooth/hci_uart.h  | 1 +
>  6 files changed, 12 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
