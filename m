Return-Path: <cyrus@holtmann.org>
Date: Sun, 16 Aug 2009 21:26:10 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add support for the source interface to audio IPC.
Message-ID: <20090816182538.GA10748@jh-x301>
References: <1250390653-476-1-git-send-email-jprvita@gmail.com> <20090816143858.GA4896@jh-x301> <2d5a2c100908160938w55475cabm7a23c34258f7de9e@mail.gmail.com> <20090816173529.GA9132@jh-x301> <2d5a2c100908161051n6604ce96wbb9acee6356df3f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <2d5a2c100908161051n6604ce96wbb9acee6356df3f@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, Aug 16, 2009, Luiz Augusto von Dentz wrote:
> >> >>       if (!interface) {
> >> >> -             if (dev->sink && avdtp_is_connected(&dev->src, &dev->dst))
> >> >> +             if (dev->source && avdtp_is_connected(&dev->src, &dev->dst))
> >> >> +                     return TYPE_SOURCE;
> >> >> +             else if (dev->sink && avdtp_is_connected(&dev->src, &dev->dst))
> >> >>                       return TYPE_SINK;
> >> >
> >> > I think the dev->source check should be in an "else if" clause while the
> >> > dev->sink check should be first. I.e. if a device happens to support both
> >> > roles of A2DP we default to dev->sink.
> >>
> >> Good catches, perhaps we should consider doing avdtp_is_connected
> >> check before checking for sink/source pointers. What do you think?
> >
> > What exactly do you mean? Could you perhaps give an example code snippet
> > of how you'd like the code to look like?
> >
> > Johan
> >
> 
> Something like this:
> 
> if (avdtp_is_connected(...)) {
>   if (dev->sink) return TYPE_SINK;
>   else if (dev->source) return TYPE_SOURCE;
>   else...
> }

Sure, but take a look at the bigger context, i.e. the whole select_service
function. You need to be careful not to change it's current behavior e.g.
in the case that avdtp_is_connected returns TRUE but both dev->sink and
dev->source are NULL (not sure how that could happen but your change would
change the logic for that case).

Johan
