Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A527C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 17:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9652253D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 17:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="lZ/DGBCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAVRNh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:13:37 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:39653 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgAVRNh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 12:13:37 -0500
Received: by mail-lj1-f179.google.com with SMTP id o11so7391016ljc.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2020 09:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zCQZTxEiO6faW0D2gqXFRPqSa61RXiivlawGUBqA0nw=;
        b=lZ/DGBCkRGKJdom3YDeNHTN0hS8ys1EwwuC6vtdjXtQm8svNgVVsVroN/EJ6kxG0xR
         S+8O74aaJKd7gqWIT/aNDUmFpwlml8EwRu6CwSptvWXQOtygzg/7/Oq7D8sRoM1MdcRH
         brPqa5m1lloV2LfLtcEN/yUwFMcZZ0MJCVStxMzODcQUDIa+87iKgzo0/xNiF2msNVQD
         1XL74UXFZihLJRvZg4xFPAtFrDc9GFLMLWTiB1p6toffYD9HH7w/9HcDxU2PHaDwhAoU
         JozRpW4Ez5PjLlmCj/Md+33bYdyJFyDJpLquZOe/4APYcsen8WI1JsBvnXF/TrXHOd8b
         FVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zCQZTxEiO6faW0D2gqXFRPqSa61RXiivlawGUBqA0nw=;
        b=muclgyN821os5gPnkeTQREFcgrmSJCQjoHLHbkYKHS9uOdup1G1a//yet/MZgr0A7R
         hNMcuc1e+vzxO5d8EQHCrxLsnRrR+OJNzoWTlxmS2t8LpSArvECAwJ2cMa3oQeZNOBth
         l59AbztENgzA/8SbcFsHsPoitDIPUqlerx4btLxqC3TkFAUsXwgJf9GcKGqD2qvnKq8b
         gS4LlX82EVx05tCpwMtDqbtwspWSP1cSzRqyElRtkIWR3MP775QSts5UxZ28oN9Ty6pG
         VcFfLs5uxCHlMBhkPmybeTRM6oHDHcyHzymBcPQs1eYPOvO+t7AspOSnuyn6JGA5HAx6
         GDWw==
X-Gm-Message-State: APjAAAVGy74cMlAW9Q6plvBxGFQnYyNpf7PCi2GIqjMqwPv8+lf4xBWf
        kbkL60UnVHLLl5fNc3f2R7CMWQ==
X-Google-Smtp-Source: APXvYqxUVpM2M7AIogZcld07KpkjFui1xNbIr2Srj+Qr6r55H3u/5XHXnlHHIUwaFEdehnUVxqJt7g==
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr20572106ljg.3.1579713215484;
        Wed, 22 Jan 2020 09:13:35 -0800 (PST)
Received: from kynes (apn-31-2-112-202.dynamic.gprs.plus.pl. [31.2.112.202])
        by smtp.gmail.com with ESMTPSA id q13sm24487645ljj.63.2020.01.22.09.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 09:13:34 -0800 (PST)
Date:   Wed, 22 Jan 2020 18:13:32 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [RFC BlueZ 0/2] Fix types and names of beacon/import flags.
Message-ID: <20200122171332.5clpw7vzlpnsub6r@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20200109083855.16000-1-michal.lowas-rzechonek@silvair.com>
 <20200121201501.v4ceigg5xngfvjb4@kynes>
 <8c665ad8c0856a3f8dd8e4d808599c953b5dfcd1.camel@intel.com>
 <ddced1e3db7d6448a2aa017ffdcb830873fee3f6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddced1e3db7d6448a2aa017ffdcb830873fee3f6.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian, Inga,

On 01/22, Gix, Brian wrote:
> Signal Emissions are Information Leaks

No, they aren't. Flags and IV Index value is public information, sent in
open text over the air in Secure Network Beacons.

> that provide no benefit...  they are sent globally to anyone on the
> DBus, and signals to anyone who may be eavesdropping that *something*
> is happening

Yeah, and you get the same info from listening to beacons. I would just
like to make it slightly easier to listen to locally. At the moment one
needs to wait for the beacon to be transmitted.


Anyway: what's your opinion about the proposed API modifications (IvUpdate
rename and BeaconFlags type change)?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
