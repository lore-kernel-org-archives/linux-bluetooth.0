Return-Path: <cyrus@holtmann.org>
Message-ID: <1358186456.1806.96.camel@aeonflux>
Subject: Re: [PATCH v2] Bluetooth: Power the device up after a rfkill unblock
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 14 Jan 2013 10:00:56 -0800
In-Reply-To: <1358173227-5384-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1358173227-5384-1-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> With the HCI_SETUP patches, this is all that is needed to make the
> case when a adapter is added with Bluetooth blocked in rfkill to work.
> 
> When rfkill is unblocked, the device will be powered on if the device
> is in HCI_SETUP state, meaning that it was never properly initialized.
> If the device is not used by userspace, the HCI_AUTO_OFF flag will
> take care of powering it off.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
> 
> Samuel on IRC caused me to remember this. Thanks :-)
> 
> 
>  net/bluetooth/hci_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 596660d..9796c0a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1124,8 +1124,11 @@ static int hci_rfkill_set_block(void *data, bool blocked)
>  
>  	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
>  
> -	if (!blocked)
> +	if (!blocked) {
> +		if (test_bit(HCI_SETUP, &hdev->dev_flags))
> +			schedule_work(&hdev->power_on);
>  		return 0;
> +	}
>  
>  	hci_dev_do_close(hdev);
>  

is this really the behavior that we want. Even if rfkill block all
Bluetooth is set, we should run the adapter initialization. That is not
triggering any RF. Sending the initial HCI_Reset is actually even more
important to ensure the adapter is really reset and has not some left
over state.

So I think what should be done is run the HCI_SETUP phase, but then
refuse to allow bringing up the controller.

Regards

Marcel


