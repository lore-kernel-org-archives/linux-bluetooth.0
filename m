Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann
	<marcel@holtmann.org>
CC: Mikel Astiz <mikel.astiz.oss@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Date: Wed, 11 Apr 2012 17:23:36 +0200
Subject: RE: [PATCH v0 4/6] Bluetooth: Simplify outgoing SCO scheduling code
Message-ID: <66BD268F973E3544A665E5F503FB38B71AFB76466C@DC01.bmw-carit.intra>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1334126932-27327-5-git-send-email-mikel.astiz.oss@gmail.com>
	<1334136286.16897.98.camel@aeonflux>
 <CABBYNZJFYJGWWLvOoAfkKJm7KR6-c4dJLObdF8UsD47WyFe2kQ@mail.gmail.com>
In-Reply-To: <CABBYNZJFYJGWWLvOoAfkKJm7KR6-c4dJLObdF8UsD47WyFe2kQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Luiz,

> >>
> >> All data produced by userspace is sent to the controller without any
> >> flow control. This was also the case before this patch, but now it's
> >> more obvious and readable.
> >
> > as in the previous patch. You can only do this if you make sure that
> > the controller does not have flow control enabled. You need another
> > basic check here to ensure this first. Otherwise a lot of things
> might break.

These patches should break nothing for several reasons:

1. HCI SCO flow control is NOT enabled by default, as described in the spec=
 volume 2 part E section 7.3.37.

2. The kernel does not read or write this parameter, which means it wouldn'=
t even know if the controller would have it enabled for some strange reason=
 (however I haven't managed to find any controller that even supports this)=
.

>=20
> It also seems to remove any quote/fairness of the scheduling, actually
> Im not sure how it works because it sends the frames regardless of the
> number of available slots/buffers indicated by sco_cnt, I also wonder
> how it will scale with multiple SCO connections, even though it is
> quite rare to have more than one who knows what crazy ideas people will
> come.
>=20

3. The previous implementation in the kernel seems to be totally useless, g=
iven that sco_cnt is never updated (grep for "sco_cnt--" or check hci_sched=
_sco() and hci_sched_esco()). So the idea of a quota is just an illusion he=
re.

Maybe I'm missing something here, that's why I need your feedback :-)

In a nutshell: if some controller does support SCO flow control, it would b=
e straightforward to support it in the Kernel (I actually have an implement=
ation but wasn't able to test it).

If the controller doesn't have this feature, which is the most common case,=
 then we either do in the kernel (time-based), in userspace, or both. For t=
he moment I just propose to do it in userspace, as we've been doing recentl=
y despite the illusion I mention above.

Regarding multiple SCOs, it's not a problem at all. It's actually what I'm =
trying to achieve with these patches.

Cheers,
Mikel
