Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTin60Z53M=vYA37tU7=7mQzv_Y+aeZp7ZeODSvaU@mail.gmail.com>
References: <AANLkTimT8sHND7PtKszFntj-b-BjmJORtijqOh_Bu3vP@mail.gmail.com> <AANLkTin60Z53M=vYA37tU7=7mQzv_Y+aeZp7ZeODSvaU@mail.gmail.com>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Fri, 4 Feb 2011 17:49:38 +0100
Message-ID: <AANLkTimesBP5-KineuPYB6-uPEa+-=yBpbZmVo+SEW5=@mail.gmail.com>
Subject: Re: Health interfaces
To: Zahirul Islam <zahir1976@gmail.com>
Cc: sancane@gmail.com, epx@signove.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zahirul,

2011/2/4 Zahirul Islam <zahir1976@gmail.com>
>
> I am using ubuntu kernel 2.6.36 (enhanced transmission enabled) and qdbusviewer to browse bluez services ..
>
> Thanks in advance.
>
> Regards
> Zahir
>
> On Fri, Feb 4, 2011 at 10:31 AM, Zahirul Islam <zahir1976@gmail.com> wrote:
>>
>> Hello,
>>
>> I have installed bluez 4.85 on my Ubuntu and was expecting following Health Interfaces (according to http://gitorious.org/hdpy) in service org.bluez:
>>
>> Org.bluez.HealthManager
>> Org.bluez.HealthApplication
>> Org.bluez.HealthService
>> Org.bluez.HealthAgent
>>
>> I can see only org.bluez.Manager interface available. How could I get those interfaces.
>>
>> I will appreciate any advice.
>>
>>
>> Regards
>>
>> Zahir

Adding the bluez mail list in CC because this kind of questions should
be reported there.

I think that your are mixing thing a little bit. If you are using
BlueZ you don't need hdpy. BlueZ implements MCAP and HDP since version
4.76. The interface is exposed in D-Bus and this should be the unique
way to access HDP.

You can find the API documentation of the HDP profile in the "docs"
folder of the BlueZ project.

Regards.

Jose.
