Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327952480.1955.154.camel@aeonflux>
References: <1327430878-23913-1-git-send-email-scott@netsplit.com>
	<1327952480.1955.154.camel@aeonflux>
Date: Mon, 30 Jan 2012 13:38:30 -0800
Message-ID: <CA+bD78it1S40KTRA+F9QX0KCVG3jDQsS=VdvEjuRdyxUPN4qhw@mail.gmail.com>
Subject: Re: [PATCHv2 0/4] Add support for bonding callbacks and retrying
From: Scott James Remnant <scott@netsplit.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 30, 2012 at 11:41 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:

> Hi Scott,
>
Hey! How's it going?

> > This adds plugin support for a callback called when bonding completes,
> > either successfully or fails, or is cancelled. In the success or failur=
e
> > cases the callback may return TRUE, in which case the bonding is retrie=
d
> > after a short backoff period.
> >
> yesterday Johan and talked about this a little bit and I just wanna
> quickly iterate some small comments here.
>
Great!

> So we should only allow retrying when we initiated the bonding. If the
> other side started the pairing, then retrying should not even be
> considered.
>
I thought I put a check in for that, but I've just realized that after
I separated out the autopair and the keyboard pairing stuff, that
check ended up only in the keyboard pairing side.

My intent was this entire path should be only when the host initiated
the bonding, not the client.

> We have to also ensure that we do not disconnect the ACL in between the
> retry attempts. Otherwise some car kits might cancel their pairing
> procedure and you have to have user interaction to get it back into
> pairing mode. So if the ACL gets disconnect, then we should just fail
> and cancel the bonding.
>
In my testing, OS X/iOS drop the ACL between retry attempts - so we
wouldn't be any worse than they are. I'm not sure whether it's even
possible in bluez to avoid dropping the ACL?

Scott
--
Have you ever, ever felt like this?
Had strange things happen? =A0Are you going round the twist?
