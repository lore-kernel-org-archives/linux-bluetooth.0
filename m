Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Jun 2010 21:22:13 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Jiri Pirko <jpirko@redhat.com>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: potential bug in bnep_net_set_mc_list()
Message-ID: <20100619002213.GC14514@vigoh>
References: <20100618230916.GA5467@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100618230916.GA5467@bicker>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

* Dan Carpenter <error27@gmail.com> [2010-06-19 01:09:17 +0200]:

> This is from ff6e2163f28a: "net: convert multiple drivers to use
> netdev_for_each_mc_addr, part7"
> 
> net/bluetooth/bnep/netdev.c
>    101                  i = 0;
>    102                  netdev_for_each_mc_addr(ha, dev) {
>    103                          if (i == BNEP_MAX_MULTICAST_FILTERS)
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>    104                                  break;
>    105                          memcpy(__skb_put(skb, ETH_ALEN), ha->addr, ETH_ALEN);
>    106                          memcpy(__skb_put(skb, ETH_ALEN), ha->addr, ETH_ALEN);
>    107                  }
> 
> "i" is never incremented here so the check is always false.

Bring back the increment should fix this. I'll send a fix for this.

-- 
Gustavo F. Padovan
http://padovan.org
