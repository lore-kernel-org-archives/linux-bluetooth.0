Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4F204BDC.1010007@babioch.de>
References: <4F204BDC.1010007@babioch.de>
Date: Thu, 26 Jan 2012 13:52:00 +0200
Message-ID: <CABBYNZJk+n2Rh4K2J_fc8A_WXjyBwck4qhYcfe6wCmK7vK7t-Q@mail.gmail.com>
Subject: Re: Changed default configuration in bluez 4.97 and higher?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Karol Babioch <karol@babioch.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Karol,

On Wed, Jan 25, 2012 at 8:37 PM, Karol Babioch <karol@babioch.de> wrote:
> Hi,
>
> I'm wondering whether there has been made any change to the default
> configuration of bluez 4.97 and/or 4.98? I've looked at the changelog,
> but combined with the release notes it looks to me as they were "simple"
> bug fixing releases. At least there is no mention of a change of the
> default configuration or something like that.
>
> However I'm experiencing trouble with these releases using my bluetooth
> headset (A2DP). To be honest I'm using gnome-bluetooth and not that
> experienced with the command line tools, but starting with 4.97 it is no
> longer possible to use my headset as an audio output device, although it
> is possible to discover it and to connect to it. But after the
> connection has been established it doesn't even get recognized by
> PulseAudio.
>
> I now got it working again by adding "Enable=Socket" in the audio.conf
> file. However I'm not sure whether this was changed intentional, because
> it worked out-of-the-box beforehand and I guess a basic A2DP setup is
> supposed to do so.
>
> There are at least two other guys affected by this, see [1]. So before
> filing a bug in the bug tracking system of my distribution and asking
> for inclusion of the above option, I would like to know why this was
> changed and whether this is intentional or not.

This is intentional as unix socket is considered deprecated now,
probably PA should be updated in your system as it seems it is lacking
support for Media D-Bus API which is now the default mechanism to
control A2DP stream. Note that Media API was introduced one year ago
and it is currently used in production in systems such as MeeGo
Harmattan aka Nokia N9.

-- 
Luiz Augusto von Dentz
