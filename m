Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1288369169.4351.8.camel@donpedro>
References: <AANLkTikQqPqJdFgLpUrKiqyAC0HNUFnj+8NtbPxazY18@mail.gmail.com>
	<1288369169.4351.8.camel@donpedro>
Date: Sun, 31 Oct 2010 21:26:35 +0200
Message-ID: <AANLkTi=BeeuAKjt8bKro2KH0SXMJDUuwMznRS5NcDj4K@mail.gmail.com>
Subject: Re: HFP Pulseaudio Source destroyed "too quickly" at the end of a call
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Dons Tychsen <donpedro@tdcadsl.dk>
Cc: =?ISO-8859-1?Q?Thomas_W=E4lti?= <twaelti@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Oct 29, 2010 at 7:19 PM, Peter Dons Tychsen <donpedro@tdcadsl.dk> wrote:
> On Wed, 2010-10-27 at 22:03 +0200, Thomas Wälti wrote:
>
>> All works well except when ending the recording of Bluetooth
>> Conversations: Once a party hangs up the call, the PulseAudio source
>> and sink disappear before I can stop GStreamer recording (I'm
>> listening to D-Bus events). Unfortunately, this causes my GStreamer
>> pipeline to crash.

Well then there is a problem in your pipeline, bluetooth sinks and
sources may disappear at any point and in fact PA do move audio,
depending on the system policy, when that occurs. Also note that
bluetooth modules do handle DisconnectRequest signal so it might react
a bit faster when user request audio to be disconnected, but that
should not make any difference for an application using PA.

> There are many reasons (especially for wireless device) that the source
> or sink could disappear at any time. Audio disappearing before or after
> the accompanying signaling furthermore a classic scenario which apps
> should be built to handle. So fixing the race (which i am not sure is
> really a race) does not seem like the correct solution. Trying to fix
> such "races" can lead to inefficiency by using unneeded timers and
> spin-locks, and will not provide robustness, as the audio streams can
> disappear for other reasons anyway.

100% agreed, arbitrary timers/timeouts are definable not robust and
iirc PA tries to be lock free.
