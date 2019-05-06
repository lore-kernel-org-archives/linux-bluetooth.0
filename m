Return-Path: <SRS0=wqlf=TG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A543C04A6B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 11:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D9D20675
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 11:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="APNOegRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfEFLni (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 May 2019 07:43:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44005 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFLni (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 May 2019 07:43:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id u27so8622624lfg.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2019 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GnCjhx630Rv39KfTF0Y/cgXKJyZUz6GILTKEfuqhsTM=;
        b=APNOegRrb9S7R0GEvMx2oLnSC5KiXLu8MBnex3WA4RW1XUk2aZq+ZmSUNzTzgOsuz5
         ujeE3DKx/kt4Kp2VOgSfjzOyyyDfJPhLLYVGKumoKjA3mAjEapPVlCaYerhg8mETktZH
         68CJxjYpFDOCcYDT6+YwTofH6hEgQX1YSBnm0cGgUy6UM1pwzJoEPUr90nJxGCOgazX7
         7lexPuRqE/Ir9LTOzDeX6nyzbsmyEVtFzKFGBjnquP7rW5pZC3DMVUoNmsJO7/csIcJh
         VcRj6jJE1r72BOOoqIDfpxa35GTi+z5Nc3+6xhUletA86dzr1JhM7lTKqf23hMKwKPlS
         3qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=GnCjhx630Rv39KfTF0Y/cgXKJyZUz6GILTKEfuqhsTM=;
        b=LQ/19AudYhruYViXYIj+70Z9j6SvSMQbNXeX0NoCJz7OVNx4MXtu0zSbBpn6ajlvnw
         3Kl8BAlyiWYi1fvVM2jQFoao2G6TnTUf5j564SGFbTj5ghuEFj81j8Okc8CeTtOyuHPC
         7Pwy6eJDK4jKBvheNitWfuiiHRDgPNSmH7msY3zhMwLoMZbKmwh4N3Zu1SPLnGKuxgq+
         zFiJlIcgQi38KHDlMVjEMV2JclCRSlxek6Ivoez4uDLdkw2FE2JG4KaYXH37YM3PaLwA
         FDxBUgJ1WSrUbC6y7PgEMrq1Yc+dDTfrL2QbKICkHwi2DoZh8SIWBbv70OSfJ8VxYzmR
         gCBg==
X-Gm-Message-State: APjAAAUoZtPxPuFCFQwoBoih49l24IX5UzTyjDqhwJHhHrj4tLdCgxjC
        jOtgcedkBrmzwZ72yExZs61WIQ==
X-Google-Smtp-Source: APXvYqzpPeR1nbVXmJll7TRukTbr0PEudI5yZn/bUd0ewxO9J6IJSoxYIb6N5BiOdl5xcsRkyVEsNw==
X-Received: by 2002:ac2:4571:: with SMTP id k17mr3589399lfm.133.1557143016615;
        Mon, 06 May 2019 04:43:36 -0700 (PDT)
Received: from scytale ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id t8sm2236761ljc.25.2019.05.06.04.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 04:43:35 -0700 (PDT)
Date:   Mon, 6 May 2019 13:43:33 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH] mesh: Use node uuids as storage directory names
Message-ID: <20190506114333.opaumtub4vgzdycw@scytale>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
References: <20190502130630.13890-1-michal.lowas-rzechonek@silvair.com>
 <a716514ec5be59e7e177c9a256238e314b4599d9.camel@intel.com>
 <20190502203526.mfglyyzsoudp6mtw@kynes>
 <89be788e4efdd963e39370b0311d8f2a53c2e13c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89be788e4efdd963e39370b0311d8f2a53c2e13c.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 05/02, Stotland, Inga wrote:
> So, Join() method will have to check if a directory name with the
> supplied UUID value already exists and, if so, fail with
> "AlreadyExists" error.  The mesh-api.txt doc should be updated
> accordingly.
> 
> Also, if the directory name contains the uuid value, then we probably
> don't need the duplicate value in the JSON file since it can be
> derived from the directory name.
Thanks for the review. I'll send an updated patch shortly.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
