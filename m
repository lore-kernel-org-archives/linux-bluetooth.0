Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <564280aab3ce4b55b064e102e286cd112fa7085d.camel@iki.fi>
Subject: Re: Failure to connect Sony headsets
From: Tanu Kaskinen <tanuk@iki.fi>
To: =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        General PulseAudio Discussion
        <pulseaudio-discuss@lists.freedesktop.org>,
        =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita
        <jprvita@endlessm.com>, Linux Upstreaming Team <linux@endlessm.com>
Date: Wed, 27 Jun 2018 10:08:51 +0300
In-Reply-To: <CA+A7VXWVtfLNPckCprxKrSV+k20Pj-r+F_VkWu6h3iY+8qNwDA@mail.gmail.com>
References: <CA+A7VXVEBULPWJpxMeED-QxxG25Az1ckWdL+cudqE0RL7he9Xg@mail.gmail.com>
         <5a3c473313387957bac050067857e22e62d544f5.camel@iki.fi>
         <CA+A7VXVy=1RjvaQgSyE5M9Hw=QRuy8Ejc0A=pFhtxn1=06ZC3Q@mail.gmail.com>
         <5731aaabb375e5b82945cabff8c315a2ef827cbe.camel@iki.fi>
         <CA+A7VXU30H_=aZw_Xi2S2iOkPp=nQxfMRTE9msAAX+oh7v1Qvw@mail.gmail.com>
         <CABBYNZ+w=iC=OYz8y=NyLuvdEXfWprDoMuZiqTs+SijU7med9w@mail.gmail.com>
         <CABBYNZKpB5FLDxu2PrAV4P+HGDY1=jWJU_3YjTmgcDjoj36ijg@mail.gmail.com>
         <CA+A7VXVJkGaZA3ZOb4F3dD1i1h9PQXXMpL2St+kRQdRJSq9g-A@mail.gmail.com>
         <CABBYNZ+FD1sJ7SwS1SP7qoQ-W4PMfYQoWvHZ0_TCbVyCpzKasw@mail.gmail.com>
         <CA+A7VXWVtfLNPckCprxKrSV+k20Pj-r+F_VkWu6h3iY+8qNwDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2018-06-26 at 08:41 -0700, João Paulo Rechi Vita wrote:
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
> > On Thu, Jun 14, 2018 at 4:57 AM, Tanu Kaskinen <tanuk@iki.fi> wrote:
> > 
> > If module-bluetooth-policy is sufficient, then module-card-restore
> > won't do anything anyway, because you never set the profile manually.
> > If you ever set the profile manually, that's an indication that module-
> > bluetooth-policy isn't always good enough.
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

I agree, it's not nice that setting the profile once will interfere
with automatic configuration forever. Do you want to make a patch for
module-card-restore that adds an option (enabled by default) for
disabling profile restoring for bluetooth?

Offering a UI for disabling profiles doesn't seem like a better
alternative to me, at least for this problem. If there's some other use
case for disabling profiles, I'm not against the idea in principle.

-- 
Tanu

https://liberapay.com/tanuk
https://www.patreon.com/tanuk
