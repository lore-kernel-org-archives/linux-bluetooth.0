Return-Path: <SRS0=Hm6j=RK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8DBC4360F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 10:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7881420684
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 10:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1lEDnQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCGKlO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:41:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33448 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfCGKlO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Mar 2019 05:41:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so11124015pfd.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Mar 2019 02:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+p89l7H6FmlZSuFb/uCgAEWfv7hWQwNSunqqb7qd3Y=;
        b=i1lEDnQf4gDu5zcUbZ3rVnzWd4HwfLshjkVHLUOTFqNlBwIbG/RPm2K/2L6HlzG0TS
         kE2q0cimevkRlXlDX1IXhhRAeJ9x5fJmB6snCrFf/rOf+htFwxdFM/8JMEqLKaQb2RJ9
         yJtVayGY76ShrMwchacDfoh+XRcc5mDAJYFnB9Pvnpabnky3djrpm4gCeK4PSRajx3oT
         qDr6wj4zayar1NO/Xu3fg/Hd+41ZtBXGllIZflzeNJGmEjyW2bbojpxWHvKGVI4xCQ9a
         56eRRdCvwoyNW4Cf5dRlRdSts0Ut4vV89zx8ZPLTnRVBI2na+VbJx8UlOBvGDRGOJ2ml
         kiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=t+p89l7H6FmlZSuFb/uCgAEWfv7hWQwNSunqqb7qd3Y=;
        b=dEgpmFfOyWBjS7DTS13VyJiIjrrM3RWCBkJBZXO1L7m6ZhPBm0+n96juMOp3eNvdop
         AXb62cwvjS6MtpFKcm/DYBCI/l26TZEHtzZrV0wWWx24S4MHRCkvKcaF94bQs3gbNaqr
         xob52g2Cce0goQ7aDDQg2pQcRGp1W/6spvvKWsWr1vegIVU+swb7NMqSJRaa1KtuqJun
         louT/QWzpxYABtAXz714mdwe3v6odRShI1Shsp3QXX/2RfzaQp51ftfJG5jdAtPfAyfa
         LgQDjVqv86pqEcG+ZHqrqWOBVFugzB3GguCEpcnpPOUDdJNQigoOe/ANxptFf4fXPodd
         maXA==
X-Gm-Message-State: APjAAAVMqnVl1YcmyCVFNJVPpb/Obque/xhvfF56IchOTyKjppL67ovM
        sizPqx+zKw5S2OwdOYxc3Mt8Dr730ao=
X-Google-Smtp-Source: APXvYqwX5csg2TBRuYt8yfFkZ8elEFuaFSxSaZvzPBC//7FdY2cN2dZ1nahyXPrseX3HIJcdowf3Wg==
X-Received: by 2002:aa7:8059:: with SMTP id y25mr11981443pfm.74.1551955273270;
        Thu, 07 Mar 2019 02:41:13 -0800 (PST)
Received: from localhost ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id f87sm7473213pff.38.2019.03.07.02.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 02:41:12 -0800 (PST)
Date:   Thu, 7 Mar 2019 12:41:08 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Josua Mayer <josua.mayer@jm0.eu>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] bluetooth: 6lowpan: check neighbour table for SLAAC
Message-ID: <20190307104108.GA32563@ccociasx-wtg7.ger.corp.intel.com>
Mail-Followup-To: Josua Mayer <josua.mayer@jm0.eu>,
        linux-bluetooth@vger.kernel.org
References: <20190208152519.16181-1-josua.mayer@jm0.eu>
 <20190208152519.16181-3-josua.mayer@jm0.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208152519.16181-3-josua.mayer@jm0.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Josua,

Your patches look fine to me in general, just a very minor thing with
this one:

On Fri, Feb 08, 2019, Josua Mayer wrote:
> +	// use the neighbout cache for matching addresses assigned by SLAAC

C++ comment style isn't used - use /* ... */ instead.

Johan
