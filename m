Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_PE5U4ePHg7rb2Q1dxXKy0=5KH1tyjzif0tcuSQCcf6Fg@mail.gmail.com>
References: <CALdY0K5NNrrWdY73e44kp+QNxF2dizEyU44ny9k5h1YFQDf21w@mail.gmail.com>
	<CAJdJm_Myxh+i50v+0bMJgDCActz4Na_fZdVbNuNjwCE7Bss_kQ@mail.gmail.com>
	<CALdY0K6u0ZrJM-z7YKd2zmDzPStX2azVO-v4LUa385Ziq4uzOA@mail.gmail.com>
	<CAJdJm_PE5U4ePHg7rb2Q1dxXKy0=5KH1tyjzif0tcuSQCcf6Fg@mail.gmail.com>
Date: Fri, 14 Mar 2014 17:18:22 +0000
Message-ID: <CALdY0K7WAnRAoBWLrp2YsmpC35EixpqpByj7bvbL-EqxZkt6=Q@mail.gmail.com>
Subject: Re: Bluetooth low energy with gatttool and jawbone
From: Christian Bianchini <christian.bianchini@euservers.net>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I would like to get the motion data, basically this device has an
accelerometer inside and maybe a gyro, so I just want to receive these
information on my pc :)
I will do some more testing later, probably if I dont answer for a
while... I will be back on Monday.

In the meantime thanks for your helpful answers!

On Fri, Mar 14, 2014 at 5:07 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Christian,
>
> On Fri, Mar 14, 2014 at 12:19 PM, Christian Bianchini
> <christian.bianchini@euservers.net> wrote:
>> You were right!
>> Something happened, but I am not sure how to continue now, even
>> because after primary I get some data then the device disconnect
>> itself.
>>
>> $ sudo gatttool -b DC:7A:F8:10:AF:A5 -t random -I
>> [   ][DC:7A:F8:10:AF:A5][LE]> connect
>> [CON][DC:7A:F8:10:AF:A5][LE]> primary
>> [CON][DC:7A:F8:10:AF:A5][LE]>
>> attr handle: 0x0001, end grp handle: 0x0007 uuid:
>> 00001800-0000-1000-8000-00805f9b34fb
>> attr handle: 0x0008, end grp handle: 0x0008 uuid:
>> 00001801-0000-1000-8000-00805f9b34fb
>> attr handle: 0x0009, end grp handle: 0x0012 uuid:
>> f7c9ba7e-6658-4390-b53c-1de5e1453654
>> attr handle: 0x0013, end grp handle: 0xffff uuid:
>> 0000180a-0000-1000-8000-00805f9b34fb
>>
>> I dont have bluetoothctl, there is special package for ubuntu?
>
> To have btmon/bluetoothctl, I think you need a recent BlueZ 5.x, which
> is not available on Ubuntu (I think even latest Ubuntu uses 4.101, not
> sure about the development version). So you need to build BlueZ from
> sources.
>
> If you see a disconnect after ~30 seconds, it may be because it is
> issuing a GATT request which gatttool does not answer (as gatttool
> does not implement a GATT server). To confirm this, use "hcidump -i
> hci0 -w jawbone.dump" and send it here. This log will show whether the
> device is attempting some ATT request (e.g. GATT service discovery).
> You can also read this log using "hcidump -r jawbone.dump".
>
> Another reason for disconnect is a failed pairing attempt.
>
> If you can't use BlueZ 5 for some reason, you can try pairing using
> "sudo bluez-simple-agent hci0 <addr>".
>
> All that said, which data specifically do you want to get from the
> device? On the output above I see a proprietary service at handle
> 0x0009 and the Device Information service at handle 0x0013 (which is
> most likely firmware version, serial number etc.). Do you have
> specifications for the proprietary service?
>
> Best Regards,
> --
> Anderson Lizardo
> http://www.indt.org/?lang=en
> INdT - Manaus - Brazil



-- 
---------------------------
Web/Mobile Developer
Luiis Group
christian@bianchini.ch
