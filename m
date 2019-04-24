Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A80C10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 08:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E90218FC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 08:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="gsZx4IQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfDXI7v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:59:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43820 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfDXI7u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 04:59:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id i68so14015717lfi.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2019 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jsB2itMGrSllc+Uwp+5nCNZwaEBwN2ZYMUNwUdmJwWU=;
        b=gsZx4IQQ6/ndMpcd+EjJU2cag2qiNjWTryWqXqKZWBAa59tSiGDoj4AnSfV2xYSJ70
         jMZ+hKfPW1ObQAgLIsQBVtcwklOis6EZks/URpAH+gfBRq0CmntzPM+QiGDG9Bi2w7pd
         r3P3kEMbBu4S4CqKal5yCP6k3w8t6Kria7VFCCM5AkSW9VA3RzvicDgWbSZcZnIBoy3x
         4j+xOokfcbHwbMXSwaN0PEeMy+ECi5BEpHFj6PXUwVW0fDD98clWEoH+yB3eqUe/VNny
         Ix4xqKy7UXRoovN9TgyvKFQOFQ2u1Dxdb49Rl81BkQz3+q9p8JzL3AMUNcbuPKxwbhl+
         dHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jsB2itMGrSllc+Uwp+5nCNZwaEBwN2ZYMUNwUdmJwWU=;
        b=e3MzNJdvvGM2vO5ddy/KgftTSvkxzp0i/ADC/BleSQFBOYNGhuwmnj9mOX4CopFZgA
         bxFE4l5vWhP7ed7DD504vfXXa/TpklFQLxKuMcZau+2SWIDhFwiDf4LXIJjFpMeZSILA
         4/ykhYqCK1Q2j7fihgi7DT0keTpcBdj3sfXWOKcbqj0mKH7T4en73Vn8LJ+nJsdSHhL/
         TD4mhsk5DCiQpchZvkzSG7dxttjiP+YHjwjdGUJpstTJo3eIHtHBPDoIPCv6VTBcJsZl
         CqdamS57PlHTuo6xYo3F3q9uINOzdsrpNssxUpK2ETAFBszZ18PsCPbDRiKYmXTMPAac
         gjUg==
X-Gm-Message-State: APjAAAXPELj1NJcFkwIG0rdvQP2I43zPN9s6OixOaM9AKxpqdvQkw40o
        JAI3EZZJ6mTDk/6507+bOcz19A==
X-Google-Smtp-Source: APXvYqwwhkfDlQC/zUsSOXcxc6FdIKA+G7PkdKrl6Ru3myg4MMF0+zWjsBJbni9RUdz7sydU3Ti5IA==
X-Received: by 2002:a19:4f07:: with SMTP id d7mr155372lfb.153.1556096388775;
        Wed, 24 Apr 2019 01:59:48 -0700 (PDT)
Received: from kynes (apn-31-2-19-253.dynamic.gprs.plus.pl. [31.2.19.253])
        by smtp.gmail.com with ESMTPSA id b12sm4242080lfa.74.2019.04.24.01.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 01:59:47 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Wed, 24 Apr 2019 10:59:45 +0200
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ] mesh: Add remote dev key support and cleanup
Message-ID: <20190424085945.zmniib4vpy2uiyql@kynes>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20190423231624.19302-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190423231624.19302-1-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

A few comments.

On 04/23, Brian Gix wrote:
> +try_remote:
> +	/* Try remote device key if available */
> +	dev_key = node_get_remote_device_key(node, src);
> +	if (!dev_key)
> +		return -1;
> +
> +	if (mesh_crypto_payload_decrypt(NULL, 0, data, size, szmict, src,
> +					dst, key_id, seq, iv_idx, out, dev_key))
> +		return APP_IDX_DEV_RMT;
> +
What's the purpose of APP_IDX_DEV_RMT?

I'm not a fan of magic values (and I hope APP_IDX_DEV goes away afterw
we manage to implement proposed Config/Provisioning API), but at least
APP_IDX_DEV is used to indicate 'privileged' loopback messages.

Adding IDX_DEV_RMT doesn't seem necessary.

> diff --git a/mesh/node.c b/mesh/node.c
> index 157991dad..fe0488108 100644
> --- a/mesh/node.c
> +++ b/mesh/node.c
> @@ -54,6 +54,8 @@
>  #define DEFAULT_CRPL 10
>  #define DEFAULT_SEQUENCE_NUMBER 0
>  
> +#define REMOTE_CACHE_LEN 5
By the way: why the limits here are set so low (and there doesn't seem
to be a way to change them...)? I don't think we should put artificial
constraints on network size, so both CRPL and remote cache could safely
be set to cover full unicast space (32768). In any practical
application, the device running Linux + bluetooth will have more than
enough RAM for this.

Getting rid of these constraints would make the implementation
substiantially simpler (no MRU, for example).

FYI, we're running networks with couples of hundreds devices, and plan
to expand them even further.

> +/* This is a thread-safe always malloced version of dirname which will work
> + * regardless of which underlying dirname implimentation is used
> + */
> +static char *alloc_dirname(const char *path)
> +{
I was under impression that mesh daemon operates inside a main loop, so
it doesn't need to worry about thread safety?

> +bool storage_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
> +							uint8_t dev_key[16])
> +{
> (...)
> +	dir_name = alloc_dirname(cfgname);
I don't see why the remote key storage should be kept separately (and in
binary files?) from the main node json. It makes the implementation much
more complicated, as you need to worry about directories etc.

I believie that keeping remote keys in the same place, as a JSON object,
would be much simpler.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
