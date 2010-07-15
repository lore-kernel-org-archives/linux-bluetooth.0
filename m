Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Thu, 15 Jul 2010 17:03:31 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: [PATCH 3/5] Bluetooth: create a l2cap dir
Message-ID: <20100715200331.GB5734@vigoh>
References: <1279033035-24708-1-git-send-email-gustavo@padovan.org>
 <1279033035-24708-2-git-send-email-gustavo@padovan.org>
 <1279033035-24708-3-git-send-email-gustavo@padovan.org>
 <1279041228.6282.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279041228.6282.20.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2010-07-13 14:13:48 -0300]:

> Hi Gustavo,
> 
> > The dir is being created looking forward to the l2cap.c split.
> > 
> > Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> > ---
> >  net/bluetooth/Makefile       |    2 +-
> >  net/bluetooth/l2cap.c        | 4859 ------------------------------------------
> >  net/bluetooth/l2cap/Makefile |    5 +
> >  net/bluetooth/l2cap/l2cap.c  | 4859 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 4865 insertions(+), 4860 deletions(-)
> >  delete mode 100644 net/bluetooth/l2cap.c
> >  create mode 100644 net/bluetooth/l2cap/Makefile
> >  create mode 100644 net/bluetooth/l2cap/l2cap.c
> 
> hold off with this changes. We are not doing a separate directory
> anyway. I need more time to think about it.

Ok, so I can go with that inside the bluetooth directory. But we need
to sort this out soon. I think we can't go ahead with the L2CAP AMP
changes without split l2cap.c first, otherwise it will be very hard to
split l2cap.c in the future.

-- 
Gustavo F. Padovan
http://padovan.org
