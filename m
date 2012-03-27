Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 12:54:32 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv5 03/26] Bluetooth: A2MP: Create A2MP channel
Message-ID: <20120327155432.GA9856@joana>
References: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332519246-16656-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120325171225.GG3106@joana>
 <20120326092737.GA18219@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120326092737.GA18219@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-26 12:27:39 +0300]:

> Hi Gustavo,
> 
> On Sun, Mar 25, 2012 at 02:12:25PM -0300, Gustavo Padovan wrote:
> > > +static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
> > 
> > a2mp_chan_open() is a better name here. Who is calling this btw?
> 
> Agree, will change it; it is called by amp_mgr_create in the following
> patch.
> 
> > > +{
> > > +	struct l2cap_chan *chan;
> > > +
> > > +	chan = l2cap_chan_create(NULL);
> > 
> > I just pushed a patch that remove the sk parameter from l2cap_chan_create(),
> > so you don't need to pass NULL here anymore.
> 
> Good! I did not know about this. BTW: Shall all patches go through mailing list
> first?

I committed just after see your patch, it was a simple patch.

> 
> > You failing to check l2cap_chan_create() for NULL return btw.
> 
> Will fix.
> 
> > > +
> > > +	hci_conn_hold(conn->hcon);
> > > +
> > > +	BT_DBG("chan %p", chan);
> > > +
> > > +	chan->sec_level = BT_SECURITY_LOW;
> > > +	chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
> > > +	chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
> > > +	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
> > > +	chan->fcs = L2CAP_FCS_CRC16;
> > > +
> > > +	chan->ops = &a2mp_chan_ops;
> > > +
> > > +	set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
> > > +
> > > +	chan->max_tx = L2CAP_DEFAULT_MAX_TX;
> > > +	chan->remote_max_tx = chan->max_tx;
> > > +
> > > +	chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
> > > +	chan->tx_win_max = L2CAP_DEFAULT_TX_WINDOW;
> > > +	chan->remote_tx_win = chan->tx_win;
> > > +
> > > +	chan->retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
> > > +	chan->monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
> > > +
> > > +	skb_queue_head_init(&chan->tx_q);
> > 
> > I think we should move all ERTM related settings here inside
> > l2cap_ertm_init(), it will make this code much more cleaner.
> 
> which settings? retrans_timeout and monitor_timeout are set in
> configuration phase before l2cap_ertm_init and putting them
> to l2cap_ertm_init would override them.
> 
> I can make a function assigning basic L2CAP settings for A2MP and for
> general L2CAP channels (those in the beginning).

Ok, let's go with this approach then.

	Gustavo
