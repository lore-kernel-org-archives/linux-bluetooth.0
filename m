Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Sep 2014 10:07:59 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	marcel@holtmann.org, Martin Townsend <martin.townsend@xsilon.com>
Subject: Re: [PATCH][linux-bluetooth 1/3] 6lowpan: skb freed locally from
 lowpan_rcv
Message-ID: <20140911080758.GB19178@omega>
References: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com>
 <1410357968-27051-3-git-send-email-martin.townsend@xsilon.com>
 <20140911075830.GA19178@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140911075830.GA19178@omega>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 11, 2014 at 09:58:30AM +0200, Alexander Aring wrote:
...
> >  
> > @@ -490,14 +490,14 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
> >  	} else {
> >  		switch (skb->data[0] & 0xe0) {
> >  		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
> > -			ret = process_data(skb, &hdr);
> > +			ret = process_data(&skb, &hdr);
> >  			if (ret == NET_RX_DROP)
> >  				goto drop;
> 
> the conversion from errno to NET_RX_DROP here.
> 
> if (ret < 0)
>         goto drop;
> 

should be more drop_skb here, since we removed the kfree_skb in
process_data. ... I know the error handling is a mess, but was also
before I start to working with it. :-)

Thanks, that you accept this challenge to fix it. ;-)

- Alex
