Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 12 Apr 2010 10:16:57 +0530
Message-ID: <h2k912bb79a1004112146wd46cc9d6j36a0807563ed4d5d@mail.gmail.com>
Subject: Regarding HS re-connection
From: nirav rabara <niravrabara@gmail.com>
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am bit confused regarding logic behind HS reconnection with dongle.
1) I paired and connect with HS with Dongle.
2) Now I paired and connect this HS with few other Devices, so HS
memory will be overwritten and won't be having any information of
Dongle paired earlier.

In such situation am I need to do repairing OR forcefully I can send
the pairing information to HS.

Thanks for your suggestions in advance.



On Wed, Apr 7, 2010 at 3:02 PM, nirav rabara <niravrabara@gmail.com> wrote:
> hi Lain,
>
> Thanks for your suggestion,
>
>> you will probably find that because the HS device is very limited in
>> resources, it does not keep records of more than one paired device. So, if
>> you pair with another device it forgets about the first and you will not
>> be able to connect except that you pair it again.
>>
>
> Does it mean that once paired device information stored in our
> cellphones, if remote device(HS) doesn't have paired information, out
> cellphone will take care of re-pairing.
>
> So ultimately am I need to do pairing again??
>
>
> --
> With Regards,
> Nirav Rabara
>



-- 
With Regards,
Nirav Rabara
