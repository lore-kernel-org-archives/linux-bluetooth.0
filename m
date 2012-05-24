Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 14:04:12 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 1/2] Bluetooth: Create chan->ops->set_err()
Message-ID: <20120524170412.GE3105@joana>
References: <1337839374-20443-3-git-send-email-gustavo@padovan.org>
 <1337842817-27865-1-git-send-email-gustavo@padovan.org>
 <20120524082603.GE24715@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120524082603.GE24715@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2012-05-24 11:26:04 +0300]:

> Hi Gustavo,
> 
> On Thu, May 24, 2012 at 04:00:16AM -0300, Gustavo Padovan wrote:
> > -	lock_sock(sk);
> > -	__l2cap_state_change(chan, BT_DISCONN);
> > -	__l2cap_chan_set_err(chan, err);
> > -	release_sock(sk);
> > +	l2cap_state_change(chan, BT_DISCONN);
> > +	if(chan->ops->set_err)
> > +		chan->ops->set_err(chan->data, err);
> 
> I do not know can it be done somehow better, currently we lock and unlock
> sockets for each operation.

I'm having trouble to get your point, could you please explain?

	Gustavo
