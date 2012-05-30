Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 May 2012 04:05:50 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH] Bluetooth: Create empty l2cap ops function
Message-ID: <20120530070550.GJ18069@joana>
References: <1338308366-11465-1-git-send-email-gustavo@padovan.org>
 <20120530070158.GA29227@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120530070158.GA29227@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2012-05-30 10:02:00 +0300]:

> Hi Gustavo,
> 
> On Tue, May 29, 2012 at 01:19:26PM -0300, Gustavo Padovan wrote:
> > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > 
> > A2MP doesn't use part of the L2CAP chan ops API so we just create general
> > empty function instead of the A2MP specific one.
> > 
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > ---
> >  include/net/bluetooth/l2cap.h |   12 ++++++++++++
> >  net/bluetooth/a2mp.c          |   23 +++--------------------
> >  2 files changed, 15 insertions(+), 20 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index a00b43e..b939e90 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -740,6 +740,18 @@ static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
> >  	return (seq + 1) % (chan->tx_win_max + 1);
> >  }
> >  
> > +static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct l2cap_chan *chan)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static inline void l2cap_chan_no_teardown(struct l2cap_chan *chan, int err)
> > +{
> > +}
> > +
> > +static inline void l2cap_chan_no_ready(struct l2cap_chan *chan)
> > +{
> > +}
> 
> One note here. Shall we have debug or error message to indicate that
> function is not implemented?

No, these are like NOPs. Shouldn't be noticed by anyone, if you decided to use
the you are saying that you don't wanna know about it.

	Gustavo
