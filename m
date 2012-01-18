Return-Path: <cyrus@holtmann.org>
Message-ID: <1326914334.6454.410.camel@aeonflux>
Subject: Re: [PATCH 14/15] Bluetooth: Rename hdev->flags to
 hdev->compat_flags
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Jan 2012 20:18:54 +0100
In-Reply-To: <1326912717-6347-15-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	 <1326912717-6347-15-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> These flags mostly exist for legacy reasons and no new flags should be
> added to this set, so compat_flags is a better name.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  drivers/bluetooth/bfusb.c        |   12 +++---
>  drivers/bluetooth/bpa10x.c       |   12 +++---
>  drivers/bluetooth/btmrvl_main.c  |    9 +++--
>  drivers/bluetooth/btusb.c        |   20 +++++-----
>  drivers/bluetooth/hci_ldisc.c    |    6 ++--
>  drivers/bluetooth/hci_vhci.c     |    6 ++--
>  include/net/bluetooth/hci.h      |    7 +---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_conn.c         |    7 ++--
>  net/bluetooth/hci_core.c         |   71 +++++++++++++++++++------------------
>  net/bluetooth/hci_event.c        |   43 ++++++++++++-----------
>  net/bluetooth/hci_sock.c         |    8 ++--
>  net/bluetooth/mgmt.c             |   38 ++++++++++----------
>  13 files changed, 121 insertions(+), 120 deletions(-)
> 
> diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> index e97f42a..8f77290 100644
> --- a/drivers/bluetooth/bfusb.c
> +++ b/drivers/bluetooth/bfusb.c
> @@ -191,7 +191,7 @@ static void bfusb_tx_complete(struct urb *urb)
>  
>  	atomic_dec(&data->pending_tx);
>  
> -	if (!test_bit(HCI_RUNNING, &data->hdev->flags))
> +	if (!test_bit(HCI_RUNNING, &data->hdev->compat_flags))
>  		return;

I do not like this change at all.

Can we just add a BT specific helper for setting/testing HCI_RUNNING and
hiding the fact of hdev->flags.

Regards

Marcel


