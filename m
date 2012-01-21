Return-Path: <cyrus@holtmann.org>
Message-ID: <1327170562.1955.55.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: silence lockdep warning
From: Marcel Holtmann <marcel@holtmann.org>
To: "Purdila, Octavian" <octavian.purdila@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 21 Jan 2012 19:29:22 +0100
In-Reply-To: <CAE1zotJs0gJOQUX_w+A31gw6zedBGnLscyWRKya8KdNKTM4+4A@mail.gmail.com>
References: <1326993579-14429-1-git-send-email-octavian.purdila@intel.com>
	 <1327164299.1955.53.camel@aeonflux>
	 <CAE1zotJs0gJOQUX_w+A31gw6zedBGnLscyWRKya8KdNKTM4+4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Octavian,

> >> +void bt_sock_reclassify_lock(struct sock *sk, int proto)
> >>  {
> >> -     struct sock *sk = sock->sk;
> >> -
> >>       if (!sk)
> >>               return;
> >
> > Why are we keeping the !sk check here if we already hand in the sk. It
> > is most likely checked by the caller already.
> >
> 
> In rfcomm_sock_create (called from bt_sock_create) sock->sk can be set
> to NULL so I think we should keep the check.

it has been too long since I looked at this part of the code. You need
to walk me through it why this is still true.

Regards

Marcel


