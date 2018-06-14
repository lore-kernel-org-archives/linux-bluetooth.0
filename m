Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5731aaabb375e5b82945cabff8c315a2ef827cbe.camel@iki.fi>
References: <CA+A7VXVEBULPWJpxMeED-QxxG25Az1ckWdL+cudqE0RL7he9Xg@mail.gmail.com>
 <5a3c473313387957bac050067857e22e62d544f5.camel@iki.fi> <CA+A7VXVy=1RjvaQgSyE5M9Hw=QRuy8Ejc0A=pFhtxn1=06ZC3Q@mail.gmail.com>
 <5731aaabb375e5b82945cabff8c315a2ef827cbe.camel@iki.fi>
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date: Thu, 14 Jun 2018 16:33:48 -0700
Message-ID: <CA+A7VXU30H_=aZw_Xi2S2iOkPp=nQxfMRTE9msAAX+oh7v1Qvw@mail.gmail.com>
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

On Thu, Jun 14, 2018 at 8:27 AM, Tanu Kaskinen <tanuk@iki.fi> wrote:
> On Thu, 2018-06-14 at 08:05 -0700, Jo=C3=A3o Paulo Rechi Vita wrote:
>> > > I also had to disable module-card-restore, otherwise it tries to
>> > > switch to the saved a2dp_sink profile right when the card is created=
,
>> > > which also makes the device abort the AVDTP connection for some
>> > > reason.
>> >
>> > This is without increasing the timeout, right, so the problem is that
>> > module-card-restore is trying to restore a2dp_sink before it's
>> > available? module-card-restore has been fixed to not to try to restore
>> > unavailable profiles:
>> > https://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=3Dd65974=
d8501052bafb03e65f5df954511e9949a2
>> >
>>
>> No, this is in addition to increasing the timeout. To have things
>> working I need to increase the timeout AND disable
>> module-card-restore. Sorry for not being clear about it before.
>>
>> I will try the commit you pointed, but I don't think it will help
>> since, if I'm following this right, the transport is already marked as
>> available at this point (I need to double-check on this point though
>> -- sorry, too many moving parts).
>
> If you confirm that module-card-restore indeed has to be disabled even
> with the increased timeout, then it would be very interesting to know
> what effect module-card-restore has in the card initialization. To me
> it seems that it should make no difference, because the a2dp profile is
> the default anyway, and all the module does is to choose the initial
> profile.
>

Ok, I have done more testing focusing on this specific point and
confirmed we indeed don't need to disable module-card-restore. With
the 60s timeout the headset was able to connect successfully 6 times
in a row. So for now the only open point is if there is any better fix
for these headsets than increasing the timeout.

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
