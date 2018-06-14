Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5a3c473313387957bac050067857e22e62d544f5.camel@iki.fi>
References: <CA+A7VXVEBULPWJpxMeED-QxxG25Az1ckWdL+cudqE0RL7he9Xg@mail.gmail.com>
 <5a3c473313387957bac050067857e22e62d544f5.camel@iki.fi>
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date: Thu, 14 Jun 2018 08:05:21 -0700
Message-ID: <CA+A7VXVy=1RjvaQgSyE5M9Hw=QRuy8Ejc0A=pFhtxn1=06ZC3Q@mail.gmail.com>
Subject: Re: Failure to connect Sony headsets
To: Tanu Kaskinen <tanuk@iki.fi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        General PulseAudio Discussion
        <pulseaudio-discuss@lists.freedesktop.org>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>,
        linux@endlessm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Tanu!

On Thu, Jun 14, 2018 at 4:57 AM, Tanu Kaskinen <tanuk@iki.fi> wrote:
> On Thu, 2018-06-14 at 00:05 -0700, Jo=C3=A3o Paulo Rechi Vita wrote:
>> Hello Luiz and Tanuk,
>>
>> I have been trying to understand a problem when trying to establish a
>> connection between my Sony MW-600 headset and my laptop (PulseAudio
>> 11.1 + a backport that gives higher priority to A2DP, BlueZ 5.47,
>> Linux 4.16.9). When the connection is initiated by the peripheral,
>> after it has already been paired on a previous connection, the
>> peripheral does not remain connected. When the computer initiates the
>> connection everything works fine. The problem seems to be that when we
>> create the card in PulseAudio is created before the AVDTP connection
>> reaches the OPEN state, the headset decides to abort the AVDTP
>> connection. In this case the card was created before the transport for
>> the card profile a2dp_sink is available and headset_head_unit was the
>> active profile, because WAIT_FOR_PROFILES_TIMEOUT_USEC was reached.
>>
>> Increasing the timeout to 60s makes the problem go away. The AVDTP
>> channel becomes connected about 50s after the HSP connection has
>> started and the card is created with a2dp_sink as the active profile.
>
> Maybe we could increase the timeout. A long timeout doesn't matter with
> properly working hardware, because the wait is terminated as soon as
> all advertised profiles have become connected.
>

Yes, I thought about it, but first I wanted to hear from Luiz (who
knows the audio specs inside out) if something in this flow might be
hitting the headset to terminate the connection, and if we could
improve it. I'm wondering iif the fact that creating the sink/source
right away, which leads to the SCO channel being established, is what
is making the headset decide it should disconnect A2DP. But I still
don't understand why the headset would also disconnect the RFCOMM link
(changing the transport in PulseAudio from idle to disconnected) after
we change the transport from playing to idle and release the SCO fd
when the sink/source get suspended (in my experience, this only
happens if A2DP is also not connected due to the failure mentioned
above).

>> I also had to disable module-card-restore, otherwise it tries to
>> switch to the saved a2dp_sink profile right when the card is created,
>> which also makes the device abort the AVDTP connection for some
>> reason.
>
> This is without increasing the timeout, right, so the problem is that
> module-card-restore is trying to restore a2dp_sink before it's
> available? module-card-restore has been fixed to not to try to restore
> unavailable profiles:
> https://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=3Dd65974d85=
01052bafb03e65f5df954511e9949a2
>

No, this is in addition to increasing the timeout. To have things
working I need to increase the timeout AND disable
module-card-restore. Sorry for not being clear about it before.

I will try the commit you pointed, but I don't think it will help
since, if I'm following this right, the transport is already marked as
available at this point (I need to double-check on this point though
-- sorry, too many moving parts).

>> I have collected btmon dumps with a slightly modified version of btmon
>> to avoid flooding the logs with SCO data and uploaded to
>> https://gist.github.com/jprvita/a7482db4601d099788c4f820ea984ba9.
>>
>> Similar symptoms have been reported by our QA team with another Sony
>> model (MDR-XB950N1) and with a few Chinese headsets, but the MW-600 is
>> the only one I have access to where I can reproduce the problem
>> consistently (works fine on a Sennheiser MM-450 and a JBL Flip 2).
>>
>> Also, the involvement of module-card-restore in this problem made me
>> think whether it actually makes sense to restore the active profile
>> from the previous connection on bluetooth cards, since we already have
>> module-bluetooth-policy to automatically select the right profile
>> depending on the stream type.
>
> If module-bluetooth-policy is sufficient, then module-card-restore
> won't do anything anyway, because you never set the profile manually.
> If you ever set the profile manually, that's an indication that module-
> bluetooth-policy isn't always good enough.
>

I agree with the theory behind this argument, but in practice most
users will switch from HSP/HFP to A2DP after the first connection,
since it has higher priority until PulseAudio 11. So there will be an
entry for it in module-card-restore's DB, which I believe does not get
removed when the user "un-pairs" the headset and the computer.

>> Please let me know if you can help me understand what is making the
>> headset decide to disconnect AVDTP in these cases, and what is the
>> best way to fix this, or any ideas that may help investigating this
>> further.
>
> This is outside of my area of expertise. Could you just clarify one
> thing: did I understand correctly that if you increase the profile
> waiting timeout, then the headset doesn't disconnect AVDTP? So
> everything works perfectly, except that the connection takes a very
> long time?
>

If I increase the timeout AND disable module-bluetooth-restore,
everything works as expected except that it takes 50-60s for the audio
card to appear after turning the headset on.

Thanks for the help!

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
