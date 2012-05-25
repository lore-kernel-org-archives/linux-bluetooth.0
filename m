Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 10:07:00 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 1/2] Bluetooth: Create chan->ops->set_err()
Message-ID: <20120525070658.GB3089@aemeltch-MOBL1>
References: <1337839374-20443-3-git-send-email-gustavo@padovan.org>
 <1337842817-27865-1-git-send-email-gustavo@padovan.org>
 <20120524082603.GE24715@aemeltch-MOBL1>
 <20120524170412.GE3105@joana>
 <alpine.DEB.2.02.1205241014250.18142@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1205241014250.18142@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 24, 2012 at 10:18:07AM -0700, Mat Martineau wrote:
> >>On Thu, May 24, 2012 at 04:00:16AM -0300, Gustavo Padovan wrote:
> >>>-	lock_sock(sk);
> >>>-	__l2cap_state_change(chan, BT_DISCONN);
> >>>-	__l2cap_chan_set_err(chan, err);
> >>>-	release_sock(sk);
> >>>+	l2cap_state_change(chan, BT_DISCONN);
> >>>+	if(chan->ops->set_err)
> >>>+		chan->ops->set_err(chan->data, err);
> >>
> >>I do not know can it be done somehow better, currently we lock and unlock
> >>sockets for each operation.
> >
> >I'm having trouble to get your point, could you please explain?
> 
> What I see is that the lock used to be acquired once, with both
> state_change and set_err happening while locked.  With this change,
> the lock is acquired twice, once for state_change and once for
> set_err.  I'm not sure it's good to release the lock between
> state_change and set_err.

Maybe we add parameter err to l2cap_state_change and if set set error.

Then we do not lock/unlock for each operation.

Best regards 
Andrei Emeltchenko 
