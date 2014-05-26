Return-Path: <cyrus@holtmann.org>
Message-ID: <1401107914.2400.21.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v2 5/8] Bluetooth: 6LoWPAN: Use connected oriented
 channel instead of fixed one
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 26 May 2014 15:38:34 +0300
In-Reply-To: <BF841E7C-706C-42C4-BEA6-E2A6C64066CE@holtmann.org>
References: 
	<1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <1400837248-12179-6-git-send-email-jukka.rissanen@linux.intel.com>
	 <BF841E7C-706C-42C4-BEA6-E2A6C64066CE@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On la, 2014-05-24 at 22:04 -0700, Marcel Holtmann wrote:
> > +static struct sk_buff *bt_6lowpan_chan_alloc_skb_cb(struct l2cap_chan *chan,
> > +						    unsigned long len, int nb)
> > +{
> > +	return bt_skb_alloc(len, GFP_ATOMIC);
> 
> Does this have to be GFP_ATOMIC?
> 

Yep, I see "BUG: sleeping function called from invalid context..."
without it.


Cheers,
Jukka
