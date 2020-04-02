Return-Path: <SRS0=u1pM=5S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A46C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 08:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3156F2078B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 08:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="nmSUM8Jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbgDBICd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:02:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36350 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387476AbgDBICd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Apr 2020 04:02:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id w145so1938541lff.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2020 01:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VtjxdlQ9Pr11gPKm504NzHF9dlgHw+5eWAWjZ2jNDGQ=;
        b=nmSUM8JmWl1A63mkjS2lpLLE99TM/VS9gCvX6VcvPn2OBNBGYCE+1fLpoA069LOm1v
         Ux2z6+h2CaQ3fWmnaJLv4U/PLIIA1I8Yw+O/bmIBQWRFELemibYAFm8Rbv0gvLe6CFMy
         9MXPR5natv+dz/pqPn8OVDBk+nBM3vEf7x/2MGzUu8e/60NOWIkhyHhJ9UCBEyvNGU+8
         gbK+KG6efbuY51JYg6O9vmXWY144K7cqCeTRL4IWbx0vjkTkZbbKAD1hDTH9SrWlcyXU
         YYw0XA5pIM+dN14Uaz+vKfWVbMw8S+JwdlLUIHfEf1yyIsX/GF1twu5tClY5pcYkLp3T
         eENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VtjxdlQ9Pr11gPKm504NzHF9dlgHw+5eWAWjZ2jNDGQ=;
        b=eLrUvxQUAJ04RLYkGDQn60KCySmSRtTgvfatuti2a8jzejJHgy+u8iglnL4YmRN2LF
         i6G7FeMzivI5JQkaJiwwh2HN5JyGH7VlWbbaqqpt+BCgxatr2c6RFOw3tr+Q7PJTw90M
         ZKMgGCGdwAHxqIe26MSlyt5etCyIun0Ie8k5IC5S7NbF9e51Pxou1mOw9A8Iri8FR0TN
         q+bqGzT4KrZQRMu1dAFpJ5mkjDtvwmwmxKgbSJTNNCkmBrkcLDUDUgDNfhgOQrGegzQ6
         LV8yOqrusQlzkzqVCSsL9ZCljvb2KuankH3OhcgLoxu2RXbz+Oqt7TmP2kh/LdBCJ9fV
         RR9w==
X-Gm-Message-State: AGi0PuY1yZC/itOqJyoe2fzfeX1o67da1M2wrhAkr7K8wLV/rBdy7IOl
        PTrkmUgXSO7m3p9u8CpZJJugFA==
X-Google-Smtp-Source: APiQypK7Nr5JwzH81vG0BMkyKXHPveRlL8s8Too3EwQUbJHiVWscXqWBi3+Muy/1lKzGXn72gULNIA==
X-Received: by 2002:a19:4b90:: with SMTP id y138mr1305616lfa.39.1585814549795;
        Thu, 02 Apr 2020 01:02:29 -0700 (PDT)
Received: from ix.localnet (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id v12sm2703278ljh.6.2020.04.02.01.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 01:02:29 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] gatt: Fix Acquire* reply handling
Date:   Thu, 02 Apr 2020 10:02:27 +0200
Message-ID: <5451372.4TLDOW9l6p@ix>
Organization: CODECOUP
In-Reply-To: <20200401232733.10686-1-luiz.dentz@gmail.com>
References: <20200401232733.10686-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thursday, 2 April 2020 01:27:33 CEST Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Originally these operation did not set any owner_queue which caused
> them to crash if the attribute is freed before the respose, to fix that
> the reply will now check if owner_queue was reset to NULL which means
> the attribute is no longer available but the owner_queue was never set
> in the first place so this ensures they are now setup properly.
> ---
>  src/gatt-database.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 11d886c56..483c84341 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -2485,8 +2485,8 @@ static struct pending_op *acquire_write(struct
> external_chrc *chrc, {
>  	struct pending_op *op;
> 
> -	op = pending_write_new(device, NULL, attrib, id, value, len, 0,
> -						link_type, false, 
false);
> +	op = pending_write_new(device, chrc->pending_writes, attrib, id, 
value,
> +				len, 0, link_type, false, false);
> 
>  	if (g_dbus_proxy_method_call(chrc->proxy, "AcquireWrite",
>  					acquire_write_setup,
> @@ -2618,6 +2618,7 @@ static uint8_t ccc_write_cb(struct pending_op *op,
> void *user_data) if (g_dbus_proxy_get_property(chrc->proxy,
> "NotifyAcquired", &iter)) { op->data.iov_base = (void *) chrc;
>  		op->data.iov_len = sizeof(chrc);
> +		op->owner_queue = chrc->pending_writes;
>  		if (g_dbus_proxy_method_call(chrc->proxy, "AcquireNotify",
>  						
acquire_notify_setup,
>  						
acquire_notify_reply,

Patch applied, thanks.

-- 
pozdrawiam
Szymon Janc


