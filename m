Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6BCC73C7C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 07:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7B720651
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 07:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="wrNc50jL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfGJHic (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:38:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39612 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfGJHic (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 03:38:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so1047362ljh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2019 00:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CZDxR4xgfgD0Xnp8CDS9w0flO3T8ocjdBsGpxn2o0ms=;
        b=wrNc50jLxfAg1bK3CpFw7ewu8Ck51Rh8A+4hiVjGNcktaL+LX4NlnZUZHwAYOWgHg9
         UbDRgZNxsKR75x7KjPXG9xoXr3Mezo/mQejHikOXVMoHkkxKDctU7O+fbVtpkCCnJpZy
         QNZjh1g8cp/GrC10e2+gfhj3O9e8ZwuMlQc2PUapPVuUd4c8QWLgor72xIPeiqxnuOBX
         WSe3v3vtb8UvEHQR5J3Ryn6J002BUPrsst5fdedJgRNCgkCgt6DEjdWzrKqW/t+CGepF
         Whc3UCsq6DiE7hcGpAepgHIQQWRwkQV4+/O9ImtzSWaCBHJxr48e7CnXky6qytfEk6Q8
         LlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CZDxR4xgfgD0Xnp8CDS9w0flO3T8ocjdBsGpxn2o0ms=;
        b=MJXmlNJ0ldZc2pG/WE+AkPXLikImNxaWlMVaS4RLxnTpHI/kC4g+8FQgX4oToJGAjm
         wZeDdZiaNdFrQECHH+6uyClpx2uHwRQsuy/fMfrMiftMm3ClnOj4U6r+qzkyr5yLQX1T
         qNcefgLOaabyncu9ZfslDVW0HsKwLLY4GDVmAEERjtrn7daTmfRgyN4BQZt6LfqaemJl
         53IF7bbGwrGWaK5wIAqNmIZdArOCN+24U89QFz/QwYbz2jNnU9OCiLAajjsyzVD5qZfD
         n4VhvkSgmxMua4/DjnFKWpGlHRnjdXAqLKMo7Usfdd+07e2hiUsaoxOUk+u7I59XWDYl
         pCpA==
X-Gm-Message-State: APjAAAVNHEErat7tQOXmQ6CNAu2+tEvsnkY6yO038Ck8ytbkj/KKJQH1
        BEOQgcz1zqLtBkyUtAtkqV3yoQ==
X-Google-Smtp-Source: APXvYqyC8o5o+WFJpGgw/IVEkvxOcIE8AGkTD7DCkZcaHFU/8uBC+Lj0kh9K+wdqLkgluEDMK+OxOA==
X-Received: by 2002:a2e:995a:: with SMTP id r26mr16476166ljj.107.1562744310199;
        Wed, 10 Jul 2019 00:38:30 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id n124sm228454lfd.46.2019.07.10.00.38.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 00:38:29 -0700 (PDT)
Date:   Wed, 10 Jul 2019 09:38:27 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        jakub.witowski@silvair.com
Subject: Re: [PATCH BlueZ 4/9] mesh: Generalize mesh-config APIs
Message-ID: <20190710073827.5ktzlyynztmebiv6@mlowasrzechonek2133>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        jakub.witowski@silvair.com
References: <20190710050959.7321-1-inga.stotland@intel.com>
 <20190710050959.7321-5-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190710050959.7321-5-inga.stotland@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 07/09, Inga Stotland wrote:
> This changes argument for each mesh-config API to use void* as
> a pointer to a node configuration object. This makes usage of JSON
> opaque for the rest of the code and allows to plug in a non-JSON
> configuration storage implementation.
> ---
>  mesh/mesh-config-json.c | 228 +++++++++++++++++++++++-----------------
>  mesh/mesh-config.h      | 107 +++++++++----------
>  2 files changed, 180 insertions(+), 155 deletions(-)
> 
> diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
> index 8fcb8afe3..5ca086ad0 100644
> --- a/mesh/mesh-config-json.c
> +++ b/mesh/mesh-config-json.c
> @@ -252,10 +252,14 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
>  	return jarray_new;
>  }
>  
> -bool mesh_config_read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
> +bool mesh_config_read_iv_index(void *cfg, uint32_t *idx, bool *update)

I'm not a fan of using void* for polymorphism. While there are places
this makes sense (e.g. user_data pointers in callbacks), I think we
should try to avoid this in our APIs.

Since the proposed patch assumes that we would switch backends during
the build, and you can't have two different config formats compiled in
at the same time, how about this:

mesh-config.h:
    union mesh_config;

    union mesh_config *mesh_config_create_config(void);
    void mesh_config_release_config(union mesh_config *config);

mesh-config-json.c:
    union mesh_config {
        json_object *json
    };

    union mesh_config *mesh_config_create_config(void)
    {
        return (union mesh_config*)json_object_new_object();
    }

    void mesh_config_release_config(union mesh_config *cfg)
    {
        json_object *jnode = (json_object *)cfg;

        if (!cfg)
            return;

        json_object_put(jnode);
    }

etc.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
