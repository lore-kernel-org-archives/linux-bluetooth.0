Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 May 2012 17:39:01 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Mat Martineau <mathewm@codeaurora.org>, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org, pkrystad@codeaurora.org,
	andrei.emeltchenko.news@gmail.com
Subject: Re: [PATCH 1/4] Bluetooth: Fix a redundant and problematic incoming
 MTU check
Message-ID: <20120504203901.GD11510@joana>
References: <1335976922-19456-1-git-send-email-mathewm@codeaurora.org>
 <1335976922-19456-2-git-send-email-mathewm@codeaurora.org>
 <CAA37ika9JvSW1WCDtcnuQnFu3DppGsDx6BqbowiJ1kyz8LBJBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ika9JvSW1WCDtcnuQnFu3DppGsDx6BqbowiJ1kyz8LBJBQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

* Ulisses Furquim <ulisses@profusion.mobi> [2012-05-04 15:55:16 -0300]:

> Hi Mat,
>=20
> On Wed, May 2, 2012 at 1:41 PM, Mat Martineau <mathewm@codeaurora.org> wr=
ote:
> > The L2CAP MTU for incoming data is verified differently depending on
> > the L2CAP mode, so the check is best performed in a mode-specific
> > context. =A0Checking the incoming MTU before HCI fragment reassembly is
> > a layer violation and assumes all bytes after the standard L2CAP
> > header are L2CAP data.
> >
> > This approach causes issues with unsegmented ERTM or streaming mode
> > frames, where there are additional enhanced or extended headers before
> > the data payload and possible FCS bytes after the data payload. =A0A
> > valid frame could be as many as 10 bytes larger than the MTU.
> >
> > Removing this code is the best fix, because the MTU is checked later
> > on for all L2CAP data frames (connectionless, basic, ERTM, and
> > streaming). =A0This also gets rid of outdated locking (socket instead of
> > l2cap_chan) and an extra lookup of the channel ID.
> >
> > Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> > ---
> > =A0net/bluetooth/l2cap_core.c | =A0 20 --------------------
> > =A01 file changed, 20 deletions(-)
>=20
> This looks good and correct to me.

Please add proper Reviewed-by tag when we are ok with a patch, it easier
to us pick it up here.

	Gustavo
