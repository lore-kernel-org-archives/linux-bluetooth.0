Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCWNUkTW9pmcvuDEhaEuSxdhphYLwvQkSYz5dLvYE2ENjg@mail.gmail.com>
References: <CANT-zCWNUkTW9pmcvuDEhaEuSxdhphYLwvQkSYz5dLvYE2ENjg@mail.gmail.com>
Date: Tue, 18 Dec 2012 11:19:07 +0100
Message-ID: <CANT-zCVXOjncycx6GSghO6T5y3TEM0FDA1Ke3W8FZSE=ZOhbVQ@mail.gmail.com>
Subject: Re: PulseAudio branch to test BlueZ master
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tanu Kaskinen <tanuk@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Thu, Dec 6, 2012 at 5:03 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> Hi all,
>
> It's been recently quite hard to test the audio part of BlueZ without
> having an updated PulseAudio which keeps up with the new D-Bus API in
> BlueZ.
>
> I've been doing some work to solve this and here you have the result:
> git://github.com/mastiz/pulseaudio-bluez5.git

I just updated the PulseAudio branch to test the BlueZ 5 API and the
patches for oFono. It's once again in:
git://github.com/mastiz/pulseaudio-bluez5.git branch bluez5-head

The main changes include the rebase on top of a more recent PA "next"
branch and some minor fixes. In addition, the feedback from Vinicious
has been integrated, affecting the PropertiesChanged signals from
oFono to PA.

> It's a big patchset on top of Tanu's next branch for PulseAudio. Only
> the last patches are related to BlueZ 5, and the rest should slowly
> get merged into PA master, in some way or another (first patches
> already submitted upstream).

Many of these patches are now merged in the "next" PA branch, so the
remaining patches are BlueZ 5-specific (except the first one).

> I warn you that it's not going to be stable in general, and in
> particular I haven't done any testing with oFono. So I'd expect quite
> a few issues.

For the first time, I got HFP working with BlueZ+oFono+PA. Still
unstable though.

On the other hand, A2DP is not working for me any more. I think this
might be an unrelated issue, probably a regression in BlueZ, but I
have to do further research.

> Consider this work-in-progress and note that it will get rebased
> periodically on top of Tanu's tree. If you have any feedback or code
> contributions, I'd suggest you contact me directly.

I will post the patches as RFC to PA mailing list once Tanu's "next"
branch gets merged into master.

Cheers,
Mikel
