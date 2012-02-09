Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 9 Feb 2012 16:08:41 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv3 03/16] Bluetooth: Do not use sk lock in get_chan functions
Message-ID: <20120209180841.GA3174@joana>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797057-26331-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797725.28848.22.camel@aeonflux>
 <20120209144038.GC22374@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120209144038.GC22374@aemeltch-MOBL1>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2012-02-09 16:40:39 +0200]:

> Hi Marcel,
> 
> On Thu, Feb 09, 2012 at 03:28:45PM +0100, Marcel Holtmann wrote:
> > Hi Andrei,
> > 
> > > When needed we take explicit lock.
> > > 
> > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > ---
> > >  net/bluetooth/l2cap_core.c |    6 ++----
> > >  1 files changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > index ae08944..dcf4792 100644
> > > --- a/net/bluetooth/l2cap_core.c
> > > +++ b/net/bluetooth/l2cap_core.c
> > > @@ -105,9 +105,8 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
> > >  
> > >  	mutex_lock(&conn->chan_lock);
> > >  	c = __l2cap_get_chan_by_scid(conn, cid);
> > > -	if (c)
> > > -		lock_sock(c->sk);
> > >  	mutex_unlock(&conn->chan_lock);
> > > +
> > >  	return c;
> > >  }
> > 
> > so this is dangerous since now we are creating an imbalance with the
> > socket locks. Are we fixing that one later on?
> 
> Yes, that will be fixed later on. Do you think that needs to be merged
> with the other code?

Please merge such changes, I don't merge a code that put us in a bad state.

	Gustavo
