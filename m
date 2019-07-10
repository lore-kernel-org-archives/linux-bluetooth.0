Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADA6C73C7C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 08:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCF920651
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 08:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="HRRkRTJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfGJI3w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:29:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42684 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfGJI3v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 04:29:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id s19so964280lfb.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2019 01:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fYB1rhP9twGtZy8aIGANkO2jvok8GoG9Tiq0ViOTJrk=;
        b=HRRkRTJ53K9LPUY2Vq5407nn7EFinD9E2NNLx5F31KliCEFW9E2nYubJ1PMCfWiDXq
         qKnJlV8PuxIcjF+Gh+5k+uhpg4IHUEgkynXe7JQHOa6tOggaA6TZ3zdGVHnKdmNYxy/l
         SYIwFejrm7fBMvS2rnpE2RmOHG4s5G8M6HiEWIV5+4tdX5jRxEIYzV+X6rycrrdOWU2k
         ROHMNrioYegXb6LIjA8tQVgMd1hQhuSS6r5O/0AV73RA9YTYrmksOYA5CFV/i0gcFQrI
         kE24hYqUxSB/uqcolGfaGMfeew3uDNl5oxkVNm8iiRfaW4BywJk5yIo+c0HHaVuNyWuP
         vUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fYB1rhP9twGtZy8aIGANkO2jvok8GoG9Tiq0ViOTJrk=;
        b=b2Zet4A25g4VUNnJgmQEoZK7zQQnvg/c6/dlUDHS7597qz1GWji/dIxQ3/mplHdCL3
         3NcmSyN72Uw/mj054ytYOL1wsmfv+jj9/c86WM9l11CaqCc+WdSJYYio+hAFqrvbDVdH
         3RytCz1iWjIUfaTE1GMXXYGjVd2H14Mqcd2K/klhlemS+WD/6fDYNc4ZfUt+NVQVPURP
         RL+coPxPoC7I7scwxR5Yeru80tB+6+S0Foa6+X/Yck/0d+nvU75d9Z4iWbsJE2vhiqIA
         2PNU6otvUz1al8KjsoxVALqoJIWyDZ/AfR/NvA4icMHCo0Rgic39SuuajrWM3eUTfAL7
         E7mw==
X-Gm-Message-State: APjAAAVzkBCLCnpqJgLdq62SbDc/2zQ2ip/lb1qLpMTyRCl2Ezxr61Qj
        AKv5HdPue1XtKCpydY6JS59h4w==
X-Google-Smtp-Source: APXvYqx5MyUkQDB8FEYnu5hdV+7eUw9epdhwRaKrOm0nYFbnPXmy92uhH9AEVx8jW04tnPrfOinTYw==
X-Received: by 2002:ac2:46ce:: with SMTP id p14mr14804177lfo.148.1562747388995;
        Wed, 10 Jul 2019 01:29:48 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id a9sm243767lfj.79.2019.07.10.01.29.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 01:29:48 -0700 (PDT)
Date:   Wed, 10 Jul 2019 10:29:45 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        jakub.witowski@silvair.com
Subject: Re: [PATCH BlueZ 5/9] mesh: Change variable prefix "jconfig" to
 "config"
Message-ID: <20190710082945.t6jec7stdjkcylbk@mlowasrzechonek2133>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        jakub.witowski@silvair.com
References: <20190710050959.7321-1-inga.stotland@intel.com>
 <20190710050959.7321-6-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190710050959.7321-6-inga.stotland@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Inga,

On 07/09, Inga Stotland wrote:
> This adjust variable naming by changing "jconfig" prefix to more generic
> "config. This also removes #include json-c/json.h for model.c,
> cfg-server.c and node.c as they no longer rely on the specifics of node
> configuration storage implementation.
> ---
>  mesh/cfgmod-server.c | 16 +++++++---------
>  mesh/model.c         |  1 -
>  mesh/node.c          | 25 ++++++++++++-------------
>  mesh/node.h          |  4 ++--
>  mesh/storage.c       | 34 +++++++++++++++++-----------------
>  5 files changed, 38 insertions(+), 42 deletions(-)
> 
> diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
> index 0479a9185..1aa7c85da 100644
> --- a/mesh/cfgmod-server.c
> +++ b/mesh/cfgmod-server.c
> @@ -24,8 +24,6 @@
>  #include <sys/time.h>
>  #include <ell/ell.h>
>  
> -#include "json-c/json.h"
> -
>  #include "mesh/mesh-defs.h"
>  #include "mesh/node.h"
>  #include "mesh/net.h"
> @@ -197,7 +195,7 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
>  
>  		/* Remove model publication from config file */
>  		if (status == MESH_STATUS_SUCCESS)
> -			mesh_config_model_pub_del(node_jconfig_get(node),
> +			mesh_config_model_pub_del(node_config_get(node),
>  				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
>  									vendor);
>  		goto done;
> @@ -219,7 +217,7 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
>  			memcpy(db_pub.virt_addr, pub_addr, 16);
>  
>  		/* Save model publication to config file */
> -		if (!mesh_config_model_pub_add(node_jconfig_get(node), ele_addr,
> +		if (!mesh_config_model_pub_add(node_config_get(node), ele_addr,
>  					vendor ? mod_id : mod_id & 0x0000ffff,
>  					vendor, &db_pub))
>  			status = MESH_STATUS_STORAGE_FAIL;
> @@ -331,18 +329,18 @@ static bool save_config_sub(struct mesh_node *node, uint16_t ele_addr,
>  
>  	if (opcode == OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE ||
>  					opcode == OP_CONFIG_MODEL_SUB_OVERWRITE)
> -		mesh_config_model_sub_del_all(node_jconfig_get(node),
> +		mesh_config_model_sub_del_all(node_config_get(node),
>  				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
>  									vendor);
>  
>  	if (opcode != OP_CONFIG_MODEL_SUB_VIRT_DELETE &&
>  			opcode != OP_CONFIG_MODEL_SUB_DELETE)
> -		return mesh_config_model_sub_add(node_jconfig_get(node),
> +		return mesh_config_model_sub_add(node_config_get(node),
>  					ele_addr,
>  					vendor ? mod_id : mod_id & 0x0000ffff,
>  					vendor, &db_sub);
>  	else
> -		return mesh_config_model_sub_del(node_jconfig_get(node),
> +		return mesh_config_model_sub_del(node_config_get(node),
>  					ele_addr,
>  					vendor ? mod_id : mod_id & 0x0000ffff,
>  					vendor, &db_sub);
> @@ -419,7 +417,7 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
>  		status = mesh_model_sub_del_all(node, ele_addr, mod_id);
>  
>  		if (status == MESH_STATUS_SUCCESS)
> -			mesh_config_model_sub_del_all(node_jconfig_get(node),
> +			mesh_config_model_sub_del_all(node_config_get(node),
>  				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
>  									vendor);
>  		break;
> @@ -878,7 +876,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
>  
>  		count = (pkt[0] >> 5) + 1;
>  		interval = ((pkt[0] & 0x1f) + 1) * 10;
> -		if (storage_set_transmit_params(node_jconfig_get(node), count,
> +		if (storage_set_transmit_params(node_config_get(node), count,
>  								interval))

Given the signature:

bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
                                                            uint8_t interval)

shouldn't that be:

    if (storage_set_transmit_params(node, count, interval))

and in other places as well?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
