Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
References: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
Date: Mon, 10 Oct 2011 17:11:07 +0300
Message-ID: <CABBYNZK_4ZMk84t+EVN1Ukz+NvKnt20jSsGL4yBbTz=UvzvnfQ@mail.gmail.com>
Subject: Re: A2DP quality (bluetooth-alsa)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "qduaty@gmail.com" <qduaty@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 10, 2011 at 1:40 PM, qduaty@gmail.com <qduaty@gmail.com> wrote:
> Hi people,
>
> I found that I cannot set A2DP bitpool to anything more than 53 in my
> ~/.asoundrc file. The bluetooth driver reports an error and keeps
> reporting it (becomes useless) until it is restarted.

It can be 2 things, either a bug or the device maximum bitpool is
actually 53 so we cannot negotiate it.

> Bitpool values as high as 128 are possible on Windows Mobile devices
> (including mine), which means they are possible in A2DP. Such a high
> value is necessary for some genres of current music, which are highly
> compressed (the problem was once discussed in one of Xiph Foundation's
> articles). SBC is unable to encode such material properly if it
> doesn't have enough bandwidth.

PulseAudio uses 64 as bitpool maximum and it seems to work fine, but
that depends on available bandwidth, in fact PA reduces the bitpool if
it detects the audio is skipping.

> I don't understand Bluetooth. So I'm asking you for an advice:
> 1. Is it actually possible to set SBC bitpool in linux' A2DP to more than 53?
> 2. If it is, can I ask for a short success story in order to reproduce it?
> 2. If not, where should I start (in bluez source code) in order to fix
> this problem?

Take a look a PulseAudio or BlueZ source tree (audio/pcm_bluetooth.c)

-- 
Luiz Augusto von Dentz
