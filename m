Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100202111019.GA27346@tango.0pointer.de>
References: <1264776266-7646-1-git-send-email-jprvita@gmail.com>
	 <aa32413d1001290653x717105bfx1d90653054a3cd24@mail.gmail.com>
	 <20100202111019.GA27346@tango.0pointer.de>
Date: Wed, 3 Feb 2010 16:38:40 -0200
Message-ID: <aa32413d1002031038h1d5c8e99udc38053e166263e6@mail.gmail.com>
Subject: Re: [pulseaudio-discuss] [RFC] [PATCH 0/2] HFP AG integration with
	PulseAudio
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
To: General PulseAudio Discussion
	<pulseaudio-discuss@mail.0pointer.de>
Cc: ofono@ofono.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 2, 2010 at 09:10, Lennart Poettering <lennart@poettering.net> wrote:
> On Fri, 29.01.10 12:53, João Paulo Rechi Vita (jprvita@gmail.com) wrote:
>
>> > Any help on testing and getting this working together or comments on the
>> > topic would be appreciated.
>> >
>> > [1] http://www.spinics.net/lists/linux-bluetooth/msg04250.html
>> > [2] http://www.spinics.net/lists/linux-bluetooth/msg04251.html
>> >
>> >
>> >
>>
>> I forgot to add, suspending of the sink/source seemed to cause
>> disconnection by the AG, so you might want to disable
>> module-suspend-on-idle when testing. BTW, Lennart, is there any way to
>> mark a source/sink to not be suspended?
>
> Not really. As Colin mentioned you can make suspending a simple NOOP
> which does what you want. That said I do believe it makes a lot of
> sense to actually mark sinks as "suspendable". I.e. Introduce a sink
> flag PA_SINK_SUSPENDABLE or so that we flag for all sinks that
> actually support suspending and leave unset fo all others, like yours.
>

Even after figuring out suspending wasn't really causing any problem
to my tests, it sounds like a good thing to have support for.

> Anyway, the patches look really good to me. I'd be happy to merge
> this, though is the bluez counterpart merged yet? (sorry, haven't
> closely followed bluez development for a while)
>

BlueZ part is still not merged, the code is under peer-review now but
it's likely to be merged soon. There may be some modification on which
signals to listen in order to load module-bluetooth-device (for HFP
case only), also. I'll send a patch rebased against git's head when
the merging time comes.

> Lennart
>
> --
> Lennart Poettering                        Red Hat, Inc.
> lennart [at] poettering [dot] net
> http://0pointer.net/lennart/           GnuPG 0x1A015CC4
> _______________________________________________
> pulseaudio-discuss mailing list
> pulseaudio-discuss@mail.0pointer.de
> https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss
>



-- 
João Paulo Rechi Vita
http://jprvita.wordpress.com/
