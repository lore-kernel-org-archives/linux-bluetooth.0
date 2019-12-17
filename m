Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85394C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 20:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD8C20716
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 20:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ZRSmX1FB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfLQUGZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:06:25 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:38372 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLQUGZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 15:06:25 -0500
Received: by mail-lj1-f174.google.com with SMTP id k8so1011071ljh.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2019 12:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rl5QIFYLHhkYwExWVgXukQLpchHbGysQNlU2zAHyGbo=;
        b=ZRSmX1FBatFZf5vpwiu/3qVFHCpXgK8wkAI2T5zeFWk3QIQnFLXTpzlQPfn3k5FW9L
         klthvNtwYamH/0MCfUMIN1/7I5vxdPBo+cMVJm6H+enyrMA8I0rpyYmL6qDgroz/CBxv
         a8Dw6+e51o2UT5EJgReNkLFyogPsOu5usHn9xyKJMB7aU47dFS0iFNVCsAGryciIB2+E
         yzl3hiYmA/iD9sQ5VWFzAeeNo/LDOeFtxu5exD09LDy335ro2f7ClqszhSMNvP7VtceY
         20XJJMYzoiJfZbUGE33BXN59+SzZPRHcBmVH2nfT3MtAIFq7wY/yF9CqNSNGHmq5FKP/
         Y5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rl5QIFYLHhkYwExWVgXukQLpchHbGysQNlU2zAHyGbo=;
        b=H5NSdyra549fiRHZb3zZ/MQeD9gaLMDMtPaZ7sk62Sq9uRmfHB2kHnuN/IoJg85MTz
         4VeojPlOdhO3YMfa47OoSPXPHoGPEJbMgsa5zUNbf/euxBZVi83PZ31et9CISgRZTiy8
         h+lG5Y9Mam7+HUTCETqds3AV34vLJettcKceLoq67jUIT4RD7bH3HA6fCBvRM0EsVsvp
         QlbtoRRjnxtrHazYpgcdeocGXH1GDSPCoKRIggZYdkVvg8pFGtullyc8pDUZ9Ybi/6a0
         joyW8q1n3Bc0zUOenhLIvnKYYpjW0ws7kXB6tCGFWNj4aN86HB7t4J1MXpczNwy84riA
         F7Xg==
X-Gm-Message-State: APjAAAW12cv8md/QbFEedtTBRkuLssQvKG8xeKwVqJsPmp0MPd9TiPe8
        HRb1sMiuV5F8/aelRycLIAIcFATLTTZ64w==
X-Google-Smtp-Source: APXvYqyM9uu/nF5Kwtc7WEE/xlaI0a4+yvUOVgzMlXu3idtLz3+D5/IN5WZAN6KXv50eSd2Wy+7E9Q==
X-Received: by 2002:a2e:8152:: with SMTP id t18mr4509423ljg.255.1576613183381;
        Tue, 17 Dec 2019 12:06:23 -0800 (PST)
Received: from kynes (apn-46-215-206-57.dynamic.gprs.plus.pl. [46.215.206.57])
        by smtp.gmail.com with ESMTPSA id p12sm11260419lfc.43.2019.12.17.12.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 12:06:22 -0800 (PST)
Date:   Tue, 17 Dec 2019 21:06:20 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: mesh: Handling application failures on Create/Join/Import
Message-ID: <20191217200620.qnbhjevotlxfrwu3@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20191217184330.coc6c7b7hw4to6vx@kynes>
 <20191217184728.qoapokv7acfyaz33@kynes>
 <a51a523c15b52b9e5d837b7b9a1110a669db4e2b.camel@intel.com>
 <d61fcfad45256fe70b0f8cfaba30e031f57d3ce9.camel@intel.com>
 <20191217191138.ib7socqz4h4i4e5j@kynes>
 <450359d19e8b296f53b5dc03b649d7ce78d9d99a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <450359d19e8b296f53b5dc03b649d7ce78d9d99a.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 12/17, Gix, Brian wrote:
> > Indeed. Would you be willing to accept a patch that changes token
> > delivery to use JoinComplete call in all cases, and checks that the call
> > returns successfully?
> 
> Maybe...  I need to discuss it with Inga.  How does this relate to
> Create() though?  There is no JoinComplete() call currently axs a
> result of Create()...  just the return value from the Create() method.
> Is your problem that the daemon cannot be sure that the return value
> (token) from Create() was received?

Yes, exactly.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
