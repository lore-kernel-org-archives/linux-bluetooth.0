Return-Path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 15 Nov 2017 15:23:20 +0100
From: Johan Hovold <johan@kernel.org>
To: abhijeet.kumar@intel.com
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluettoth: btusb: Prevent USB devices to autosuspend
 while setting interface
Message-ID: <20171115142320.GE11226@localhost>
References: <1510747888-13912-1-git-send-email-abhijeet.kumar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510747888-13912-1-git-send-email-abhijeet.kumar@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Nov 15, 2017 at 05:41:28PM +0530, abhijeet.kumar@intel.com wrote:
> From: Abhijeet Kumar <abhijeet.kumar@intel.com>
> 
> Runtime resume USB device in order to ensure that PM framework knows
> that the we might be using the device in a short time and doesn't
> autosuspend the device while we update it's interface.
> 
> Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
> ---
>  drivers/bluetooth/btusb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7a5c06aaa181..588aabf991be 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1444,6 +1444,12 @@ static void btusb_work(struct work_struct *work)
>  			data->sco_skb = NULL;
>  			spin_unlock_irqrestore(&data->rxlock, flags);
>  
> +			 /*
> +			  *Letting runtime PM know that we wish to use
> +			  *the device in a short time.
> +			  */
> +			  pm_runtime_get(&data->udev->dev);
> +

This is broken. Where is the corresponding put? And why would you need
this at all, given that the interface is resumed at the start of this
branch?

>  			if (__set_isoc_interface(hdev, new_alts) < 0)
>  				return;
>  		}

Johan
