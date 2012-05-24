Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 13:57:38 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 6/8] Bluetooth: Move check for backlog size to l2cap_sock.c
Message-ID: <20120524165738.GC3105@joana>
References: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
 <1337821964-4618-2-git-send-email-gustavo@padovan.org>
 <1337821964-4618-3-git-send-email-gustavo@padovan.org>
 <1337821964-4618-4-git-send-email-gustavo@padovan.org>
 <1337821964-4618-5-git-send-email-gustavo@padovan.org>
 <1337821964-4618-6-git-send-email-gustavo@padovan.org>
 <1337821964-4618-7-git-send-email-gustavo@padovan.org>
 <20120524094546.GM24715@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120524094546.GM24715@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2012-05-24 12:45:48 +0300]:

> Hi Gustavo,
> 
> On Wed, May 23, 2012 at 10:12:42PM -0300, Gustavo Padovan wrote:
> > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > 
> > Remove socket specific code from l2cap_core.c
> > 
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > ---
> >  net/bluetooth/l2cap_core.c |   12 ------------
> >  net/bluetooth/l2cap_sock.c |    6 ++++++
> >  2 files changed, 6 insertions(+), 12 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 9416c60..46e6fb7 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1156,12 +1156,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
> >  
> >  	lock_sock(parent);
> >  
> > -	/* Check for backlog size */
> > -	if (sk_acceptq_is_full(parent)) {
> > -		BT_DBG("backlog full %d", parent->sk_ack_backlog);
> > -		goto clean;
> > -	}
> > -
> >  	chan = pchan->ops->new_connection(pchan->data);
> >  	if (!chan)
> >  		goto clean;
> > @@ -3348,12 +3342,6 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
> >  
> >  	result = L2CAP_CR_NO_MEM;
> >  
> > -	/* Check for backlog size */
> > -	if (sk_acceptq_is_full(parent)) {
> > -		BT_DBG("backlog full %d", parent->sk_ack_backlog);
> > -		goto response;
> > -	}
> > -
> >  	chan = pchan->ops->new_connection(pchan->data);
> >  	if (!chan)
> >  		goto response;
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 8a3620b..bc409a2 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -895,6 +895,12 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
> >  {
> >  	struct sock *sk, *parent = data;
> >  
> > +	/* Check for backlog size */
> > +	if (sk_acceptq_is_full(parent)) {
> > +		BT_DBG("backlog full %d", parent->sk_ack_backlog);
> > +		return NULL;
> > +	}
> > +
> 
> Ok I see where comes from this change. I feel that this can be merged with
> some other patch removing parent sk.

Let keep this patch as is, the other patch changes locking and I prefer a
separated patch for it.

	Gustavo
