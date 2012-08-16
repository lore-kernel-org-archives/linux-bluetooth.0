Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1345136955.28588.5.camel@zingle>
References: <CABBYNZJ16G7zOEm+AJwmb8SeEtRyGzfiKFf+QsK8NdQGUUGqDA@mail.gmail.com>
	<1345136955.28588.5.camel@zingle>
Date: Thu, 16 Aug 2012 16:50:49 -0300
Message-ID: <CAAngNMb2fmLrYRORMS5qmZL91WvGDEUNCVormBa5-LBc0TyD6g@mail.gmail.com>
Subject: Re: Moving bluetooth plugin to gstreamer
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: =?UTF-8?Q?Tim=2DPhilipp_M=C3=BCller?= <t.i.m@zen.co.uk>
Cc: Discussion of the development of and with GStreamer
	<gstreamer-devel@lists.freedesktop.org>,
	linux-bluetooth@vger.kernel.org,
	Thiago Sousa Santos <thiagossantos@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 16, 2012 at 2:09 PM, Tim-Philipp Müller <t.i.m@zen.co.uk> wrote:
> On Thu, 2012-08-16 at 16:25 +0300, Luiz Augusto von Dentz wrote:
>
> Hi,
>
>> Since we now have a proper library for SBC codec
>> (http://git.kernel.org/?p=bluetooth/sbc.git;a=summary) and its patent
>> has expired June 2, 2010. (source:
>> http://en.wikipedia.org/wiki/SBC_(codec)), I wonder if it wouldn't be
>> a good idea to move the plugin to gstreamer tree?
>>
>> The plugin has the following elements:
>>
>> bluetooth:  sbcenc: Bluetooth SBC encoder
>> bluetooth:  sbcdec: Bluetooth SBC decoder
>> bluetooth:  sbcparse: Bluetooth SBC parser
>> bluetooth:  avdtpsink: Bluetooth AVDTP sink
>> bluetooth:  a2dpsink: Bluetooth A2DP sink
>> bluetooth:  rtpsbcpay: RTP packet payloader
>
> Sounds like a good idea to me.
>
> We'd probably add them to gst-plugins-bad first though, since that's
> where new plugins are usually added before they get moved to -good or
> elsewhere. And probably only to git master (ie. for the upcoming
> 0.11/1.0 API version).
>
> Would the idea be that you'd turn libsbc from noinst into a proper
> library, or would we just move that over into the plugin as well?
>

It will be a shared lib, also used by pulseaudio's bluetooth modules.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
