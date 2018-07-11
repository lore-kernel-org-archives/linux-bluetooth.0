Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 11 Jul 2018 16:37:47 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: A2DP backchannel
Message-ID: <20180711143747.lg6ve2lxkfphkftt@pali>
References: <20180711110406.hkcqfjkmxsqq5xqk@pali>
 <CABBYNZJQPJOz75cZ4M8WZO0ZL29ePnsi1V1Y1Rc6S-=DT0ox+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CABBYNZJQPJOz75cZ4M8WZO0ZL29ePnsi1V1Y1Rc6S-=DT0ox+w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 11 July 2018 16:34:14 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Wed, Jul 11, 2018 at 2:04 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> > Hi!
> >
> > Some vendor A2DP bluetooth codecs like FastStream or aptX Low Latency
> > supports backchannel. Which means that they are bi-directional and in
> > A2DP they supports not only (music) playback, but also receiving
> > backchannel (microphone) voice.
> >
> > How to establish this bi-directional A2DP transfer with backchannel via
> > bluez daemon?
> 
> There is no such thing as bi-directional in AVDTP, which is a screw up
> from the spec authors,

So it means that those vendor A2DP codecs somehow extends AVDTP, right?
I would need to figure out how A2DP devices send voice data... At least
backchannel activation for FastStream is via one bit in codec parameters
like other codec parameters.

> luckily we don't have to stick to it since our
> sockets are bi-directional so you can send and receive data at same
> time, though the configuration must be the same in either direction
> otherwise we would have to support transport multiplexing to have
> multiple configuration done using the same channel.

So does it mean that I can read from file descriptor received from dbus
which is used for sending encoded A2DP audio samples? And if other side
(e.g device with FastStream or aptX LL vendor codec) send voice via A2DP
then I receive them on that file descriptor?

-- 
Pali Rohár
pali.rohar@gmail.com
