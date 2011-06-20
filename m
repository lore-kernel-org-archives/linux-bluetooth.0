Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=e8C_3Yewys5Oy2ftmbj6U0ygZow@mail.gmail.com>
References: <1308560871-3225-1-git-send-email-sancane@gmail.com>
	<EB40D37D-9291-4215-BC31-EE7B1462253B@signove.com>
	<BANLkTi=e8C_3Yewys5Oy2ftmbj6U0ygZow@mail.gmail.com>
Date: Mon, 20 Jun 2011 19:24:47 +0200
Message-ID: <BANLkTincPpdn5475a+BsXgz3ZghJRDS8gg@mail.gmail.com>
Subject: Re: [RFC] Health Thermometer Profile API
From: Santiago Carot <sancane@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Elvis Pfutzenreuter <epx@signove.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

2011/6/20 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> Hi,
>
> On Mon, Jun 20, 2011 at 7:45 AM, Elvis Pfutzenreuter <epx@signove.com> wrote:
>>> +             MeasureReceived(dict measure)
>>> +
>>> +                     This signal is emmited when a measure has been scanned
>>> +                     by the thermometer. The Time entry in the dict will be
>>> +                     only present if the device supports storing of data.
>>> +                     The Type entry is optional and it will be provided if
>>> +                     the measure type is non-static. For static measures the
>>> +                     property Type will be provided. The Value entry
>>> +                     corresponds to IEEE-11073 32-bit FLOAT.
>>> +
>>> +                     Dict is defined as below:
>>> +                     {
>>> +                             "Value" : uint32,
>>> +                             "Unit" : ("Celsius" or "Fahrenheit")
>>> +                             "Time" : {
>>> +                                             "Year" : uint16,
>>> +                                             "Month" : uint8,
>>> +                                             "Day" : uint8,
>>> +                                             "Hours" : uint8,
>>> +                                             "Minutes" : uint8,
>>> +                                             "Seconds" : uint8
>>
>> We don't really need to mimic the timestamp structure used in spec. We could
>> go for a simple int with time() format (we should look into other
>> BlueZ APIs to see which format they use for date or time).
>>
>> A value for no-timestamp case should be defined, too.
>
> For reference, this is from doc/clock-api.txt in connman (which has
> architecture similar to BlueZ:
>
> [...]
> Properties      uint64 Time [readonly or readwrite]
>
>                        Current system time in seconds since epoch.
> [...]
>
>
>
>>
>>> +                                     }
>>> +                             "Type" : uint8,
>>> +                             "Measurement" : ("Final", "Intermediate")
>>> +                     }
>>
>> I would favor an agent for this case instead of signals, because it makes it
>> implicit whether there is someone interested in getting temperature notifications.
>> I mean, if some app a) enables notification properties and b) leaves, notification
>> will keep being done, burning both devices' batteries. That's LE, after all :)
>>
>> Turning off upon exit is not an option because some other app may be interested,
>> too. The agent is a natural 'reference counter', too.
>
> In general, if you want/need to support multiple users of the D-Bus
> API, something like an agent is necessary IMHO. Otherwise, it would be
> necessary to return some "busy" error to avoid other users disabling
> intermediate measurements while another user is interested on them.

Ok, I think the agent style API will fit better with multi-user use
cases. I'm going to work in these changes and I'll submit a new patch
when it's ready.

Regards.
