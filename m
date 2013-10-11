Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Oct 2013 15:38:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add hdev parameter to hdev->send driver
 callback
Message-ID: <20131011133804.GA19246@x220.p-661hnu-f1>
References: <1381497558-6315-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381497558-6315-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 11, 2013, Marcel Holtmann wrote:
> Instead of masking hdev inside the skb->dev parameter, hand it
> directly to the driver as a parameter to hdev->send. This makes
> the driver interface more clear and simpler.
> 
> This patch fixes all drivers to accept and handle the new parameter
> of hdev->send callback. Special care has been taken for bpa10x
> and btusb drivers that require having skb->dev set to hdev for
> the URB transmit complete handlers.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/bfusb.c        | 3 +--
>  drivers/bluetooth/bluecard_cs.c  | 3 +--
>  drivers/bluetooth/bpa10x.c       | 5 +++--
>  drivers/bluetooth/bt3c_cs.c      | 3 +--
>  drivers/bluetooth/btmrvl_main.c  | 4 +---
>  drivers/bluetooth/btsdio.c       | 3 +--
>  drivers/bluetooth/btuart_cs.c    | 3 +--
>  drivers/bluetooth/btusb.c        | 5 +++--
>  drivers/bluetooth/btwilink.c     | 5 +----
>  drivers/bluetooth/dtl1_cs.c      | 3 +--
>  drivers/bluetooth/hci_ldisc.c    | 3 +--
>  drivers/bluetooth/hci_ll.c       | 1 -
>  drivers/bluetooth/hci_vhci.c     | 3 +--
>  include/net/bluetooth/hci_core.h | 2 +-
>  net/bluetooth/hci_core.c         | 4 +---
>  15 files changed, 18 insertions(+), 32 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
