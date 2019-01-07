Return-Path: <SRS0=SaLm=PP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C44C43387
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jan 2019 18:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087B8206BB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jan 2019 18:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HSY7EReK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfAGSvL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:51:11 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41810 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfAGSuw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Jan 2019 13:50:52 -0500
Received: by mail-vs1-f67.google.com with SMTP id t17so888083vsc.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jan 2019 10:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZHDCGPs4z3y7ituqpfrLyMWFnn+906H7KD1VFwaE18=;
        b=HSY7EReKFJ3rs89PzbLD5kgnqLvq/YhfkvltohmFyZ+PFoOnCwzWQVwZV+sLvQqD3k
         J+UlTwiNC8tMvwGaw4j/4T3oeoatGqYjQSbS+N0hXs/rss8+ah7fWcOQLLsm+EJfvt+T
         0616M31tj+4Rz6pE3ZWRUJ/50qyind8yDu0EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZHDCGPs4z3y7ituqpfrLyMWFnn+906H7KD1VFwaE18=;
        b=rFhY5CcqFk/S0YQsnXQz0DHrgl7AIgA558WuPApdjg0sO8TDj+qRSnTYsXZti0PgQH
         QNUYO/N7EuKT20k26Hzwa/Ej1DGSahjvRF08zMKht1tZ7dww8JQvywvRuMDnVeSFFlC3
         xWFdvKWahE6iY47mGWbJ3wqi+4fLxpCN9GNMNTn01mDw1IWLznFK+nHOwKXwgfVWqoqr
         Pvwkn3mYF927sxLitCROoLzLO90kX9t71Bh9fOxolOpjc+8vyhCvYsfR9w17M8+5y1ho
         MdfJiLMA9mgV4S4tiuKSOSIlg5eqfwQHZk+D15p/e8+sl6CTBnM5Xz9J8+ByrrnoeGgk
         8Rjw==
X-Gm-Message-State: AA+aEWa+DSOn7c0/l1yzUjmrJCIUHFxacgvzpJ22ojwJYxaTsdWwY5hu
        zxRZV0uhXaVPyK9RxJD4ygJAB4yDF1E=
X-Google-Smtp-Source: AFSGD/UXYG8tM7rYkicRHQcBllzmiingvyj2Smi/iGolgv8ZufDuxDv6bTIxv5k9PhhbIjLaGsBp/w==
X-Received: by 2002:a67:f60e:: with SMTP id k14mr26135194vso.71.1546887051995;
        Mon, 07 Jan 2019 10:50:51 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a187sm37501623vkf.26.2019.01.07.10.50.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:50:50 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id z11so462492uaa.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jan 2019 10:50:50 -0800 (PST)
X-Received: by 2002:ab0:45d4:: with SMTP id u78mr22969857uau.52.1546887050200;
 Mon, 07 Jan 2019 10:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20190103001120.177784-1-mka@chromium.org>
In-Reply-To: <20190103001120.177784-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Jan 2019 10:50:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wdgyh6pW2mZiq6qHR=mxisf4ygSS6yf23P_qw4tAGCwg@mail.gmail.com>
Message-ID: <CAD=FV=Wdgyh6pW2mZiq6qHR=mxisf4ygSS6yf23P_qw4tAGCwg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix locking in bt_accept_enqueue() for BH context
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dean Jenkins <Dean_Jenkins@mentor.com>,
        linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Dmitry Grinberg <dmitrygr@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jan 2, 2019 at 4:11 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> With commit e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket
> atomically") lock_sock[_nested]() is used to acquire the socket lock
> before manipulating the socket. lock_sock[_nested]() may block, which
> is problematic since bt_accept_enqueue() can be called in bottom half
> context (e.g. from rfcomm_connect_ind()):
>
> [<ffffff80080d81ec>] __might_sleep+0x4c/0x80
> [<ffffff800876c7b0>] lock_sock_nested+0x24/0x58
> [<ffffff8000d7c27c>] bt_accept_enqueue+0x48/0xd4 [bluetooth]
> [<ffffff8000e67d8c>] rfcomm_connect_ind+0x190/0x218 [rfcomm]
>
> Add a parameter to bt_accept_enqueue() to indicate whether the
> function is called from BH context, and acquire the socket lock
> with bh_lock_sock_nested() if that's the case.
>
> Also adapt all callers of bt_accept_enqueue() to pass the new
> parameter:
>
> - l2cap_sock_new_connection_cb()
>   - uses lock_sock() to lock the parent socket => process context
>
> - rfcomm_connect_ind()
>   - acquires the parent socket lock with bh_lock_sock() => BH
>     context
>
> - __sco_chan_add()
>   - called from sco_chan_add(), which is called from sco_connect().
>     parent is NULL, hence bt_accept_enqueue() isn't called in this
>     code path and we can ignore it
>   - also called from sco_conn_ready(). uses bh_lock_sock() to acquire
>     the parent lock => BH context
>
> Fixes: e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket atomically")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - use parameter in bt_accept_enqueue() to decide which lock to
>   acquire and adapt all callers
> - updated commit message
> ---
>  include/net/bluetooth/bluetooth.h |  2 +-
>  net/bluetooth/af_bluetooth.c      | 16 +++++++++++++---
>  net/bluetooth/l2cap_sock.c        |  2 +-
>  net/bluetooth/rfcomm/sock.c       |  2 +-
>  net/bluetooth/sco.c               |  2 +-
>  5 files changed, 17 insertions(+), 7 deletions(-)

This looks nice to me, thanks!

Cc: stable@vger.kernel.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>
