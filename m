Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 17:13:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Reintroduce socket restrictions for LE sockets
Message-ID: <20131016141359.GA13598@x220.p-661hnu-f1>
References: <1381919863-27504-1-git-send-email-johan.hedberg@gmail.com>
 <088BACEA-5E9A-4ECF-A447-56A9F8D03525@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <088BACEA-5E9A-4ECF-A447-56A9F8D03525@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 16, 2013, Marcel Holtmann wrote:
> > Right now we do not allow user space to use connection oriented channels
> > on LE, and the only CID that can be used is the Attribute Protocol one.
> > These restrictions went away together with the recent refactoring of the
> > L2CAP code, but this patch puts them back to their appropriate places.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > net/bluetooth/l2cap_sock.c | 20 ++++++++++++++++++++
> > 1 file changed, 20 insertions(+)
> > 
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 68f486a..bda52d7 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -72,6 +72,16 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
> > 	if (!bdaddr_type_is_valid(la.l2_bdaddr_type))
> > 		return -EINVAL;
> > 
> > +	if (la.l2_bdaddr_type == BDADDR_LE_PUBLIC ||
> > +	    la.l2_bdaddr_type == BDADDR_LE_RANDOM) {
> 
> can we use bdaddr_type_is_le() here instead.

I forgot that we had that helper. A v2 has been sent.

Johan
