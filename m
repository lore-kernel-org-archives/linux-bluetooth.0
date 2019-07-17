Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2ADC76186
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 08:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C962173E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 08:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ZBp3Qi+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfGQIs7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:48:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44399 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfGQIs6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 04:48:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so10937354lfm.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 01:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9C1OaM2ubRaQdUHNUot0RdCNrlYgzHu9Ql1cSkC90QA=;
        b=ZBp3Qi+odak/Fn22oRZidt6KYL848U7T0vu/yCaIfLFjNBd3YlzqrbEkHZ1HBBBC2F
         4VOOZTVcuikh4Uumun7TlVuWB/GoSBj+tCqll+3oXUQyBKlShlYqk+8xj1BerOeyERlu
         kyQgBEZNnevU/L6qi+oFV8zrGwMHJC4NWjaNNafasDlImHMeC+YgxGKsJJ4Ml0pqtEnN
         W4kO1qYr9JyxZXNOMWbwaQQFn7rrTYr2f+1QCumt+RdYKLi+CewfwO2ugRFjgGKAvxNW
         Ptjuo8s8XrBwNe1/t8RqlI0iutZZq2j3vkOC5IcZ3DschOqQHyLL5iJGMRLqwStrvPxZ
         VzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9C1OaM2ubRaQdUHNUot0RdCNrlYgzHu9Ql1cSkC90QA=;
        b=W4GmIYuennlGLJI3GXdiAk6xRgVyZ4QBWTLZ2o2h6NP3xoQe17UsTztOGv334rM6DI
         vD0y+T6GJQKb/EsFRqfvdQ4kmKiuWnWC1Tcw45Z6VPaqtrWhe149tzuiOAgO+eOWIlsg
         1Y17n6nwcuuanH3N5aN6g/q/pNE6IzzLkfZ6lzaSJURTJ8H1xH9SaWBS9cxIc2CY50Pb
         QUEdkWOQ7EwyiZvVodpoArrPSGkAQc8R1srF0B0MHLgsT9pPTvn+v5ZiUB/7lOtpq227
         kAf2Mz5sM46Uw+j003Su4FX8te63Ip3wgewV6Sqg70vY7YdJMmhUnxWiH6gQV1Do3MPB
         tbng==
X-Gm-Message-State: APjAAAVZBm196May11ua3tEP47P134UXaiI2k0NxtfF4+nBQJni+8bZn
        Eon0AiV7mXg6nMGaEgkbYahDtQ==
X-Google-Smtp-Source: APXvYqxTWtWGtNcvOZ5MkzKHsL1/OKhIkfeqCuZg7pyIvRHj6HGTwCn+oezriLXEHqb7YhQMoH/bcw==
X-Received: by 2002:a19:f007:: with SMTP id p7mr17176998lfc.24.1563353337132;
        Wed, 17 Jul 2019 01:48:57 -0700 (PDT)
Received: from mlowasrzechonek2133 ([31.0.84.191])
        by smtp.gmail.com with ESMTPSA id k27sm3638813lfm.90.2019.07.17.01.48.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 01:48:56 -0700 (PDT)
Date:   Wed, 17 Jul 2019 10:48:53 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ 3/3] mesh: Propagate Net Index up Rx message chain
Message-ID: <20190717084853.copy2f3dc7oaglf4@mlowasrzechonek2133>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20190716225644.11449-1-brian.gix@intel.com>
 <20190716225644.11449-4-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190716225644.11449-4-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 07/16, Brian Gix wrote:
> When a model receives a message, it is required by the spec
> to respond using the same credentials. When an App Key is used,
> this is trivial because App keys are bound to Net keys, so only
> the App Index is required.  Messages received on a Device key
> however, need the Net Index preserved from original message for
> re-use during the response.
> ---
>  mesh/cfgmod-server.c | 154 ++++++++++++++++++++++++++++-----------------------
>  mesh/model.c         | 129 +++++++++++++++++++++---------------------
>  mesh/model.h         |  10 ++--
>  mesh/net.c           |  92 +++++++++++++++++-------------
>  mesh/net.h           |   6 +-
>  mesh/node.c          |  10 ++--
>  6 files changed, 214 insertions(+), 187 deletions(-)
> 
(...)
> diff --git a/mesh/net.c b/mesh/net.c
> index a5693f154..ba52867c4 100644
> --- a/mesh/net.c
> +++ b/mesh/net.c
> @@ -119,7 +119,6 @@ struct mesh_net {
>  	unsigned int pkt_id;
>  	unsigned int bea_id;
>  	unsigned int beacon_id;
> -	unsigned int key_id_next;
>  	unsigned int sar_id_next;
>  
>  	bool friend_enable;
> @@ -203,7 +202,7 @@ struct mesh_sar {
>  	bool frnd_cred;
>  	uint8_t ttl;
>  	uint8_t last_seg;
> -	uint8_t key_id;
> +	uint8_t key_aid;
>  	uint8_t buf[4]; /* Large enough for ACK-Flags and MIC */
>  };
>  
> @@ -225,7 +224,7 @@ struct msg_rx {
>  	union {
>  		struct {
>  			uint16_t app_idx;
> -			uint8_t key_id;
> +			uint8_t key_aid;
>  		} m;
>  		struct {
>  			uint16_t seq0;
> @@ -668,7 +667,6 @@ struct mesh_net *mesh_net_new(struct mesh_node *node)
>  	net->node = node;
>  	net->pkt_id = 0;
>  	net->bea_id = 0;
> -	net->key_id_next = 0;
>  
>  	net->beacon_enable = true;
>  	net->proxy_enable = false;
> @@ -676,7 +674,7 @@ struct mesh_net *mesh_net_new(struct mesh_node *node)
>  
>  	net->seq_num = 0x000000;
>  	net->src_addr = 0x0000;
> -	net->default_ttl = 0x00;
> +	net->default_ttl = 0x7f;
(...)
> @@ -3408,18 +3421,17 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
>  	if (!src || !dst)
>  		return false;
>  
> -	if (ttl == 0xff)
> +	if (ttl == DEFAULT_TTL)
>  		ttl = net->default_ttl;
(...)

I would keep these in a separate patch, it's not really related to key
ids/indexes.

Otherwise, LGTM!

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
