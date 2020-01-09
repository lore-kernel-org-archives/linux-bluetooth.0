Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2237CC282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E912075D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="S0/DNfHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgAIVX1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:23:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39675 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIVX1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 16:23:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id l2so8789951lja.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jan 2020 13:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ensXTgk6MfNfAgdu/P0DwJYw5+4kLAxUQGVLoTwPuTw=;
        b=S0/DNfHW7VbRV5mGnn9DVnN2Mt46dddZaWhK4vGDFnQ8UI0YHZNwVLYKr55Ccwf8kB
         R/GwBDgtSXjydts3F7uVW2uTAcNSPgU/D1qJr7LNG9Y6nhE5aW25DXGcYYx06Ztu8byA
         D0UOL6f9aSf2aIG0765Va6V0CIFVBwBIDdEggVQszk9MdpNJ6SfH5Gcpxcx1dF0zTHvk
         zq4zvVQewBQv3TushF9FMeRaHZzuNcKrGVY0o45lHWvtGmSz+55eZJbR2y1xB3DwhH19
         5MsRf+wP4RlaPA03iWBb7PmbeQ2IyqQLFqKy/re6PppIN/UZtn+aPALcJgeRqgheR9yx
         MQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ensXTgk6MfNfAgdu/P0DwJYw5+4kLAxUQGVLoTwPuTw=;
        b=sWMOyfksqHjDlhUX0LQUEBXc7JOqERq2ss0Z+eGPeqA5iufFZ3dAONKXjzbInakYQg
         xI5ODEJDAQom5h9VXwFAcchviGhJnFCcgloU4QA/CyVkDSBsSviUBcrVEnWfey8nrQyk
         Zt0XTjdUnSFtr74jA5JSCzD6lYvZnVE4/OWpcDxvYh57NJl7BqcEKWcawaBtB3h74Q++
         sObypj3wZoDPaNcsZQtQiqBwDrAAy3Mt4xu0W0ji0mU0kljO8WS7QgVKy9K6q2ZY03NY
         yGd6cxgtlZCLB41HURpQv/A2UAJssYu+vbwZvQ0eDBL6hFHR99I+XDhV++zmtyM2/A6I
         Hseg==
X-Gm-Message-State: APjAAAWGcrisuJI29ISVlkrnduzjK+oexIKSxhBFs01DBuDebx2VA8xP
        taH6YXe8mRq8UqXrsC4uQGOPlkpQYvI=
X-Google-Smtp-Source: APXvYqwTjouR+DWTvY+GNeWrlPd0lEhfvWSmBlA/MdTHje/QEFev/XDV0Rsc0LLQBznp4HRfaWQVlA==
X-Received: by 2002:a2e:9e19:: with SMTP id e25mr38315ljk.179.1578605005369;
        Thu, 09 Jan 2020 13:23:25 -0800 (PST)
Received: from kynes (apn-37-7-124-67.dynamic.gprs.plus.pl. [37.7.124.67])
        by smtp.gmail.com with ESMTPSA id g15sm3605778ljl.10.2020.01.09.13.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:23:24 -0800 (PST)
Date:   Thu, 9 Jan 2020 22:23:23 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Correctly generate NetKey list
Message-ID: <20200109212323.vq5pvnp5snelbumo@kynes>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200109175715.22925-1-inga.stotland@intel.com>
 <20200109210837.yraajvc76g4xv5oh@kynes>
 <d831f4046203d691b65bf145909cdc184bc788e9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d831f4046203d691b65bf145909cdc184bc788e9.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Inga,

On 01/09, Stotland, Inga wrote:
>> Another thing: doesn't this duplicate the same logic implemented in
>> appkey.c function appkey_list?
> 
> No, it's a different list organization. So I cannot re-use the code.

I understand that the list we iterate over is different, but in the end
the index list serialization format is exactly the same.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
