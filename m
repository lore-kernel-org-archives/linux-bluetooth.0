Return-Path: <cyrus@holtmann.org>
Message-ID: <50697F39.90008@tieto.com>
Date: Mon, 1 Oct 2012 13:32:09 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Santiago Carot <sancane@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 07/15] thermometer: Reformat MeasurementReceived description
References: <1349083437-23528-1-git-send-email-andrzej.kaczmarek@tieto.com> <1349083437-23528-8-git-send-email-andrzej.kaczmarek@tieto.com> <CACLukzL99YF13_+V9wemKgWVQGC8Wcj_v+41A8DWrxnK2=cfoQ@mail.gmail.com>
In-Reply-To: <CACLukzL99YF13_+V9wemKgWVQGC8Wcj_v+41A8DWrxnK2=cfoQ@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On 10/01/2012 11:43 AM, Santiago Carot wrote:
> Hi Andrzej
>
> 2012/10/1 Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>:
>> MeasurementReceived method description is reformatted to be more
>> readable and consistent with other API documents.
>>
>> Special values for Exponent and Mantissa fields specify now only NaN
>> value as this is only special value defined by HTS specification for
>> measurement.
>> ---
>>   doc/thermometer-api.txt | 67 +++++++++++++++++++++++++++----------------------
>>   1 file changed, 37 insertions(+), 30 deletions(-)
>>
>> diff --git a/doc/thermometer-api.txt b/doc/thermometer-api.txt
>> index 1828811..0fb28f5 100644
>> --- a/doc/thermometer-api.txt
>> +++ b/doc/thermometer-api.txt
>> @@ -97,33 +97,40 @@ Service             unique name
>>   Interface      org.bluez.ThermometerWatcher
>>   Object path    freely definable
>>
>> -Methods                void MeasurementReceived(dict measure)
>> -
>> -                       This callback gets called when a measure has been
>> -                       scanned in the thermometer. The Time entry in the dict
>> -                       will be only present if the device supports storing of
>> -                       data. The time value is expressed in seconds since epoch.
>> -                       The value represented is (mantissa) x (10**exponent)
>> -                       See foot note for special values when treating with
>> -                       health devices. The Type entry is only present if the
>> -                       measurement type is known. Otherwise, it is undefined.
>> -
>> -                       Dict is defined as below:
>> -                       {
>> -                               "Exponent" : int8,
>> -                               "Mantissa" : int32,
>> -                               "Unit" : ("Celsius" or "Fahrenheit"),
>> -                               "Time" : uint64,
>> -                               "Type" : ("Armpit", "Body", "Ear", "Finger",
>> -                                       "Intestines", "Mouth", "Rectum", "Toe",
>> -                                       "Tympanum"),
>> -                               "Measurement" : ("Final" or "Intermediate"),
>> -                       }
>> -
>> -                       For special cases, the exponent shall always be zero and
>> -                       the mantissa should be one of following values:
>> -
>> -                       NRes = -(2**23)
>> -                       NaN = +(2**23-1)
>> -                       INFINITY = (2**23-2)
>> -                       -INFINITY = -(2**23-2)
>> +Methods                void MeasurementReceived(dict measurement)
>> +
>> +                       This callback gets called when a measurement has been
>> +                       scanned in the thermometer.
>> +
>> +                       Measurement:
>> +
>> +                               int16 Exponent:
>> +                               int32 Mantissa:
>> +
>> +                                       Measurement value is calculated as
>> +                                       (Mantissa) x (10^Exponent)
>> +
>> +                                       In case of invalid or missing data,
>> +                                       Exponent is set to 0 and Mantissa is
>> +                                       set to 2^23-1 (0x7FFFFF hexadecimal).
>
> Mantissa values must not always be 2^23-1 on special cases.
> Information provided here is required for upper profiles which are
> implementing an 11073-20601 protocol layer because they have to
> differentiate among these values. In my opinion, documentation about
> passible values for the mantissa should remain as they are.

HTS specification states (see quote below) that measurement value field 
may be NaN in case sensor is not able to provide valid measurement. So I 
assume here that either it has valid data or NaN otherwise and thus 
there's no need to specify other special values as they should not be 
received here.

<quote>
The Temperature Measurement Value field may contain special float value 
NaN (0x007FFFFF) defined in IEEE 11073-20601 [4] to report an invalid 
result from a computation step or missing data due to the hardware’s 
inability to provide a valid measurement.
</quote>


BR,
Andrzej
