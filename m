Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJPnn7U4fKwVUJLZOphGDXdqgbc-Z3_dgx_1r2vruO6=w@mail.gmail.com>
References: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1401177171-19994-2-git-send-email-andrzej.kaczmarek@tieto.com>
	<CABBYNZ+1MJevdU8HiY+p-72aNYJT9dRQyp0ki7aQRmdRt5fUFQ@mail.gmail.com>
	<CAF3PWx3Sm4hcsT4MXQD6cas4oHPE0AUoQYS17p7aCzViaLAqdg@mail.gmail.com>
	<CABBYNZ+sjcjJWE7cLRFAGF4R=4+RQuSvco0syUdU9ceKWSTbBQ@mail.gmail.com>
	<CAN_7+YZ4DDyVei6dpOBH0pdEKdBHzRqz3qJB_PX-jm3JOfSEzg@mail.gmail.com>
	<CABBYNZJPnn7U4fKwVUJLZOphGDXdqgbc-Z3_dgx_1r2vruO6=w@mail.gmail.com>
Date: Thu, 29 May 2014 10:52:53 -0700
Message-ID: <CAGVBWjQAHRBrBs_mhXRKNbnmgj7Lwhv=XAHqncv+8uDZhO_LjA@mail.gmail.com>
Subject: Re: [PATCH 1/9] doc: Introduce connection monitoring API
From: Tim Song <tengs@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

I disagree that these properties are too low level. The inquiry RSSI
is already exposed to applications, and it makes sense to also expose
the RSSI during a connection. Additionally, as Andrzej described
above, the RSSI isn't meaningful without also knowing the TX power.

Proximity for BR/EDR is a bit more complicated than LE due to the
varying TX power to keep RSSI in a golden range, and calibration on
the application side may be necessary as well due to hardware
differences. For this reason, I think it makes sense to expose these
properties to applications rather than a plugin or a standardized
profile.

Regards,
Tim

