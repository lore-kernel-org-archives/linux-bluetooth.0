Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHZ1yCnFaUoNyCF8BCXw9nz8ioki0jmdPh0n1Ah3CC4y9=sv=A@mail.gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1367829810-8262-11-git-send-email-mikel.astiz.oss@gmail.com>
	<CAHZ1yCnFaUoNyCF8BCXw9nz8ioki0jmdPh0n1Ah3CC4y9=sv=A@mail.gmail.com>
Date: Thu, 16 May 2013 08:22:26 +0200
Message-ID: <CANT-zCUH97DBRPkrbEDrkHvJm2NukC2436fMwDe8Z-VxJdJveA@mail.gmail.com>
Subject: Re: [RFC BlueZ v0 10/13] doc: Add API documentation for org.bluez.Service1
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Scott James Remnant <keybuk@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Wed, May 15, 2013 at 6:38 PM, Scott James Remnant <keybuk@google.com> wrote:
> On Mon, May 6, 2013 at 1:43 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>
>> diff --git a/doc/service-api.txt b/doc/service-api.txt
>> new file mode 100644
>> index 0000000..ef611d6
>> --- /dev/null
>> +++ b/doc/service-api.txt
>> @@ -0,0 +1,54 @@
>> +BlueZ D-Bus Service API description
>> +***********************************
>> +
>> +Copyright (C) 2012-2013  BMW Car IT GmbH. All rights reserved.
>> +
>> +
>> +Service hierarchy
>> +=================
>> +
>> +Service                unique name
>> +Interface      org.bluez.Service1 [Experimental]
>> +Object path    freely definable
>> +
>> +Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/
>> +                                                               serviceZZZ
>> +
>
> This says the Object path is both freely definable and fixed, which is it? :)

The later is the correct one, thanks for pointing it out.

Cheers,
Mikel
