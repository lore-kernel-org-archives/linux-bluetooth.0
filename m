Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 10 Nov 2010 13:47:35 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ville Tervo <ville.tervo@nokia.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/7] Bluetooth: Hold the lock inside
 l2cap_get_sock_by_addr()
Message-ID: <20101110154735.GB3275@vigoh>
References: <1288710198-6108-1-git-send-email-padovan@profusion.mobi>
 <20101105134935.GD19903@null>
 <20101105143711.GB9116@vigoh>
 <1289367595.9615.240.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289367595.9615.240.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2010-11-10 14:39:55 +0900]:

> Hi Gustavo,
> 
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
> we might also not just bother with read/write locks. Since they are not
> always the right thing to do. In a lot of cases a pure spinlock is just
> better. And in case of Bluetooth I think we would be just fine with
> using a pure spinlock. You might run some tests with this.


Better than spinlock is move everything to RCU, than we will just need a
mutex or spinlock in the write operations. Using a RCU is a lot simpler.

These patches are a clean up to add RCU to sk_list, so I propose to
upstream the new version of my patches and do the RCU change on top
of them.

After all these changes we will be ready for the l2cap.c split.

-- 
Gustavo F. Padovan
http://profusion.mobi
