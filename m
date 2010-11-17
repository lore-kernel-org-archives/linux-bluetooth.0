Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Nov 2010 21:17:33 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/7] Bluetooth: Hold the lock inside
 l2cap_get_sock_by_addr()
Message-ID: <20101117231733.GC32261@vigoh>
References: <1288710198-6108-1-git-send-email-padovan@profusion.mobi>
 <20101105134935.GD19903@null>
 <20101105143711.GB9116@vigoh>
 <20101117231141.GB32261@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101117231141.GB32261@vigoh>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo F. Padovan <padovan@profusion.mobi> [2010-11-17 21:11:41 -0200]:

> * Gustavo F. Padovan <padovan@profusion.mobi> [2010-11-05 10:37:11 -0400]:
> 
> > Hi Ville,
> > 
> > * Ville Tervo <ville.tervo@nokia.com> [2010-11-05 15:49:35 +0200]:
> > 
> > > Hi Gustavo,
> > > 
> > > On Tue, Nov 02, 2010 at 04:03:12PM +0100, ext Gustavo F. Padovan wrote:
> > > > It also have to change the name of the function to
> > > > l2cap_get_sock_by_addr() because we do hold the lock inside it now.
> > > > 
> > > > Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> > > > ---
> > > >  net/bluetooth/l2cap.c |   17 ++++++-----------
> > > >  1 files changed, 6 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> > > > index 6f931cc..3d48867 100644
> > > > --- a/net/bluetooth/l2cap.c
> > > > +++ b/net/bluetooth/l2cap.c
> > > > @@ -728,15 +728,18 @@ static inline void l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, stru
> > > >  }
> > > >  
> > > >  /* ---- Socket interface ---- */
> > > > -static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
> > > > +static struct sock *l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
> > > >  {
> > > >  	struct sock *sk;
> > > >  	struct hlist_node *node;
> > > > +
> > > > +	write_lock_bh(&l2cap_sk_list.lock);
> > > 
> > > Code is only reading so read_lock_bh would be enough?
> > 
> > Sure, I didn't looked to that, I just keept the same code that we were
> > using before. I'll fix it.
> 
> I figured out that we need write_lock_bh() here, because set the psm and
> sport is like a new element to the list. l2cap_get_sock_by_addr()
> searches for either psm or sport. 
> 
> I'm also dropping the option to use RCU on the bt_sk_list(), It does not
> fit on our case. We can't have anyone writing the list while we are
> reading it.

That said, only patch 4 and 5 are still valid (I'll resend them), and 6 is
so trivial that I put it upstream already.  

-- 
Gustavo F. Padovan
http://profusion.mobi
