Return-Path: <cyrus@holtmann.org>
Message-ID: <1361053591.1583.9.camel@aeonflux>
Subject: Re: [RFC v2 1/8] Bluetooth: Setup LE scan with no timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 16 Feb 2013 23:26:31 +0100
In-Reply-To: <1360970828-24004-2-git-send-email-andre.guedes@openbossa.org>
References: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
	 <1360970828-24004-2-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch modifies hci_do_le_scan and hci_cancel_le_scan helpers so
> we are able to start and stop LE scan with no timeout. This feature
> will be used by the LE connection routine.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_core.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 22e77a7..3aa0345 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1618,26 +1618,27 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
>  	if (err < 0)
>  		return err;
>  
> -	queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
> -			   msecs_to_jiffies(timeout));
> +	if (timeout > 0)
> +		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
> +				   msecs_to_jiffies(timeout));
>  
>  	return 0;
>  }

I really do not like this magic handling of scan disable. Maybe you
better remove the timeout handling completely and put it into the
discovery functionality.

Doing it like this seems pretty much hacked together. It no longer looks
like the right place to do handle it.

Regards

Marcel


