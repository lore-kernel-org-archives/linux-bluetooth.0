Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Jun 2009 11:29:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: lan zhu <zhu.lan.cn@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: question on A2DP sink suspend/resume
Message-ID: <20090625082913.GA25902@jh-x301>
References: <113d36d80906242033p134edf27t12bda1d0359c4134@mail.gmail.com> <113d36d80906242326g3f2ce8e3h6c779aa01d776b04@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <113d36d80906242326g3f2ce8e3h6c779aa01d776b04@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 25, 2009, lan zhu wrote:
> My question is,  I found there is no such sink_suspend or sink_resume
> method in D-BUS API while these functions are all implemented in Bluez
> audio module. I would like to know why don't put them to D-BUS API?
> If we need to call these functions we have to expand the D-BUS API.

You're forgetting the other control point to audio which is the UNIX
socket that alsa, gstreamer, pulseaudio, etc connect to to request audio
streams. The main purpose of the audio related D-Bus interfaces is to
control and monitor the profile-level connections but not the stream
states.

If you have an active audio stream (either SCO connection or A2DP stream
in streaming state) you also need some application providing data to the
stream (and consuming data from the stream in the SCO case). This is why
there's no control for it in the D-Bus interface. E.g. pulseaudio is able
to handle the switch from HFP/HSP to A2DP and back quite smoothly using
just the UNIX socket IPC messages. If you want to investigate how the
logic in the code goes with respect to this you can start by looking at
audio/unix.c.

If you have a good use case for not using the UNIX socket for controlling
the stream states we can naturally consider adding that to the D-Bus
interface, but right now I get the impression that you might simply not
have been aware that the principal control point for active audio streams
is the UNIX socket that audio clients can connect to.

> One more question is, is there a formal way to test SCO/A2DP
> simultaneous case? we can't find a proper headset to test it because
> those headsets are all well implemented with the simultaneous logic,
> so there is no way to enter ourselves' code that handle this logic.
> Can we test it by configurating some test tool such as PTS?

I'm not aware of any formal way and the PTS (afaik) doesn't have any
support for multi-profile testing.

Johan
