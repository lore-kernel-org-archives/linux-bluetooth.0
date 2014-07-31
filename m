Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Jul 2014 08:26:11 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org
Subject: Re: [Linux-zigbee-devel] [PATCH 2/2] Change lowpan_rcv so skb is
 freed within function and fix return values.
Message-ID: <20140731062610.GC26557@omega>
References: <1406733923-21700-1-git-send-email-martin.townsend@xsilon.com>
 <1406733923-21700-3-git-send-email-martin.townsend@xsilon.com>
 <20140731055427.GB26557@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140731055427.GB26557@omega>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 31, 2014 at 07:54:27AM +0200, Alexander Aring wrote:
...
> >  
> >  	raw_dump_inline(NULL,
> > @@ -179,10 +179,10 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
> >  
> >  	new = skb_copy_expand(skb, sizeof(struct ipv6hdr),
> >  			      skb_tailroom(skb), GFP_ATOMIC);
> > -	kfree_skb(skb);
> > -
> >  	if (!new)
> > -		return -ENOMEM;
> > +		return -1;
> > +
> > +	kfree_skb(skb);
> 
> This leaks memory here, move kfree_skb above the condition after the
> skb_copy_expand. This should be also a consume_skb or dev_kfree_skb, we
> should not mix these function in this file and use only one of them.
> 
> We need another patch for this.
>

Ah, no there is no memory leaking sorry. You removed also the
kfree_skb(skb) in the drop label and we do this at one place to detect if
an error occur.

Maybe we can return the errno at the drop label and set err = -ENOMEM
and do a goto drop.

- Alex

