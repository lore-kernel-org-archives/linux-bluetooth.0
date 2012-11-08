Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD2+Bb1+32YKBTNnG93dchn9SNU0ur4ZKCZtKV80ohc3bkwsYg@mail.gmail.com>
References: <CABBYNZJ16G7zOEm+AJwmb8SeEtRyGzfiKFf+QsK8NdQGUUGqDA@mail.gmail.com>
	<1345136955.28588.5.camel@zingle>
	<1345173220.13726.31.camel@aeonflux>
	<CAD2+Bb1+32YKBTNnG93dchn9SNU0ur4ZKCZtKV80ohc3bkwsYg@mail.gmail.com>
Date: Thu, 8 Nov 2012 17:20:46 +0200
Message-ID: <CABBYNZ+vGYoj+0VpAb_9HAbCSRZ+F_-5zbd+WODG4_Qrz_vcaw@mail.gmail.com>
Subject: Re: Moving bluetooth plugin to gstreamer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Discussion of the development of and with GStreamer
	<gstreamer-devel@lists.freedesktop.org>
Cc: linux-bluetooth@vger.kernel.org,
	Thiago Sousa Santos <thiagossantos@gmail.com>,
	=?ISO-8859-1?Q?Tim=2DPhilipp_M=FCller?= <t.i.m@zen.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Guys,

On Fri, Aug 17, 2012 at 12:26 PM, sreerenj b <bsreerenj@gmail.com> wrote:
> Hi Tim,
>
> Are you planning to integrate bluez-gstreamer to plugsin-bad? or some new
> plugins for sbc?
>
>
> On Fri, Aug 17, 2012 at 6:13 AM, Marcel Holtmann <marcel@holtmann.org>
> wrote:
>>
>> Hi Tim,
>>
>> > > Since we now have a proper library for SBC codec
>> > > (http://git.kernel.org/?p=bluetooth/sbc.git;a=summary) and its patent
>> > > has expired June 2, 2010. (source:
>> > > http://en.wikipedia.org/wiki/SBC_(codec)), I wonder if it wouldn't be
>> > > a good idea to move the plugin to gstreamer tree?
>> > >
>> > > The plugin has the following elements:
>> > >
>> > > bluetooth:  sbcenc: Bluetooth SBC encoder
>> > > bluetooth:  sbcdec: Bluetooth SBC decoder
>> > > bluetooth:  sbcparse: Bluetooth SBC parser
>> > > bluetooth:  avdtpsink: Bluetooth AVDTP sink
>> > > bluetooth:  a2dpsink: Bluetooth A2DP sink
>> > > bluetooth:  rtpsbcpay: RTP packet payloader
>> >
>> > Sounds like a good idea to me.
>> >
>> > We'd probably add them to gst-plugins-bad first though, since that's
>> > where new plugins are usually added before they get moved to -good or
>> > elsewhere. And probably only to git master (ie. for the upcoming
>> > 0.11/1.0 API version).
>> >
>> > Would the idea be that you'd turn libsbc from noinst into a proper
>> > library, or would we just move that over into the plugin as well?
>>
>> as Luiz pointed out, that has already been done. It is standalone now
>> with its own GIT tree and a released 1.0 tarball for distributions to
>> package.
>>
>> Regards
>>
>> Marcel

Im about to send a patch to remove this from BlueZ, I hope somebody
from gstreamer community can step up and take the task to move this to
gstreamer tree, if nobody does I will eventually do it but this might
take some time for me since Im quite busy with upcoming BlueZ 5.0
(which is also the reason why we are cleaning up the tree).

-- 
Luiz Augusto von Dentz
