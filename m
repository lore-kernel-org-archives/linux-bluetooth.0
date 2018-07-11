Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180711110406.hkcqfjkmxsqq5xqk@pali>
References: <20180711110406.hkcqfjkmxsqq5xqk@pali>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Jul 2018 16:34:14 +0300
Message-ID: <CABBYNZJQPJOz75cZ4M8WZO0ZL29ePnsi1V1Y1Rc6S-=DT0ox+w@mail.gmail.com>
Subject: Re: bluez: A2DP backchannel
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pali,

On Wed, Jul 11, 2018 at 2:04 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> Hi!
>
> Some vendor A2DP bluetooth codecs like FastStream or aptX Low Latency
> supports backchannel. Which means that they are bi-directional and in
> A2DP they supports not only (music) playback, but also receiving
> backchannel (microphone) voice.
>
> How to establish this bi-directional A2DP transfer with backchannel via
> bluez daemon?

There is no such thing as bi-directional in AVDTP, which is a screw up
from the spec authors, luckily we don't have to stick to it since our
sockets are bi-directional so you can send and receive data at same
time, though the configuration must be the same in either direction
otherwise we would have to support transport multiplexing to have
multiple configuration done using the same channel.

--=20
Luiz Augusto von Dentz
