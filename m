Return-Path: <cyrus@holtmann.org>
Message-ID: <1334158493.16897.115.camel@aeonflux>
Subject: RE: [PATCH v0 4/6] Bluetooth: Simplify outgoing SCO scheduling code
From: Marcel Holtmann <marcel@holtmann.org>
To: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mikel Astiz <mikel.astiz.oss@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 11 Apr 2012 17:34:53 +0200
In-Reply-To: <66BD268F973E3544A665E5F503FB38B71AFB76466C@DC01.bmw-carit.intra>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
	 <1334126932-27327-5-git-send-email-mikel.astiz.oss@gmail.com>
	 <1334136286.16897.98.camel@aeonflux>
	 <CABBYNZJFYJGWWLvOoAfkKJm7KR6-c4dJLObdF8UsD47WyFe2kQ@mail.gmail.com>
	 <66BD268F973E3544A665E5F503FB38B71AFB76466C@DC01.bmw-carit.intra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

> > >> All data produced by userspace is sent to the controller without any
> > >> flow control. This was also the case before this patch, but now it's
> > >> more obvious and readable.
> > >
> > > as in the previous patch. You can only do this if you make sure that
> > > the controller does not have flow control enabled. You need another
> > > basic check here to ensure this first. Otherwise a lot of things
> > might break.
> 
> These patches should break nothing for several reasons:
> 
> 1. HCI SCO flow control is NOT enabled by default, as described in the spec volume 2 part E section 7.3.37.
> 
> 2. The kernel does not read or write this parameter, which means it wouldn't even know if the controller would have it enabled for some strange reason (however I haven't managed to find any controller that even supports this).

this does not mean we just remove code now. We should start fixing that
and read the setting actually.

> > It also seems to remove any quote/fairness of the scheduling, actually
> > Im not sure how it works because it sends the frames regardless of the
> > number of available slots/buffers indicated by sco_cnt, I also wonder
> > how it will scale with multiple SCO connections, even though it is
> > quite rare to have more than one who knows what crazy ideas people will
> > come.
> > 
> 
> 3. The previous implementation in the kernel seems to be totally useless, given that sco_cnt is never updated (grep for "sco_cnt--" or check hci_sched_sco() and hci_sched_esco()). So the idea of a quota is just an illusion here.
> 
> Maybe I'm missing something here, that's why I need your feedback :-)
> 
> In a nutshell: if some controller does support SCO flow control, it would be straightforward to support it in the Kernel (I actually have an implementation but wasn't able to test it).
> 
> If the controller doesn't have this feature, which is the most common case, then we either do in the kernel (time-based), in userspace, or both. For the moment I just propose to do it in userspace, as we've been doing recently despite the illusion I mention above.
> 
> Regarding multiple SCOs, it's not a problem at all. It's actually what I'm trying to achieve with these patches.

Lets read the settings first and see what current controllers are doing.
That part needs to be fixed first. It is something we have been lazy and
ignoring it.

Regards

Marcel


