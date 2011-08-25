Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Aug 2011 11:27:05 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/7] Bluetooth: Add support for reusing the same hci_conn
 for LE links
Message-ID: <20110825142705.GA27645@samus.indt.org>
References: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313798816-8647-5-git-send-email-vinicius.gomes@openbossa.org>
 <20110825012712.GF5462@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110825012712.GF5462@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 22:27 Wed 24 Aug, Gustavo Padovan wrote:
> Hi Vinicius,
> 
> * Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-08-19 21:06:53 -0300]:
> 
> > As most LE devices leave advertising mode when they enter the connected
> > state, we may want to "pass" that connection to other users.
> > 
> > The first user will be the pairing procedure, the connection is
> > established without an associated socket, after the pairing is
> > complete, userspace may want to discover via GATT what services the
> > newly bonded device has.
> > 
> > If userspace establishes the connection while the timeout still
> > hasn't expired, the connection will be re-used.
> > 
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  net/bluetooth/hci_conn.c   |   31 ++++++++++++-----------
> >  net/bluetooth/l2cap_core.c |   56 ++++++++++++++++++++++++++++++-------------
> >  2 files changed, 55 insertions(+), 32 deletions(-)
> > 
[ ... ]

> > @@ -1128,6 +1144,12 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
> >  		goto done;
> >  	}
> >  
> > +	if (hcon->type == LE_LINK && !l2cap_chan_empty(conn)) {
> > +		hci_conn_put(hcon);
>  
> The lock (in l2cap_chan_empty) have to be release after conn put. So just get
> rid of l2cap_chan_empty and do an inline locking here.

Sure. Will fix.

> 
> 	Gustavo

Cheers,
--
Vinicius

