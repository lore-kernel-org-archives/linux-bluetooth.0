Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: MTU configuration for LE links
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
	johan.hedberg@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
In-Reply-To: <BANLkTinOJGPTfQwjTi7mXEWHWKAd0aX6Zw@mail.gmail.com>
References: <anderson.briglia@openbossa.org>
	 <1302567158-18617-2-git-send-email-anderson.briglia@openbossa.org>
	 <1302581196.2572.249.camel@aeonflux>
	 <BANLkTinoW_bjCw=DwS2pMg-eM06Yq3MXLg@mail.gmail.com>
	 <1302605974.2572.258.camel@aeonflux>
	 <BANLkTinOJGPTfQwjTi7mXEWHWKAd0aX6Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Apr 2011 16:20:38 -0700
Message-ID: <1302736838.2572.262.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> >> One thing to consider is that there are a couple of MTU checks along
> >> the L2CAP code. The issue which originated this patch is code such as:
> >>
> >>                 /* Check outgoing MTU */
> >>                 if (len > pi->omtu) {
> >>                         err = -EMSGSIZE;
> >>                         goto done;
> >>                 }
> >>
> >> We understood that just letting omtu/imtu values on kernel reflect the
> >> current connection MTU settings was the cleanest solution. What do you
> >> propose? Bypassing these checks for LE?
> >
> > this does not look clean to me. And we might have an internal MTU
> > variable as part of L2CAP, but the way how it gets set and thus its
> > semantic differs clearly between BR/EDR and LE. So shoehorning an
> > existing socket option this is clearly a bad idea.
> 
> Sure. What to do then if:
> 
> 1) LE links have MTU (omtu specifically) hard-coded to 23 on kernel.
> 2) the kernel rejects sending data longer than omtu.
> 
> (this is the current situation)
> 
> This clearly needs some fix on kernel side, otherwise we can't send
> PDUs longer than the LE default MTU (23), *even* if the peer device
> supports a bigger MTU.

I agree with that. Userspace needs to be able to change the kernel MTU
if a different one gets negotiated. That is not the problem. The problem
is trying to shoehorn this into an existing (and already declared
legacy) socket option.

> Suggestions are welcome regarding how to best approach this, without
> affecting current BR/EDR MTU semantics.

We need to have a socket option that allows us the dynamically change
the MTU of a L2CAP link. And right now this option will only be valid if
the link is actually an LE link.

Regards

Marcel


