Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Mar 2014 13:42:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 04/10] emulator: Add handling inquiry number of
 responses
Message-ID: <20140312114203.GD7489@localhost.P-661HNU-F1>
References: <1394406363-6751-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1394406363-6751-5-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394406363-6751-5-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Mar 10, 2014, Lukasz Rymanowski wrote:
> @@ -769,17 +772,22 @@ static bool inquiry_callback(void *user_data)
>  		}
>  	}
>  
> -	if (i == MAX_BTDEV_ENTRIES) {
> -		struct bt_hci_evt_inquiry_complete ic;
> -
> -		ic.status = BT_HCI_ERR_SUCCESS;
> -		send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
> +	/* Check if we sent already required amount of responses*/
> +	if (data->num_resp && data->sent_count == data->num_resp)
> +		goto finish;
>  
> -		btdev->inquiry_id = 0;
> -		return false;
> -	}
> +	if (i == MAX_BTDEV_ENTRIES)
> +		goto finish;
>  
>  	return true;
> +
> +finish:
> +	/* Note that destroy will be called */
> +	ic.status = BT_HCI_ERR_SUCCESS;
> +	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
> +
> +	btdev->inquiry_id = 0;
> +	return false;
>  }

I know you're just moving it around from the first patch but isn't the
btdev->inquiry_id = unnecessary here since you're doing the same in the
destroy function which gets called as soon as you return false?

Johan
