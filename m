Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F6BC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 22:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F74C2465A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 22:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="F3ydmm6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAOWCp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:02:45 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43791 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAOWCp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 17:02:45 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so13953976lfq.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 14:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6BwF7PjtzsoNEKXcA1p5I+0sY0cHBo7uiQ/SNaQ0tyA=;
        b=F3ydmm6PWaVlneVZuE0mhXTZIVjRn3RrqiP+91izi6gQlXZfSsPi0VuLHIdWv4eWI8
         oPxQDx080U/H7fx7XcskBpA61Jey4hqWYYcWrJEKzZUQ2p/eNXyQjuVU3olRgd3iQQqE
         +vRjEz2GhKUzLq59O2LM2NJllP38BcV68bTeyBx+HIRpSWSlkTkHqFXUFxkrTL0beOyw
         ze8NMq1hAZwaAN5iaYHofCBWhE0lyH5pW1kEmt7JXVe+S29vjsrgCCB4QIUAh4GHBEfO
         jXjQbnjMiGqDlkrEW/wKB7r4t0AMxgoetD9lUat+h2NnfGbG84UYkolwtm/AE4cY+1ff
         wFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6BwF7PjtzsoNEKXcA1p5I+0sY0cHBo7uiQ/SNaQ0tyA=;
        b=rljEh6P4fP6jSEZfXCf4O614kD4Ot+lZQkmJIr0F7JaHrLa5JvSnMVX+YtZ95RvRgj
         IaGs0I93+kAmx8S1pkxY7p1613+5PJqugv2iIgz/kstjIfIBtlCZ4b5F+hsMfTWFAKUV
         26M+0fG2vTeVEQOJeEejjMDVIz6eNjMZgNFHW5OAqG923I4wtaJ9AudfRxD5gjDSZtNq
         fdFXlWRxjJm2+aDMmRcUoGYkhvwWwtr3GR8tiTmoOa9SktExcp21/bZDsaPENqg7kMP5
         ht7avuVu0dcdogFWsflnHc238sc6MkXYsrfUMS087TU6yvbYP/86Gpgi9uHBU52RxVy4
         psLw==
X-Gm-Message-State: APjAAAXHzInkqeIVaIVLloPgpfiwX4+zMMOzt3vPXNSUUQP5YXck9IcJ
        ybazVdRsXfM016d1IsL0tUhHiD5odao=
X-Google-Smtp-Source: APXvYqxp3hw64hqQXy2yyHkenz7Fhi/SnCAMxAlIZLV1K9ay0B0msOoqSHD2nV+OOXSv3ZxcqdayfQ==
X-Received: by 2002:ac2:51de:: with SMTP id u30mr586913lfm.69.1579125763690;
        Wed, 15 Jan 2020 14:02:43 -0800 (PST)
Received: from kynes (apn-5-60-0-97.dynamic.gprs.plus.pl. [5.60.0.97])
        by smtp.gmail.com with ESMTPSA id y1sm9728424ljm.12.2020.01.15.14.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 14:02:43 -0800 (PST)
Date:   Wed, 15 Jan 2020 23:02:39 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "istotlan@ingas-xps13.amr.corp.intel.com" 
        <istotlan@ingas-xps13.amr.corp.intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/1] Sequence number out of range fix
Message-ID: <20200115220239.x3jnpn5z6strqwr4@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "istotlan@ingas-xps13.amr.corp.intel.com" <istotlan@ingas-xps13.amr.corp.intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200115170830.7479-1-jakub.witowski@silvair.com>
 <4da92cbf6134822629bd2204fb7161c04008780e.camel@intel.com>
 <20200115190904.qcusabsj3ti7sid4@kynes>
 <4C48D122-7887-4A5E-9E3C-0A2FE15D6A1A@intel.com>
 <20200115210414.fvywao5evmbx5725@kynes>
 <456a42fe1d521b9c61bb54bacbddf7b99573df5f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <456a42fe1d521b9c61bb54bacbddf7b99573df5f.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 01/15, Gix, Brian wrote:
> > Now, this raw value is used in send_seg, passed to
> > mesh_crypto_packet_build, which effectively applies a 24bit mask in line
> > 640:
> 
> Yes, we should definitely be sanity checking this, and not sending if
> SeqNum out of range.

Ok, we'll do that then.

> I think if we are repeatedly crashing, and it is causing a runaway
> sequence number increase, that being forbidden to send more packets is
> a natural consequence, and people should fix the code that was causing
> the crash in the first place.

You don't say. But it's not a given that the code is in the daemon
itself. Two words: OOM killer.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
