Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Dec 2012 17:26:24 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 04/16] Bluetooth: add l2cap_state_change_and_error()
Message-ID: <20121212192624.GA5554@joana>
References: <1355285624-25811-1-git-send-email-gustavo@padovan.org>
 <1355285624-25811-5-git-send-email-gustavo@padovan.org>
 <CAJdJm_PMBC8nivsJuYDp-wW5ei1WF7m3SJzh78RScUyQu5ApJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_PMBC8nivsJuYDp-wW5ei1WF7m3SJzh78RScUyQu5ApJQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2012-12-12 09:40:06 -0400]:

> Hi Gustavo,
> 
> On Wed, Dec 12, 2012 at 12:13 AM, Gustavo Padovan <gustavo@padovan.org> wrote:
> > @@ -238,7 +244,7 @@ static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
> >         struct sock *sk = chan->sk;
> >
> >         lock_sock(sk);
> > -       __l2cap_chan_set_err(chan, err);
> > +       chan->ops->state_change(chan, chan->state, 0);
> 
> Why "0" and not "err" ?

Yes, it is "err" here. I fixed both issues you reported.

	Gustavo
