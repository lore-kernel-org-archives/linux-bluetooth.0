Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Aug 2015 12:58:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth:Fix error handling in the function
 hci_inquiry_cache_update
Message-ID: <20150824095801.GC6958@t440s.lan>
References: <1440002190-24683-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440002190-24683-1-git-send-email-xerofoify@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nicholas,

(again unneeded recipients removed from CC)

On Wed, Aug 19, 2015, Nicholas Krause wrote:
> This fixes error handling in the function hci_inquiry_cache_update
> for checking if the call to the function hci_remove_oob_data has
> failed by returning the error code -ENOENT and if so exit immediately
> to the caller of the function hci_inquiry_cache_update by returning
> the error code -ENOENT to signal that the call to this function has
> failed.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  net/bluetooth/hci_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 2f8fb33..ae1bb3d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1136,7 +1136,8 @@ u32 hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
>  
>  	BT_DBG("cache %p, %pMR", cache, &data->bdaddr);
>  
> -	hci_remove_remote_oob_data(hdev, &data->bdaddr, BDADDR_BREDR);
> +	if (hci_remove_remote_oob_data(hdev, &data->bdaddr, BDADDR_BREDR))
> +		return -ENOENT;
>  
>  	if (!data->ssp_mode)
>  		flags |= MGMT_DEV_FOUND_LEGACY_PAIRING;

This patch is wrong for several reasons. Firstly, this function returns
returns u32 so trying to return -ENOENT makes no sense. Secondly, it's
normal for hci_remove_remote_oob_data() to fail in this scenario so we
can safely ignore its return value.

Johan
