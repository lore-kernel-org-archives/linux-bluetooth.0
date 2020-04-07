Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E677C2BA16
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 07:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B98820644
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 07:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="P2EiccST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgDGHOR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:14:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43333 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbgDGHOR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 03:14:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id k28so1500065lfe.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 00:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:organization:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=imYCD2xWoMVaj7Kw27rrHAjZFT8sKAu9DHj/SsA1HOk=;
        b=P2EiccSTeFc6AWgnniUy+ULImwxrAazApq2z2KTH7F8MsyuL9fHyh3+HdtKL+UVQc6
         hUMPF9Yy0Kd4Ls8tepoXB7zrZIxYZxuwuFpRvtqyqe4rcimkBxFtQe5iWdH2VzS9JCYc
         6nXFgTuUXwe0F0PqrzfvXpAWLVlCklULeGVtv7f/DJWf+Fvn5hfIR08FBvPCJnlkD1jK
         nSmyHdEsywo92KGShVkcgbOyOmc7VTDp7bNeWT7VSsJWvIVtq/lhWmiGMPkdntanE9NK
         yPcHX7cAUNWNgA4DuG6yOXCO+HnENI1bPuAj4MS+VxPUhzSdicnn9+WULXhGyqHF//RU
         h0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=imYCD2xWoMVaj7Kw27rrHAjZFT8sKAu9DHj/SsA1HOk=;
        b=Cw+7Kwtf+wWsXDxBy6d52ZQCuSgUeCEGQ3fwD7mDMjJ9UtIiw1vjcsPrG6n3i/Ho0M
         x7S0fVxRk+YiMACKuMsFF2nGvJkOwBvpLQLS335IBXW3aF3Cqi7jrEqC/mMmr6wdzm+V
         s54nt8MOR8cdeqk/QXZtrJ+VoktzuAcFjN9lavzxUgAKsI4XCjOT4V9TCCBlB5d07YW/
         YF8uILa+cAVn4aMlCTSuv3h7sbqOu1BrHT/ijXl2eMRGV/db5YPILXa/fhz2nv2eAjAm
         77dfGjMewWWIByTzA171nfPQJExHfAuaYOpI0v2wKjLqIQJOKZvlBQiQZBmVtFw14wa3
         u/2w==
X-Gm-Message-State: AGi0PuaFMF/OI1pX+s1/uvLjmOmEiIggEwghe4Rz2A32eGKyanARgozR
        CwOgDOMXUCOV5iySeFO/nuP9du6/QlE=
X-Google-Smtp-Source: APiQypI05Kno1T1wf2FvWyGjO4gChXIP0b6/YZZ6pOHp+u50lMljmWNbvOS0UHG+iMZCUKJJrMbB6w==
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr619026lfo.152.1586243654432;
        Tue, 07 Apr 2020 00:14:14 -0700 (PDT)
Received: from ix.localnet (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id p21sm11156527ljg.5.2020.04.07.00.14.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 00:14:13 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gatt: Fix AcquireWrite and AcquireNotify server support
Date:   Tue, 07 Apr 2020 09:14:13 +0200
Message-ID: <2834426.nXdnVRqWta@ix>
Organization: CODECOUP
In-Reply-To: <20200407012906.166736-1-szymon.janc@codecoup.pl>
References: <20200407012906.166736-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday, 7 April 2020 03:29:06 CEST Szymon Janc wrote:
> Register read handler only for notify IO and handle socket
> disconnection in sock_io_read.
> ---
>  src/gatt-database.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 483c84341..92e24e5f7 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -2358,7 +2358,7 @@ static bool sock_io_read(struct io *io, void
> *user_data) ssize_t bytes_read;
> 
>  	bytes_read = read(fd, buf, sizeof(buf));
> -	if (bytes_read < 0)
> +	if (bytes_read <= 0)
>  		return false;
> 
>  	send_notification_to_devices(chrc->service->app->database,
> @@ -2379,8 +2379,6 @@ static struct io *sock_io_new(int fd, void *user_data)
> 
>  	io_set_close_on_destroy(io, true);
> 
> -	io_set_read_handler(io, sock_io_read, user_data, NULL);
> -
>  	io_set_disconnect_handler(io, sock_hup, user_data, NULL);
> 
>  	return io;
> @@ -2537,6 +2535,7 @@ static void acquire_notify_reply(DBusMessage *message,
> void *user_data) DBG("AcquireNotify success: fd %d MTU %u\n", fd, mtu);
> 
>  	chrc->notify_io = sock_io_new(fd, chrc);
> +	io_set_read_handler(chrc->notify_io, sock_io_read, chrc, NULL);
> 
>  	__sync_fetch_and_add(&chrc->ntfy_cnt, 1);

Applied.

-- 
pozdrawiam
Szymon Janc


