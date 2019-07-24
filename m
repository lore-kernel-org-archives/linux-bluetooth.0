Return-Path: <SRS0=wkNI=VV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1F8C7618B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jul 2019 07:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBBC2070D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jul 2019 07:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="fB/DLvzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfGXHzP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:55:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38469 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfGXHzP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Jul 2019 03:55:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id h28so31245400lfj.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2019 00:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3svE+oi52k++Bjz/kjn5Y+L+VU2i5JJBVxB/KVGPT9M=;
        b=fB/DLvzD61U1BOcmdz0Te2E1orYTen7tB796O9CFpe5DRvzvs7ndIDdn9CResdQd7K
         QWdhLVg8IbKPtHAfXWUdAt5v9yi0EXmp16+SkO983qX2CG9OKPUBtKzxyuJigMJ9LOh0
         rmu9VY0AvcpTk8zkgI/vEA135r7zPKStMEodzAQND8ClzlbL/BbztHByD653Jd5G9ZzH
         hKZZOrZRmlOU3nxVXENwWNSQk8UmliD4sbtafx+0NbLewnF3JA0uxhE0tGdOnsLniYQ2
         ZEptAKP5Vm/E0LiShBf0DnQAQ08ivr9e6qcPPLXZXHU5f5xh0VftZiu6R33NN+RGwOhq
         uezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3svE+oi52k++Bjz/kjn5Y+L+VU2i5JJBVxB/KVGPT9M=;
        b=F8pwo0jnfKSltHUvQHTC860w3KYwE8OaPgcjII6hF2m6OXgy+fu3FOzwQ1S1edb2J0
         Jh5wifwSbFJAY/atr3ZTRu+kPEMqS6Lqgfz/0Ira0sTSY9jF0OtKPZI4Ll79/f4AwEAI
         CQ6e4hOstwzigCvZ5mXKtQql/Kj3vVNFBWIA0VuQtVtB9s8RiN8sCVLXiHAIp6kxNVi8
         6b3ifrHEbka9BE776XO5uZNV+QsH+WReecrTE63WGm5Jwp6Hyc11HUtaE/H65srlC6ZB
         +tNOHCAB82wvL7LaWF6kt1FgEvzjpXa75na5iUJWa6zwbGDaFZSAPdZhZL4mk9OaQtDq
         eF1Q==
X-Gm-Message-State: APjAAAUWByXchv7sz5C22SVZCaSOSZYKYD3Y+Kf471ov/rXN8yIJ5f9I
        /yln/asx/9JWHvPOZmA5NG5raQ==
X-Google-Smtp-Source: APXvYqwoxKEUvQpLqYyJzGEoph1iRmWVIof5O+ipd7qwGw7fytB9UPPzsQjxdWp6l/7QyOwGRn0x6g==
X-Received: by 2002:a19:ec15:: with SMTP id b21mr12517186lfa.32.1563954913116;
        Wed, 24 Jul 2019 00:55:13 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id j77sm8446845ljb.55.2019.07.24.00.55.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 00:55:12 -0700 (PDT)
Date:   Wed, 24 Jul 2019 09:55:11 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v2 2/5] mesh: Validate application by comparing
 composition data
Message-ID: <20190724075511.elmqslt5kb3u3p2m@mlowasrzechonek2133>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190723100623.6957-1-michal.lowas-rzechonek@silvair.com>
 <20190723100623.6957-3-michal.lowas-rzechonek@silvair.com>
 <164c441cf7b43a1be420444676417f77f88a86c4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <164c441cf7b43a1be420444676417f77f88a86c4.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Inga,

On 07/24, Stotland, Inga wrote:
> > -		ele->path = l_strdup(path);
> 
> The path needs to be preserved if this is the Attach() request.
> One way to do this would be to save it here, in the temporary node and
> then after all the checks are done, move it to the node that is "owned"
> by the daemon prior to deleting the temporary node in
> get_managed_objects_cb()
(...)
> 
> So here, prior to removing the temorary node, the element paths need to
> be copied into the "req->attach" version of the node.
> Same goes for node->agent and node->provisioner.	

True, thanks! I'll fix this in v3.

> "Location" property is described as optional in mesh-api.txt. It's
> populated with "Default Location", if the property is not present.
> I believe, it was more out of the convenience for the app develpers,
> but maybe we should change the property description as mandatory, i.e.,
> remove "optional" from the property descrition in mesh-api.txt

I'm inclined to make this property mandatory, but I don't have a strong
opinion about it. So just tell me how should it be and I'll adjust v3
accordingly.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
