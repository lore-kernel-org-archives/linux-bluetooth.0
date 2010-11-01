Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=BeeuAKjt8bKro2KH0SXMJDUuwMznRS5NcDj4K@mail.gmail.com>
References: <AANLkTikQqPqJdFgLpUrKiqyAC0HNUFnj+8NtbPxazY18@mail.gmail.com>
	<1288369169.4351.8.camel@donpedro>
	<AANLkTi=BeeuAKjt8bKro2KH0SXMJDUuwMznRS5NcDj4K@mail.gmail.com>
Date: Mon, 1 Nov 2010 09:11:40 +0100
Message-ID: <AANLkTikPsyrod-GODJnXipsk+ysm3rOr0o_vrv8uYD9U@mail.gmail.com>
Subject: Re: HFP Pulseaudio Source destroyed "too quickly" at the end of a call
From: =?ISO-8859-1?Q?Thomas_W=E4lti?= <twaelti@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Peter Dons Tychsen <donpedro@tdcadsl.dk>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/10/31 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>> On Wed, 2010-10-27 at 22:03 +0200, Thomas Wälti wrote:
>>
>>> All works well except when ending the recording of Bluetooth
>>> Conversations: Once a party hangs up the call, the PulseAudio source
>>> and sink disappear before I can stop GStreamer recording (I'm
>>> listening to D-Bus events). Unfortunately, this causes my GStreamer
>>> pipeline to crash.
>
> Well then there is a problem in your pipeline, bluetooth sinks and
> sources may disappear at any point and in fact PA do move audio,
> depending on the system policy, when that occurs. Also note that
> bluetooth modules do handle DisconnectRequest signal so it might react
> a bit faster when user request audio to be disconnected, but that
> should not make any difference for an application using PA.

Thanks everybody for the helpful comments and valuable details,
helping me to understand how the "underworld" of my app works in the
Bluez/PA corner.
I'll now shift my focus towards GStreamer :-)

Best regards
-Tom
