Return-Path: <cyrus@holtmann.org>
Message-ID: <4CF8CBB1.90506@atheros.com>
Date: Fri, 3 Dec 2010 16:21:29 +0530
From: Bala Shanmugam <sbalashanmugam@atheros.com>
MIME-Version: 1.0
To: Alexander Holler <holler@ahsoftware.de>
CC: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	SongXing Xu <SongXing.Xu@Atheros.com>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>,
	Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] ath3k: reduce memory usage
References: <1290456541-3812-1-git-send-email-holler@ahsoftware.de> <20101130015200.GD5919@vigoh> <4CF4BAE6.1080502@ahsoftware.de>
In-Reply-To: <4CF4BAE6.1080502@ahsoftware.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/30/2010 2:20 PM, Alexander Holler wrote:
> Hello,
>
> Am 30.11.2010 02:52, schrieb Gustavo F. Padovan:
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
> I don't know. I assume it's a stub which has to be send before the real
> firmware. It already was there and I haven't touched that.
>
> Regards,
>
> Alexander
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
The first 20 bytes contain information about the binary like binary 
length, crc,
jump address etc.,

I manually made these changes and its not working.
I am unable to apply Alex patch taken from my office id.
Alex can you send the patch to btlinuxmail@gmail.com.

Regards,
BAla.
