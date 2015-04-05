Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Apr 2015 09:28:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: hci_uart: Add name information to
 hci_uart_proto struct
Message-ID: <20150405062819.GH11977@t440s.P-661HNU-F1>
References: <1428211655-15217-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428211655-15217-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Apr 04, 2015, Marcel Holtmann wrote:
> This adds an extra name field to the hci_uart_proto struct that provides
> a simple way of adding a string identifier to the protocol.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ath.c  | 15 ++++++++-------
>  drivers/bluetooth/hci_bcsp.c |  1 +
>  drivers/bluetooth/hci_h4.c   |  1 +
>  drivers/bluetooth/hci_h5.c   |  1 +
>  drivers/bluetooth/hci_ll.c   |  1 +
>  drivers/bluetooth/hci_uart.h |  1 +
>  6 files changed, 13 insertions(+), 7 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
