Return-Path: <cyrus@holtmann.org>
Message-ID: <1329841303.2049.29.camel@aeonflux>
Subject: Re: [PATCH 6/9] Bluetooth: mgmt: Fix New Settings event for
 connectable/discoverable
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 21 Feb 2012 17:21:43 +0100
In-Reply-To: <1329840005-4977-6-git-send-email-johan.hedberg@gmail.com>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
	 <1329840005-4977-6-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When powered off and doing changes to the Connectable or Discoverable
> setting we should also send an appropriate New Settings event in
> addition to the command response.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   41 ++++++++++++++++++++++++++++++++++-------
>  1 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 74b6db1..96386ff 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -862,12 +862,26 @@ static int set_discoverable(struct sock *sk, u16 index, void *data, u16 len)
>  	}
>  
>  	if (!hdev_is_powered(hdev)) {
> +		bool changed = false;
> +
>  		if (cp->val) {
> +			if (!test_and_set_bit(HCI_DISCOVERABLE,
> +							&hdev->dev_flags))
> +				changed = true;
>  			set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
> -			set_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
> -		} else
> -			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
> +		} else {
> +			if (test_and_clear_bit(HCI_DISCOVERABLE,
> +							&hdev->dev_flags))
> +				changed = true;
> +		}
> +

does it really need to be this complicated? If we remove the set_bit for
CONNECTABLE, then we can just send this one out. Since we know that
something changed.

>  		err = send_settings_rsp(sk, MGMT_OP_SET_DISCOVERABLE, hdev);
> +		if (err < 0)
> +			goto failed;
> +
> +		if (changed)
> +			err = new_settings(hdev, sk);
> +
>  		goto failed;
>  	}
>  
> @@ -925,13 +939,26 @@ static int set_connectable(struct sock *sk, u16 index, void *data, u16 len)
>  	hci_dev_lock(hdev);
>  
>  	if (!hdev_is_powered(hdev)) {
> -		if (cp->val)
> -			set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
> -		else {
> -			clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
> +		bool changed = false;
> +
> +		if (cp->val) {
> +			if (!test_and_set_bit(HCI_CONNECTABLE,
> +							&hdev->dev_flags))
> +				changed = true;
> +		} else {
> +			if (test_and_clear_bit(HCI_CONNECTABLE,
> +							&hdev->dev_flags))
> +				changed = true;
>  			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
>  		}
> +

Same here. Even with the clearing of DISCOVERABLE, we should just send
the new settings. event.

>  		err = send_settings_rsp(sk, MGMT_OP_SET_CONNECTABLE, hdev);
> +		if (err < 0)
> +			goto failed;
> +
> +		if (changed)
> +			err = new_settings(hdev, sk);
> +
>  		goto failed;
>  	}
>  

Regards

Marcel


