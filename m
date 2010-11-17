Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201011161112.05202.szymon.janc@tieto.com>
References: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com>
 <201011150954.23553.szymon.janc@tieto.com> <AANLkTik+LOzvJMG=of7cwrQ3j2a0mDvN4Rnq_d4rtwKB@mail.gmail.com>
 <201011161112.05202.szymon.janc@tieto.com>
From: jaikumar Ganesh <jaikumarg@gmail.com>
Date: Wed, 17 Nov 2010 09:15:31 -0800
Message-ID: <AANLkTi==GmuytYsX0ZRz3RGtHXs7k+LL1m=4B+hYPG+x@mail.gmail.com>
Subject: Re: [PATCH 3/4] Add DBus OOB API documentation.
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon:

On Tue, Nov 16, 2010 at 2:12 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> >> Why are we enforcing this limitation ?
>> >
>> > Spec requires that each hash&randomizer values should be used only for one OOB
>> > transfer. Implementation enforces that by allowing only one active OOB plugin
>> > at time and DBUS OOB plugin only 'expose' plugin API over DBUS. So this
>> > limitation is a consequence of that.
>>
>> I don't think the spec says that. It just says every single time the
>> call to read the local adapters hash
>> and randomizer is done you get new values. You can use the value that
>> you have obtained for as many OOB pairings
>> as you wish.
>
> Please see note in Vol2. Part E. 7.3.60:
>
>        "Each OOB transfer will have unique C and R values so after each OOB
>        transfer this command shall be used to obtain a new set of values for the next
>        OOB transfer."
>

Yes we were talking about the same thing, just at different layers. I
was talking about it from the user of the provider.
This looks fine to me.

>
> --
> Szymon Janc
>
