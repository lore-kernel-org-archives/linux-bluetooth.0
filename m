Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <k2h2c3916b71004040340t63dccd5bj11953c26d826d98f@mail.gmail.com>
References: <k2h2c3916b71004040340t63dccd5bj11953c26d826d98f@mail.gmail.com>
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date: Sun, 4 Apr 2010 13:14:35 +0000
Message-ID: <k2qaa32413d1004040614h91fa69caq5ef65a1b974ebe1f@mail.gmail.com>
Subject: Re: Question about BlueZ's configure script
To: Daniel Abraham <daniel.shrugged@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Apr 4, 2010 at 10:40, Daniel Abraham <daniel.shrugged@gmail.com> wrote:
> In BlueZ's README, dev packages for ALSA, Gstreamer (+ plugins base),
> and libsnd are not listed as required or even optional.
>
> However, the configure script does look for them (although it doesn't
> fail if they're missing).
>
> So my question is: why does it look for them? How do they affect BlueZ
> compilation/functionality?
>

Bluetooth audio profiles are implemented in 3 different ways: as an
ALSA driver (soon-to-be deprecated), GStreamer elements (SBC decoder,
A2DP sink, etc), and PulseAudio modules (recommended). These last ones
lives on PulseAudio's tree, the other two live on bluez' tree, so if
configure finds it's headers it enables compilation of the respective
modules.

-- 
João Paulo Rechi Vita
http://jprvita.wordpress.com/
