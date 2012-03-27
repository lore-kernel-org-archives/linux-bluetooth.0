Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 13:06:37 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv5 06/26] Bluetooth: A2MP: Add chan callbacks
Message-ID: <20120327160637.GC9856@joana>
References: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332519246-16656-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120325171612.GH3106@joana>
 <20120326115950.GB18219@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120326115950.GB18219@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-26 14:59:52 +0300]:

> Hi Gustavo,
> 
> On Sun, Mar 25, 2012 at 02:16:12PM -0300, Gustavo Padovan wrote:
> ...
> 
> > > +static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
> > > +					unsigned long len, int nb, int *err)
> > 
> > Wrong coding style here. As we just changed our coding style check the rest of
> > this patchset for errors like this
> 
> I believe that here the style is OK. Otherwise we would have to make
> several lines or go outside 80 characters.

Then break it in 3 lines. You have to align everything after the opening "(".

	Gustavo
