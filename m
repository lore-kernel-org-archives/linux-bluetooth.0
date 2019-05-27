Return-Path: <SRS0=yF4w=T3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B58CC07542
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 May 2019 06:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447A920717
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 May 2019 06:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="rfa0UV59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfE0Gya (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 May 2019 02:54:30 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:42044 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfE0Gya (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 May 2019 02:54:30 -0400
Received: by mail-lj1-f173.google.com with SMTP id 188so13657837ljf.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 May 2019 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RCRhcmJCaNfa5Vb+j+5bk04PYDXOJTpzB+KreXdM5so=;
        b=rfa0UV59Ga0aZe18xZpba5HFgDmRgBj+rhdAp8XS3bIn0zcR32uQqCh3bmodW1IZfI
         YU7Sp9MYorue4Nq9/GIZll2WUw2HSiohTezrkWYJh8x2uXUAysyfb+YkQKh9MwzS+JPn
         D0ur7NnsLbO4BBuqxo+AErKeW+8DXHvvNJCxhg3QVKNlqONO+Rr0xGN78DakAsLQ+kzV
         T4lsNAINVyeHawMGpg/w3lldLr86WQiAcjDQ7alBzL1nFLG9/x+rb0LgAOVaFlTK2KrG
         cFmDOny9qSRai113Eqapp4eJ2TDwiNclddDDIoOQNgQfa4TJDj0mvqAvf7yUMz7tkpaQ
         MJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RCRhcmJCaNfa5Vb+j+5bk04PYDXOJTpzB+KreXdM5so=;
        b=bP1dEHeL9pvwi6nrwaSZY7cVDLLPEzcLMb+1LnBfQ9Ms/dvYK8hiUtDwjdR4qum6Q8
         bBWntYC5f2AtWFwnHnYMgfKUYRyoEkPcBkIc6qlhYTqnSRP4HE1BK7zWdYS3FKLarjLV
         YWJlFIffua4gR4Wo7JZETKuD5zVJ9EQOATVmfWTGUlVvECw70m6/Uo+gLoXqZstKW20T
         3NtfYRA+ZZUUYB8p/9b73P0mGC/LtfqFXwolATTnB0E5QJLbK9OjpdgDKxAh1rh1iB5T
         yob2ttrepmGPzcr8T6JvryH3s2p9GNoBF6viqhKgHZQFVbk9btriuGyOkCHyO52f39Gl
         lnog==
X-Gm-Message-State: APjAAAUD7BxEtyWzVsUtsD3abuPKZSOLN3y70/PBuOalDB3bmntf3+Qv
        xBr+QzrQYs3wuKS0jLs6RYzAYI0vgOo=
X-Google-Smtp-Source: APXvYqwhaNyX4iGdKmZ9o1xbFncLGueHJEmiXP/iZcB2a6nlN6mpmPFGTureNMmPyEp0giv2PQTOUA==
X-Received: by 2002:a2e:121d:: with SMTP id t29mr50147162lje.29.1558940068342;
        Sun, 26 May 2019 23:54:28 -0700 (PDT)
Received: from scytale ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id p10sm2073488ljh.50.2019.05.26.23.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 May 2019 23:54:27 -0700 (PDT)
Date:   Mon, 27 May 2019 08:54:25 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix long MIC usage in segmented messages
Message-ID: <20190527065425.frz3i25x5qha4qlo@scytale>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20190523175321.13094-1-brian.gix@intel.com>
 <1558710400.332.20.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1558710400.332.20.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 05/24, Gix, Brian wrote:
> Patch Applied

Sorry for radio silence, I was away for last two weeks.

Thank you!

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
