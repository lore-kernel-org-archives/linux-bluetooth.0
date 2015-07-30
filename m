Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] Bluetooth: hciuart: Add to support QCA ROME
 configuration
To: Marcel Holtmann <marcel@holtmann.org>
References: <55B97ECE.7020307@qca.qualcomm.com>
 <DD3468DA-08F6-429B-AF85-9D7FC5BD3876@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
From: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Message-ID: <55BA9FBE.8080300@qca.qualcomm.com>
Date: Thu, 30 Jul 2015 15:05:50 -0700
MIME-Version: 1.0
In-Reply-To: <DD3468DA-08F6-429B-AF85-9D7FC5BD3876@holtmann.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 07/30/15 04:16, Marcel Holtmann wrote:
> +
> +#ifdef CONFIG_SERIAL_MSM_HS
> +#include <linux/platform_data/msm_serial_hs.h>
> +#endif
> I do not like platform data. Why can't this be done with device tree?

This is specific code for MSM UART HighSpeed code which is not upstreamed yet. The MSM device tree has already defined this config_serial_msm_hs. I'd like to move this part to btqca.c module since it is for vendor specific implementation.

>> +static int rome_set_baudrate(struct hci_dev *hdev, unsigned int speed)
>> +{
>> +    struct sk_buff *skb;
>> +    uint8_t baudrate;
>> +
>> +    if (speed > 3000000)
>> +        return -EINVAL;
>> +
>> +    BT_INFO("%s: Set controller UART speed to %d", hdev->name, speed);
>> +
>> +    baudrate = rome_get_baudrate(speed);
>> +    skb = __hci_cmd_sync(hdev, EDL_PATCH_BAUDRATE, 1, &baudrate,
>> +                 msecs_to_jiffies(100));
> Introduce proper constant defines for timeout or use HCI_INIT_TIMEOUT.
>
>> +    if (IS_ERR(skb)) {
>> +        if (PTR_ERR(skb) == -ETIMEDOUT)
>> +            return 0;
> Why return success when it times out?
>

QCA ROME doesn't return cc event after recieving baudrate command changed because it triggers HCI_RESET right away and set to new baudrate to communicate with host. Hence timeout can be handled as succeed case. If something goes wrong after changing baudrate, commands follow-ed won't be delivered to controller.

>> +
>> #define HCI_UART_H4    0
>> #define HCI_UART_BCSP    1
>> @@ -45,6 +45,7 @@
>> #define HCI_UART_ATH3K    5
>> #define HCI_UART_INTEL    6
>> #define HCI_UART_BCM    7
>> +#define HCI_UART_ROME     8
> Can we just name these HCI_UART_QCA instead. The ROME thing is a bit confusing since it is more a product name than a vendor name.
>
>> #define HCI_UART_RAW_DEVICE    0
>> #define HCI_UART_RESET_ON_INIT    1
>> @@ -176,3 +177,8 @@ int intel_deinit(void);
>> int bcm_init(void);
>> int bcm_deinit(void);
>> #endif
>> +
>> +#ifdef CONFIG_BT_HCIUART_QCAROME
>> +int rome_init(void);
>> +int rome_deinit(void);
>> +#endif
> Same here. I rather have this qca_init etc.
>
> Regards
>
> Marcel
>

Thanks for your code review. I'll submit new patches to address all your suggestions.

Thanks
-- Ben Kim
