Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 14:49:26 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv4 05/30] Bluetooth: Lock sk only if exist
Message-ID: <20120320124925.GE27063@aemeltch-MOBL1>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1331814621-13905-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikb7ayXRER=JRZqA+gyj56-L1SA1g8FoOsdSEuLHcykcbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikb7ayXRER=JRZqA+gyj56-L1SA1g8FoOsdSEuLHcykcbg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Tue, Mar 20, 2012 at 09:22:46AM -0300, Ulisses Furquim wrote:
> > @@ -212,9 +212,13 @@ static inline void l2cap_state_change(struct l2cap_chan *chan, int state, int er
> >  {
> >        struct sock *sk = chan->sk;
> >
> > -       lock_sock(sk);
> > +       if (sk)
> > +               lock_sock(sk);
> > +
> >        __l2cap_state_change(chan, state, err);
> > -       release_sock(sk);
> > +
> > +       if (sk)
> > +               release_sock(sk);
> >  }
> >
> >  void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
> > --
> > 1.7.9.1
> 
> Well, this doesn't look good, does it? Wouldn't make sense to call
> __l2cap_state_change() where we know sk doesn't exist and
> l2cap_state_change() in the others? After all the separation between
> chan and sk is something we need to have as much clear as possible
> from now on, right?

Sounds good, the only issue is that instead of this simple change we would
have dozens of "if/else".

Best regards 
Andrei Emeltchenko 
