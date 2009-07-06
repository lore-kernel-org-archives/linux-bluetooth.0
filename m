Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090625082913.GA25902@jh-x301>
References: <113d36d80906242033p134edf27t12bda1d0359c4134@mail.gmail.com>
	 <113d36d80906242326g3f2ce8e3h6c779aa01d776b04@mail.gmail.com>
	 <20090625082913.GA25902@jh-x301>
Date: Mon, 6 Jul 2009 19:11:18 +0800
Message-ID: <113d36d80907060411r72ab6ecbme3c006e4ce2b03a6@mail.gmail.com>
Subject: Re: question on A2DP sink suspend/resume
From: Lan Zhu <zhu.lan.cn@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

2009/6/25 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi,
>
> On Thu, Jun 25, 2009, lan zhu wrote:
>> My question is,  I found there is no such sink_suspend or sink_resume
>> method in D-BUS API while these functions are all implemented in Bluez
>> audio module. I would like to know why don't put them to D-BUS API?
>> If we need to call these functions we have to expand the D-BUS API.
>
> You're forgetting the other control point to audio which is the UNIX
> socket that alsa, gstreamer, pulseaudio, etc connect to to request audio
> streams. The main purpose of the audio related D-Bus interfaces is to
> control and monitor the profile-level connections but not the stream
> states.
>
> If you have an active audio stream (either SCO connection or A2DP stream
> in streaming state) you also need some application providing data to the
> stream (and consuming data from the stream in the SCO case). This is why
> there's no control for it in the D-Bus interface. E.g. pulseaudio is able
> to handle the switch from HFP/HSP to A2DP and back quite smoothly using
> just the UNIX socket IPC messages. If you want to investigate how the
> logic in the code goes with respect to this you can start by looking at
> audio/unix.c.
>
> If you have a good use case for not using the UNIX socket for controlling
> the stream states we can naturally consider adding that to the D-Bus
> interface, but right now I get the impression that you might simply not
> have been aware that the principal control point for active audio streams
> is the UNIX socket that audio clients can connect to.
>
>> One more question is, is there a formal way to test SCO/A2DP
>> simultaneous case? we can't find a proper headset to test it because
>> those headsets are all well implemented with the simultaneous logic,
>> so there is no way to enter ourselves' code that handle this logic.
>> Can we test it by configurating some test tool such as PTS?
>
> I'm not aware of any formal way and the PTS (afaik) doesn't have any
> support for multi-profile testing.
>
> Johan
>

Thanks for your response. In Google android platform, AudioFlinger
calls the functions in liba2dp for streaming related functions. If we
suspend A2DP Sink in AaudioFlinger when handling SCO routing, it will
be a easy way to implement the A2DP/SCO interaction except for one
violation of the simultaneous whitepaper, that is, the sequence of
halting A2DP streaming and creating SCO.  In the whitepaper the
sequence is defined as (1) halt A2DP stream (2) create SCO, but
because AudioFlinger only gets notification after SCO created
successfully, it has to create SCO at first and then halt A2DP stream.
Could you let me know if this sequence is acceptable? Will it bring
any issue in any unexpected cases?

Thanks,
Zhu Lan
