Return-Path: <cyrus@holtmann.org>
Message-ID: <4E7990A9.2070709@nokia.com>
Date: Wed, 21 Sep 2011 10:22:17 +0300
From: Antti Julku <antti.julku@nokia.com>
MIME-Version: 1.0
To: Lukasz.Rymanowski@tieto.com, mika.linnanoja@nokia.com,
        linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
        marcel@holtmann.org, linus.walleij@stericsson.com,
        par-gunnar.p.hjalmdahl@stericsson.com, padovan@profusion.mobi
Subject: Re: [PATCH] bluetooth: Fix for security block issue.
References: <1295965639-16683-1-git-send-email-lukasz.rymanowski@tieto.com> <1295971990.1520.53.camel@aeonflux> <4DB935D9.5080302@nokia.com> <20110428095139.GJ18898@null> <4DBA6D97.7050207@nokia.com> <7D7F2FD3846CF6429ACEBDFB5A2DD86F07F33ED77A@EXMB01.eu.tieto.com> <20110505190948.GD2098@joana>
In-Reply-To: <20110505190948.GD2098@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Gustavo,

On 05/05/2011 10:09 PM, ext Gustavo F. Padovan wrote:

>> On Thu, Apr 28, 2011 at 12:39:37PM +0300, Antti Julku wrote:
>>> It's easy to reproduce at least with these dongles:
>>>
>>> Alink BLUEUSB21 (BCM)
>>> Belkin BT2.1 F8T017 (BCM)
>>> DeLock 2.1 (CSR)
>>> PTS 2.1 (CSR)
>>>
>>> So most of our BT 2.1 dongles seem to be buggy. It would be nice to
>>> have a workaround since it happens with so many dongles.
>>
>> If there is so many buggy devices I think Gustavo and Marcel could consider to take this patch.
>
> The patch is too hackish, I don't wanna have such workaround in the tree.
> It is a good idea check the USB stack for possible causes for this bug.
>

We checked this with USB sniffer. Data comes from USB in the same order 
as shown in hcidump, so USB seems to work correctly.

Br,
Antti
