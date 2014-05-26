Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 5/8] Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed one
Date: Mon, 26 May 2014 20:25:56 +0200
Message-ID: <1702130.YSG8MgCIJi@athlon>
In-Reply-To: <DED0C0AE-2C66-4B7F-8496-A6CD1DA0230A@holtmann.org>
References: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com> <1401107914.2400.21.camel@jrissane-mobl.ger.corp.intel.com> <DED0C0AE-2C66-4B7F-8496-A6CD1DA0230A@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Monday 26 May 2014 14:46:37 Marcel Holtmann wrote:
> Hi Jukka,
> 
> >>> +static struct sk_buff *bt_6lowpan_chan_alloc_skb_cb(struct l2cap_chan
> >>> *chan, +						    unsigned long len, int nb)
> >>> +{
> >>> +	return bt_skb_alloc(len, GFP_ATOMIC);
> >> 
> >> Does this have to be GFP_ATOMIC?
> > 
> > Yep, I see "BUG: sleeping function called from invalid context..."
> > without it.
> 
> should we fix the caller? I am curious why this is possible in the first
> place. The whole Bluetooth subsystem should run in a workqueue these days.
> Do we have by any chance the wrong lock hold at this point or why is this
> happening.
> 
> If we really need to keep GFP_ATOMIC here then you need to add a comment on
> why that is. Because otherwise we will forget about it next time around.

FWIW this is due to holding hci_dev_list_lock which is RW_LOCK. For similar 
reason there is GFP_ATOMIC in read_index_list() in mgmt.c.

-- 
Szymon K. Janc
szymon.janc@gmail.com
