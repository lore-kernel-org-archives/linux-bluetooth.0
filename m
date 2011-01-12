Return-Path: <cyrus@holtmann.org>
Message-ID: <4D2DAE99.50403@atheros.com>
Date: Wed, 12 Jan 2011 19:07:29 +0530
From: Bala Shanmugam <sbalashanmugam@atheros.com>
MIME-Version: 1.0
To: Alexander Holler <holler@ahsoftware.de>
CC: "Gustavo F. Padovan" <padovan@profusion.mobi>, Marcel Holtmann
	<marcel@holtmann.org>, SongXing Xu <SongXing.Xu@Atheros.com>, Luis Rodriguez
	<Luis.Rodriguez@Atheros.com>, Vikram Kandukuri
	<Vikram.Kandukuri@Atheros.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] ath3k: reduce memory usage
References: <1290456541-3812-1-git-send-email-holler@ahsoftware.de> <20101130015200.GD5919@vigoh> <4D2B39B1.8010404@ahsoftware.de>
In-Reply-To: <4D2B39B1.8010404@ahsoftware.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 1/10/2011 10:24 PM, Alexander Holler wrote:
> Hello,
>
> because the merge window is currently open, should I resend that patch
> or post it on another mailing list too?
>
> I still think that driver should not waste about 250kb of memory. ;)
>
> Regards,
>
> Alexander
>
> Am 30.11.2010 02:52, schrieb Gustavo F. Padovan:
>> Hi Alexander,
>>
>> * Alexander Holler<holler@ahsoftware.de>   [2010-11-22 21:09:01 +0100]:
>>
>>> There is no need to hold the firmware in memory.
>>>
>>> Signed-off-by: Alexander Holler<holler@ahsoftware.de>
>>> ---
>>>    drivers/bluetooth/ath3k.c |   75 ++++++++++++---------------------------------
>>>    1 files changed, 20 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
>>> index 128cae4..81cd1ed 100644
>>> --- a/drivers/bluetooth/ath3k.c
>>> +++ b/drivers/bluetooth/ath3k.c
>>> @@ -43,46 +43,40 @@ MODULE_DEVICE_TABLE(usb, ath3k_table);
>>>    #define USB_REQ_DFU_DNLOAD	1
>>>    #define BULK_SIZE		4096
>>>
>>> -struct ath3k_data {
>>> -	struct usb_device *udev;
>>> -	u8 *fw_data;
>>> -	u32 fw_size;
>>> -	u32 fw_sent;
>>> -};
>>> -
>>> -static int ath3k_load_firmware(struct ath3k_data *data,
>>> -				unsigned char *firmware,
>>> -				int count)
>>> +static int ath3k_load_firmware(struct usb_device *udev,
>>> +				const struct firmware *firmware)
>>>    {
>>>    	u8 *send_buf;
>>>    	int err, pipe, len, size, sent = 0;
>>> +	int count = firmware->size;
>>>
>>> -	BT_DBG("ath3k %p udev %p", data, data->udev);
>>> +	BT_DBG("udev %p", udev);
>>>
>>> -	pipe = usb_sndctrlpipe(data->udev, 0);
>>> +	pipe = usb_sndctrlpipe(udev, 0);
>>>
>>> -	if ((usb_control_msg(data->udev, pipe,
>>> +	send_buf = kmalloc(BULK_SIZE, GFP_ATOMIC);
>>> +	if (!send_buf) {
>>> +		BT_ERR("Can't allocate memory chunk for firmware");
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	memcpy(send_buf, firmware->data, 20);
>>> +	if ((err = usb_control_msg(udev, pipe,
>>>    				USB_REQ_DFU_DNLOAD,
>>>    				USB_TYPE_VENDOR, 0, 0,
>>> -				firmware, 20, USB_CTRL_SET_TIMEOUT))<   0) {
>>> +				send_buf, 20, USB_CTRL_SET_TIMEOUT))<   0) {
>>>    		BT_ERR("Can't change to loading configuration err");
>>> -		return -EBUSY;
>>> +		goto error;
>>>    	}
>>>    	sent += 20;
>>>    	count -= 20;
>> Patch looks good to me,  but I have a question here: what's 20 here? I
>> didn't figured out.
>>
>> Vikram, what's your opinion on this patch? Can you ack/nack it?
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Alex,

Sorry for late reply.
Was held up in a work.

I will check your patch and update soon.
Can you send a fresh patch cc to btlinuxmail@gmail.com

Regards,
Bala.
