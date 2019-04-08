Return-Path: <SRS0=Ssic=SK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC181C10F13
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 18:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21E82084C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 18:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="Rha+EuuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfDHSQW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:16:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34634 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfDHSQV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Apr 2019 14:16:21 -0400
Received: by mail-io1-f66.google.com with SMTP id n11so11938964ioh.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2019 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0tlyk4FQ6HuHMCUtDzHor1YlbGrEJ0p0O7u2utWEVHM=;
        b=Rha+EuuIAdeRD0ObtQXs73mustlQl62Ar9SuOSgcoi55uAA3Mds3drrCLyjWrZxGgb
         WNM2b3fuwV2D+51eD0HtRleMLAxidDjN17+N25U+SMihBqCrTF0fMAqbyUkvkCIPmMHk
         pkyxyA1wyBphaMV26tTkcrz8tVMhnxrF1dag8Uiw0DoP53Osv/i16GP82+auj+fx8wLB
         XTDId1mUJnxB4DouoqQ6ESupGEqQS5xCGk4D9Veakus8cSCxR/BE004BVUGDR7SMemVv
         2tO0UefeTnOivWyMw+EW2Vskl010wkWPGYxWZtpIu61nMLMb4vRSuguLfqWu95YPHTzn
         GtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0tlyk4FQ6HuHMCUtDzHor1YlbGrEJ0p0O7u2utWEVHM=;
        b=VJ0WrdHSi503Lcqr8DtK/aRaGsnkQkzIA1n0RjhXDmtSxxk+6p11yAL0faXAe/ZpRu
         zJbAtYXxVXuizW/wBIU/WBBvsYYa/z4Ml2I25VMECIb2ch/sx439uu7O/RQRFdqkhxgF
         toprbh9q8d1EMVsPrdN9U5SA1Yr5QpiYuQd8Yikm6i1RZjILFltMN/7nacC9ggRV2PBO
         xr4otyc/POYXoFMkt7gKMW3YOQhA8OmXwjcX7PscbDD3xtIt+97c/zGUQ5jpWDNAA7h+
         qh7oIrHU1hhaleYQ8AFlxx5GcNfJ84UaxO2unE4FA4VlEYne+NgHJLqU7AfKcuXqx5xO
         kA8w==
X-Gm-Message-State: APjAAAX2SeaxHf2/7+enhA5aDR4PP7k+iNlNfI4TjP1sJA/NcI7sqQCC
        VWMWFnFyzEMUsAVc7Wsu0nWrSg==
X-Google-Smtp-Source: APXvYqyh2V7+WuzR2EG+LS3PSkNLTvZaQXkhousrfbfZGvtFw7WEcwcRKrENxpTv4uVOqcv6dLEB7Q==
X-Received: by 2002:a6b:d913:: with SMTP id r19mr7524529ioc.76.1554747381142;
        Mon, 08 Apr 2019 11:16:21 -0700 (PDT)
Received: from x220t ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id c200sm5372559itc.43.2019.04.08.11.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 11:16:20 -0700 (PDT)
Date:   Mon, 8 Apr 2019 14:16:18 -0400
From:   Alexander Aring <aring@mojatatu.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] 6lowpan: Off by one handling ->nexthdr
Message-ID: <20190408181618.2m5c3aqlqjmem57j@x220t>
References: <20190403053416.GA21913@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403053416.GA21913@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Apr 03, 2019 at 08:34:16AM +0300, Dan Carpenter wrote:
> NEXTHDR_MAX is 255.  What happens here is that we take a u8 value
> "hdr->nexthdr" from the network and then look it up in
> lowpan_nexthdr_nhcs[].  The problem is that if hdr->nexthdr is 0xff then
> we read one element beyond the end of the array so the array needs to
> be one element larger.
> 
> Fixes: 92aa7c65d295 ("6lowpan: add generic nhc layer interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Alexander Aring <aring@mojatatu.com>

Thanks.

- Alex
