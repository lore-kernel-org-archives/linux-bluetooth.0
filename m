Return-Path: <SRS0=PQ2f=6Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55769C47255
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 May 2020 13:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298D4206DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 May 2020 13:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="xj7FHtp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgEKN3L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 May 2020 09:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbgEKN3L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 May 2020 09:29:11 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12585C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2020 06:29:10 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a4so7495697lfh.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2020 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F3PrhpusTFa2IxB1+2ym5YG5U8+6riyJNWdQH7sYGt0=;
        b=xj7FHtp99SXyYxP7cQQqa5yPaVuESMhXfNHNr5n34PQjJJTP57f6zwirB2uvlnp6Az
         liTbc/j5DXYDB7ziju9FxNLDUaeHU5xzZ89xcl0uHYMnycwduzBM9WVteek0sUp+O+3C
         xDCui13T6TCSYyi76XsG2kBB2jh3ngCle7pA1fYa3V6vDGe6n7FdYJnsvSsHGVGh5Qws
         hEkrZfL+fmPafCX2WD4Ib6l46m8OtpTZApVZscZ2znawSs8WhY/Rru8Qqy79jc+dpqEZ
         ebiACDCRu5H74CZ0Dy1b97xwrOhq0mgzPgP0bQoGKT6uzJm45DNt8zPAYWeBTnc9UuGD
         XYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=F3PrhpusTFa2IxB1+2ym5YG5U8+6riyJNWdQH7sYGt0=;
        b=SxsO1pQkop8sQiFxk5HO2hxIJjqJ8c0Yn5OgbgHXvxxpfBE27tmuwDljKbJcjCB9dy
         Rnk6hww7OnYdOQNzP07WUdGX+75sjQtzIr07vIR7cI/dRb/L7TUTlLa+y44A8Y66XfgJ
         ig04jdGoGPY2iOFmnjnU9JPAJdKWDQvDNFKqZduNuKaSO7ZQrqOp3NQFXX1Sdz3mf8jz
         gO/6cfxtKxNhgyVN0xagZ9sGFEsGqrO8TYmC0h96pIb7ApjOe6m0N++aPVkKkpIsYuum
         wES3cmp+M2ux5Nr8xbCwRjPfiUYdyxhWOw/ViTfBF3SUOidmrVRrOYO8AlLBhjPyQo5f
         IfpQ==
X-Gm-Message-State: AOAM532XTRdeaB6brsNyS/OH94giI5F3Jq9YGpEHyH2NyUfkwOuLA2NP
        28vfUdnoo7XI1w9YOi+l1dYicIvL9v4=
X-Google-Smtp-Source: ABdhPJyiOAEyfuME017qmM4KQja+1WX5+Yblvh8jKYJIDgcySVzeSrfijWl7ToEGyBeQKK22jnGYag==
X-Received: by 2002:ac2:563b:: with SMTP id b27mr11227403lff.149.1589203748161;
        Mon, 11 May 2020 06:29:08 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id s4sm10923583lfs.30.2020.05.11.06.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:29:06 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org,
        Mariusz Skamra <mariusz.skamra@codecoup.pl>
Cc:     Mariusz Skamra <mariusz.skamra@codecoup.pl>
Subject: Re: [PATCH BlueZ] client: Update write callbacks with invalid offset error handlers
Date:   Mon, 11 May 2020 15:29:04 +0200
Message-ID: <2528440.mvXUDI8C0e@ix>
Organization: CODECOUP
In-Reply-To: <20200505082901.258762-1-mariusz.skamra@codecoup.pl>
References: <20200505082901.258762-1-mariusz.skamra@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mariusz,

On Tuesday, 5 May 2020 10:29:01 CEST Mariusz Skamra wrote:
> This patch adds invalid offset handlers to write callbacks of attributes.
> ---
>  client/gatt.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/client/gatt.c b/client/gatt.c
> index 416eda953..5713f8343 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -2141,6 +2141,12 @@ static void authorize_write_response(const char
> *input, void *user_data) goto error;
>  	}
> 
> +	if (aad->offset > chrc->value_len) {
> +		err = "org.bluez.Error.InvalidOffset";
> +
> +		goto error;
> +	}
> +
>  	/* Authorization check of prepare writes */
>  	if (prep_authorize) {
>  		reply = g_dbus_create_reply(pending_message, 
DBUS_TYPE_INVALID);
> @@ -2272,6 +2278,11 @@ static DBusMessage *chrc_write_value(DBusConnection
> *conn, DBusMessage *msg, return NULL;
>  	}
> 
> +	if (offset > chrc->value_len)
> +		return g_dbus_create_error(msg,
> +				"org.bluez.Error.InvalidOffset", 
NULL);
> +
> +
>  	/* Authorization check of prepare writes */
>  	if (prep_authorize)
>  		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> @@ -2683,6 +2694,10 @@ static DBusMessage *desc_write_value(DBusConnection
> *conn, DBusMessage *msg, return g_dbus_create_error(msg,
>  				"org.bluez.Error.InvalidArguments", 
NULL);
> 
> +	if (offset > desc->value_len)
> +		return g_dbus_create_error(msg,
> +				"org.bluez.Error.InvalidOffset", 
NULL);
> +
>  	if (write_value(&desc->value_len, &desc->value, value,
>  					value_len, offset, desc-
>max_val_len))
>  		return g_dbus_create_error(msg,

Applied, thanks.

-- 
pozdrawiam
Szymon Janc


