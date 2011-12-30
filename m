Return-Path: <cyrus@holtmann.org>
Message-ID: <1325272635.1965.297.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooh: Fix hci_cc_read_local_ext_features()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <aguedespe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Date: Fri, 30 Dec 2011 11:17:15 -0800
In-Reply-To: <1325252044-21134-2-git-send-email-aguedespe@gmail.com>
References: <1325252044-21134-1-git-send-email-aguedespe@gmail.com>
	 <1325252044-21134-2-git-send-email-aguedespe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Copy the Features value according to the Page number.
> 
> Signed-off-by: Andre Guedes <aguedespe@gmail.com>
> ---
>  net/bluetooth/hci_event.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 37c31c5..10152d2 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -711,7 +711,14 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
>  	if (rp->status)
>  		return;
>  
> -	memcpy(hdev->host_features, rp->features, 8);
> +	switch (rp->page) {
> +	case 0:
> +		memcpy(hdev->features, rp->features, 8);
> +		break;
> +	case 1:
> +		memcpy(hdev->host_features, rp->features, 8);
> +		break;
> +	}
>  
>  	hci_req_complete(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, rp->status);
>  }

I was fine with just handling page 1 properly since we do not use
read_local_ext_features for page 0 in the first place. However this is
also fine with me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


