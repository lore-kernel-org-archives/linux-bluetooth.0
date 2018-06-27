Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+A7VXWVtfLNPckCprxKrSV+k20Pj-r+F_VkWu6h3iY+8qNwDA@mail.gmail.com>
References: <CA+A7VXVEBULPWJpxMeED-QxxG25Az1ckWdL+cudqE0RL7he9Xg@mail.gmail.com>
 <5a3c473313387957bac050067857e22e62d544f5.camel@iki.fi> <CA+A7VXVy=1RjvaQgSyE5M9Hw=QRuy8Ejc0A=pFhtxn1=06ZC3Q@mail.gmail.com>
 <5731aaabb375e5b82945cabff8c315a2ef827cbe.camel@iki.fi> <CA+A7VXU30H_=aZw_Xi2S2iOkPp=nQxfMRTE9msAAX+oh7v1Qvw@mail.gmail.com>
 <CABBYNZ+w=iC=OYz8y=NyLuvdEXfWprDoMuZiqTs+SijU7med9w@mail.gmail.com>
 <CABBYNZKpB5FLDxu2PrAV4P+HGDY1=jWJU_3YjTmgcDjoj36ijg@mail.gmail.com>
 <CA+A7VXVJkGaZA3ZOb4F3dD1i1h9PQXXMpL2St+kRQdRJSq9g-A@mail.gmail.com>
 <CABBYNZ+FD1sJ7SwS1SP7qoQ-W4PMfYQoWvHZ0_TCbVyCpzKasw@mail.gmail.com> <CA+A7VXWVtfLNPckCprxKrSV+k20Pj-r+F_VkWu6h3iY+8qNwDA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 27 Jun 2018 11:15:32 +0300
Message-ID: <CABBYNZLRQZY3ownapZFQPhF766H+_h7Fd5phq933VYYAe4NOnA@mail.gmail.com>
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

On Tue, Jun 26, 2018 at 6:41 PM, Jo=C3=A3o Paulo Rechi Vita
<jprvita@gmail.com> wrote:
> Hello,
>
> On Tue, Jun 26, 2018 at 3:55 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Joao,
>>
>> On Thu, Jun 21, 2018 at 10:21 PM, Jo=C3=A3o Paulo Rechi Vita
>> <jprvita@gmail.com> wrote:
>>>
>>> I'm adding some extra debug around the initial profile selection to
>>> have a clear picture of what is going on there and will keep analyzing
>>> this further. I'll get back when I have something, now that I have a
>>> better idea of what to look for, but any insights are welcome in the
>>> meantime.
>>
>> Just a heads up Ive sent a patch for BlueZ that shoud fix this for
>> MW600, it turns out the device did not reconnect A2DP after HFP and
>> would only do that is SCO is connected which is too late.
>
> That is great news, although I don't see any new patch on the list.
> Can you share a link?
>
> Just to add more info (although it may not be super useful at this
> point), on the past few days I've been experimenting with how
> module-card-restore is affecting this problem, combined with
> increasing WAIT_FOR_PROFILES_TIMEOUT_USEC to 60s and got the following
> summary:
>
> WAIT_FOR_PROFILES_TIMEOUT_USEC=3D60s, module-card-restore restores A2DP:
> a2dp_sink available: Yes, headset_head_unit available: Yes, active
> profile: a2dp_sink
> WAIT_FOR_PROFILES_TIMEOUT_USEC=3D60s, module-card-restore restores HSP:
> a2dp_sink available: No, headset_head_unit available: Yes, active
> profile: headset_head_unit
> WAIT_FOR_PROFILES_TIMEOUT_USEC=3D3s, module-card-restore restores HSP:
> a2dp_sink available: No, headset_head_unit available: No, active
> profile: None -- card removed
> WAIT_FOR_PROFILES_TIMEOUT_USEC=3D3s, no module-card-restore: a2dp_sink
> available: No, headset_head_unit available: No, active profile: None
> -- card removed
> WAIT_FOR_PROFILES_TIMEOUT_USEC=3D3s, module-card-restore tries to
> restore a2dp_sink but it does not because it is not available:
> a2dp_sink available: No, headset_head_unit available: No, active
> profile: None, card removed
> WAIT_FOR_PROFILES_TIMEOUT_USEC=3D3s, module-card-restore restores A2DP
> (this is without the patch that makes m-c-r ignore unavailble
> profiles, just for testing): a2dp_sink available: Yes,
> headset_head_unit available: Yes, active profile: off
>
> Also, I've tried to make module-bluez5-device avoid acquiring the
> transport right away when the card is created and have the source/sink
> be created suspended, deferring the audio connection establishment to
> when there is an actual stream to be transferred (which should resume
> the sink) or we get an incoming connection. But I looks like I have
> messed up the state machine while doing that and the source/sink was
> never resumed, which is not really useful. I going to try your BlueZ
> fix first (when I find it), and after that we can see if there is
> anything else that needs to be fixed in PulseAudio.

Ive pushed the fix, at least MW600 reconnects properly.

>> Anyway I
>> briefly discussed with Tanu about the ordering of initial profile
>> shall be bluetooth-policy first than restore since that means restore
>> is run last overriding any profile set by bluetooth-policy in case the
>> user has set anything as preference.
>>
>
> In my tests module-bluetooth-policy was not affecting this problem at
> all since it was not taking any actions on these profiles (and I
> didn't have any media.role=3Dphone stream active). Are you trying to
> address a different problem with that change?
>
> My initial thought is that module-card-restore does more harm then
> good for UX with Bluetooth headsets, actually. It sure was useful when
> module-bluetooth-policy did not exist, but I think a good user
> experience is based on dynamically adapting according to which streams
> are active at a certain moment, instead of user input. This is mostly
> covered by module-bluetooth-policy + module-role-{cork,ducking}, but I
> don't think anything switches the profile to A2DP when there is a
> "high-quality" stream playing if module-card-restore initially set the
> profile to headset_head_sink. Maybe this is more of a UI bug and a
> user-focused UI should not expose means for the user to manually
> select the profile, which is aligned with a previous comment from
> Tanu:
>
>> On Thu, Jun 14, 2018 at 4:57 AM, Tanu Kaskinen <tanuk@iki.fi> wrote:
>>
>> If module-bluetooth-policy is sufficient, then module-card-restore
>> won't do anything anyway, because you never set the profile manually.
>> If you ever set the profile manually, that's an indication that module-
>> bluetooth-policy isn't always good enough.
>
> Still, I think the general user will only manually change the profile
> either if things go wrong for some reason, or before PulseAudio 12,
> because HSP/HFP was selected by default. If they leave the setting on
> the "wrong profile", it affects their experience next time using the
> headset, despite if it is right afterwards or months later, or if the
> headset has been removed and paired with a different machine in the
> meantime. Again, it may be a UI issue after all, but comparing to
> Android/iPhone (which is what a lot of users are likely to have
> previous experience with), there is not even a way for users to
> manually set the active profile for headsets. They can enable/disable
> a profile for an specific headset on Android tho, which gives them
> some sort of control. I don't think there is any client API for
> disabling profiles on cards, but maybe that could be a good
> alternative?

Yep, I guess having only one policy module is actually better in this
case so perhaps restore need to check if bluetooth-policy is loaded
and then ignore any bluetooth card.

> I realized automatic audio routing is a hot-topic and I may be missing
> some alternatives or other previous discussions -- please point me to
> them if that is the case.
>
> --
> Jo=C3=A3o Paulo Rechi Vita
> http://about.me/jprvita



--=20
Luiz Augusto von Dentz
