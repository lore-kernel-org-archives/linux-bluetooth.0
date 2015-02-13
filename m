Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Feb 2015 14:41:35 -0500
From: Josh Boyer <jwboyer@redhat.com>
To: Alexander Ploumistos <alex.ploumistos@gmail.com>
Cc: Dmitry Tunin <hanipouspilot@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alexander Ploumistos <alexpl@fedoraproject.org>
Subject: Re: [PATCH v2] Bluetooth: ath3k: Add support for 04f2:aff1 (Atheros
 AR5B195 combo Mini PCIe card)
Message-ID: <20150213194135.GB16771@hansolo.redhat.com>
References: <CAM86y2vc-EUswU+D6EeEAeKQWDVuDVGOvpLTgKjB-R4VzxyshA@mail.gmail.com>
 <1423854311-7909-1-git-send-email-alexpl@fedoraproject.org>
 <54DE4E93.1090402@gmail.com>
 <20150213192154.GA16771@hansolo.redhat.com>
 <CAM86y2uQpg85RL=_pJBeWVvJzsvkLCT=gC8CdPO0=MMUaNUKEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAM86y2uQpg85RL=_pJBeWVvJzsvkLCT=gC8CdPO0=MMUaNUKEQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Feb 13, 2015 at 09:37:31PM +0200, Alexander Ploumistos wrote:
> On Fri, Feb 13, 2015 at 9:21 PM, Josh Boyer <jwboyer@redhat.com> wrote:
> >
> > On Fri, Feb 13, 2015 at 10:20:51PM +0300, Dmitry Tunin wrote:
> > >
> > > I think it makes sense to add
> > >
> > > Cc: stable@vger.kernel.org
> > >
> > > If you do, it will be merged into stable kernel versions.
> >
> > I agree, but this is something the upstream maintainer can also add at
> > their discretion.
> 
> After feeling stupid for a few minutes, given that
> stable@vger.kernel.org was already in the Cc list of my messages, I
> realized that you meant to also include it in the message body (or
> have I got it wrong again?).

In the message body, yes.  It would look like:

<blah blah blah>

Cc: stable@vger.kernel.org
Signed-off-by: <you>

<patch>

> No, I think I've spammed everyone enough for one evening and I would
> also like to put some distance between myself and git, at least for
> today.
> If deemed necessary, I will do it tomorrow.

Marcel will let you know I'm sure.  I hope he can just add it if he
thinks it is applicable.

> Thank you all for everything so far, it's been educational.

Thanks for persisting through this.  The first time is always the
hardest, and it is great to see people being helpful to a new
contributor.

josh
