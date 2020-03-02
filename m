Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BCFC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 14:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA25214DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 14:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="R3Oy1eAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCBOWm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:22:42 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34725 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgCBOWm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 09:22:42 -0500
Received: by mail-wr1-f52.google.com with SMTP id z15so12876079wrl.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2020 06:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iyH2jqHbAo/0kInMN+91cUOZsd7GtvO7MpjGcoLxzcQ=;
        b=R3Oy1eAYbL9YqUqPHtLNe4d+HDwFYuWFE0Z1nk3RDhXqnglYQvhFETRqmzfpZfgZoW
         tX7ooKC98BXO+np3pteB8bi8KVJprSW6uQ7Um69nj/CHuS6SzDzAYq3mIvDDSIeyydnF
         4mFtO9cWi2OqJrdhvDKA4LIoPWPnQ6V1pqt4/yWbDwyF/55peLp/I3F4ZQfoLvW2T/0m
         GniLcNWt3sXnmsRiPKvGSLTi+/8XPQ1lUinLHaZN9hdkro1XMLuy0PiIuaohxN5pTh4b
         fy5R2HazWOvdzL/1JKqaancmzBHTFgZPfCCOw9sX1Qecbzt+0hiDYt1QTUS+EW0FpHbH
         2LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=iyH2jqHbAo/0kInMN+91cUOZsd7GtvO7MpjGcoLxzcQ=;
        b=kJg2o2uApd1rESBZE4xNA9nEViDVUUtru4IIusApy1aCtTf+PVfSnP11xV32HO/gM4
         /9BQIAmT8sJ6GlPS3sZmPEq81FXVKdFdLvHeb6l9cUu0qEiOefHHITHPcbYsrGfe3dif
         2zXHNK1j/2/gGipoCYPmlRGjTkLmNs5ZW7cuajGkv4+Na9ef5Q+s4tjppq7+Ww4ZAzXF
         pUq1rZvrjMusbUxRiSwz29CcgN6FK/9jkpr8LMXApJeVqQudokIWobVupkPBLj/KP55n
         VnIfFasTZRJXYVHJz+UaFvxiRFMT6KQtCtL5OI604CiARczpaGhOHSIUtyXkAHyJU1Mp
         hprg==
X-Gm-Message-State: APjAAAVgBCx00IOGbMkF5aAHCxCmyE7NBtcdj1veThAjN4GAZnfmhQfo
        CRXaGebBXthPlHrqFHnFqKsDIQ==
X-Google-Smtp-Source: APXvYqzvh/BwD/FCXxRstZkYxuPxJRsn1X34mzkJqjqNDdDEH4xuBtyitii6wlNRp9d5iBc52ybxaw==
X-Received: by 2002:adf:f2cf:: with SMTP id d15mr22502789wrp.397.1583158960279;
        Mon, 02 Mar 2020 06:22:40 -0800 (PST)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id z14sm28491203wru.31.2020.03.02.06.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 06:22:39 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@mlowasrzechonek2133>
Date:   Mon, 2 Mar 2020 15:22:39 +0100
To:     Anupam Roy <anupam.r@samsung.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Semun Lee <semun.lee@samsung.com>,
        Dohyun Pyun <dh79.pyun@samsung.com>,
        Nitin Jhanwar <nitin.j@samsung.com>
Subject: Re: Regarding OOB authentication method & action for Mesh provisioner
Message-ID: <20200302142239.re57glm4ixjot7d3@mlowasrzechonek2133>
Mail-Followup-To: Anupam Roy <anupam.r@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Semun Lee <semun.lee@samsung.com>,
        Dohyun Pyun <dh79.pyun@samsung.com>,
        Nitin Jhanwar <nitin.j@samsung.com>
References: <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p3>
 <20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p3>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 03/02, Anupam Roy wrote:
> Also, I would like to know, whether there is any plan to Request
> external provisioning Agent to choose Provisioning method & specific
> action?  The reason being, some *application* may be interested in a
> particular Security level & Authentication action, depending on its
> own I/O capabilities.

For the record, we also need this is functionality. One of the possible
scenarios is having a provisioner who doesn't have a reliable Internet
connection and might want to fall back to (less secure) OOB actions if
it cannot obtain OOB public key.

We've been planning to send a patch implementing a D-Bus API for that,
but it's not ready yet :(

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
