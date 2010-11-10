Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/7] Bluetooth: Hold the lock inside
 l2cap_get_sock_by_addr()
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Ville Tervo <ville.tervo@nokia.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20101105143711.GB9116@vigoh>
References: <1288710198-6108-1-git-send-email-padovan@profusion.mobi>
	 <20101105134935.GD19903@null>  <20101105143711.GB9116@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Nov 2010 14:39:55 +0900
Message-ID: <1289367595.9615.240.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > On Tue, Nov 02, 2010 at 04:03:12PM +0100, ext Gustavo F. Padovan wrote:
> > > It also have to change the name of the function to
> > > l2cap_get_sock_by_addr() because we do hold the lock inside it now.
> > > 
> > > Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> > > ---
> > >  net/bluetooth/l2cap.c |   17 ++++++-----------
> > >  1 files changed, 6 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> > > index 6f931cc..3d48867 100644
> > > --- a/net/bluetooth/l2cap.c
> > > +++ b/net/bluetooth/l2cap.c
> > > @@ -728,15 +728,18 @@ static inline void l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, stru
> > >  }
> > >  
> > >  /* ---- Socket interface ---- */
> > > -static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
> > > +static struct sock *l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
> > >  {
> > >  	struct sock *sk;
> > >  	struct hlist_node *node;
> > > +
> > > +	write_lock_bh(&l2cap_sk_list.lock);
> > 
> > Code is only reading so read_lock_bh would be enough?
> 
> Sure, I didn't looked to that, I just keept the same code that we were
> using before. I'll fix it.

we might also not just bother with read/write locks. Since they are not
always the right thing to do. In a lot of cases a pure spinlock is just
better. And in case of Bluetooth I think we would be just fine with
using a pure spinlock. You might run some tests with this.

Regards

Marcel