On Wed, May 28, 2014 at 3:13 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Thu, May 29, 2014 at 12:48 AM, Lukasz Rymanowski
> <lukasz.rymanowski@gmail.com> wrote:
>> Hi Luiz
>>
>> On Wed, May 28, 2014 at 9:54 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Andrzej,
>>>
>>> On Wed, May 28, 2014 at 10:24 PM, Andrzej Kaczmarek
>>> <andrzej.kaczmarek@tieto.com> wrote:
>>>> Hi Luiz,
>>>>
>>>> On 27 May 2014 14:49, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, May 27, 2014 at 10:52 AM, Andrzej Kaczmarek
>>>>> <andrzej.kaczmarek@tieto.com> wrote:
>>>>>> From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
>>>>>>
>>>>>> This patch introduces API to monitor connection parameters.
>>>>>>
>>>>>> New device properties are introduced: ConnectionRSSI, ConnectionTXPower
>>>>>> and ConnectionTXPowerMax.
>>>>>>
>>>>>> Client can request to poll for updates of RSSI and TX power via Start-
>>>>>> and StopConnectionMonitor methods.
>>>>>> ---
>>>>>>  doc/device-api.txt | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>  1 file changed, 56 insertions(+)
>>>>>>
>>>>>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>>>>>> index 577ee60..67f573c 100644
>>>>>> --- a/doc/device-api.txt
>>>>>> +++ b/doc/device-api.txt
>>>>>> @@ -100,6 +100,35 @@ Methods            void Connect()
>>>>>>                         Possible errors: org.bluez.Error.DoesNotExist
>>>>>>                                          org.bluez.Error.Failed
>>>>>>
>>>>>> +
>>>>>> +               void StartConnectionMonitor()
>>>>>> +
>>>>>> +                       This method starts connection monitor session. This
>>>>>> +                       includes link RSSI and TX power.
>>>>>> +                       Use StopConnectionMonitor to release the sessions
>>>>>> +                       acquired.
>>>>>> +
>>>>>> +                       This process will start updating connection-related
>>>>>> +                       properties, e.g. ConnectionRSSI and ConnectionTXPower.
>>>>>> +
>>>>>> +                       Note that all sessions for device are released when
>>>>>> +                       device is disconnected and it's required to start
>>>>>> +                       sessiong again once reconnected.
>>>>>> +
>>>>>> +                       Possible errors: org.bluez.Error.Busy
>>>>>> +                                        org.bluez.Error.NotConnected
>>>>>> +
>>>>>> +               void StopConnectionMonitor()
>>>>>> +
>>>>>> +                       This method stops previous StartConnectionMonitor
>>>>>> +                       session.
>>>>>> +
>>>>>> +                       Note that connection monitor is shared between all
>>>>>> +                       monitor sessions thus calling StopConnectionMonitor
>>>>>> +                       releases a single session.
>>>>>> +
>>>>>> +                       Possible errors: org.bluez.Error.Failed
>>>>>> +
>>>>>>  Properties     string Address [readonly]
>>>>>>
>>>>>>                         The Bluetooth device address of the remote device.
>>>>>> @@ -193,3 +222,30 @@ Properties string Address [readonly]
>>>>>>
>>>>>>                         Received Signal Strength Indicator of the remote
>>>>>>                         device (inquiry or advertising).
>>>>>> +
>>>>>> +               int16 ConnectionRSSI [readonly, optional]
>>>>>> +
>>>>>> +                       Received Signal Strength Indicator of connected remote
>>>>>> +                       device.
>>>>>> +
>>>>>> +                       This property is present only if device is connected
>>>>>> +                       and will be updated if at least one monitoring session
>>>>>> +                       is active.
>>>>>> +
>>>>>> +                       Note that RSSI has different units for BR/EDR (dB)
>>>>>> +                       and LE (dBm) as specified in BT Core ver. 4.1, Vol. 2,
>>>>>> +                       Part E, Chapter 7.5.4
>>>>>> +
>>>>>> +               int16 ConnectionTXPower [readonly, optional]
>>>>>> +
>>>>>> +                       Transmit power level to connected remote device.
>>>>>> +
>>>>>> +                       This property is present only if device is connected
>>>>>> +                       and will be updated if at least one monitoring session
>>>>>> +                       is active.
>>>>>> +
>>>>>> +               int16 ConnectionTXPowerMax [readonly, optional]
>>>>>> +
>>>>>> +                       Maximum transmit power level to connected remote device.
>>>>>> +
>>>>>> +                       This property is present only if device is connected.
>>>>>> --
>>>>>> 1.9.3
>>>>>
>>>>> IMO this API is too low level, if there is a reliable way to calculate
>>>>> the link quality we should do it and probably expose as a single
>>>>> property in percentage like we see in WiFi and other technologies,
>>>>> trying to push this to the application to figure out is probably bad
>>>>> idea since different applications may come up with different results.
>>>>>
>>>>> I would follow connman API design:
>>>>>
>>>>>   uint8 Strength [readonly]
>>>>>
>>>>>   Indicates the signal strength of the service. This
>>>>>   is a normalized value between 0 and 100...
>>>>
>>>> There's nothing to calculate here since RSSI and TX power are measured
>>>> in different "directions". Actually you can calculate pathloss once
>>>> you have RSSI from *local* side and TX power from *remote*. This is
>>>> what PXP does using TPS, (but it only works over LE). By having these
>>>> values exposed to application you can make proper PXP application and
>>>> even do this on BR/EDR.
>>>
>>> But why you want to do PXP as an application and not as a plugin? Both
>>> PXP and TPS should be very simple to be implemented as plugin since we
>>> have this info over MGMT interface.
>>>
>> I think the problem here is that  PXP for BR/EDR is not specified so
>> probably you don't want it as a plugin in BlueZ.
>> But if we expose those properties to application they can make fun usage of it.
>
> We do support non-standard/device specific profiles such as sixaxis
> and I would always prefer to attract people to contribute directly to
> BlueZ so we have fun together. Now regarding PXP on BR/EDR, if that is
> a good idea it is about time someone suggest it as official profile
> and in case it turn out to be adopted it would kind make these
> properties useless.
>
>
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
