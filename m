Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Feb 2012 10:53:09 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv3 07/16] Bluetooth: Add unlocked __l2cap_chan_add function
Message-ID: <20120210085307.GE28197@aemeltch-MOBL1>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797057-26331-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikYZFA6-vDX-ub-5jif7wf=7pvvw5S_Vcjwu8OKKu6UMFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikYZFA6-vDX-ub-5jif7wf=7pvvw5S_Vcjwu8OKKu6UMFA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Thu, Feb 09, 2012 at 03:54:56PM -0200, Ulisses Furquim wrote:
> > -static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> > +void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> >  {
> >        BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
> >                        chan->psm, chan->dcid);
> > @@ -370,8 +370,13 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> >
> >        l2cap_chan_hold(chan);
> >
> > -       mutex_lock(&conn->chan_lock);
> >        list_add(&chan->list, &conn->chan_l);
> > +}
> > +
> > +void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> > +{
> > +       mutex_lock(&conn->chan_lock);
> > +       __l2cap_chan_add(conn, chan);
> >        mutex_unlock(&conn->chan_lock);
> >  }
> >
> > --
> > 1.7.8.3
> 
> As far as I see we don't need the locked version of l2cap_chan_add().

It is still used.

> What I said in my previous review was to remove the lock and unlock
> around the list_add() and add the prefix __ to l2cap_chan_add() then
> use it like that. You'll see that all places where you have
> l2cap_chan_add() you have already grabbed chan_lock. Ok? Adding the

Not always.

> locked version and not using it afterwards makes no sense at all.
> Another thing is that this change to l2cap_chan_add() really belongs
> to patch number 2 in your series.

Yes I can merge this patch to patch number 2 but does it really belongs to
"changing from RCU to mutex locks"?

Best regards 
Andrei Emeltchenko 
