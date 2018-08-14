Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH] Use default .cfg file name for RTL8723BS devices with id
 of OBDA8723
To: Ian W MORRISON <ianwmorrison@gmail.com>, marcel@holtmann.org,
 johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180814064742.14519-1-ianwmorrison@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <29a87a37-6dda-62c2-01b1-d4a806e19cf2@redhat.com>
Date: Tue, 14 Aug 2018 09:28:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180814064742.14519-1-ianwmorrison@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 14-08-18 08:47, Ian W MORRISON wrote:
> For RTL8723BS devices the current config file name is a composite of
> both the config name (rtl8723bs) and a postfix of the device-id.
> 
> Given the majority of RTL8723BS devices use a device-id of OBDA8723
> this simplifies the config file name to use "rtl8723bs_config.bin"
> as a default of for these devices.

NACK, the device id is in there for a reason, once someone writes
support for it we will also need a rtl8723bs_config file on ARM
boards, which will definitely be board specific. I don't want us
to pretend there is one config to rule them all.

Specifically I plan to submit both the firmware and
rtl8723bs_config-OBDA8723.bin to linux-firmware soon, if the kernel
instead looks for just rtl8723bs_config.bin then I need to give
it that name in linux-firmware and then when we get ARM support
and the kernel complains about e.g. rtl8723bs_config-NextThingCo-CHIP.bin
not being there people may be tempted to think they can just link
to the "generic" one from linux-firmware which then turns out
to not be generic at all.

Regards,

Hans



> 
> Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
> ---
>   drivers/bluetooth/hci_h5.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..cce422dc1b8d 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -852,7 +852,9 @@ static int h5_btrtl_setup(struct h5 *h5)
>   	bool flow_control;
>   	int err;
>   
> -	btrtl_dev = btrtl_initialize(h5->hu->hdev, h5->id);
> +	btrtl_dev = strcmp("OBDA8723", h5->id) ?
> +		btrtl_initialize(h5->hu->hdev, h5->id) :
> +			btrtl_initialize(h5->hu->hdev, NULL);
>   	if (IS_ERR(btrtl_dev))
>   		return PTR_ERR(btrtl_dev);
>   
> 
