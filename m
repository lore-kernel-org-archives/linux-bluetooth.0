Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D12EC10F06
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 06:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E26420882
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 06:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCGX5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:23:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:50920 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfDCGX5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 02:23:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 23:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,303,1549958400"; 
   d="scan'208";a="334526877"
Received: from jrissane-mobl.fi.intel.com ([10.237.67.34])
  by fmsmga005.fm.intel.com with ESMTP; 02 Apr 2019 23:23:53 -0700
Message-ID: <50a114ab56ec46ab88f7721081e1d1489fe0f369.camel@linux.intel.com>
Subject: Re: [PATCH net] 6lowpan: Off by one handling ->nexthdr
From:   Jukka Rissanen <jukka.rissanen@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alexander Aring <alex.aring@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Wed, 03 Apr 2019 09:23:52 +0300
In-Reply-To: <20190403053416.GA21913@kadam>
References: <20190403053416.GA21913@kadam>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

On Wed, 2019-04-03 at 08:34 +0300, Dan Carpenter wrote:
> NEXTHDR_MAX is 255.  What happens here is that we take a u8 value
> "hdr->nexthdr" from the network and then look it up in
> lowpan_nexthdr_nhcs[].  The problem is that if hdr->nexthdr is 0xff
> then
> we read one element beyond the end of the array so the array needs to
> be one element larger.
> 
> Fixes: 92aa7c65d295 ("6lowpan: add generic nhc layer interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This is the only place which uses the NEXTHDR_MAX define, so I
> considered
> changing that to 256 instead.  Either fix would work.
> 
>  net/6lowpan/nhc.c  | 2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
> index 4fa2fdda174d..9e56fb98f33c 100644
> --- a/net/6lowpan/nhc.c
> +++ b/net/6lowpan/nhc.c
> @@ -18,7 +18,7 @@
>  #include "nhc.h"
>  
>  static struct rb_root rb_root = RB_ROOT;
> -static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
> +static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX + 1];
>  static DEFINE_SPINLOCK(lowpan_nhc_lock);
>  
>  static int lowpan_nhc_insert(struct lowpan_nhc *nhc)

Nice catch!

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka



