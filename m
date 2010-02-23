Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100223125854.GA22065@8planets.net>
References: <20100223125854.GA22065@8planets.net>
Date: Tue, 23 Feb 2010 22:14:49 +0200
Message-ID: <2d5a2c101002231214n37b61a6bt5106b6c68ec0bb2@mail.gmail.com>
Subject: Re: A2DP sink indications + autoclose after suspension
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jacek Szczech <jszczech@8planet.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2010/2/23 Jacek Szczech <jszczech@8planet.net>:
> Hi,
>
> I succeeded writing a program that receives a2dp stream (from my mobile
> phone), decodes and sends to stdout using unix/ipc interface. It'll be run on
> old hw without X enviroment, that's why I didn't use already available
> software (like pulseaudio).
>
> I faced a few problems connected with suspension of stream:
>
> 1) Unix.c does not support indications (am I right?). How can I detect changes
> of states (e.g. OPEN<->STREAMING)? I can detect suspension with EAGAIN on
> stream_fd but it does not seem to be proper solution. Do you plan to support
> indications in unix/ipc interface?

You can listen for State on Audio interface or in the profile specific
interfaces such as AudioSource/AudioSink/Headset.

> 2) Will it be possible to get indications concerning OPEN<->STREAMING changes
> on dbus Media interface?

Media interface is just for endpoint registration, but again you can
achieve the same by listen to State changes e.g. Connected <-> Playing

> 3) After suspension of stream (SUSPEND sent from SRC) the stream
> is CLOSEd after about 10 seconds. What part of code disconnects this? Is it a
> way to avoid this?

Afaik this is not triggered if there is a unix client holding a lock,
so if e.g. the headset reconnects you have to claim the socket
otherwise it will timeout.

-- 
Luiz Augusto von Dentz
Computer Engineer
