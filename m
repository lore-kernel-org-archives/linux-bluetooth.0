Return-Path: <cyrus@holtmann.org>
Message-ID: <1326277627.6454.220.camel@aeonflux>
Subject: Re: [RFC 1/2] Bluetooth: make use of MSG_DONTROUTE flag in L2CAP
 sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 11 Jan 2012 11:27:07 +0100
In-Reply-To: <CABBYNZJ1YuVFjNX+tTu9qsFSnu=2wiBpALe2BTNQqu1152+n0w@mail.gmail.com>
References: <1326201988-17651-1-git-send-email-luiz.dentz@gmail.com>
	 <1326214206.6454.211.camel@aeonflux>
	 <CABBYNZJ1YuVFjNX+tTu9qsFSnu=2wiBpALe2BTNQqu1152+n0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> This use MSG_DONTROUTE to send a single message with highest possible
> >> priority without having to rely on socket options.
> >>
> >> This is useful for RFCOMM which relies on socket interface to send frames
> >> to L2CAP, but since some of this frames are actual commands that can
> >> timeout they should be sent as soon as possible.
> >>
> >> For userspace this also offer the convenience of not having to use
> >> setsockopt several times when only a single/some messages needs to be
> >> prioritize.
> >
> > are you sure that we are not mis-using the MSG_DONTROUTE flag?
> 
> This is the reason Ive sent as RFC, man page says it is only define
> for protocols that route, but note that MSG_TRYHARD does map to the
> same value (4) so the meaning depend on the protocol. Perhaps creating
> a new flag e.g. MSG_HIGHPRIO would be acceptable?

try to get this upstream via netdev mailing list first. And lets see
where this goes. I personally like the idea, but shoehorning it into
MSG_DONTROUTE seems not really a good idea.

> >> +     priority = sk->sk_priority;
> >> +
> >> +     /* MSG_DONTROUTE send message at maximum possible priority */
> >> +     if ((msg->msg_flags & MSG_DONTROUTE) && priority < HCI_PRIO_MAX - 1)
> >> +             priority = HCI_PRIO_MAX - 1;
> >> +
> >
> > you need to enforce the same privilege check that SO_PRIORITY does.
> > Otherwise every single application can just go and overwrite it.
> 
> Currently HCI_PRIO_MAX - 1 maps to the highest priority without
> requiring privileges, but I can change that to HCI_PRIO_MAX so only
> privileged processes such bluetoothd can make use of it.

If we wanna do then, we should give privileged daemons to use highest
priority as well.

Regards

Marcel


