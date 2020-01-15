Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDBCC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386D3222C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="jQ6yRKx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgAOVEU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:04:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37332 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgAOVEU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 16:04:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so13831636lfc.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Gpp+AqHOstBOYQoao0WoSCGO9bSgfvtWwvknQwxsxJM=;
        b=jQ6yRKx8A+gdLLiQxpoD//YSUhdpaJGD4Ao920084xO9dqn8I9VBftmEdpoKN/tBYk
         Lk+E8x+hCeDRFM19t8sZMA4pPAYb9OI7V/iYUU2wiMCo0utdXOiQOFeiEHI1htX2gfuR
         Llg3nLHZKspAm+VMxrXnJoSZXsyCafu41HGJikBjoa3b4YNW630WSlzfxrdIBhQUUyAf
         gfc/XqkwxHXp6V20td3NN1130Le1qFl5Z5WTPUIDyxiyU5NSTmvO3JqM9WV6RM5jdpW5
         b8F/c8nw3ZYLJ6rBnIW5KG1JvBcNvPuG0It4U3QgBGZ5as1zRQXsyaxKMLTP+GEIEThz
         WPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Gpp+AqHOstBOYQoao0WoSCGO9bSgfvtWwvknQwxsxJM=;
        b=diY66ydXYsC3wQ8LWhqxfqZa96WG2bmiNpUHfaccd1GEeBKJ2MzwUVmjN/VRrM8yJ8
         eiITsmLLB3Tjku1jKpkuZaWVFy1v8tCHAiIE1bBWPtY4T80uQqe48C4P5Wzc/AsEMCe9
         HFE7o4S6+sfj7y4L9Y1ZBEFIwo5nnkF48pF16p6tg/Og+yWQkNf2ROKmmkterdKAAQbD
         33vFzc5Zi7yoZ550mmY5T7pSm5QZukpl7iuxrpJ4LYlXQW+aqrGFIxmnz1uzKdUw73/O
         lAalRmnjhURzMii9rPyVxznZ8ZYkMqDCMK52dnvIJo0Eig5C7lBvVaL/bko7N9mvfRGH
         JjTg==
X-Gm-Message-State: APjAAAWqKCylWatFw2PECPA9a72e0iCTXEawvEUvuXbMUtt/PzizSVjo
        4Qg1mIzuLWeoYzLMMZNnmWKd0w==
X-Google-Smtp-Source: APXvYqwyq92wsPYliVYGfZJVxqpemw6qVOruaOKVhXfcUWfqH7K5pscPHg7PPnWbHuV9IdN6jlebqw==
X-Received: by 2002:ac2:51a4:: with SMTP id f4mr486576lfk.76.1579122258834;
        Wed, 15 Jan 2020 13:04:18 -0800 (PST)
Received: from kynes (apn-5-60-0-97.dynamic.gprs.plus.pl. [5.60.0.97])
        by smtp.gmail.com with ESMTPSA id e21sm11257544lfc.63.2020.01.15.13.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 13:04:18 -0800 (PST)
Date:   Wed, 15 Jan 2020 22:04:14 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "istotlan@ingas-xps13.amr.corp.intel.com" 
        <istotlan@ingas-xps13.amr.corp.intel.com>
Subject: Re: [PATCH 0/1] Sequence number out of range fix
Message-ID: <20200115210414.fvywao5evmbx5725@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "istotlan@ingas-xps13.amr.corp.intel.com" <istotlan@ingas-xps13.amr.corp.intel.com>
References: <20200115170830.7479-1-jakub.witowski@silvair.com>
 <4da92cbf6134822629bd2204fb7161c04008780e.camel@intel.com>
 <20200115190904.qcusabsj3ti7sid4@kynes>
 <4C48D122-7887-4A5E-9E3C-0A2FE15D6A1A@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4C48D122-7887-4A5E-9E3C-0A2FE15D6A1A@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 01/15, Gix, Brian wrote:
> > Good point. Note that his is also possible in the current
> > implementation: since seq_num is applied to nonce with a 24bit mask,
> > it's going to wrap around.
> 
> The full IV Index is in the nonce, and at 192 hours per IV index, will
> be unique for something like 1.4 million years.

Yes it is, but that's not the point.

At the moment, net->seq_num is a 32 bit value that *can* exceed 24bit
range, because mesh_net_next_seq_num() doesn't check ranges. So the
raw value can reach 0x1000000 and above.

Now, this raw value is used in send_seg, passed to
mesh_crypto_packet_build, which effectively applies a 24bit mask in line
640:

	l_put_be32(seq, packet + 1);
	packet[1] = (ctl ? CTL : 0) | (ttl & TTL_MASK);

So this means that when:

 - the network is already in iv update (so that you can't increase the
   iv_index, maybe you even started the procedure yourself because your
   seq_num is above the threshold)

 - your sequence number is sufficiently large (because of the "repeated
   crash" scenario described below)

Then the actual value used in the nonce will be net->seq_num & 0xffffff,
which is something you have *already* used before. All of that happens
with the same IV index.

> The over commit is calculated based on the usage rate, and the daemon
> would need to unexpectedly abort (not just ctrl-c or exit) for us to
> use the over-commit value

Indeed, that's precisely what I'm talking about - repeated, unhandled
process terminations. We're trying to come up with the patch simply
because this situation has *already happened* on one of our instances.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
