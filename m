Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 11 Jul 2018 10:23:52 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: bluez: dbus method call for switching endpoint
Message-ID: <20180711082352.oo6srapfnol5nkxq@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

I prepared WIP patch for pulseaudio which adds support for A2DP aptX
codec (using LGPL libopenaptx library) but there is a one big problem.

https://patchwork.freedesktop.org/patch/236801/
https://github.com/pali/libopenaptx

bluez dbus API does not provide a way to switch from one codec to
another once A2DP connection is established.

And to have support for more codecs in pulseaudio (e.g. both SBC and
aptX) it is needed to export for each codec own endpoint.

I was told that for new connections bluez choose first registered
endpoint and therefore also codec. But when connection is initiated by
A2DP device itself, then codec is chosen randomly. And once connection
is active there is no way to change codec.

Therefore client application (like pulseaudio) have no control on codec
selection, nor it cannot change codes from one to other.

So for supporting more then one codec in pulseaudio, which means
anything different as mandatory SBC, it is needed that bluez exports
some dbus API for changing currently selected codec.

Can you extend bluez daemon for this support?

Also I have an another question, how to get (via dbus API) list of all
supported codecs by particular A2DP device? This is needed e.g. in GUI
applications for selecting which codec to use for headset device. And
select menu should contain only supported codecs.

-- 
Pali Rohár
pali.rohar@gmail.com
