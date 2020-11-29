Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19970C3E8C5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Nov 2020 09:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F2420771
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Nov 2020 09:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgK2Jpo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Nov 2020 04:45:44 -0500
Received: from atl4mhfb02.myregisteredsite.com ([209.17.115.118]:44716 "EHLO
        atl4mhfb02.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgK2Jpo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Nov 2020 04:45:44 -0500
Received: from jax4mhob08.registeredsite.com (jax4mhob08.myregisteredsite.com [64.69.218.88])
        by atl4mhfb02.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 0AT9j18r027949
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Nov 2020 04:45:01 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.85])
        by jax4mhob08.registeredsite.com (8.14.4/8.14.4) with ESMTP id 0AT9iHoU022998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Nov 2020 04:44:18 -0500
Received: (qmail 22964 invoked by uid 0); 29 Nov 2020 09:44:17 -0000
X-TCPREMOTEIP: 208.85.15.155
X-Authenticated-UID: sbrown@opensat.com
Received: from unknown (HELO 155-15-85-208.altiusbb.net) (sbrown@opensat.com@208.85.15.155)
  by 0 with ESMTPA; 29 Nov 2020 09:44:17 -0000
Received: from localhost (localhost [127.0.0.1])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id 345741540499;
        Sun, 29 Nov 2020 04:44:16 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at ewol.com
Received: from 155-15-85-208.altiusbb.net ([127.0.0.1])
        by localhost (fl-server.ewol.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z3i3emfX9gvp; Sun, 29 Nov 2020 04:44:14 -0500 (EST)
Received: from w7.lan (w7.lan [192.168.1.9])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id 59E761540113;
        Sun, 29 Nov 2020 04:44:14 -0500 (EST)
Message-ID: <e0c8edbb7b44aaea6d2779eac526c9a7b977f958.camel@ewol.com>
Subject: Re: [PATCH BlueZ v2] mesh: Fix check for mkdir return value in
 keyring.c
From:   Steve Brown <sbrown@ewol.com>
To:     Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com
Date:   Sun, 29 Nov 2020 04:44:14 -0500
In-Reply-To: <20201129062202.91034-1-inga.stotland@intel.com>
References: <20201129062202.91034-1-inga.stotland@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

Patch works for me.

Thanks,

Steve

On Sat, 2020-11-28 at 22:22 -0800, Inga Stotland wrote:
> Remove check for mkdir() return value, since checking for zero does
> not
> cover "already exists" condition and adding extra check for errno
> value
> unnecessarily complicates the code. If mkdir() fails due to any
> reason
> than "already exists", the subsequent call to open() fails and the
> error is detected and corectly processed by the code.
> ---
>  mesh/keyring.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mesh/keyring.c b/mesh/keyring.c
> index 1ef4fc3ef..0b74ee914 100644
> --- a/mesh/keyring.c
> +++ b/mesh/keyring.c
> @@ -51,8 +51,7 @@ bool keyring_put_net_key(struct mesh_node *node,
> uint16_t net_idx,
>  
>         snprintf(key_file, PATH_MAX, "%s%s", node_path, net_key_dir);
>  
> -       if (!mkdir(key_file, 0755))
> -               return false;
> +       mkdir(key_file, 0755);
>  
>         snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path,
> net_key_dir,
>                                                                 net_i
> dx);
> @@ -88,8 +87,7 @@ bool keyring_put_app_key(struct mesh_node *node,
> uint16_t app_idx,
>  
>         snprintf(key_file, PATH_MAX, "%s%s", node_path, app_key_dir);
>  
> -       if (!mkdir(key_file, 0755))
> -               return false;
> +       mkdir(key_file, 0755);
>  
>         snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path,
> app_key_dir,
>                                                                 app_i
> dx);
> @@ -207,8 +205,7 @@ bool keyring_put_remote_dev_key(struct mesh_node
> *node, uint16_t unicast,
>  
>         snprintf(key_file, PATH_MAX, "%s%s", node_path, dev_key_dir);
>  
> -       if (!mkdir(key_file, 0755))
> -               return false;
> +       mkdir(key_file, 0755);
>  
>         for (i = 0; i < count; i++) {
>                 snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,


