Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=xGCsnyzdQK=w6qYp6dJE4tg6fHA@mail.gmail.com>
References: <BANLkTi=xGCsnyzdQK=w6qYp6dJE4tg6fHA@mail.gmail.com>
Date: Thu, 19 May 2011 20:41:42 +0300
Message-ID: <BANLkTimBybd1uCJnaDhsA6LHj6nPzp5yXA@mail.gmail.com>
Subject: Re: Audio streaming to 2 A2DP headsets
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vijayalakshmi N <vijayalakshmi.nk@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 19, 2011 at 3:26 PM, Vijayalakshmi N
<vijayalakshmi.nk@gmail.com> wrote:
> Hi,
>
> We have a requirement of establishing A2DP connections to 2 headsets
> simultaniously (on android).
>
> After changing the audio.conf with SBCSources=2, I am able to connect
> to 2 devices from DBUS (audio.sink).
> But this establishes the Signaling channels only.
>
> And the data channel is established when the Media player plays the audio.
>
> But the audio is streamed to only the first device.
>
> Is it possible to establish the data channel to the 2nd device also
> and stream the audio on bluez?
>
> Could anyone please give a hint on this?

BlueZ will take care of the signalling part only, it is not
responsible for streaming anything, so if you expect that by just
connecting 2 headset it will start streaming to both than you are
looking in the wrong place. Android seems to use a library iirc
liba2dp which is responsible for streaming, you should probably have
to change it to be able stream to multiple devices simultaneously.

-- 
Luiz Augusto von Dentz
Computer Engineer
