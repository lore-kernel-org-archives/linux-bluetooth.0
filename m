Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: MTU configuration for LE links
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
	johan.hedberg@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
In-Reply-To: <BANLkTinoW_bjCw=DwS2pMg-eM06Yq3MXLg@mail.gmail.com>
References: <anderson.briglia@openbossa.org>
	 <1302567158-18617-2-git-send-email-anderson.briglia@openbossa.org>
	 <1302581196.2572.249.camel@aeonflux>
	 <BANLkTinoW_bjCw=DwS2pMg-eM06Yq3MXLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Apr 2011 12:59:33 +0200
Message-ID: <1302605974.2572.258.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> > so how do you expect this to work exactly? In BR/EDR L2CAP you set the
> > MTU details before calling connect(). With LE you expect to be connected
> > and then tell the kernel what the limits actually are?
> 
> Yes. For LE, the MTU negotiation happens over the connected link
> (using specific ATT commands).
> 
> > This sounds highly convoluted. And especially hijacking the existing
> > command for it seems wrong. Using l2cap_sock_setsockopt_old() might have
> > given it away that it is a bad idea to re-use that socket option for a
> > new technology ;)
> >
> > So the real fact here is that the MTU handling/negotiation for BR/EDR
> > and LE are different. Nothing is going to change this. So this should be
> > also different from a socket option point of view.
> 
> One thing to consider is that there are a couple of MTU checks along
> the L2CAP code. The issue which originated this patch is code such as:
> 
>                 /* Check outgoing MTU */
>                 if (len > pi->omtu) {
>                         err = -EMSGSIZE;
>                         goto done;
>                 }
> 
> We understood that just letting omtu/imtu values on kernel reflect the
> current connection MTU settings was the cleanest solution. What do you
> propose? Bypassing these checks for LE?

this does not look clean to me. And we might have an internal MTU
variable as part of L2CAP, but the way how it gets set and thus its
semantic differs clearly between BR/EDR and LE. So shoehorning an
existing socket option this is clearly a bad idea.

Regards

Marcel


