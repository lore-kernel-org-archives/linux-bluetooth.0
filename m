Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <aa32413d0912151430p5e56c7c9v1cf792ee627c8d90@mail.gmail.com>
References: <ba5648fa0912150245k65a7e9b9iffff1550883dae3c@mail.gmail.com>
	 <aa32413d0912151430p5e56c7c9v1cf792ee627c8d90@mail.gmail.com>
Date: Wed, 16 Dec 2009 17:28:24 +0530
Message-ID: <ba5648fa0912160358q718d5db9ycc153d680717ea79@mail.gmail.com>
Subject: Re: Audio Sink Support
From: bluezprofile kernel <bluezprofile@gmail.com>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2009/12/16 João Paulo Rechi Vita <jprvita@gmail.com>:
> On Tue, Dec 15, 2009 at 8:45 AM, bluezprofile kernel
> <bluezprofile@gmail.com> wrote:
>> Hi All,
>> I am trying to connect my A2DP enabled mobile with Bluez host in
>> Ubuntu 9.10 karmic Koala.
>> Bluez version : 4.51 (A2DP sink support added in 4.46)
>> Kernel: 2.6.31
>> Pulseaudio: 0.9.19 and 0.9.21
>>
>> I read following link to do
>> http://jprvita.wordpress.com/2009/07/17/bluez-now-has-a2dp-sink-support/
>>
>> 1) As mentioned in the link, I am able to connect to the audio sink and
>> see the audio streaming in the hcidump. It disconnects in few seconds.
>> Is this the current status of Audio sink or any other patches added
>> 2) Is any one played the song in host successfully with any player(There is
>> no player to decode the stream) using sink support.
>> Then please give me a hint to proceed.
>
> The recommended is to use pulseaudio to decode the frames and offer a
> source abstraction for applications. If you want the audio to be sent
> to your speakers, you can use module-loopback (in pulseaudio) for
> that.
>
>> 3) Some times my audio configuration setting is getting crashed once I
>> play the song from mobile.
>> Is this know issue?
>>
>
> No clues, you need to elaborate more if you want any help.
>
>> Do I need to enable any flag on bluez/pulseaudio to succeed this?
>> or any specific kernel patch do I need to apply?
>> Please advice.
>>
>
> No kernel nor userspace patches. You just need to enable the
> AudioSource interface in bluez and use pulseaudio bluetooth modules to
> handle the stream.
>
> This post has a more detailed description on how to do so:
> http://jprvita.wordpress.com/2009/12/15/1-2-3-4-a2dp-stream/
>
> --
> João Paulo Rechi Vita
> MSc Computer Science Student
> Computer Engineer
> IC / Unicamp
> http://jprvita.wordpress.com/
>

bluezprofile kernel to João
show details 5:27 PM (0 minutes ago)


2009/12/16 João Paulo Rechi Vita <jprvita@gmail.com>:

- Show quoted text -
> On Tue, Dec 15, 2009 at 8:45 AM, bluezprofile kernel
> <bluezprofile@gmail.com> wrote:
>> Hi All,
>> I am trying to connect my A2DP enabled mobile with Bluez host in
>> Ubuntu 9.10 karmic Koala.
>> Bluez version : 4.51 (A2DP sink support added in 4.46)
>> Kernel: 2.6.31
>> Pulseaudio: 0.9.19 and 0.9.21
>>
>> I read following link to do
>> http://jprvita.wordpress.com/2009/07/17/bluez-now-has-a2dp-sink-support/
>>
>> 1) As mentioned in the link, I am able to connect to the audio sink and
>> see the audio streaming in the hcidump. It disconnects in few seconds.
>> Is this the current status of Audio sink or any other patches added
>> 2) Is any one played the song in host successfully with any player(There is
>> no player to decode the stream) using sink support.
>> Then please give me a hint to proceed.
>
> The recommended is to use pulseaudio to decode the frames and offer a
> source abstraction for applications. If you want the audio to be sent
> to your speakers, you can use module-loopback (in pulseaudio) for
> that.
>
>> 3) Some times my audio configuration setting is getting crashed once I
>> play the song from mobile.
>> Is this know issue?
>>
>
> No clues, you need to elaborate more if you want any help.
>
>> Do I need to enable any flag on bluez/pulseaudio to succeed this?
>> or any specific kernel patch do I need to apply?
>> Please advice.
>>
>
> No kernel nor userspace patches. You just need to enable the
> AudioSource interface in bluez and use pulseaudio bluetooth modules to
> handle the stream.
>
> This post has a more detailed description on how to do so:
> http://jprvita.wordpress.com/2009/12/15/1-2-3-4-a2dp-stream/
>
> --
> João Paulo Rechi Vita
> MSc Computer Science Student
> Computer Engineer
> IC / Unicamp
> http://jprvita.wordpress.com/
>

João,
Thanks for the reply.
I was able to succeed till the step 3 and partial of step 4.
I am able to connect to audio source. Once I start play song from A2DP mobile,
my sound card settings disappears from the panel and pulse audio get
disconnected.
In /var/log/messages I see

pulseaudio[1728]: ratelimit.c: 122 events suppressed
pulseaudio[2190]: pid.c: Stale PID file, overwriting.
pulseaudio[2198]: pid.c: Stale PID file, overwriting.

What kind of debug traces do you need for this debugging? Can I send
bluetoothd debug details. Will that help?

Thanks,
Nic Shen
