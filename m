Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1312406086.3358.187.camel@THOR>
References: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
	<1312406086.3358.187.camel@THOR>
Date: Thu, 4 Aug 2011 11:20:51 +0300
Message-ID: <CABBYNZ+ZLJd17xMS1LpMn92T04gGKr7xGxe6eMbWOa_3k+tFfQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] RFC: prioritizing data over HCI
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Aug 4, 2011 at 12:14 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Hi Luiz,
>
> On Wed, 2011-08-03 at 09:11 -0400, Luiz Augusto von Dentz wrote:
> ....
>> The main use case for this is A2DP, many people complained that when they
>> are using their HID devices (mouses) together with headset the mouse has
>> higher priority, which btw is not true since currently there is no
>> priority and connections receives the same quote.
>>
>> With this changes it may reduce the problem since PulseAudio already sets
>> A2DP socket as low latency (priority 6), which means audio packets will be
>> processed before the HID packets, but this only affects tx and there still
>> exist the problem of some HID not letting us being master.
>
> What packets are being transmitted _to_ the HID devices during audio
> streaming?  In all my captures of A2DP crackle/skips, there's not a
> single HID packet being transmitted out. Of course, I was carefully not
> to press any of the led-transition keys during the capture :).

Well with HID you will probably be only receiving, but that doesn't
change anything does it? I mean you still got less bandwidth to use
and we probably want low latency packets to be prioritized in any
case, besides there is probably some use case where HID transmit too,
see net/bluetooth/hidp/core.c:666(hidp_process_transmit).

> It's my belief that the incredibly complicated way that PulseAudio
> handles the stream indices and computed latency is really the issue (at
> least with A2DP).

Really, so you have a fix for that? I would be happy to see your
proposal and discussion on PulseAudio mailing list.

> For example, in several configuration I have, PulseAudio is rendering
> *too fast*. This is evidenced by the remote device sending STOP packets
> (which can flood the syslog as 0-length L2CAP packets) because its recv
> buffers are full! (Of course, these DM1 packets are eating up air time
> too -- which is slowing legitimate rx packets from the HID devices!)

But why the kernel is not stopping PulseAudio? I mean PA does use
POLLOUT to check if the socket is writable, it then writes as much as
possible and sleep, but without using guaranteed channels with proper
QoS support I don't this changing anytime soon.

> You should hear the 'skipping' when the sleep timer which delays the
> next block render is IFDEF'd out of the
> module-bluetooth-device.c/threadfn(). With other subsystems but not with
> Bluez, PulseAudio uses a 'smoother' to fine-tune when to render the next
> block.

This can be fixed, the source already uses the smoother anyway, but Im
afraid this can cause bad effects like much frequent wakeups and even
auto of sync with some headsets.

> My point here is I think it's premature to conclude that PulseAudio
> doesn't have a part to play.

It probably does, but it doesn't change the fact the prioritization is
pretty much needed, actually it will probably make such problems more
visible than ever.

-- 
Luiz Augusto von Dentz
