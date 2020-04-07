Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D688DC2BA16
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 07:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CAF2064A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 07:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="skzj3FkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgDGHOg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:14:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39408 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbgDGHOg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 03:14:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id m2so1518753lfo.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 00:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKqWawCu+4Bmqse6zM12jvmVuhhKmztVWrtk3GLWYh4=;
        b=skzj3FkLPUxu1vzRSSyHKjIaFcMT1xnJzyTOIL6t8Z0tp2jG0Q9sjonlzjshL+NYJF
         gkE7hzkwxhzvsZ1LZRL8ElHZd6jErR6DQVoIuvt9ks6QDQ1pG5hQoMtMl6G5Km8O1QEB
         LN8VwXtpDxGz6Li61u7uyYTF7rfgvWb3LKBgd8UZO2pEWzJwPXOzAyhwb0iq8ZohNhjJ
         jUyboXlpLxk0kP/1L0iCt4gqYzb5ts0w/M1xvR83IqpveRBNx/otet7tiXhmv90MDcOl
         d9fr1anHW3yTxNx4L4K9oR1+gsq59ofPkMXgJBv0gXhZV3x7IRuLuJ/6O7ESypSHU4eO
         Nj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iKqWawCu+4Bmqse6zM12jvmVuhhKmztVWrtk3GLWYh4=;
        b=Ds/TKQOtIBOX56NdcJfN6aR9v7BOg+51rn3MR+cNkaIDWE8Fh5+o7V2FV4tDQoQixH
         Ok9Q0hdr3gOxa2RLUzTEVRD4rsqYHmNqLVIEYlxbkcp5t46jyeBFjfmvr6Zj1f72HRBO
         eg0QJdRGk9708VSZyo/uOpDkolzWbF4h7oOCE2umzJKg5FaW7zqSkCGssLqXs+wHX5gh
         TqloKDO0khkVDSVLI57RS+V+GTtLLdIkdsOoIorowBMuzEhI2HL8AkLBfIWWFGMxhEHO
         GNhgRBTrnQLFXHRw6HBcvIt8/U133IDLBvu0IOa8+t5xd42qzkgwhCJfZy295yCR3Y5N
         ewoA==
X-Gm-Message-State: AGi0PuaMiEK3eXypxN8Wm0giZi/yQNqJ3wNB8UKhbZ8ohBfgmV7PTUpx
        73xiWfmbbD2BAjz9+f7tSFqmR/sEhRE=
X-Google-Smtp-Source: APiQypKtjc9seTv9VrGgD7INGjvpeBycALBJNIBJRdRaOIJm3941HNd//+V1X+X8iyzg3MzLY6CHIA==
X-Received: by 2002:ac2:5559:: with SMTP id l25mr624438lfk.55.1586243674054;
        Tue, 07 Apr 2020 00:14:34 -0700 (PDT)
Received: from ix.localnet (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id 64sm5734864lfh.32.2020.04.07.00.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 00:14:33 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] gatt: Fix not sending any data when server supports AcquireWrite
Date:   Tue, 07 Apr 2020 09:14:32 +0200
Message-ID: <4198260.fHHya7ajGy@ix>
Organization: CODECOUP
In-Reply-To: <20200406211903.12549-1-luiz.dentz@gmail.com>
References: <20200406211903.12549-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Monday, 6 April 2020 23:19:03 CEST Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> msg.msg_iovlen should be set to 1 to forward the data received over the
> file descriptor.
> ---
>  src/gatt-database.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 483c84341..db67dd3f8 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -2396,6 +2396,7 @@ static int sock_io_send(struct io *io, const void
> *data, size_t len)
> 
>  	memset(&msg, 0, sizeof(msg));
>  	msg.msg_iov = &iov;
> +	msg.msg_iovlen = 1;
> 
>  	return sendmsg(io_get_fd(io), &msg, MSG_NOSIGNAL);
>  }

Applied, thanks.

-- 
pozdrawiam
Szymon Janc


