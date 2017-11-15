Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] Bluettoth: btusb: Prevent USB devices to autosuspend
 while setting interface
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1510747888-13912-1-git-send-email-abhijeet.kumar@intel.com>
Date: Wed, 15 Nov 2017 14:54:45 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <395C47EC-9D79-451D-B774-9F6D6555F100@holtmann.org>
References: <1510747888-13912-1-git-send-email-abhijeet.kumar@intel.com>
To: abhijeet.kumar@intel.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Abhijeet,

> Runtime resume USB device in order to ensure that PM framework knows
> that the we might be using the device in a short time and doesn't
> autosuspend the device while we update it's interface.
> 
> Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
> ---
> drivers/bluetooth/btusb.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7a5c06aaa181..588aabf991be 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1444,6 +1444,12 @@ static void btusb_work(struct work_struct *work)
> 			data->sco_skb = NULL;
> 			spin_unlock_irqrestore(&data->rxlock, flags);
> 
> +			 /*
> +			  *Letting runtime PM know that we wish to use
> +			  *the device in a short time.
> +			  */
> +			  pm_runtime_get(&data->udev->dev);
> +

the indentation is wrong here and the comment coding style if off. Please fix.

Regards

Marcel
