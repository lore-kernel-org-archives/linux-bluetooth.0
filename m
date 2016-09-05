Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160905180241.GA29844@t440s.P-661HNU-F1>
References: <1472820549-1976-1-git-send-email-luiz.dentz@gmail.com> <20160905180241.GA29844@t440s.P-661HNU-F1>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 5 Sep 2016 21:35:58 +0300
Message-ID: <CABBYNZLTYBTV4NCvEjT6ysYUWjYSqbUWPwev_EUQvHh_O7x1Og@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] core/device: Fix attempting to connect to
 random address over BR/EDR
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Sep 5, 2016 at 9:02 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Fri, Sep 02, 2016, Luiz Augusto von Dentz wrote:
>> BR/EDR don't have the concept of random addresses so the only option is
>> to over LE in that case.
>> ---
>>  src/device.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/src/device.c b/src/device.c
>> index fb766d1..b8556f1 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -1748,6 +1748,10 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
>>       else if (!dev->bredr_state.bonded && dev->le_state.bonded)
>>               return dev->bdaddr_type;
>>
>> +     /* If the address is private it can only be connected over LE */
>> +     if (device_address_is_private(dev))
>> +             return dev->bdaddr_type;
>> +
>
> This doesn't look right to me. The comment also isn't correct since a
> dual mode device may use a resolvable private address for LE, i.e.
> device_address_is_private(dev) would return true. IIRC the
> dev->bdaddr_type value tells the LE address type when LE is supported.

This is evaluated after checking if device is bonded, but it doesn't
actually matter because this device object can only use the random
address until it is resolved, if we later on resolve the address I
suppose the object is updated with its identity address and the
address type is changed to public.

> If LE is not supported then dev->bdaddr_type is BDADDR_BREDR.

But private addresses can only be used in LE, so
device_address_is_private will only return true for LE.

-- 
Luiz Augusto von Dentz
