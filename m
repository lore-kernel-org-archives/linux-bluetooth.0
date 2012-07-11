Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jul 2012 14:37:58 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Bluetooth: debug: Print l2cap refcount
Message-ID: <20120711113756.GB3044@aemeltch-MOBL1>
References: <1341923271-14222-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1341923271-14222-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120710183333.GC13847@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120710183333.GC13847@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jul 10, 2012 at 03:33:33PM -0300, Gustavo Padovan wrote:
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/l2cap.h |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index d80e3f0..dfe9374 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -672,11 +672,17 @@ enum {
> >  
> >  static inline void l2cap_chan_hold(struct l2cap_chan *c)
> >  {
> > +	BT_DBG("chan %p refcnt %d -> %d", c, atomic_read(&c->refcnt),
> > +	       atomic_read(&c->refcnt) + 1);
> > +
> 
> We don't really need to call atomic_read() twice read. Just print the new
> value and the log reader has to figure it out.

The code looks better if I print original refcnt in a case chan_put and
also for kref cases with amp_mgr. I will send patches shortly.

Best regards 
Andrei Emeltchenko 
