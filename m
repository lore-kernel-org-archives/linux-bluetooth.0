Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 6 Dec 2012 17:03:39 +0100
Message-ID: <CANT-zCWNUkTW9pmcvuDEhaEuSxdhphYLwvQkSYz5dLvYE2ENjg@mail.gmail.com>
Subject: PulseAudio branch to test BlueZ master
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

It's been recently quite hard to test the audio part of BlueZ without
having an updated PulseAudio which keeps up with the new D-Bus API in
BlueZ.

I've been doing some work to solve this and here you have the result:
git://github.com/mastiz/pulseaudio-bluez5.git

It's a big patchset on top of Tanu's next branch for PulseAudio. Only
the last patches are related to BlueZ 5, and the rest should slowly
get merged into PA master, in some way or another (first patches
already submitted upstream).

I warn you that it's not going to be stable in general, and in
particular I haven't done any testing with oFono. So I'd expect quite
a few issues.

Consider this work-in-progress and note that it will get rebased
periodically on top of Tanu's tree. If you have any feedback or code
contributions, I'd suggest you contact me directly.

Cheers,
Mikel
