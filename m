Return-Path: <martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <CAL9uMOH0N-4jgQncmPjK-KyU0vY9Q0ZnHYSAGgz3z3ywzc8Avw@mail.gmail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-8-martin.blumenstingl@googlemail.com>
 <563D6F9F-8495-40D4-BE56-5338ED2B9B99@holtmann.org> <CAL9uMOEMDup4hRkxD-tM8R0YirGs5uQi31AjJUnFCPNMKUdRHg@mail.gmail.com>
 <E8E39477-CF1A-4A3E-84C5-830E182C2266@holtmann.org> <CAL9uMOH0N-4jgQncmPjK-KyU0vY9Q0ZnHYSAGgz3z3ywzc8Avw@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 2 Jan 2018 22:46:32 +0100
Message-ID: <CAFBinCBB=SmviOMRHGDH6vzjTjV-mrtQEc8nBUhDbJGs9SBpgw@mail.gmail.com>
Subject: Re: [RFC v2 7/9] bluetooth: btrtl: load the config blob from
 devicetree when available
To: Carlo Caione <carlo@endlessm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.com,
	johan@kernel.org, linux-amlogic@lists.infradead.org,
	Larry.Finger@lwfinger.net, Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Carlo,

On Tue, Jan 2, 2018 at 12:31 PM, Carlo Caione <carlo@endlessm.com> wrote:
> On Tue, Jan 2, 2018 at 11:19 AM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>> Hi Carlo,
>>
>>>>> Some Realtek bluetooth devices need a "config" blob. The btrtl driver
>>>>> currently only allows loading this config blob via the request_firmwa=
re
>>>>> mechanism.
>>>>>
>>>>> The UART Bluetooth chips use this config blob to specify the baudrate=
,
>>>>> whether flow control is used and some other unknown bits. This means
>>>>> that the config blob is board-specific - thus loading it via
>>>>> request_firmware means that the rootfs is tied to a specific board.
>>>>>
>>>>> The UART Bluetooth chips are implemented through serdev. This means
>>>>> there is also a devicetree node which describes the Bluetooth chip.
>>>>> Thus we can also load the blob from the devicetree node to keep the
>>>>> filesystem independent of any board configuration data. In the future
>>>>> this could be extended to support ACPI as well (in case that's needed=
).
>>>>>
>>>>> Parse the devicetree node if it exists and obtain the config blob fro=
m
>>>>> there. Otherwise fall back to using the "old" request_firmware
>>>>> mechanism.
>>>>
>>>> where are these config blobs coming from? I think we also need to give=
 people a helping hand on how to add them to DT. I still wonder if the only=
 pieces we are using are the UART config, then maybe skipping the config bl=
ob and allowing for clear named values in DT might be better.
>>>
>>> What about x86 platforms where we do not have DT (I didn't check but I
>>> don't think that the UART config in that case is shipped in the ACPI
>>> tables)?
>>
>> if we have this hardware in x86 systems, then I would really like to see=
 ACPI table dumps. Some pieces might need hardcoding based on ACPI ID.
>
> Yes, we have, especially on cherry-trail SoCs. In [0] the DSDT of a
> cherry-trail laptop shipping the rtl8723bs (device OBDA8723).
>
> [0] https://gist.github.com/carlocaione/82bff95ababb67dd33f52a86e94ce3ff
so this shows that the UART settings (initial baudrate, HW flow
control, etc.) are part of the DSDT
however, the actual config blob is not

the description of this patch explains: "Parse the devicetree node ...
[or] ... fall back to using the "old" request_firmware mechanism."
do you have any other solution in mind?


Regards
Martin
