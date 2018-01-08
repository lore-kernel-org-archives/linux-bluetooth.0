Return-Path: <chia-lin.kao@canonical.com>
MIME-Version: 1.0
In-Reply-To: <DD31674B-4AE6-4759-9986-0F0736EDBCE3@holtmann.org>
References: <CAFv23Qk1zv-Otg_EJXndfiXgxzO2O44JTbV12SJyZapjPwPwaw@mail.gmail.com>
 <DD31674B-4AE6-4759-9986-0F0736EDBCE3@holtmann.org>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 8 Jan 2018 09:24:37 +0800
Message-ID: <CAFv23Qm88ANgnj+rsddYXMYwN0fv86kwVJxdPNN1goXUKA_fYQ@mail.gmail.com>
Subject: Re: Intel BT[8087:0025] leads to system auto resume from S3 randomly
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Ethan Hsieh <ethan.hsieh@canonical.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

The issue is the system automatically wakes up from S3.
We tried to figure out the issue and found that BT is suspicious
that's how the workaround comes from.
Also, we found that if we connect the BT antenna, the system will be
waken up more quickly.

I know the quirk will disable the ability to wake up the system from
remote, but I have no idea how to debug it further.
Is there any way I could try to check if we really got a wake up
packet or we keep receiving random packets and trigger the wake up
process?
Thanks.

Best regards,
AceLan Kao.

2018-01-05 22:59 GMT+08:00 Marcel Holtmann <marcel@holtmann.org>:
> Hi AceLan,
>
>> We found an issue that when system enters S3, it stays in S3 for a few
>> seconds, and somehow it resumes automatically.
>> And we try below quirk which can prevent it from waking up.
>>
>> drivers/usb/core/quirks.c
>> @@ -208,11 +208,11 @@ static const struct usb_device_id usb_quirk_list[]=
 =3D {
>>                        USB_QUIRK_DISCONNECT_SUSPEND },
>>        { USB_DEVICE(0x12d1, 0x15c3), .driver_info =3D
>>                        USB_QUIRK_DISCONNECT_SUSPEND },
>> +        { USB_DEVICE(0x8087, 0x0025), .driver_info =3D
>> +                        USB_QUIRK_DISCONNECT_SUSPEND },
>>
>> Here are some findings from the system.
>>
>> $ lsusb
>> Bus 001 Device 004: ID 8087:0025 Intel Corp.
>
> can we be a bit more specific here on what is going on and triage this a =
bit more. I have not heard of our hardware needing such a broad quirk. Also=
 disconnecting on suspend means that we loose the support for remote wakeup=
 and I am pretty sure that we do not want that.
>
> Regards
>
> Marcel
>
