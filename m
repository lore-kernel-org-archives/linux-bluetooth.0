Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: anamtsov@gmail.com
In-Reply-To: <CA+XVXfcXqRZsnsEoBHtcn-sZVqe1E_Sfn4H-9ZRL7ZWU_ZWBOg@mail.gmail.com>
References: <1331503837-19015-1-git-send-email-arik@wizery.com>
 <1331512937.14217.74.camel@aeonflux> <CA+XVXfeSUaXiRWNO68VaL7ZkRuJ3g-MxzBvVsViLVPfsNQqM6g@mail.gmail.com>
 <1331573362.14217.78.camel@aeonflux> <CA+XVXfcXqRZsnsEoBHtcn-sZVqe1E_Sfn4H-9ZRL7ZWU_ZWBOg@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Mon, 19 Mar 2012 11:00:29 +0200
Message-ID: <CA+XVXfcPy+N0JiJsJz5-sb+7re8Y6wSGfkygzSe68H0TtN3Z6A@mail.gmail.com>
Subject: Re: [PATCH] mgmt-api: add read Tx power level command
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 12, 2012 at 20:07, Arik Nemtsov <arik@wizery.com> wrote:
>>> >> + =A0 =A0 Controller Index: =A0 =A0 =A0 <controller id>
>>> >> + =A0 =A0 Command Parameters: =A0 =A0 Address (6 Octets)
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Address_Ty=
pe (1 Octet)
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Type (1 Oc=
tet)
>>> >> + =A0 =A0 Return Parameters: =A0 =A0 =A0Address (6 Octets)
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Address_Ty=
pe (1 Octet)
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Status (1 =
Octet)
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Level (1 O=
ctet)
>>> >> +
>>> >> + =A0 =A0 Possible values for the Address_Type parameter:
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 BR/EDR
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 1 =A0 =A0 =A0 LE Public
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 2 =A0 =A0 =A0 LE Random
>>> >> +
>>> >> + =A0 =A0 Possible values for the Type parameter:
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 Current Transmit Power Level
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 1 =A0 =A0 =A0 Maximum Transmit Power Level
>>> >
>>> > Which ones do you care about? And why not just read both and return b=
oth
>>> > at the same time.
>>> >
>>> > I think that I made this pretty clear multiple times already. The mgm=
t
>>> > API is not for stuffing random HCI commands into it. Please explain y=
our
>>> > usage pattern of the results clearly.
>>> >
>>> > Who is triggering this command and who is consuming the results?
>>>
>>> Well the proximity reporter and proximity monitor profiles are the
>>> ones using this (with LE connections only). The proximity monitor can
>>> query the reporter for the Tx power level. The spec claims there's no
>>> point in polling for this, as the value doesn't change during an LE
>>> connection.
>>
>> so why are we not just reading that value when creating a LE connection?
>> What is the penalty for doing it on every LE connection?
>
> Well presumably it should only be read when the TPS profile if
> enabled. The cost is sending another command to the controller on each
> connection. Not sure it's very high.
> Maybe we can even integrate it into the "device connected" event, and
> just read it for all connecting devices.
>
> I guess it's a matter of personal preference.
>
> I think this API is better for future proofing - it gives the caller
> the option to get the Tx power for BR/EDR devices as well, at
> arbitrary times (since it can change during a BR connection).
> Some earlier emails suggested it might be useful.
>
>>
>>> Both profiles only care about the current Tx power level. I added the
>>> type for flexibility. It can be removed of course.
>>>
>>> In the proposed implementation the reporter reads this value when a
>>> device connects and caches it. When a remote device asks for this
>>> value (via an ATT read as part of the TPS profile), we return the
>>> cached value.
>>
>> So it gets always read anyway.
>
> Only when TPS server is enabled.

Is the current API acceptable?

Regards,
Arik
