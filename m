Return-Path: <cyrus@holtmann.org>
Message-ID: <1402921114.27142.100.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v6 1/4] Bluetooth: 6LoWPAN: Use connected oriented
 channel instead of fixed one
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 16 Jun 2014 15:18:34 +0300
In-Reply-To: <C2C016F1-D165-4E26-B19B-9BDA3373CB5B@holtmann.org>
References: <1402664013-29358-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <1402664013-29358-2-git-send-email-jukka.rissanen@linux.intel.com>
	 <2A263CED-602C-48AD-830F-77DA72D89514@holtmann.org>
	 <1402918352.27142.84.camel@jrissane-mobl.ger.corp.intel.com>
	 <C2C016F1-D165-4E26-B19B-9BDA3373CB5B@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On ma, 2014-06-16 at 13:49 +0200, Marcel Holtmann wrote:
> Hi Jukka,
> 
> >>> Create a CoC dynamically instead of one fixed channel for communication
> >>> to peer devices.
> >>> 
> > 
> >>> +static struct l2cap_ops bt_6lowpan_chan_ops;
> >> 
> >> Why this does need a forward declaration. Lets avoid this. And just a reminder that l2cap_ops need to be const now.
> > 
> > The chan_ops is needed when setting up the channel in new_connection cb,
> > I did not see a way to avoid forward declaration here.
> 
> then why does l2cap_sock.c does not need this forward declaration?
> 
> Either your code is doing something funky or our l2cap_ops is not flexible. I think we should not require this forward declaration. Can we fix this?

Hmm, it might be that I am doing something wrong. So the current code
allocates a new channel in new_connection cb, because of that the
channel's ops field need to be set and forward decl. is needed.
l2cap_sock.c does the allocation of chan differently but I was not quite
able to understand the magic behind it.


> 
> >>> +	/* Remember the skb so that we can send EAGAIN to the caller if
> >>> +	 * we run out of credits.
> >>> +	 */
> >>> +	chan->data = skb;
> >> 
> >> Isn't this one dangerous? Who owns the skb and also more important who frees it? Don't we have to reference the skb somehow?
> > 
> > Sure, I will add ref here.
> 
> Only if it is needed. I am still curious on how owns this SKB and who is responsible for freeing it. I want to make sure we do not leak memory here.

Well, the skb comes from netdev so it should not disappear during BT
transmit so in theory we would not need to ref the skb. Taking ref just
increments the skb->users field so this is not very big issue.


> 
> >>> +static struct sk_buff *chan_alloc_skb_cb(struct l2cap_chan *chan,
> >>> +					 unsigned long hdr_len,
> >>> +					 unsigned long len, int nb)
> >>> +{
> >>> +	return bt_skb_alloc(hdr_len + len, GFP_ATOMIC);
> >>> +}
> >> 
> >> this should no longer be there and just use the default one.
> >> 
> > 
> > Using GFP_KERNEL in standard l2cap_chan_no_alloc_skb() will lead to this
> > "might sleep" bug:
> 
> So why is that? Who is calling l2cap_chan_send and where is it calling it from. The current assumption is that it is called from a context that can sleep. Is the netdev context not able to sleep when doing TX? Can we change this to a netdev context that can sleep?

I am guessing that the culprit is the hard xmit functions as seen in the
backtrace. I do not think there is a way to change this, we have created
a network device and our xmit function is now being called whatever way
netdev decides.

[   43.409028]  [<f848faf2>] bt_xmit+0x1f2/0x2f0 [bluetooth_6lowpan]
[   43.409028]  [<c1710a1c>] dev_hard_start_xmit+0x2ec/0x5e0
[   43.409028]  [<c18221ab>] ? _raw_spin_lock+0x6b/0x80
[   43.409028]  [<c1711080>] __dev_queue_xmit+0x370/0x630
[   43.409028]  [<c1710d10>] ? dev_hard_start_xmit+0x5e0/0x5e0
[   43.409028]  [<f848fbf0>] ? bt_xmit+0x2f0/0x2f0 [bluetooth_6lowpan]
[   43.409028]  [<c171134f>] dev_queue_xmit+0xf/0x20

> 
> Do we need to provide the gfp_t to alloc_skb or should we let all implementations provide their own version of it. The more issues we uncover with this, the more I think we need to start re-thinking core parts of L2CAP packet handling.

What about keeping it simple and allowing alloc_skb cb to allocate the
memory anyway it wants to.

> 
> What we might need is something that can handle iovev/msghdr and fragment it on the spot into a proper SKB with fragments. And something that can take a SKB from a higher layer (for example netdev) and fragment that into ACL packets.
> 
> Regards
> 
> Marcel
> 


Cheers,
Jukka


