Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 3/5] route: Exporting ip6_route_add() so that BLE 6LoWPAN can use it
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1382511164-1989-4-git-send-email-jukka.rissanen@linux.intel.com>
Date: Wed, 23 Oct 2013 14:00:44 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <30925AE8-AE7B-43D9-9E5D-4898C0CF8390@holtmann.org>
References: <1382511164-1989-1-git-send-email-jukka.rissanen@linux.intel.com> <1382511164-1989-4-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> net/ipv6/route.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index c979dd9..d7c200f 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -1662,6 +1662,7 @@ out:
> 		dst_free(&rt->dst);
> 	return err;
> }
> +EXPORT_SYMBOL_GPL(ip6_route_add);

check with netdev is this is something that would be accepted upstream.

For the time being, can we work around this internally for testing? I like to just build and load a new Bluetooth module for testing and not have to replace IPv6 as well.

Regards

Marcel

