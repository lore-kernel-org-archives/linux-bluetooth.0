Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F4BC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 12:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090DA2222B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 12:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgKQMcF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 07:32:05 -0500
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.119]:35840 "EHLO
        atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbgKQMcF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 07:32:05 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 07:32:04 EST
Received: from jax4mhob03.registeredsite.com (jax4mhob03.myregisteredsite.com [64.69.218.83])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 0AHCPlHN029969
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 07:25:48 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.85])
        by jax4mhob03.registeredsite.com (8.14.4/8.14.4) with ESMTP id 0AHCPjYi030304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 07:25:45 -0500
Received: (qmail 51589 invoked by uid 0); 17 Nov 2020 12:25:45 -0000
X-TCPREMOTEIP: 208.85.15.155
X-Authenticated-UID: sbrown@opensat.com
Received: from unknown (HELO 155-15-85-208.altiusbb.net) (sbrown@opensat.com@208.85.15.155)
  by 0 with ESMTPA; 17 Nov 2020 12:25:45 -0000
Received: from localhost (localhost [127.0.0.1])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id B28DF154055F;
        Tue, 17 Nov 2020 07:25:44 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at ewol.com
Received: from 155-15-85-208.altiusbb.net ([127.0.0.1])
        by localhost (fl-server.ewol.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9S241725A3Nj; Tue, 17 Nov 2020 07:25:38 -0500 (EST)
Received: from w7.lan (w7.lan [192.168.1.9])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id 738BC1540385;
        Tue, 17 Nov 2020 07:25:38 -0500 (EST)
Message-ID: <5f6e9b95f48fd4c8488bfbbf85ca900db57dbf82.camel@ewol.com>
Subject: Re: [PATCH BlueZ v5 10/10] mesh: Refactor heartbeat pub/sub
From:   Steve Brown <sbrown@ewol.com>
To:     Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com
Date:   Tue, 17 Nov 2020 07:25:38 -0500
In-Reply-To: <20200807013834.123263-11-inga.stotland@intel.com>
References: <20200807013834.123263-1-inga.stotland@intel.com>
         <20200807013834.123263-11-inga.stotland@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

This patch breaks heartbeat subscription set for me.

Subscription isn't enabled in net.c:mesh_net_set_heartbeat_sub() unless
sub->dst != dst. That is a change from prior to refactoring and seems
wrong.

Steve

On Thu, 2020-08-06 at 18:38 -0700, Inga Stotland wrote:
> Move heartbeat publication/subscription timers and housekeeping
> to net.c since this is where the trigger events and control messages
> are handled. Configuration server (cfgmod-server.c) stays
> responsible for parsing the set pub/sub message parameters and
> assemblying the pub/sub status messages.
> 
> Also, make sure that the correct message status is reported.
> ---
>  mesh/cfgmod-server.c | 307 ++++++++++++++---------------------------
> --
>  mesh/net.c           | 273 ++++++++++++++++++++++++++++----------
>  mesh/net.h           |  48 ++++---
>  3 files changed, 328 insertions(+), 300 deletions(-)
> 
> diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
> index ea0741969..ffeb0afeb 100644
> --- a/mesh/cfgmod-server.c
> +++ b/mesh/cfgmod-server.c
> 
------------- snip ----------------------------
> +               return 0;
>  
> -       if (hb->sub_dst != dst) {
> -               if (IS_GROUP(hb->sub_dst))
> -                       mesh_net_dst_unreg(net, hb->sub_dst);
> -               if (IS_GROUP(dst))
> -                       mesh_net_dst_reg(net, dst);
> -       }
> +       period_log = pkt[4];
>  
> -       hb->sub_enabled = !!period_log;
> -       hb->sub_src = src;
> -       hb->sub_dst = dst;
> -       hb->sub_count = 0;
> -       hb->sub_period = log_to_uint32(period_log, 1);
> -       hb->sub_min_hops = 0x00;
> -       hb->sub_max_hops = 0x00;
> +       if (period_log > 0x11)
> +               return 0;
>  
> -       gettimeofday(&time_now, NULL);
> -       hb->sub_start = time_now.tv_sec;
> +       net = node_get_net(node);
>  
> 
------------------ snip ------------------------

> diff --git a/mesh/net.c b/mesh/net.c
> index 9b4454fee..633727601 100644
> --- a/mesh/net.c
> +++ b/mesh/net.c
> 

------------------- snip ----------------

> +
> +       } else if (sub->dst != dst) {
> +               if (IS_GROUP(sub->dst))
> +                       mesh_net_dst_unreg(net, sub->dst);
> +
> +               if (IS_GROUP(dst))
> +                       mesh_net_dst_reg(net, dst);
> +
> +               sub->enabled = !!period_log;
> +               sub->src = src;
> +               sub->dst = dst;
> +               sub->count = 0;
> +               sub->period = log_to_uint32(period_log);
> +               sub->min_hops = 0x00;
> +               sub->max_hops = 0x00;
> +               gettimeofday(&time_now, NULL);
> +               sub->start = time_now.tv_sec;
> +       }
> +

--------------------- snip --------------------




