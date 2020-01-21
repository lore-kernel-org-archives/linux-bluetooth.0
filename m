Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B5DC2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 20:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A3C217F4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 20:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="mYnEf8BA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAUUF3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:05:29 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42155 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgAUUF3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 15:05:29 -0500
Received: by mail-lf1-f47.google.com with SMTP id y19so3364998lfl.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 12:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UcyqngV//1J9l9nZlZu30kKPNe8LASfRxkjZZbOGhEk=;
        b=mYnEf8BAUPeiE7+Kpw36XFHtwtJkwoZMA3YIyVix+XmkQwGfUcCZ8BpOwmBFE7tEOV
         F1Gamd17zpsTA3sHrS8iPBhJdoQv41p7lgletEZuNyveSAyMydcmBQVepBlFmy7HrW9I
         FhdcSxuhl9N2jgnlwpcymGWADeGLT7n9XMWqVRhabqh98JteEzwKmEIA+xNxNvmaj+Nq
         Lgb24l9mnEnMvpwwpmrQ6pMhMjSUt4iIa1twRwzd43Zp0uuNIZ03pvUK1Itqqm8NJN/y
         q6yGkTGMTRY1vALbihkVgGhM+9lN/z7gPoNrwoED3ngumAVgAvk8lMogCHnOX+5f3Mt/
         9TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UcyqngV//1J9l9nZlZu30kKPNe8LASfRxkjZZbOGhEk=;
        b=HoUKmzt5Z11VWPfgonkDujWwECgJjON1RkCgXik+9XAKFH1/oCZQ2INVukfpc9h7xk
         Qk4tHyMAM3f2jT9JKW59ojKJbJ0y+4LcSwsB93bYSDtHxzI6pjRy0nRHethKmp4kCgLx
         fGGonI6k5diKOH62t/PpqCypO0vsQAXItlQJphriTTTAPr4V3VmrszbEj/ZOuSSqCKJt
         xzNqiGrwsef/VVYQtPKV5wZiGlX/bKoRLF7NwhocrDKxMGccuATpzQ8RPo/EcTTzt7bx
         YFLxy+dbG3j1UhKyyphF54xP3W9iRP+rM9AjUurIYGyB3LlgEXnTot2w5nUnblsVDoHv
         3yzA==
X-Gm-Message-State: APjAAAUpbAiUxoAc22m5lqIHQMLd2VdiOVhn5jxNt+mPuQB6cHi5Nx82
        WWi0AdZORhTH44gsdzb5yjm7IQ==
X-Google-Smtp-Source: APXvYqw265jNO7sdl07p9c4SxJKgIkiv/ZxbfS8MOYR2qRpZpgbFRaKNWtT89fuj7F6GtVf/CAG1/w==
X-Received: by 2002:a19:f00d:: with SMTP id p13mr3572666lfc.37.1579637127413;
        Tue, 21 Jan 2020 12:05:27 -0800 (PST)
Received: from kynes ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h19sm19196230ljl.57.2020.01.21.12.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 12:05:26 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Tue, 21 Jan 2020 21:05:24 +0100
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "Gix, Brian" <brian.gix@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/3] Allow to reattach with new composition data
Message-ID: <20200121200524.olwlsw57xcrio5lq@kynes>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "Gix, Brian" <brian.gix@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200120161114.6757-1-jakub.witowski@silvair.com>
 <56b3aa902dee18a45e91d826344085cf1fb3ecca.camel@intel.com>
 <20200121105927.s2a3avh7tdcnf566@jwitowski2365>
 <2565ef678df9e316ac980937f0f629aad83703b6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2565ef678df9e316ac980937f0f629aad83703b6.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 01/21, Stotland, Inga wrote:
> I would strongly prefer not to allow changing CID. Is there a good
> reason to change CID ever?

I don't know, maybe legal, after acquisition, or something?

I don't see any practical difference between these 3 IDs - nothing in
the spec is tied to them, they are informational only. So maybe keep
things simple and not add any "special" logic around the CID?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
