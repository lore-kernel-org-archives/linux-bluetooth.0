Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F00C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 07:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B94208D5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 07:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="XOOIql9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgFQHt4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQHtz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 03:49:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAEFC061573
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 00:49:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n24so1639697lji.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 00:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IwFpNEPNq9wxv3xJ7gG8eHJ66U4NFq8U8PuusGH9/YQ=;
        b=XOOIql9QXrE51u0F/d1Gqy51CviKGQPs1i6JHSM/E/256c6OSeAnUEsNG/HCvILzsh
         hP/bxVTJoHrcgVOASHx8lxpdPQirF1WbyXUGyRuRP5EsK2Neai8J7jPGTntiaM/LNHlS
         wqZI1gwfvlimEqfxNxTS73RvTabMPQbeKGyLTsN0cFvD7lbZ50iYiJ8nfjrXpQBfH67V
         8H65r8WylPLOMvLG5g3aaE4S8WA76+pik0+IaqwMR5k2RVyH5OOh6SPdh8HyQ6O9givn
         96fkZOQzOjdJ/h6K2dj87R+F8MRidm2EXVlKVXbInFfWdPrKBbnwawGQkoZj3A5WNt7X
         LsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IwFpNEPNq9wxv3xJ7gG8eHJ66U4NFq8U8PuusGH9/YQ=;
        b=MhqnAB7BOGajluo3BdJpELUILPmxs92OxjPIrXyk98gfmfEshf7b2KwHRSaTmhqmiK
         drDmqt8TfTF2jvFrRan8Jf+e22uQ70WYK/jiLARIF0Av4tbLRcQAAHbnpbNZmZYDyH5f
         KEhM6A+arpzVfgUPG93HM7jBijRdbG7m7v9dV9UUJwY66XYWSRbWJe4XjMHCwXkEkbsd
         IWnshVFcXNk1iRRMe9J2YeAmzzR/3lzo6XGlDNdsT0yiIPQGNzoKIRKM5iCIUmSFhbl4
         1gwwAeixCU+IRqFVBuZuBkKfj2VmTwPd5wt+L4ReC6iVzoM1GgV+CeL1YGWew9lYQakD
         2SeQ==
X-Gm-Message-State: AOAM531+445uxiscNaKT43qjDMtFcftI+H/XfxTO/X77T/nphhNyJM25
        NtLasYE9TEKWkTm0BHu+jUWRNOGVIp4eYQ==
X-Google-Smtp-Source: ABdhPJxiQwl1paUQ2qAD3HP+dq5tZeodHd0FL/+6lhF7TWmepOX+SG4Lg9EdB5TZa2Q43Xq8/fQWHA==
X-Received: by 2002:a2e:1311:: with SMTP id 17mr3347715ljt.122.1592380192251;
        Wed, 17 Jun 2020 00:49:52 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id l22sm4826539lji.120.2020.06.17.00.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 00:49:51 -0700 (PDT)
Date:   Wed, 17 Jun 2020 09:50:15 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ v2] mesh: Add deferral of Attach() and Leave() if
 busy
Message-ID: <20200617075015.4hntygf64dzz6fka@mlowasrzechonek2133>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20200616181436.50319-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616181436.50319-1-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 06/16, Brian Gix wrote:
> We require the successful return of JoinComplete() method before
> handling subsequent Attach() or Leave() method calls. To simplify the
> construction of Applications, we will accept one of these calls up to 1
> second prior to receiving the final return status of JoinComplete,
> which tells us that the Application is ready to use the node.
> 
> If the node is still not ready after the deferral, Attach and/or Leave
> will fail.

Nice, I think this solution is simpler than the patch I came up with.

> ---
>  mesh/mesh.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/mesh/mesh.c b/mesh/mesh.c
> index ab2393deb..bc170371d 100644
> --- a/mesh/mesh.c
> +++ b/mesh/mesh.c
> @@ -104,6 +104,10 @@ static struct l_queue *pending_queue;
>  
>  static const char *storage_dir;
>  
> +/* Forward static decalrations */
> +static void def_attach(struct l_timeout *timeout, void *user_data);
> +static void def_leave(struct l_timeout *timeout, void *user_data);
> +
>  static bool simple_match(const void *a, const void *b)
>  {
>  	return a == b;
> @@ -634,12 +638,26 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
>  	uint64_t token;
>  	const char *app_path, *sender;
>  	struct l_dbus_message *pending_msg;
> +	struct mesh_node *node;
>  
>  	l_debug("Attach");
>  
>  	if (!l_dbus_message_get_arguments(msg, "ot", &app_path, &token))
>  		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
>  
> +	node = node_find_by_token(token);
> +	if (!node)
> +		return dbus_error(msg, MESH_ERROR_NOT_FOUND, "Attach failed");
> +
> +	if (node_is_busy(node)) {
> +		if (user_data)
> +			return dbus_error(msg, MESH_ERROR_BUSY, NULL);
> +
> +		/* Try once more in 1 second */
> +		l_timeout_create(1, def_attach, l_dbus_message_ref(msg), NULL);
> +		return NULL;
> +	}
> +
>  	sender = l_dbus_message_get_sender(msg);
>  
>  	pending_msg = l_dbus_message_ref(msg);
> @@ -650,6 +668,19 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
>  	return NULL;
>  }
>  
> +static void def_attach(struct l_timeout *timeout, void *user_data)
> +{
> +	struct l_dbus *dbus = dbus_get_bus();
> +	struct l_dbus_message *msg = user_data;
> +	struct l_dbus_message *reply;
> +
> +	l_timeout_remove(timeout);
> +
> +	reply = attach_call(dbus, msg, (void *) true);

Why not pass NULL as the 3rd argument? We register the interface with
empty user data, so this would be an equivalent.

> +	l_dbus_send(dbus, reply);
> +	l_dbus_message_unref(msg);
> +}
> +
>  static struct l_dbus_message *leave_call(struct l_dbus *dbus,
>  						struct l_dbus_message *msg,
>  						void *user_data)
> @@ -666,14 +697,33 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
>  	if (!node)
>  		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
>  
> -	if (node_is_busy(node))
> -		return dbus_error(msg, MESH_ERROR_BUSY, NULL);
> +	if (node_is_busy(node)) {
> +		if (user_data)
> +			return dbus_error(msg, MESH_ERROR_BUSY, NULL);
> +
> +		/* Try once more in 1 second */
> +		l_timeout_create(1, def_leave, l_dbus_message_ref(msg), NULL);
> +		return NULL;
> +	}
>  
>  	node_remove(node);
>  
>  	return l_dbus_message_new_method_return(msg);
>  }
>  
> +static void def_leave(struct l_timeout *timeout, void *user_data)
> +{
> +	struct l_dbus *dbus = dbus_get_bus();
> +	struct l_dbus_message *msg = user_data;
> +	struct l_dbus_message *reply;
> +
> +	l_timeout_remove(timeout);
> +
> +	reply = leave_call(dbus, msg, (void *) true);

Same here.

> +	l_dbus_send(dbus, reply);
> +	l_dbus_message_unref(msg);
> +}
> +
>  static void create_join_complete_reply_cb(struct l_dbus_message *msg,
>  								void *user_data)
>  {
> -- 
> 2.25.4
> 

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
