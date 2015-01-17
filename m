Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <DDFBBE14-D229-455D-B83F-A4682E073260@holtmann.org>
References: <1421444673-6301-1-git-send-email-rick@rickdunn.com>
	<1421444673-6301-2-git-send-email-rick@rickdunn.com>
	<DDFBBE14-D229-455D-B83F-A4682E073260@holtmann.org>
Date: Sat, 17 Jan 2015 09:19:14 -0500
Message-ID: <CABPUHraqLbn6RVV9oGD8xMQ8kdxeYZb85q6G8885=g6Zd8aY4Q@mail.gmail.com>
Subject: Re: [PATCH] Add 0b05:17cf line for BCM4352 combo card BCM20702A0 chip
From: Rick Dunn <rick@rickdunn.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks and I am not sure either so thank you. Will attempt to test
before sending in the future.

On Fri, Jan 16, 2015 at 11:30 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Rick,
>
>> ---
>> drivers/bluetooth/btusb.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index af122e2..0725003 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -107,6 +107,7 @@ static const struct usb_device_id btusb_table[] = {
>>       { USB_DEVICE(0x0b05, 0x17cb) },
>>       { USB_DEVICE(0x04ca, 0x2003) },
>>       { USB_DEVICE(0x0489, 0xe042) },
>> +     { USB_DEVICE(0x0b05, 0x17cf), .driver_info = BTUSB_BCM_PATCHRAM },
>>       { USB_DEVICE(0x13d3, 0x3388), .driver_info = BTUSB_BCM_PATCHRAM },
>>       { USB_DEVICE(0x13d3, 0x3389), .driver_info = BTUSB_BCM_PATCHRAM },
>>       { USB_DEVICE(0x413c, 0x8197), .driver_info = BTUSB_BCM_PATCHRAM },
>
> I honestly have no idea on what you are doing with git send-email, but your patches never arrive in one piece. They are split over two.
>
> So I took the information and created a proper patch based on your information and send it to the mailing list.
>
> Regards
>
> Marcel
>
