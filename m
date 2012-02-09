Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Feb 2012 16:50:17 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv3 16/16] Bluetooth: Remove socket lock check
Message-ID: <20120209145015.GD22374@aemeltch-MOBL1>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797057-26331-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328798620.28848.34.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328798620.28848.34.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Feb 09, 2012 at 03:43:40PM +0100, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Simplify code so that we do not need to check whether socket is locked.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/l2cap_sock.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index ddac4cb..358975a 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -125,15 +125,15 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
> >  
> >  	err = l2cap_chan_connect(chan, la.l2_psm, la.l2_cid, &la.l2_bdaddr);
> >  	if (err)
> > -		goto done;
> > +		return err;
> >  
> >  	lock_sock(sk);
> >  
> >  	err = bt_sock_wait_state(sk, BT_CONNECTED,
> >  			sock_sndtimeo(sk, flags & O_NONBLOCK));
> > -done:
> > -	if (sock_owned_by_user(sk))
> > -		release_sock(sk);
> > +
> > +	release_sock(sk);
> > +
> 
> is this code change really equivalent?

I think so, we used to have possibility to get sk locked
in l2cap_chan_connect but now it is not locked so we explicitly lock and
unlock.

I do not like that check sock_owned_by_user, this means we do not know is
socket locked or not.

Best regards 
Andrei Emeltchenko 
