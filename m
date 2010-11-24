Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Nov 2010 07:05:01 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: "ext Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 06/20] Bluetooth: Do not send disconn comand over LE links
Message-ID: <20101124050501.GG874@null>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
 <1290524796-32246-7-git-send-email-vinicius.gomes@openbossa.org>
 <20101123224839.GA11860@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101123224839.GA11860@vigoh>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 23, 2010 at 08:48:39PM -0200, ext Gustavo F. Padovan wrote:
> * Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2010-11-23 12:06:22 -0300]:
> 
> > From: Ville Tervo <ville.tervo@nokia.com>
> > 
> > l2cap over LE links can be disconnected without sending
> > disconnect command first.
> > 
> > Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> > ---
> >  net/bluetooth/l2cap.c |   15 ++++++++++-----
> >  1 files changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> > index 0b583c4..5894662 100644
> > --- a/net/bluetooth/l2cap.c
> > +++ b/net/bluetooth/l2cap.c
> > @@ -873,6 +873,8 @@ static void l2cap_sock_kill(struct sock *sk)
> >  
> >  static void __l2cap_sock_close(struct sock *sk, int reason)
> >  {
> > +	struct l2cap_conn *conn;
> > +
> >  	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
> >  
> >  	switch (sk->sk_state) {
> > @@ -882,8 +884,10 @@ static void __l2cap_sock_close(struct sock *sk, int reason)
> >  
> >  	case BT_CONNECTED:
> >  	case BT_CONFIG:
> > -		if (sk->sk_type == SOCK_SEQPACKET ||
> > -				sk->sk_type == SOCK_STREAM) {
> > +		conn = l2cap_pi(sk)->conn;
> > +		if ((sk->sk_type == SOCK_SEQPACKET ||
> > +				sk->sk_type == SOCK_STREAM) &&
> > +				conn->hcon->type != LE_LINK) {
> 
> Makes more senses check for conn->hcon->type == ACL_LINK.

Will be changed.

> 
> >  			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
> >  
> >  			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
> > @@ -893,9 +897,10 @@ static void __l2cap_sock_close(struct sock *sk, int reason)
> >  		break;
> >  
> >  	case BT_CONNECT2:
> > -		if (sk->sk_type == SOCK_SEQPACKET ||
> > -				sk->sk_type == SOCK_STREAM) {
> > -			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
> > +		conn = l2cap_pi(sk)->conn;
> > +		if ((sk->sk_type == SOCK_SEQPACKET ||
> > +				sk->sk_type == SOCK_STREAM) &&
> > +				conn->hcon->type != LE_LINK) {
> 
> Same here.

Ditto

-- 
Ville
