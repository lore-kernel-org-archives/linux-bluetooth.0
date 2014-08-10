Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Aug 2014 17:14:36 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com
Subject: Re: [RFC bluetooth-next 1/8] 6lowpan: add generic nhc layer interface
Message-ID: <20140810151434.GB31007@omega>
References: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
 <1407610943-27701-2-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1407610943-27701-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Aug 09, 2014 at 09:02:16PM +0200, Alexander Aring wrote:
....
> +
> +	nhc = lowpan_search_nhc_by_nhcid(*skb);
> +	if (nhc) {
> +		ret = nhc->uncompress(skb);
> +		if (!ret) {
> +			skb_reset_transport_header(*skb);
> +			hdr->nexthdr = nhc->nexthdr;
> +		} else if (ret == -ENOTSUPP) {
> +			net_warn_ratelimited("%s received %s which is not supported.\n",
> +					     (*skb)->dev->name, nhc->name);
> +		}
> +	}

here we need a else branch and return -ENOENT or something similar to
drop the packet afterwards.

Thanks Phoebe for the hint.

- Alex
