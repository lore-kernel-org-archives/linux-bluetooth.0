Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Feb 2012 11:18:17 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv3 15/16] Bluetooth: Use l2cap chan lock in socket connect
Message-ID: <20120210091816.GF28197@aemeltch-MOBL1>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797057-26331-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikaPnRheNYxZoNRYA6Qg+ndiW887k3ZqH51htEphCK8uBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikaPnRheNYxZoNRYA6Qg+ndiW887k3ZqH51htEphCK8uBA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Thu, Feb 09, 2012 at 04:25:11PM -0200, Ulisses Furquim wrote:
> >        bacpy(src, conn->src);
> >
> > +       l2cap_chan_unlock(chan);
> >        l2cap_chan_add(conn, chan);
> > +       l2cap_chan_lock(chan);
> 
> Hum, do we really need to do this? Maybe l2cap_chan_add() can receive
> chan already locked?

Then we have here order of locking changed and I have lockdep warnings.

And here l2cap_chan_add used locked.

> 
> > -       __l2cap_state_change(chan, BT_CONNECT);
> > +       l2cap_state_change(chan, BT_CONNECT);
> 
> Why? Is there a problem moving the release_sock() call to we don't
> call the locked function here?
> 
> >        __set_chan_timer(chan, sk->sk_sndtimeo);
> >
> >        if (hcon->state == BT_CONNECTED) {
> >                if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
> >                        __clear_chan_timer(chan);
> >                        if (l2cap_chan_check_security(chan))
> > -                               __l2cap_state_change(chan, BT_CONNECTED);
> > +                               l2cap_state_change(chan, BT_CONNECTED);
> 
> And here as well.

Then we would need to release lock before l2cap_do_start.



> 
> >                } else
> >                        l2cap_do_start(chan);


Best regards 
Andrei Emeltchenko 

