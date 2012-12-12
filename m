Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Dec 2012 17:57:25 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 12/16] Bluetooth: Use abstract chan->data in comparison
Message-ID: <20121212195725.GB5554@joana>
References: <1355285624-25811-1-git-send-email-gustavo@padovan.org>
 <1355285624-25811-13-git-send-email-gustavo@padovan.org>
 <20121212082009.GA7034@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121212082009.GA7034@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2012-12-12 10:20:11 +0200]:

> Hi Gustavo,
> 
> On Wed, Dec 12, 2012 at 02:13:40AM -0200, Gustavo Padovan wrote:
> > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > 
> > If the L2CAP user is l2cap_sock.c chan->data is a pointer to the l2cap
> > socket so chan->sk and chan->data are the same thing. Then we can just
> > compare with chan->data instead.
> > 
> > Non-socket users will have skb->sk = NULL, thus this change does not
> > interfere in other users.
> > 
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > ---
> >  net/bluetooth/l2cap_core.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 934ac1b..92936db 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -2682,12 +2682,11 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
> >  	mutex_lock(&conn->chan_lock);
> >  
> >  	list_for_each_entry(chan, &conn->chan_l, list) {
> > -		struct sock *sk = chan->sk;
> >  		if (chan->chan_type != L2CAP_CHAN_RAW)
> >  			continue;
> >  
> >  		/* Don't send frame to the socket it came from */
> > -		if (skb->sk == sk)
> > +		if (skb->sk && skb->sk == chan->data)
> 
> In the other patch you delete chan->sk pointer and then we have only
> chan->data which points to sk. What is the reason for that? This would
> confuse people reading chan->data guessing what the hell is this.
> 
> I really think we can leave chan->sk if it is needed and it is better to
> remove chan->data.

chan->data is the generic data pointer for l2cap users, l2cap_sock.c puts an
struct sock while a2mp.c puts struct amp_mgr there. I'll better add a comment
to struct l2cap_chan saying what it is for instead of re-adding struct sock.

	Gustavo
