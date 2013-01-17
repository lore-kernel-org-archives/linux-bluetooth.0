Return-Path: <cyrus@holtmann.org>
Message-ID: <1358400095.3059.7.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix Class of Device indication when powering
 off
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 16 Jan 2013 21:21:35 -0800
In-Reply-To: <1358345734-17892-1-git-send-email-johan.hedberg@gmail.com>
References: <1358345734-17892-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When a HCI device is powered off the Management interface specification
> dictates that the class of device value is indicated as zero. This patch
> fixes sending of the appropriate class of device changed event when a
> HCI device is powered off.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index fc171f2..54f3ddba 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2987,7 +2987,13 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
>  		}
>  	} else {
>  		u8 status = MGMT_STATUS_NOT_POWERED;
> +		u8 zero_cod[] = { 0, 0, 0 };
> +
>  		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
> +
> +		if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0)

shouldn't we better use if (memcmp( ...)) here.

> +			mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
> +				   zero_cod, sizeof(zero_cod), NULL);
>  	}

Otherwise this is fine with me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


