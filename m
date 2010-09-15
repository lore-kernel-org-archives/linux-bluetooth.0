Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Sep 2010 12:49:09 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: "ext johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Hedberg Johan (Nokia-MS/Helsinki)" <Johan.Hedberg@nokia.com>
Subject: Re: [PATCH] Bluetooth: Don't clear the blacklist when closing the
 HCI device
Message-ID: <20100915094909.GB14330@null>
References: <1284017559-13510-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284017559-13510-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 09, 2010 at 09:32:39AM +0200, ext johan.hedberg@gmail.com wrote:
> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> Clearing the blacklist in hci_dev_do_close() would mean that user space
> needs to do extra work to re-block devices after a DEVDOWN-DEVUP cycle.
> This patch removes the clearing of the blacklist in this case and
> thereby saves user space from the extra work.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>

Acked-by: Ville Tervo <ville.tervo@nokia.com>

> ---
>  net/bluetooth/hci_core.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index c52f091..bc2a052 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -562,7 +562,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
>  	hci_dev_lock_bh(hdev);
>  	inquiry_cache_flush(hdev);
>  	hci_conn_hash_flush(hdev);
> -	hci_blacklist_clear(hdev);
>  	hci_dev_unlock_bh(hdev);
>  
>  	hci_notify(hdev, HCI_DEV_DOWN);
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
