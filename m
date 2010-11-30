Return-Path: <cyrus@holtmann.org>
Message-ID: <4CF4BAE6.1080502@ahsoftware.de>
Date: Tue, 30 Nov 2010 09:50:46 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
CC: Alicke Xu <sxu@atheros.com>,
	"Luis R. Rodriguez" <lrodriguez@atheros.com>,
	Vikram Kandukuri <vikram.kandukuri@atheros.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] ath3k: reduce memory usage
References: <1290456541-3812-1-git-send-email-holler@ahsoftware.de> <20101130015200.GD5919@vigoh>
In-Reply-To: <20101130015200.GD5919@vigoh>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Am 30.11.2010 02:52, schrieb Gustavo F. Padovan:
>> -	if ((usb_control_msg(data->udev, pipe,
>> +	send_buf = kmalloc(BULK_SIZE, GFP_ATOMIC);
>> +	if (!send_buf) {
>> +		BT_ERR("Can't allocate memory chunk for firmware");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	memcpy(send_buf, firmware->data, 20);
>> +	if ((err = usb_control_msg(udev, pipe,
>>   				USB_REQ_DFU_DNLOAD,
>>   				USB_TYPE_VENDOR, 0, 0,
>> -				firmware, 20, USB_CTRL_SET_TIMEOUT))<  0) {
>> +				send_buf, 20, USB_CTRL_SET_TIMEOUT))<  0) {
>>   		BT_ERR("Can't change to loading configuration err");
>> -		return -EBUSY;
>> +		goto error;
>>   	}
>>   	sent += 20;
>>   	count -= 20;
>
> Patch looks good to me,  but I have a question here: what's 20 here? I
> didn't figured out.

I don't know. I assume it's a stub which has to be send before the real 
firmware. It already was there and I haven't touched that.

Regards,

Alexander
