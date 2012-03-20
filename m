Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 15:00:26 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv4 06/30] Bluetooth: Timers fixes
Message-ID: <20120320130024.GF27063@aemeltch-MOBL1>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1331814621-13905-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikYrU460dm9qD+2hYMrdqNO6J=i++EgR8gX9-Rux+SwMhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikYrU460dm9qD+2hYMrdqNO6J=i++EgR8gX9-Rux+SwMhw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Tue, Mar 20, 2012 at 09:21:56AM -0300, Ulisses Furquim wrote:
> > -static inline void l2cap_set_timer(struct l2cap_chan *chan,
> > -                                       struct delayed_work *work, long
> > timeout)
> > -{
> > -       BT_DBG("chan %p state %s timeout %ld", chan,
> > -                                       state_to_string(chan->state),
> > timeout);
> > -
> > -       if (!cancel_delayed_work(work))
> > -               l2cap_chan_hold(chan);
> > -       schedule_delayed_work(work, timeout);
> > -}
> > -
> >  static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
> >                                        struct delayed_work *work)
> >  {
> >        bool ret;
> >
> > -       ret = cancel_delayed_work(work);
> > +       ret = (delayed_work_pending(work) && cancel_delayed_work(work));
> >        if (ret)
> >                l2cap_chan_put(chan);
> >
> >        return ret;
> >  }
> >
> > +static inline void l2cap_set_timer(struct l2cap_chan *chan,
> > +                                       struct delayed_work *work, long
> > timeout)
> > +{
> > +       BT_DBG("chan %p state %s timeout %ld", chan,
> > +                                       state_to_string(chan->state),
> > timeout);
> > +
> > +       l2cap_clear_timer(chan, work);
> > +
> > +       l2cap_chan_hold(chan);
> > +       schedule_delayed_work(work, timeout);
> > +}
> > +
> What are you fixing here? Care to explain and send an example? This
> needs to be clear in the commit message so we don't have more
> confusion with timer handling as we had this code for quite some time.

I have just sent the patch with proper commit message. I think you assume
that cancel_delayed_work returns not zero if it cancels delayed work but
it returns not zero if there is no work running (even if there was no timer
-- as far as I understood and comment apply).

Best regards 
Andrei Emeltchenko 

