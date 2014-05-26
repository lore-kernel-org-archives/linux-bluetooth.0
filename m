Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 5/8] Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed one
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401107914.2400.21.camel@jrissane-mobl.ger.corp.intel.com>
Date: Mon, 26 May 2014 14:46:37 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DED0C0AE-2C66-4B7F-8496-A6CD1DA0230A@holtmann.org>
References: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com> <1400837248-12179-6-git-send-email-jukka.rissanen@linux.intel.com> <BF841E7C-706C-42C4-BEA6-E2A6C64066CE@holtmann.org> <1401107914.2400.21.camel@jrissane-mobl.ger.corp.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

>>> +static struct sk_buff *bt_6lowpan_chan_alloc_skb_cb(struct l2cap_chan *chan,
>>> +						    unsigned long len, int nb)
>>> +{
>>> +	return bt_skb_alloc(len, GFP_ATOMIC);
>> 
>> Does this have to be GFP_ATOMIC?
>> 
> 
> Yep, I see "BUG: sleeping function called from invalid context..."
> without it.

should we fix the caller? I am curious why this is possible in the first place. The whole Bluetooth subsystem should run in a workqueue these days. Do we have by any chance the wrong lock hold at this point or why is this happening.

If we really need to keep GFP_ATOMIC here then you need to add a comment on why that is. Because otherwise we will forget about it next time around.

Regards

Marcel

