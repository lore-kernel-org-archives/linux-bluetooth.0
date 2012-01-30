Return-Path: <cyrus@holtmann.org>
Message-ID: <1327960292.1955.177.camel@aeonflux>
Subject: Re: [PATCHv2 0/4] Add support for bonding callbacks and retrying
From: Marcel Holtmann <marcel@holtmann.org>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Date: Mon, 30 Jan 2012 13:51:32 -0800
In-Reply-To: <CA+bD78it1S40KTRA+F9QX0KCVG3jDQsS=VdvEjuRdyxUPN4qhw@mail.gmail.com>
References: <1327430878-23913-1-git-send-email-scott@netsplit.com>
	 <1327952480.1955.154.camel@aeonflux>
	 <CA+bD78it1S40KTRA+F9QX0KCVG3jDQsS=VdvEjuRdyxUPN4qhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> > > This adds plugin support for a callback called when bonding completes,
> > > either successfully or fails, or is cancelled. In the success or failure
> > > cases the callback may return TRUE, in which case the bonding is retried
> > > after a short backoff period.
> > >
> > yesterday Johan and talked about this a little bit and I just wanna
> > quickly iterate some small comments here.
> >
> Great!
> 
> > So we should only allow retrying when we initiated the bonding. If the
> > other side started the pairing, then retrying should not even be
> > considered.
> >
> I thought I put a check in for that, but I've just realized that after
> I separated out the autopair and the keyboard pairing stuff, that
> check ended up only in the keyboard pairing side.
> 
> My intent was this entire path should be only when the host initiated
> the bonding, not the client.

to be honest, I did not get further into actually checking the code
itself. I just wanted to ensure we are on the same and expecting how
this is suppose to work ;)

> > We have to also ensure that we do not disconnect the ACL in between the
> > retry attempts. Otherwise some car kits might cancel their pairing
> > procedure and you have to have user interaction to get it back into
> > pairing mode. So if the ACL gets disconnect, then we should just fail
> > and cancel the bonding.
> >
> In my testing, OS X/iOS drop the ACL between retry attempts - so we
> wouldn't be any worse than they are. I'm not sure whether it's even
> possible in bluez to avoid dropping the ACL?

Is Apple doing retried pairing (or auto-pairing) as well?

Strictly speaking the ACL disconnect is host stack triggered. So you
have HCI_Authentication_Requested and you can just execute that again
with the same link. We also do have a ACL disconnect timeout handling of
2 seconds that will allow sockets to re-use the same ACL link. Can you
provide some hcidump traces from your test cases?

Regards

Marcel


