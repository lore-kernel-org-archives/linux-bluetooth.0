Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180711082352.oo6srapfnol5nkxq@pali>
References: <20180711082352.oo6srapfnol5nkxq@pali>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Jul 2018 16:27:07 +0300
Message-ID: <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
Subject: Re: bluez: dbus method call for switching endpoint
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pali,

On Wed, Jul 11, 2018 at 11:23 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> Hi!
>
> I prepared WIP patch for pulseaudio which adds support for A2DP aptX
> codec (using LGPL libopenaptx library) but there is a one big problem.
>
> https://patchwork.freedesktop.org/patch/236801/
> https://github.com/pali/libopenaptx
>
> bluez dbus API does not provide a way to switch from one codec to
> another once A2DP connection is established.
>
> And to have support for more codecs in pulseaudio (e.g. both SBC and
> aptX) it is needed to export for each codec own endpoint.
>
> I was told that for new connections bluez choose first registered
> endpoint and therefore also codec. But when connection is initiated by
> A2DP device itself, then codec is chosen randomly. And once connection
> is active there is no way to change codec.
>
> Therefore client application (like pulseaudio) have no control on codec
> selection, nor it cannot change codes from one to other.
>
> So for supporting more then one codec in pulseaudio, which means
> anything different as mandatory SBC, it is needed that bluez exports
> some dbus API for changing currently selected codec.
>
> Can you extend bluez daemon for this support?
>
> Also I have an another question, how to get (via dbus API) list of all
> supported codecs by particular A2DP device? This is needed e.g. in GUI
> applications for selecting which codec to use for headset device. And
> select menu should contain only supported codecs.

One way to solve all of these is that we would expose the remote
endpoints using MediaEndpoint1, though only SelectConfiguration would
be really useful here and that doesn't contain the remote capabilities
that probably should be made into properties, along with codec type
and uuid.

Note all of this is only useful as far as manually selecting goes
since I don't think it would be a good idea to torn down streams just
because the codec was not the best one as that may cause the whole
link to be disconnected. Besides a good headset would probably
remember what codec you selected the last time and just connect with
it, this btw is what I would do when operating as a sink.

--=20
Luiz Augusto von Dentz
