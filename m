Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Feb 2012 10:21:35 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv4 06/16] Bluetooth: Add socket error function
Message-ID: <20120215082133.GB920@aemeltch-MOBL1>
References: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328882113-19810-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120214183955.GB14503@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120214183955.GB14503@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Feb 14, 2012 at 04:39:55PM -0200, Gustavo Padovan wrote:
> > @@ -974,10 +987,8 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
> >  	mutex_lock(&conn->chan_lock);
> >  
> >  	list_for_each_entry(chan, &conn->chan_l, list) {
> > -		struct sock *sk = chan->sk;
> > -
> >  		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
> > -			sk->sk_err = err;
> > +			l2cap_chan_set_err(chan, err);
> 
> Why is this l2cap_chan_set_err()? This function wasn't holding the lock.
> Please justify this change.

You are right here, will change it to unlocked one.

Best regards 
Andrei Emeltchenko 
