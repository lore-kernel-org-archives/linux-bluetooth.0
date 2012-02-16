Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Feb 2012 15:17:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Do not dereference zero sk
Message-ID: <20120216131745.GD16080@x220.ger.corp.intel.com>
References: <1329225177-31940-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329225150.28848.74.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329225150.28848.74.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Feb 14, 2012, Marcel Holtmann wrote:
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/l2cap_sock.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 1636029..138fe34 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -795,7 +795,7 @@ static void l2cap_sock_kill(struct sock *sk)
> >  static int l2cap_sock_shutdown(struct socket *sock, int how)
> >  {
> >  	struct sock *sk = sock->sk;
> > -	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> > +	struct l2cap_chan *chan;
> >  	int err = 0;
> >  
> >  	BT_DBG("sock %p, sk %p", sock, sk);
> > @@ -803,6 +803,8 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
> >  	if (!sk)
> >  		return 0;
> >  
> > +	chan = l2cap_pi(sk)->chan;
> > +
> 
> funny that this never caused any problems so far.
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Applied to my bluetooth-next tree. Thanks.

Johan
