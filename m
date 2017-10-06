Return-Path: <frederic.danis.oss@gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Correct context of IRQ polarity
 message
To: Ian W MORRISON <ianwmorrison@gmail.com>, marcel@holtmann.org,
 gustavo@padovan.org, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Cc: hdegoede@redhat.com
References: <d9ad3bdc-2f94-b3b1-1ec1-786999c1e529@gmail.com>
From: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>
Message-ID: <2600bbf4-e5fb-312f-0e29-5b17746844b5@gmail.com>
Date: Fri, 6 Oct 2017 20:15:36 +0200
MIME-Version: 1.0
In-Reply-To: <d9ad3bdc-2f94-b3b1-1ec1-786999c1e529@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

Le 06/10/2017 à 09:34, Ian W MORRISON a écrit :
> As the overwriting of IRQ polarity to active low occurs during the driver
> probe using 'bt_dev_warn' to display the warning results in '(null)'
> being displayed for the device. This patch uses the underlying 'BT_INFO'
> to directly display the warning instead.
>
> Signed-off-by: ianwmorrison <ianwmorrison@gmail.com>
> ---
>   drivers/bluetooth/hci_bcm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 77326eeb6146..17c036599407 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -839,7 +839,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>   
>   	dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
>   	if (dmi_id) {
> -		bt_dev_warn(dev, "%s: Overwriting IRQ polarity to active low",
> +		BT_INFO("%s: Overwriting IRQ polarity to active low",
>   			    dmi_id->ident);
>   		dev->irq_active_low = true;
>   	}

We can also set the device name before calling bcm_acpi_probe(), i.e. 
moving "dev->name = dev_name(dev->dev);" from bcm_get_resources() to 
bcm_probe() and bcm_serdev_probe().

Regards,

Fred
