Return-Path: <cyrus@holtmann.org>
Message-ID: <506AAB46.3020007@tieto.com>
Date: Tue, 2 Oct 2012 10:52:22 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Santiago Carot <sancane@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 07/15] thermometer: Reformat MeasurementReceived description
References: <1349083437-23528-1-git-send-email-andrzej.kaczmarek@tieto.com> <1349083437-23528-8-git-send-email-andrzej.kaczmarek@tieto.com> <CACLukzL99YF13_+V9wemKgWVQGC8Wcj_v+41A8DWrxnK2=cfoQ@mail.gmail.com> <50697F39.90008@tieto.com> <CACLukz+Ducgd2LmFCrqyb6TnSz_BSEVm1x=rKXrOzSzKNg6ung@mail.gmail.com>
In-Reply-To: <CACLukz+Ducgd2LmFCrqyb6TnSz_BSEVm1x=rKXrOzSzKNg6ung@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On 10/01/2012 02:08 PM, Santiago Carot wrote:
>>> Mantissa values must not always be 2^23-1 on special cases.
>>> Information provided here is required for upper profiles which are
>>> implementing an 11073-20601 protocol layer because they have to
>>> differentiate among these values. In my opinion, documentation about
>>> passible values for the mantissa should remain as they are.
>>
>>
>> HTS specification states (see quote below) that measurement value field may
>> be NaN in case sensor is not able to provide valid measurement. So I assume
>> here that either it has valid data or NaN otherwise and thus there's no need
>> to specify other special values as they should not be received here.
>>
>> <quote>
>> The Temperature Measurement Value field may contain special float value NaN
>> (0x007FFFFF) defined in IEEE 11073-20601 [4] to report an invalid result
>> from a computation step or missing data due to the hardware’s inability to
>> provide a valid measurement.
>> </quote>
>>
>
> IMHO that doesn't justify you to force all mantisse values to be
> 2^23-1, first of all because the value type for this characteristic is
> a FLOAT type, so any value that a thermometer could send, it does it
> using the format defined for FLOAT types which is explained in
> IEEE-11073-20601,
> [http://developer.bluetooth.org/gatt/Pages/FormatTypes.aspx]
>
> On the other hand, I understand from this quote that thermometers MAY
> set NaN in case sensor is not able to provide valid measuremen due to
> an invalid result or missing data, but it doesn't say anything about
> other values that a FLOAT types can take, so you are forcing to be NaN
> other special cases that are defined for this kind of type.
>
> If you had a look to that spec you could see wich other special values
> a FLOAT type could take, if not, you could at least have a look to one
> of the whitepapers defined in bluetooth sig for transcoders.

Just to be clear here: I do not force mantissa values to any particular 
value. Whatever is received from remote device is still dispatched to 
application as-is. I just modified description so it mentions what HTS 
specification says about this value and that's all and since it was just 
done "by the way" when reformatting description I won't push for it.

But perhaps it's worth just adding note that exponent and mantissa are 
as in IEEE-11073-20601. This clearly states that apps working in 
IEEE-11073-20601 ecosystem can pack both values directly into float and 
there's no need to specify all special values.

BR,
Andrzej
