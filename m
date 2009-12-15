Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <ba5648fa0912150245k65a7e9b9iffff1550883dae3c@mail.gmail.com>
References: <ba5648fa0912150245k65a7e9b9iffff1550883dae3c@mail.gmail.com>
Date: Tue, 15 Dec 2009 20:30:15 -0200
Message-ID: <aa32413d0912151430p5e56c7c9v1cf792ee627c8d90@mail.gmail.com>
Subject: Re: Audio Sink Support
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
To: bluezprofile kernel <bluezprofile@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 15, 2009 at 8:45 AM, bluezprofile kernel
<bluezprofile@gmail.com> wrote:
> Hi All,
> I am trying to connect my A2DP enabled mobile with Bluez host in
> Ubuntu 9.10 karmic Koala.
> Bluez version : 4.51 (A2DP sink support added in 4.46)
> Kernel: 2.6.31
> Pulseaudio: 0.9.19 and 0.9.21
>
> I read following link to do
> http://jprvita.wordpress.com/2009/07/17/bluez-now-has-a2dp-sink-support/
>
> 1) As mentioned in the link, I am able to connect to the audio sink and
> see the audio streaming in the hcidump. It disconnects in few seconds.
> Is this the current status of Audio sink or any other patches added
> 2) Is any one played the song in host successfully with any player(There is
> no player to decode the stream) using sink support.
> Then please give me a hint to proceed.

The recommended is to use pulseaudio to decode the frames and offer a
source abstraction for applications. If you want the audio to be sent
to your speakers, you can use module-loopback (in pulseaudio) for
that.

> 3) Some times my audio configuration setting is getting crashed once I
> play the song from mobile.
> Is this know issue?
>

No clues, you need to elaborate more if you want any help.

> Do I need to enable any flag on bluez/pulseaudio to succeed this?
> or any specific kernel patch do I need to apply?
> Please advice.
>

No kernel nor userspace patches. You just need to enable the
AudioSource interface in bluez and use pulseaudio bluetooth modules to
handle the stream.

This post has a more detailed description on how to do so:
http://jprvita.wordpress.com/2009/12/15/1-2-3-4-a2dp-stream/

-- 
João Paulo Rechi Vita
MSc Computer Science Student
Computer Engineer
IC / Unicamp
http://jprvita.wordpress.com/
