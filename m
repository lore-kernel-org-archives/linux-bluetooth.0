Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 10:59:39 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 02/19] Bluetooth: Add ready to L2CAP channel ops
Message-ID: <20120524075936.GC24715@aemeltch-MOBL1>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337787445-23235-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337787445-23235-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1205231614400.6526@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1205231614400.6526@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, May 23, 2012 at 04:16:37PM -0700, Mat Martineau wrote:
> >+static void l2cap_sock_chan_ready_cb(struct l2cap_chan *chan)
> >+{
> >+	struct sock *sk = chan->sk;
> >+	struct sock *parent;
> >+
> >+	lock_sock(sk);
> >+
> >+	parent = bt_sk(sk)->parent;
> >+
> >+	BT_DBG("sk %p, parent %p", sk, parent);
> >+
> >+	__clear_chan_timer(chan);
> >+
> >+	/* This clears all conf flags, including CONF_NOT_COMPLETE */
> >+	chan->conf_state = 0;
> >+
> >+	chan->state = BT_CONNECTED;
> 
> Similar to patch 1, would there be some benefit to leaving the chan
> code (timer clearing, state and conf_state modification) in
> l2cap_core?  These things need to happen even if chan->ops->ready is
> NULL.

This can be done, then I would need to create new function like
l2cap_chan_ready which do chan code and calls ready callback. I will try
to come out with some solution later today.

Best regards 
Andrei Emeltchenko 

