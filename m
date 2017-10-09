Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Bluetooth: hci_bcm: Correct context of IRQ polarity
 message
To: Ian W MORRISON <ianwmorrison@gmail.com>, marcel@holtmann.org,
 gustavo@padovan.org, johan.hedberg@gmail.com,
 "bluez mailin list (linux-bluetooth@vger.kernel.org)"
 <linux-bluetooth@vger.kernel.org>
Cc: frederic.danis.oss@gmail.com
References: <b54325b3-280f-4fc0-b340-8e4b850af603@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <027aed47-7476-04e9-20a6-b5fef7b00ab9@redhat.com>
Date: Mon, 9 Oct 2017 15:52:11 +0200
MIME-Version: 1.0
In-Reply-To: <b54325b3-280f-4fc0-b340-8e4b850af603@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 07-10-17 08:16, Ian W MORRISON wrote:
> As the overwriting of IRQ polarity to active low occurs during the driver probe using 'bt_dev_warn' to display the warning results in '(null)' being displayed for the device. This patch uses 'dev_warn' to correctly display the device in the warning instead.
> 
> Signed-off-by: ianwmorrison <ianwmorrison@gmail.com>
> ---
> v2: Uses 'dev_warn' (Suggested-by: Marcel Holtmann <marcel@holtmann.org>)
> 
> Testing shows the following improvements using an extract from dmesg of the affected message:
> 
> Without patch:
> [    5.512175] Bluetooth: (null): MINIX Z83-4: Overwriting IRQ polarity to active low
> 
> v1 (superseded) patch:
> [    5.592238] Bluetooth: MINIX Z83-4: Overwriting IRQ polarity to active low
> 
> v2 patch (with a kernel excluding serdev ACPI support patches):
> [    6.112265] hci_bcm BCM2EA4:00: MINIX Z83-4: Overwriting IRQ polarity to active low
> 
> v2 patch (with a kernel including serdev ACPI support patches):
> [    6.367829] hci_uart_bcm serial1-0: MINIX Z83-4: Overwriting IRQ polarity to active low
> ---

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



>   drivers/bluetooth/hci_bcm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 77326eeb6146..16c2eaaaf72b 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -839,7 +839,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>   
>   	dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
>   	if (dmi_id) {
> -		bt_dev_warn(dev, "%s: Overwriting IRQ polarity to active low",
> +		dev_warn(dev->dev, "%s: Overwriting IRQ polarity to active low",
>   			    dmi_id->ident);
>   		dev->irq_active_low = true;
>   	}
> 
