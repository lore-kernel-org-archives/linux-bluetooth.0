Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+w=iC=OYz8y=NyLuvdEXfWprDoMuZiqTs+SijU7med9w@mail.gmail.com>
References: <CA+A7VXVEBULPWJpxMeED-QxxG25Az1ckWdL+cudqE0RL7he9Xg@mail.gmail.com>
 <5a3c473313387957bac050067857e22e62d544f5.camel@iki.fi> <CA+A7VXVy=1RjvaQgSyE5M9Hw=QRuy8Ejc0A=pFhtxn1=06ZC3Q@mail.gmail.com>
 <5731aaabb375e5b82945cabff8c315a2ef827cbe.camel@iki.fi> <CA+A7VXU30H_=aZw_Xi2S2iOkPp=nQxfMRTE9msAAX+oh7v1Qvw@mail.gmail.com>
 <CABBYNZ+w=iC=OYz8y=NyLuvdEXfWprDoMuZiqTs+SijU7med9w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 21 Jun 2018 13:27:59 +0300
Message-ID: <CABBYNZKpB5FLDxu2PrAV4P+HGDY1=jWJU_3YjTmgcDjoj36ijg@mail.gmail.com>
Subject: Re: Failure to connect Sony headsets
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: Tanu Kaskinen <tanuk@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        General PulseAudio Discussion
        <pulseaudio-discuss@lists.freedesktop.org>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao,

On Wed, Jun 20, 2018 at 5:47 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Joao,
>
> On Fri, Jun 15, 2018 at 2:33 AM, Jo=C3=A3o Paulo Rechi Vita
> <jprvita@gmail.com> wrote:
>> On Thu, Jun 14, 2018 at 8:27 AM, Tanu Kaskinen <tanuk@iki.fi> wrote:
>>> On Thu, 2018-06-14 at 08:05 -0700, Jo=C3=A3o Paulo Rechi Vita wrote:
>>>> > > I also had to disable module-card-restore, otherwise it tries to
>>>> > > switch to the saved a2dp_sink profile right when the card is creat=
ed,
>>>> > > which also makes the device abort the AVDTP connection for some
>>>> > > reason.
>>>> >
>>>> > This is without increasing the timeout, right, so the problem is tha=
t
>>>> > module-card-restore is trying to restore a2dp_sink before it's
>>>> > available? module-card-restore has been fixed to not to try to resto=
re
>>>> > unavailable profiles:
>>>> > https://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=3Dd659=
74d8501052bafb03e65f5df954511e9949a2
>>>> >
>>>>
>>>> No, this is in addition to increasing the timeout. To have things
>>>> working I need to increase the timeout AND disable
>>>> module-card-restore. Sorry for not being clear about it before.
>>>>
>>>> I will try the commit you pointed, but I don't think it will help
>>>> since, if I'm following this right, the transport is already marked as
>>>> available at this point (I need to double-check on this point though
>>>> -- sorry, too many moving parts).
>>>
>>> If you confirm that module-card-restore indeed has to be disabled even
>>> with the increased timeout, then it would be very interesting to know
>>> what effect module-card-restore has in the card initialization. To me
>>> it seems that it should make no difference, because the a2dp profile is
>>> the default anyway, and all the module does is to choose the initial
>>> profile.
>>>
>>
>> Ok, I have done more testing focusing on this specific point and
>> confirmed we indeed don't need to disable module-card-restore. With
>> the 60s timeout the headset was able to connect successfully 6 times
>> in a row. So for now the only open point is if there is any better fix
>> for these headsets than increasing the timeout.
>
> Im trying to reproduce this with sony sbh50 but apparently it doesn't
> have the same problem as it worked just fine, one thing I notice
> though is that HFP does not connect:
>
> https://gist.github.com/Vudentz/6f385ededcb00d1d0f4403f06923fd1a
>
> As you can see locally we only support HSP which means there is no
> match for MFP, but perhaps you are running with oFono? Anyway I should
> have an mw600 somewhere but that is quite old already, but you
> mentioned it did not work with MDR-XB950N1 which is quite new model?
> Anyway if you can gather some logs of bluetoothd that would be useful
> to identify where is the problem.

Managed to reproduce the issue, if I recall correctly MW600 don't like
that SCO is open before A2DP is configured which is caused by:


   /* Ignore card if has already set other initial profile than a2dp */
    if (card->active_profile &&
        !pa_streq(card->active_profile->name, "a2dp") &&
        !pa_streq(card->active_profile->name, "a2dp_sink"))
        return PA_HOOK_OK;

    /* Set initial profile to hsp */
    card_set_profile(u, card, false);

If I get it correctly the first if statement will not return in case
of A2DP, which basically negates restored profile?, and then it sets
HSP which I find to be the opposite of what we should be doing except
if there already an stream tagged with voice otherwise we shall really
prefer A2DP.

--=20
Luiz Augusto von Dentz
