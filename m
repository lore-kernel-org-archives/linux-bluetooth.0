Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinVkr3ivG0-Jt-sCJe0VLpPFTUAgDaTTiM5U51A@mail.gmail.com>
References: <AANLkTi=652bHGqL841fp1ufO1_7C3iTq+tZ4eBcGtEiO@mail.gmail.com>
	<4D4BED6C.3040506@nokia.com>
	<AANLkTinVkr3ivG0-Jt-sCJe0VLpPFTUAgDaTTiM5U51A@mail.gmail.com>
Date: Fri, 4 Feb 2011 15:45:32 +0200
Message-ID: <AANLkTimhUD74h=QDKQu=EGfPXYHafuTMnwQ-RbGeaUFp@mail.gmail.com>
Subject: Re: Not able to test GATT on ubuntu
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vijayalakshmi N <vijayalakshmi.nk@gmail.com>
Cc: Mika Linnanoja <mika.linnanoja@nokia.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 4, 2011 at 2:33 PM, Vijayalakshmi N
<vijayalakshmi.nk@gmail.com> wrote:
> Hi Mika,
>
> I did use --le option but I get that the socket cannot bind error:
>
> l2cap_bind: Address already in use (98)
>
> I did take Vinicius Gomes'  kernel patches for LE and compile it.
>
> I will get the hcidump for LE as you have said.
>
> Could you pls. tell me why I'm getting the l2cap error.

Well that normally indicate that there is some other application
listen on the same psm, but I doubt that could happen in this case
since normally you are not able to run multiple instances of
bluetoothd simultaneously, so perhaps this could be caused by LE not
enabled in the kernel or something like that.

> Thanks,
> Vijayalakshmi
>
>
>
> On Fri, Feb 4, 2011 at 5:43 PM, Mika Linnanoja <mika.linnanoja@nokia.com> wrote:
>> On 02/04/2011 01:59 PM, ext Vijayalakshmi N wrote:
>>>
>>> Dear all,
>>>
>>> I have taken the bluetooth code with BLE changes  (net/bluetooth and
>>> include/net/bluetooth) from
>>>
>>>
>>> http://git.infradead.org/users/vcgomes/linux-2.6.git/tree/refs/heads/le-l2cap
>>> to my 2.6.35 kernel and built the kernel.
>>>
>>> and also built bluez 4.84 on ubuntu 10.10.
>>>
>>> Tried testing GATT with the gatttool that is available with the bluez.
>>>
>>> gatttool --primary -b<bd-address>
>>
>> Hi.
>>
>> If you want to use LE add "--le" to gatttool options. Otherwise (and evident
>> from your hcidump) it tries to create classic BT connection.
>>
>> We haven't tried adding LE kernel patches to .35 kernels (stock ubuntu one),
>> why don't you checkout whole vcgomes' kernel and compile it for your ubuntu
>> box instead?
>>
>> Boots fine in Ubuntu 10.10. Used "make oldconfig" with .config from /boot/
>> for stock kernel and answered defaults to most questions and "Y" to the one
>> asking about enabling SMP for BT LE.
>>
>>> Please see the log (hcidump) of the Master BT device below followed by
>>> the hcidump of Slave (GATT Server).
>>
>> Also, upgrade to hcidump 2.0 it has LE stuff in it, logs will be more
>> useful. Ie get git version and compile and run from compile dir, no need to
>> install.
>>
>>> Thanks,
>>> Vijayalakshmi
>>
>> BR,
>> Mika
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz
Computer Engineer
