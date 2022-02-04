Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E672C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 15:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353177AbiBDPjU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Feb 2022 10:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiBDPjU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Feb 2022 10:39:20 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC64C061714
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Feb 2022 07:39:18 -0800 (PST)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 2B2793F734;
        Fri,  4 Feb 2022 16:39:14 +0100 (CET)
Date:   Fri, 4 Feb 2022 16:39:12 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] gdbus: Emit InterfacesAdded of parents objects
 first
Message-ID: <20220204153912.5upv7ahzngz4xezz@SoMainline.org>
References: <20220204013620.2465024-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204013620.2465024-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2022-02-03 17:36:20, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes InterfacesAdded respect the object hierarchy in case its
> parent has pending interfaces to be added.
> 
> Fixes: https://github.com/bluez/bluez/issues/284

https://lore.kernel.org/linux-bluetooth/20211215180527.886481-1-claudio.takahasi@gmail.com/T/#mfb2f320363c6cd086f6e92d5f6ad441b23d540fe
too?  This fixees the issue again, thanks!

> ---
>  gdbus/object.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 50a8b4ff1..7232c2986 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -551,6 +551,12 @@ static void emit_interfaces_added(struct generic_data *data)
>  	if (root == NULL || data == root)
>  		return;
>  
> +	/* Emit InterfacesAdded on the parent first so it appears first on the
> +	 * bus as chield objects may point to it.

child*

- Marijn

> +	 */
> +	if (data->parent && data->parent->added)
> +		emit_interfaces_added(data->parent);
> +
>  	signal = dbus_message_new_signal(root->path,
>  					DBUS_INTERFACE_OBJECT_MANAGER,
>  					"InterfacesAdded");
> -- 
> 2.34.1
> 


