Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <5a3c473313387957bac050067857e22e62d544f5.camel@iki.fi>
Subject: Re: Failure to connect Sony headsets
From: Tanu Kaskinen <tanuk@iki.fi>
To: =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
        General PulseAudio Discussion
        <pulseaudio-discuss@lists.freedesktop.org>,
        =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita
        <jprvita@endlessm.com>, linux@endlessm.com
Date: Thu, 14 Jun 2018 14:57:48 +0300
In-Reply-To: <CA+A7VXVEBULPWJpxMeED-QxxG25Az1ckWdL+cudqE0RL7he9Xg@mail.gmail.com>
References: <CA+A7VXVEBULPWJpxMeED-QxxG25Az1ckWdL+cudqE0RL7he9Xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2018-06-14 at 00:05 -0700, João Paulo Rechi Vita wrote:
> Hello Luiz and Tanuk,
> 
> I have been trying to understand a problem when trying to establish a
> connection between my Sony MW-600 headset and my laptop (PulseAudio
> 11.1 + a backport that gives higher priority to A2DP, BlueZ 5.47,
> Linux 4.16.9). When the connection is initiated by the peripheral,
> after it has already been paired on a previous connection, the
> peripheral does not remain connected. When the computer initiates the
> connection everything works fine. The problem seems to be that when we
> create the card in PulseAudio is created before the AVDTP connection
> reaches the OPEN state, the headset decides to abort the AVDTP
> connection. In this case the card was created before the transport for
> the card profile a2dp_sink is available and headset_head_unit was the
> active profile, because WAIT_FOR_PROFILES_TIMEOUT_USEC was reached.
> 
> Increasing the timeout to 60s makes the problem go away. The AVDTP
> channel becomes connected about 50s after the HSP connection has
> started and the card is created with a2dp_sink as the active profile.

Maybe we could increase the timeout. A long timeout doesn't matter with
properly working hardware, because the wait is terminated as soon as
all advertised profiles have become connected.

> I also had to disable module-card-restore, otherwise it tries to
> switch to the saved a2dp_sink profile right when the card is created,
> which also makes the device abort the AVDTP connection for some
> reason.

This is without increasing the timeout, right, so the problem is that
module-card-restore is trying to restore a2dp_sink before it's
available? module-card-restore has been fixed to not to try to restore
unavailable profiles:
https://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=d65974d8501052bafb03e65f5df954511e9949a2

> I have collected btmon dumps with a slightly modified version of btmon
> to avoid flooding the logs with SCO data and uploaded to
> https://gist.github.com/jprvita/a7482db4601d099788c4f820ea984ba9.
> 
> Similar symptoms have been reported by our QA team with another Sony
> model (MDR-XB950N1) and with a few Chinese headsets, but the MW-600 is
> the only one I have access to where I can reproduce the problem
> consistently (works fine on a Sennheiser MM-450 and a JBL Flip 2).
> 
> Also, the involvement of module-card-restore in this problem made me
> think whether it actually makes sense to restore the active profile
> from the previous connection on bluetooth cards, since we already have
> module-bluetooth-policy to automatically select the right profile
> depending on the stream type.

If module-bluetooth-policy is sufficient, then module-card-restore
won't do anything anyway, because you never set the profile manually.
If you ever set the profile manually, that's an indication that module-
bluetooth-policy isn't always good enough.

> Please let me know if you can help me understand what is making the
> headset decide to disconnect AVDTP in these cases, and what is the
> best way to fix this, or any ideas that may help investigating this
> further.

This is outside of my area of expertise. Could you just clarify one
thing: did I understand correctly that if you increase the profile
waiting timeout, then the headset doesn't disconnect AVDTP? So
everything works perfectly, except that the connection takes a very
long time?

-- 
Tanu

https://liberapay.com/tanuk
https://www.patreon.com/tanuk
