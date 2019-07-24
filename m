Return-Path: <SRS0=wkNI=VV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD106C76186
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jul 2019 19:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC181218F0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jul 2019 19:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="zjNJzw6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfGXTMr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:12:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37114 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfGXTMq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Jul 2019 15:12:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id c9so32670767lfh.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2019 12:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5YwAIA0kuKzNKxzpxQq64RzoBMp/ErDL78MenJ/PqHw=;
        b=zjNJzw6K4pNYGlMlKjfinpwXeAn4Ei23SVx4myStGMH14ivsrbn68sWvmw8vGazLh9
         zeIjc8topHlGnpwA+aDjcA9h5JznuqF6oxlGePtYAnvUSMqWMotV0oBZ4YaSzVxc6wSO
         RUWThM9NMipcp7yV9yEyEUcVvO5/QdamHgvsKr19FViio4zmTPnrlJkLCylpyqIUrBwR
         P3v+qpCv1y1wOiSXL+yLLzc2GT9RrLiNcVuCCNCAI3ZxcywRIfnFRyVsCd12rPH2ZzPi
         cgK2uHeiCmmx07rt3ztNAi3xZf7VaZ/dTa/vdkCKABkP+clM6ayqRrC1anpYBVTHq6dE
         FA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5YwAIA0kuKzNKxzpxQq64RzoBMp/ErDL78MenJ/PqHw=;
        b=mSAs2rQZ64jNIax2r30dElaucAhhfo2HRdRviURoNcmnN3vx0TipRymsXQAWXs/tpr
         Sgugk5t/b3xDjzV9haYWs+4ZTLxSmWAoMoLvSxrJLky88akhVyc98Xmk5cOi9Qs9zpRm
         W8XGf23JZmFInNd5JzxqtHUJq4AwxMUJ8OGyaw6viYx45JSBlDmwD+wc7lqN0HEsDJwf
         bTGko7O+LPaSqMLXHCBmeWCf08R9L0QK7Ta5Z05DwqJmu+tF9CrGWC0rXWKWcptj2QgN
         6prp9sLy2CCi1pE+2EYUMnu7gCbz1wQLwgRjWo5+vbT0Tsyfn+eduSXch8hN/ShbT0Xr
         veYQ==
X-Gm-Message-State: APjAAAW4Eo6YSCH6UVMkiOkk2M0FfSSdfvwKpWUl/ehQGI/x9hFOT53W
        dsrgJtk1YCdNuhhMTnE5BQkyDA==
X-Google-Smtp-Source: APXvYqw9m2gQnhGc4RUVofKdIni1qSjy3pCV9pZdi3/vWDTnBMEnp11QiBj17p4ebnKshdjpCJ4D0g==
X-Received: by 2002:a19:7616:: with SMTP id c22mr39988182lff.115.1563995564847;
        Wed, 24 Jul 2019 12:12:44 -0700 (PDT)
Received: from kynes (apn-95-40-32-72.dynamic.gprs.plus.pl. [95.40.32.72])
        by smtp.gmail.com with ESMTPSA id m17sm8735037lji.16.2019.07.24.12.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 12:12:43 -0700 (PDT)
Date:   Wed, 24 Jul 2019 21:12:41 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v2 2/5] mesh: Validate application by comparing
 composition data
Message-ID: <20190724191241.ad4vri23hs2zqyce@kynes>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190723100623.6957-1-michal.lowas-rzechonek@silvair.com>
 <20190723100623.6957-3-michal.lowas-rzechonek@silvair.com>
 <164c441cf7b43a1be420444676417f77f88a86c4.camel@intel.com>
 <20190724075511.elmqslt5kb3u3p2m@mlowasrzechonek2133>
 <d880777698581163febad448e8b71c69ab4c0580.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d880777698581163febad448e8b71c69ab4c0580.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 07/24, Stotland, Inga wrote:
> > > So here, prior to removing the temorary node, the element paths
> > > need to be copied into the "req->attach" version of the node.
> > > Same goes for node->agent and node->provisioner.	
> > 
> > True, thanks! I'll fix this in v3.
> 
> Also, could you please add some comment there, like "Deleting the
> temporary node" just to make the point that tit was temporary? I am
> afraid that for an outside person this will not be clear why the node
> is being removed.

Sure thing.

> > > "Location" property is described as optional in mesh-api.txt. It's
> > > populated with "Default Location", if the property is not present.
(...)
> Let's try to keep it as optional then.

Will do.

> This will require some *fuzzy* matching of the composition data,
> something like:
> add a boolean flag to generate_node_composition() that indicates
> whether the composition is generated for the verification or as a
> result of an external request, i.e. for the config server model. Based
> on the flag, either include location field, or not.

I don't think I follow. If the application doesn't provide the
"Location" property, everything behaves as if it provided it with value
"0", no?

Location descriptor is *not* optional in Composition Data (Table 4.4 in
section 4.2.1.1).


-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
