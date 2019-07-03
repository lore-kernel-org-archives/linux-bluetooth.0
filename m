Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520A0C0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 17:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259C221882
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 17:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="fjFpry6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGCRYU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:24:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40570 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCRYU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 13:24:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id a21so3321684ljh.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q+OFyINI6SSDUW9DCpyWL7PsqLgYetLCVbikOwTw0Dc=;
        b=fjFpry6FI+CkhYquUYO2Cu6fOP2gUOIA1rfC6W+Onx9crNozh419rFSJfgB3NF5pXw
         jUJto3V83os2hj9RZp10FaxkKTPWLptIUrDaoiJ8hruWX36D7L8UaUiL/D4E9/pEJQyu
         wBQLcetRoXlhXqO/LbvPx6kebPT9apwVJn+c70yZDHDxW7cNppUDIXC3zGHOdqs3za03
         v7y8ZYntexKs18mvWDWAagKRkhJuti03BO2wrhMXaPqMwBf2ElXXBJ80cVkxz7cpF9zK
         8bxklv+FuegqjnGldTDtnfIP+nqmdBFQilqpGrOUk73k6JA6VA+6HWN0N0xf5xlZR1tH
         FbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=q+OFyINI6SSDUW9DCpyWL7PsqLgYetLCVbikOwTw0Dc=;
        b=ZB8QqOeDZsL0zTgJcBMMW/JV9i+ph4p+9tARneN1iho6CpVaqtgkUxv1aUvXzzn4/3
         B8U/hLKE3CaRzcEgS30oDLLVZxR9kwEGSOcSHK1WT4KGA5oVVUa2tSUM0Bat//1hRKKh
         Yk6uEmjsibezn0Aqak0WXpWoq1qp/V0MmEOGqvWm/hZk+zEYEz8wVB9bGm2wVrf8Tajj
         wLW3TrQRu1Gf9EDIjg42goBvdkoRpOrAGKxz17J7L0GfKjhFDsUEuFVvCvrFn3c9bXqc
         2E3qZWhCijjuzUUCA87/BxY0kWjzC99Huaxj4BI7X+NHNfdstLizhFolSrW3RbmNEj0S
         AyQA==
X-Gm-Message-State: APjAAAXcRE5hMr9bhCS9BXVLcWSOMwKQBu7EeLyNmZN0LVGe+rFwC6Dh
        luqZFdgQ34LxAjoSk3PI1CeGkrAGOJg=
X-Google-Smtp-Source: APXvYqz6NUTv4X2wOV5LF9OMISFfm7Ur1NZglqgwPkFjsETb/LesvihtNNmtOeiqEFAxesaswjNb2g==
X-Received: by 2002:a2e:5c6:: with SMTP id 189mr22371305ljf.22.1562174658530;
        Wed, 03 Jul 2019 10:24:18 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id c1sm482402lfh.13.2019.07.03.10.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 10:24:17 -0700 (PDT)
Date:   Wed, 3 Jul 2019 19:24:16 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ] mesh: Fix memory leak on dbus message creation
Message-ID: <20190703172416.thky44wklorfz7zz@kynes>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20190703163403.15814-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190703163403.15814-1-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 07/03, Brian Gix wrote:
> ---
>  mesh/model.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mesh/model.c b/mesh/model.c
> index 7401dcecb..a2b3e5c18 100644
> --- a/mesh/model.c
> +++ b/mesh/model.c
> @@ -729,10 +729,13 @@ static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
>  	if (!l_dbus_message_builder_finalize(builder))
>  		goto error;
>  
> +	l_dbus_message_builder_destroy(builder);
>  	l_dbus_send(dbus, msg);
> +	return;
>  
>  error:
>  	l_dbus_message_builder_destroy(builder);
> +	l_dbus_message_unref(msg);
>  }
>  
>  bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,

Since in ELL's dbus API it's legal to unref a NULL message, I'd rather
write this as:

    l_dbus_send(dbus, msg);
    msg = NULL;

error:
    l_dbus_message_builder_destroy(builder);
    l_dbus_message_unref(msg);


or (version for purists):

    l_dbus_send(dbus, msg);
    msg = NULL;

error:
    l_dbus_message_builder_destroy(builder);
    if (msg)
        l_dbus_message_unref(msg);


mostly to emphasize that l_dbus_send has "move" semantics.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
