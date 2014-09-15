Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Sep 2014 13:50:21 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	marcel@holtmann.org
Subject: Re: [PATCH v2 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140915115019.GB13603@omega>
References: <1410514480-9070-1-git-send-email-martin.townsend@xsilon.com>
 <1410514480-9070-3-git-send-email-martin.townsend@xsilon.com>
 <20140915101331.GA10580@omega>
 <5416C8B3.9020302@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5416C8B3.9020302@xsilon.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 15, 2014 at 12:08:35PM +0100, Martin Townsend wrote:
> Hi Alex,
> 
...
> > Also here that's too broken here. In lowpan_give_skb_to_devices we have
> > mixed errno and  NET_RX_SUCCESS for the return variable, we need to
> > clean this up. Maybe just return the NET_RX_SUCCESS|NET_RX_DROP return
> > value from netif_rx call.
> ok, shall i just do a
> return lowpan_give_skb_to_devices(skb);
> 
> and then add the code from freeing or consuming the skb in lowpan_give_skb_to_devices?
> 

yes, great idea.

- Alex
