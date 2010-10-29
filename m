Return-Path: <cyrus@holtmann.org>
Subject: Re: HFP Pulseaudio Source destroyed "too quickly" at the end of a
 call
From: Peter Dons Tychsen <donpedro@tdcadsl.dk>
To: Thomas =?ISO-8859-1?Q?W=E4lti?= <twaelti@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTikQqPqJdFgLpUrKiqyAC0HNUFnj+8NtbPxazY18@mail.gmail.com>
References: <AANLkTikQqPqJdFgLpUrKiqyAC0HNUFnj+8NtbPxazY18@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Oct 2010 18:19:29 +0200
Message-ID: <1288369169.4351.8.camel@donpedro>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2010-10-27 at 22:03 +0200, Thomas Wälti wrote:

> All works well except when ending the recording of Bluetooth
> Conversations: Once a party hangs up the call, the PulseAudio source
> and sink disappear before I can stop GStreamer recording (I'm
> listening to D-Bus events). Unfortunately, this causes my GStreamer
> pipeline to crash.

There are many reasons (especially for wireless device) that the source
or sink could disappear at any time. Audio disappearing before or after
the accompanying signaling furthermore a classic scenario which apps
should be built to handle. So fixing the race (which i am not sure is
really a race) does not seem like the correct solution. Trying to fix
such "races" can lead to inefficiency by using unneeded timers and
spin-locks, and will not provide robustness, as the audio streams can
disappear for other reasons anyway.

Maybe the crash is more interesting. What actually crashes when this
happens, and why?

Thanks,

/pedro


