Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Algorithm for create serial connection without rfcomm
References: <000301d347db$df1dd300$9d597900$@com>
 <6B2D6FC09217DA4280D35175FA16A620688418CA@msceml521-mbx.china.huawei.com>
 <457BA4F48509464E9000537839AF501857261694@msceml521-mbx.china.huawei.com>
 <59E7EBF9.3050705@zabzd.ru>
 <457BA4F48509464E9000537839AF501857261990@msceml521-mbx.china.huawei.com>
 <7CC793D56C5DD04ABFAFBF59EB0D4A3650F1DDAB@msceml522-mbx.china.huawei.com>
 <59E946F9.1060501@zabzd.ru>
 <7CC793D56C5DD04ABFAFBF59EB0D4A3650F1E01D@msceml522-mbx.china.huawei.com>
 <59ED2E3D.7030809@zabzd.ru>
 <7CC793D56C5DD04ABFAFBF59EB0D4A3650F1E6D0@msceml522-mbx.china.huawei.com>
 <59F92B55.0@zabzd.ru>
 <7CC793D56C5DD04ABFAFBF59EB0D4A3650F23FDB@msceml522-mbx.china.huawei.com>
 <480C9E29A742984996B50276401889F36B33E940@msceml521-mbx.china.huawei.com>
 <5AE03410.7070806@zabzd.ru>
 <CAAu3APYXpqO77M0AhAVD-EnOapXAOXsAD4e26x5ULTVCxfSreg@mail.gmail.com>
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@zabzd.ru>
To: linux-bluetooth@vger.kernel.org
Message-ID: <5AE2BB79.30003@zabzd.ru>
Date: Fri, 27 Apr 2018 13:56:09 +0800
MIME-Version: 1.0
In-Reply-To: <CAAu3APYXpqO77M0AhAVD-EnOapXAOXsAD4e26x5ULTVCxfSreg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you Barry Byford,

Your example is more understandable for me, but I do not know python.
If I understand correctly, the algorithm is as follows:
1. Connect to device (pair, connect)
2. "Release" profile
3. "RegisterProfile" with parameters. profile_path - path for new 
profile on Dbus?

After RegisterProfile device port /dev/rfcomm created automatic or need 
more operation?

4. For disconnect make RequestDisconnection



26.04.2018 21:39, Barry Byford пишет:
> Hello Aleksandr ,
>
> I believe that the following example in the tree is intended to serve
> the purpose.
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/test-profile
>
> I couldn't workout the correct command line switches to get this
> working so I did my own experiment and came up with the follow gist
> for Serial Port Profile:
> https://gist.github.com/ukBaz/217875c83c2535d22a16ba38fc8f2a91
>
> I hope that helps.
>
> Regards,
> Barry
>
>
> On 25 April 2018 at 08:53, Проклов Александр Валерьевич
> <ProklovAV@zabzd.ru> wrote:
>> Hi all,
>>
>> The rfcomm command is deprecated, what is the use of the algorithm to create
>> serial connections?
>>
>> Whether it is possible to create /dev/rfcomm not using rfcomm command
>> through Dbus or another utility from Bluez5?
>>
>> In many forums, people also ask this question, and everything is decided by
>> adding rfcomm command.
>>
>> --------------
>> Best regards,
>> Aleksandr Proklov
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

