Return-Path: <SRS0=pDNe=VM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D6BC7618F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 08:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1818D21655
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 08:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="eTB5V9He"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfGOIH0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:07:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34266 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbfGOIH0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jul 2019 04:07:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so3084388lfq.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2019 01:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O0ftE8t7D0ShJghNcYvcNUllZjZnMG3BIipRqbjeaTg=;
        b=eTB5V9HeqNJwTMQus9qEy0CGEK0h4UGD6+Ygly+M+puBQ+g7PcE0c+7AOlP2kWgJqE
         k4ODDdiDm1ITONCwfYziyFj1+VxzVZw5MVgw7BLJqsVaahZ8LZSg1lTHUNLR1dqexuY6
         RzZ1iIvrjooIua/itgSTf9AlILRnYuHLH0mhcW2+6FoC/uEZHn1CRIjkY+kEszeTlVXq
         GVxuwmJtwoEZjBQrkW60N+oeNlv3Fml1irVagPoXQsM3d4MDerpxrdqbEAwzEYGIveHN
         ysBNtsUoI7/TnQVcpwRNJMsCa5Brj7kEGaENqr4KdwuDiMlPwOQN7WYDFrq6qPrQETKp
         vzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=O0ftE8t7D0ShJghNcYvcNUllZjZnMG3BIipRqbjeaTg=;
        b=Fw5hK7KYjVXEr2UHnD7YYNnrFzQ7zfkZWg9ecP/6+KR3yt8RmaYhw4fd3IVavMdTSm
         AmOUHC4p1oLbsIvY2OP6C4dO/vmThohVxcLA4bgZkmwy03Al1xbZQLUP7DymUgmUG/HF
         vz4Uc4wCHD/U8w5OAyi9ukSIFF3nlr/4i1oUpBIpT7vg5qnp8ZTPdbb+BjmXZ1HUyySw
         tcspIwblQcd4BBb2qktXvGKkewPe+v8DHAQ5mBhWlkXa0ZSgue4PgGXRjd9msPX6Kkxx
         nulcF5tc6IPRuJ2i1/9iQTYBrpBCmAQsYj5amari2DnbKuf4HX6uc1VG2RQgMUHGISSU
         q4xQ==
X-Gm-Message-State: APjAAAURV8AqFdJp56Je7YBgIcIuANiBs+0WszTGDUI7TcIUxC00zLrb
        iNSRtv8RZr/Hx3Xc1ydxKM3s+zdgulU=
X-Google-Smtp-Source: APXvYqyR/vwj2hhTKurKr7cpEPOy/XHOI2iSV3R7GScek4Piihatn+2HRrolN2MhxEAknr5mJuggNw==
X-Received: by 2002:a19:f007:: with SMTP id p7mr10735564lfc.24.1563178044376;
        Mon, 15 Jul 2019 01:07:24 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id m17sm3031362lji.16.2019.07.15.01.07.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 01:07:23 -0700 (PDT)
Date:   Mon, 15 Jul 2019 10:07:21 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        jakub.witowski@silvair.com
Subject: Re: [PATCH BlueZ 00/10 v3] mesh: Configuration storage re-org
Message-ID: <20190715080721.a4fcaqsdcqimeajc@mlowasrzechonek2133>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        jakub.witowski@silvair.com
References: <20190714232320.20921-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190714232320.20921-1-inga.stotland@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

On 07/14, Inga Stotland wrote:
> + rebase off the tip
> 
> This set of patches introduces the notion of generic mesh-config API
> that allows the daemon to be agnostic of the underlying node configuration
> directory layout and the format of the file(s) in which node configuration
> is saved. 
> 
> Currently, the daemon supports only JSON-based configuration format.
> It is expected that other configuration formats may be added in future.
> 
> As a result of these changes, storage.c and storage.h are obsolete
> and are removed.
> 
> Inga Stotland (10):
>   mesh: Move network config setup from storage.c to node.c
>   mesh: Rename mesh-db.c to mesh-config-json.c
>   mesh: Change mesh_db prefix to mesh_config
>   mesh: Move load from storage functionality into node.c
>   mesh: Confine dependency on json-c to mesh-config-json.c
>   mesh: Replace storage_save_config with mesh_config_save_config
>   mesh: Use mesh_config APIs to store node configuration
>   mesh: Manage node config directory in mesh-config
>   mesh: Create or re-use a node storage directory for keyring
>   mesh: Rename mesh_config_srv_init() to cfgmod_server_init()
> 
>  Makefile.mesh                          |    3 +-
>  mesh/appkey.c                          |   19 +-
>  mesh/cfgmod-server.c                   |   31 +-
>  mesh/cfgmod.h                          |    2 +-
>  mesh/keyring.c                         |   36 +-
>  mesh/{mesh-db.c => mesh-config-json.c} | 1071 +++++++++++++++++-------
>  mesh/mesh-config.h                     |  172 ++++
>  mesh/mesh-db.h                         |  157 ----
>  mesh/mesh.c                            |   15 +-
>  mesh/mesh.h                            |    1 +
>  mesh/model.c                           |   23 +-
>  mesh/net.c                             |   26 +-
>  mesh/node.c                            |  224 +++--
>  mesh/node.h                            |   13 +-
>  mesh/storage.c                         |  656 ---------------
>  mesh/storage.h                         |   51 --
>  mesh/util.c                            |   39 +-
>  mesh/util.h                            |    1 +
>  18 files changed, 1219 insertions(+), 1321 deletions(-)
>  rename mesh/{mesh-db.c => mesh-config-json.c} (58%)
>  create mode 100644 mesh/mesh-config.h
>  delete mode 100644 mesh/mesh-db.h
>  delete mode 100644 mesh/storage.c
>  delete mode 100644 mesh/storage.h
> 
> -- 
> 2.21.0
> 

Reviewed-by: Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>


I have a style question (as usual, unrelated to this patchset ;) - do we
have a preferred way for verb usage in (public) function names?

At the moment I see:
 - mesh_config_create vs mesh_net_new - my preference is _new/_free
 - mesh_net_node_get vs mesh_net_get_io - my preference is to place verbs at the end

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
