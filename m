Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Apr 2015 09:26:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Make struct hci_uart_proto always
 const
Message-ID: <20150405062656.GG11977@t440s.P-661HNU-F1>
References: <1428210703-2808-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428210703-2808-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Apr 04, 2015, Marcel Holtmann wrote:
> The usage of struct hci_uart_proto should always be const. Change the
> function headers and individual protocol drivers.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ath.c   |  2 +-
>  drivers/bluetooth/hci_bcsp.c  |  2 +-
>  drivers/bluetooth/hci_h4.c    |  2 +-
>  drivers/bluetooth/hci_h5.c    |  2 +-
>  drivers/bluetooth/hci_ldisc.c | 10 +++++-----
>  drivers/bluetooth/hci_ll.c    |  2 +-
>  drivers/bluetooth/hci_uart.h  |  6 +++---
>  7 files changed, 13 insertions(+), 13 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
