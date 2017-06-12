Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btbcm: Read controller features during configuration
Date: Mon, 12 Jun 2017 11:49:07 +0200
Message-ID: <3850709.UsqOsZgzJe@ix>
In-Reply-To: <20170610123229.41513-1-marcel@holtmann.org>
References: <20170610123229.41513-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Saturday, 10 June 2017 14:32:29 CEST Marcel Holtmann wrote:
> Read the Broadcom specific controller features during configuration and
> print them for informational purposes.
> 
> < HCI Command: Broadcom Read Controller Features (0x3f|0x006e) plen 0
> 
> > HCI Event: Command Complete (0x0e) plen 12
> 
>       Broadcom Read Controller Features (0x3f|0x006e) ncmd 1
>         Status: Success (0x00)
>         Features: 0x07 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>           Multi-AV transport bandwidth reducer
>           WBS SBC
>           FW LC-PLC
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btbcm.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index ba3dd2eafc09..24f8c4e93f4e 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -246,6 +246,27 @@ static struct sk_buff *btbcm_read_verbose_config(struct
> hci_dev *hdev) return skb;
>  }
> 
> +static struct sk_buff *btbcm_read_controller_features(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc6e, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s: BCM: Read controller features failed (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		return skb;
> +	}
> +
> +	if (skb->len != 9) {
> +		BT_ERR("%s: BCM: Controller features length mismatch",
> +		       hdev->name);
> +		kfree_skb(skb);
> +		return ERR_PTR(-EIO);
> +	}
> +
> +	return skb;
> +}
> +
>  static struct sk_buff *btbcm_read_usb_product(struct hci_dev *hdev)
>  {
>  	struct sk_buff *skb;
> @@ -417,6 +438,14 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
>  	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
>  	kfree_skb(skb);
> 
> +	/* Read Controller Features */
> +	skb = btbcm_read_controller_features(hdev);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +	BT_INFO("%s: BCM: features 0x%2.2x", hdev->name, skb->data[1]);
> +	kfree_skb(skb);
> +
>  	/* Read Local Name */
>  	skb = btbcm_read_local_name(hdev);
>  	if (IS_ERR(skb))
> @@ -540,6 +569,13 @@ int btbcm_setup_apple(struct hci_dev *hdev)
>  		kfree_skb(skb);
>  	}
> 
> +	/* Read Controller Features */
> +	skb = btbcm_read_controller_features(hdev);
> +	if (!IS_ERR(skb)) {
> +		BT_INFO("%s: BCM: features 0x%2.2x", hdev->name, skb->data[1]);
> +		kfree_skb(skb);
> +	}
> +
>  	/* Read Local Name */
>  	skb = btbcm_read_local_name(hdev);
>  	if (!IS_ERR(skb)) {

Applied to bluetooth-next tree. Thanks.

-- 
pozdrawiam
Szymon Janc
