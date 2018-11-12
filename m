Return-Path: <SRS0=dtqE=NX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BECC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 21:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7935224E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 21:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bms8byNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7935224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbeKMHfO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:35:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39407 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeKMHfI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Nov 2018 02:35:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so4638571pgv.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Nov 2018 13:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iHOW629F4mpFjxsqJaP1AmqGYv4DQ5FykhLL32YDDFU=;
        b=Bms8byNL1W3LRHNXS/m8JFW3vARD26dLgtzCXLG2aLl/MA7TIQhT0zKuwPw8ZanXnj
         YleB0ppvn1S5Ahr6qEbjbXqx7zD6RaYKrBhdlUzsq2CkWJKLV19P0qF5UD7kYziOKPFQ
         mFABzSuSNMFbag0rS+WZv53NzKqzGo8L4pIkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iHOW629F4mpFjxsqJaP1AmqGYv4DQ5FykhLL32YDDFU=;
        b=gMf+7HqwVYfJgOzCncliWauRC234A8QggEnWWru4Xzlon4vVuCylFzsXKXFfq7/ET2
         jbQc9kVFIuPIp4Vfpsas1gzqKP/fPsM29UpqUtKVJUvZSzGXTfO4w+4FZj7+lFFifupg
         LeLcWh3NV170GcNibfvBxuFMzcTN01tcTA0Kc0Y04o+vlj3PqvMgv4TFnvOgPkaNGPkD
         GZYEC7KzoDSmBkQdoGHnA8yJUYJUZDq4lgIIHeM5dp/MXPYoPvK/XBJFkRIrcFdlDyfF
         4ke4mWmCdOVJUgNrOThf9Mb3HU0onNKuldoOtz69DWyVcH/PKjghYn0ygb/6JFDI6A2z
         1CwA==
X-Gm-Message-State: AGRZ1gLGfrI5Y3IA1CyB1BS2iVL42ilHU/uRQEfY48WB3fI1Gp3Z8ThK
        Uxk2h1GqrHzwyj03qW15y5CowQ==
X-Google-Smtp-Source: AJdET5cx7XhZ3X8NaweHwgl0hJccbOA/PDdix/DAsHbK27KfF/P2zCs//O0QvAY29yFe8Bix5fOp/g==
X-Received: by 2002:a63:3858:: with SMTP id h24mr2243843pgn.300.1542058805183;
        Mon, 12 Nov 2018 13:40:05 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id r124-v6sm26751290pfr.151.2018.11.12.13.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 13:40:04 -0800 (PST)
Date:   Mon, 12 Nov 2018 13:40:03 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dean Jenkins <Dean_Jenkins@mentor.com>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>
Subject: Re: [PATCH] Bluetooth: Fix locking in bt_accept_enqueue() for BH
 context
Message-ID: <20181112214003.GE22824@google.com>
References: <20181015223910.197729-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181015223910.197729-1-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Oct 15, 2018 at 03:39:10PM -0700, Matthias Kaehlcke wrote:
> With commit e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket
> atomically") lock_sock[_nested]() is used to acquire the socket lock
> before manipulating the socket. lock_sock[_nested]() may block, which
> is problematic since bt_accept_enqueue() can be called in bottom half
> context (e.g. from rfcomm_connect_ind()).
> 
> The socket API provides bh_lock_sock[_nested]() to acquire the socket
> lock in bottom half context. Check the context in bt_accept_enqueue()
> and use the appropriate locking mechanism for the context.
> 
> Fixes: e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket atomically")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Not sure if this is the correct solution, it's certainly not elegant and
> checkpatch.pl complains that in_atomic() shouldn't be used outside of
> core kernel code. I'm open to other suggestions :)
> 
>  net/bluetooth/af_bluetooth.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index deacc52d7ff1..0f0540dbb44a 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -159,10 +159,20 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk)
>  	BT_DBG("parent %p, sk %p", parent, sk);
>  
>  	sock_hold(sk);
> -	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
> +
> +	if (in_atomic())
> +		bh_lock_sock_nested(sk);
> +	else
> +		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
> +
>  	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
>  	bt_sk(sk)->parent = parent;
> -	release_sock(sk);
> +
> +	if (in_atomic())
> +		bh_unlock_sock(sk);
> +	else
> +		release_sock(sk);
> +
>  	parent->sk_ack_backlog++;
>  }
>  EXPORT_SYMBOL(bt_accept_enqueue);

Any comments or ideas for a better solutions?

Thanks

Matthias
