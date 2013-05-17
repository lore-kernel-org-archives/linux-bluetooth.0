Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHZ1yCnPYU8eZxjO2YDrJSBkcs4BnGg53GL=fKLMsXKT=H94Rw@mail.gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1367829810-8262-11-git-send-email-mikel.astiz.oss@gmail.com>
	<CAHZ1yCnFaUoNyCF8BCXw9nz8ioki0jmdPh0n1Ah3CC4y9=sv=A@mail.gmail.com>
	<CANT-zCUH97DBRPkrbEDrkHvJm2NukC2436fMwDe8Z-VxJdJveA@mail.gmail.com>
	<CAHZ1yCnPYU8eZxjO2YDrJSBkcs4BnGg53GL=fKLMsXKT=H94Rw@mail.gmail.com>
Date: Fri, 17 May 2013 11:20:27 +0200
Message-ID: <CANT-zCVzqmhV-FBs+in+Z8gFUi0=U006qp0GkgvdbvtMbPYMfw@mail.gmail.com>
Subject: Re: [RFC BlueZ v0 10/13] doc: Add API documentation for org.bluez.Service1
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Scott James Remnant <keybuk@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Thu, May 16, 2013 at 7:10 PM, Scott James Remnant <keybuk@google.com> wrote:
> On Wed, May 15, 2013 at 11:22 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> Hi Scott,
>>
>> On Wed, May 15, 2013 at 6:38 PM, Scott James Remnant <keybuk@google.com> wrote:
>>> On Mon, May 6, 2013 at 1:43 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>>>
>>>> diff --git a/doc/service-api.txt b/doc/service-api.txt
>>>> new file mode 100644
>>>> index 0000000..ef611d6
>>>> --- /dev/null
>>>> +++ b/doc/service-api.txt
>>>> @@ -0,0 +1,54 @@
>>>> +BlueZ D-Bus Service API description
>>>> +***********************************
>>>> +
>>>> +Copyright (C) 2012-2013  BMW Car IT GmbH. All rights reserved.
>>>> +
>>>> +
>>>> +Service hierarchy
>>>> +=================
>>>> +
>>>> +Service                unique name
>>>> +Interface      org.bluez.Service1 [Experimental]
>>>> +Object path    freely definable
>>>> +
>>>> +Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/
>>>> +                                                               serviceZZZ
>>>> +
>>>
>>> This says the Object path is both freely definable and fixed, which is it? :)
>>
>> The later is the correct one, thanks for pointing it out.
>>
>
> What's the interaction between this and org.bluez.Profile1 ?

There'no direct relation between these two interfaces.

org.bluez.Profile1 is some kind of agent which can be used by a
external component (e.g. oFono) to implement a profile. I argued in
the past that the name is misleading but without success.

>
> Do you need an exported org.bluez.Profile1 object with a matching UUID
> of serviceZZZ to be able to connect? I would assume so, since that's
> what would receive the file descriptor.

No, they are independent mechanisms. For example A2DP is implemented
inside bluetoothd and has therefore no associated org.bluez.Profile1
interface, but the service gets exposed nevertheless in a
org.bluez.Service1 and can thus be connected.

Cheers,
Mikel
