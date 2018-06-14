Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <5731aaabb375e5b82945cabff8c315a2ef827cbe.camel@iki.fi>
Subject: Re: Failure to connect Sony headsets
From: Tanu Kaskinen <tanuk@iki.fi>
To: =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        General PulseAudio Discussion
        <pulseaudio-discuss@lists.freedesktop.org>,
        =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita
        <jprvita@endlessm.com>, linux@endlessm.com
Date: Thu, 14 Jun 2018 18:27:49 +0300
In-Reply-To: <CA+A7VXVy=1RjvaQgSyE5M9Hw=QRuy8Ejc0A=pFhtxn1=06ZC3Q@mail.gmail.com>
References: <CA+A7VXVEBULPWJpxMeED-QxxG25Az1ckWdL+cudqE0RL7he9Xg@mail.gmail.com>
         <5a3c473313387957bac050067857e22e62d544f5.camel@iki.fi>
         <CA+A7VXVy=1RjvaQgSyE5M9Hw=QRuy8Ejc0A=pFhtxn1=06ZC3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2018-06-14 at 08:05 -0700, João Paulo Rechi Vita wrote:
> > > I also had to disable module-card-restore, otherwise it tries to
> > > switch to the saved a2dp_sink profile right when the card is created,
> > > which also makes the device abort the AVDTP connection for some
> > > reason.
> > 
> > This is without increasing the timeout, right, so the problem is that
> > module-card-restore is trying to restore a2dp_sink before it's
> > available? module-card-restore has been fixed to not to try to restore
> > unavailable profiles:
> > https://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=d65974d8501052bafb03e65f5df954511e9949a2
> > 
> 
> No, this is in addition to increasing the timeout. To have things
> working I need to increase the timeout AND disable
> module-card-restore. Sorry for not being clear about it before.
> 
> I will try the commit you pointed, but I don't think it will help
> since, if I'm following this right, the transport is already marked as
> available at this point (I need to double-check on this point though
> -- sorry, too many moving parts).

If you confirm that module-card-restore indeed has to be disabled even
with the increased timeout, then it would be very interesting to know
what effect module-card-restore has in the card initialization. To me
it seems that it should make no difference, because the a2dp profile is
the default anyway, and all the module does is to choose the initial
profile.

-- 
Tanu

https://liberapay.com/tanuk
https://www.patreon.com/tanuk
