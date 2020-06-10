Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E97CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5668207ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn4STn4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgFJUZk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgFJUZk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 16:25:40 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC60AC03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:25:39 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id e12so781500oou.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4cod7zvxfie8YrihbE5IwK1b0nHHjh7+HOCJNBsTjwA=;
        b=Yn4STn4CHg+RPCzQCY60FFxqgzHeA7IUevCicJK/r99kS0BFMxx3jUva7p3pyuqo8l
         rnW2q4fH3jeqxh58UjrpmbhjF4bJsVczBfmgFm1/ScuiDH/NbNKnX+wG3cAoFbC/6ixt
         02T78k0hxs1yEzbj72IUYkgWgUmozNhasSJjRs15K9D/xXd3H7LS9XyrNQEOZkJ+ajWv
         2YHHXm9HtdhklbzMxWIKYMpwF8NYERzICXfrOtIcCyaZJAjijnR6ew3AcBPqTieXyE6A
         LhFEVHvJVJk6SSN5lXWwvz8bJwEHno5H4LMlYb+Hwj+avWhSFFV8f0TWA0SyaP21UcLz
         Mdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4cod7zvxfie8YrihbE5IwK1b0nHHjh7+HOCJNBsTjwA=;
        b=F+t+V2zefaSb61Td8Te4oEHRO2/wHjT89+O6+Ry1KuBNi+8Fa9DtD7/mm8BN8Dz8QN
         a9I+Vf30OF8uSnXkZKFqMmAOadpiZzoSR3M0jwL+YMG5y4TckUjVvLDLJ9OtuU0ohhe8
         z6Nlz0I9MKBvAsjMyWCkDMDxx6YEmMlLJtDulsZJiIoH6Hxb+cwgYjnLCLRJbZEhi7Dr
         ofEsVogyFfm1e4YgxZOc0LAo2OksWXAHNgS1HO5hcspoUOkS+jH2gUwSXR4Yow7UmUj6
         rSdxfRqLBWKa2VXUN5wwsTwUzFxXvYNMp6zbV+TOYPynAw71uq9XDq1c9zUqaA5g7APt
         Ar2g==
X-Gm-Message-State: AOAM533ykkYEOnQNjOPGw7xne+mOeC0KsqE3XBXEAOzCYoXPOUgQNXWS
        xIW5bbsu5LlRNhRIa5/xlodtrxfvFQ0oh/VG/i6o2Q==
X-Google-Smtp-Source: ABdhPJyWW53b97L56E4QYsL6VWGn355CQ43EpyvUJxK/08eLdgpYS7u/7rJUf6a08lFllnxOoalcj3wVUDuJCS/dShk=
X-Received: by 2002:a4a:3811:: with SMTP id c17mr3876650ooa.91.1591820738893;
 Wed, 10 Jun 2020 13:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200608220153.880790-1-luiz.dentz@gmail.com>
In-Reply-To: <20200608220153.880790-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Jun 2020 13:25:23 -0700
Message-ID: <CABBYNZKHeyqEZqbDdrs3SWqZJakLoUmM02_VW6xFHP0qqwqf5A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] adapter: Do not remove client watch directly if
 discovery fails
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Jun 8, 2020 at 3:01 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Client watch is used for both discovery and it filters so in case the
> client has set the later the watch shall be perserved.
> ---
>  src/adapter.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 76acfea70..bf51b120b 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1651,7 +1651,6 @@ fail:
>         if (client->msg) {
>                 reply = btd_error_busy(client->msg);
>                 g_dbus_send_message(dbus_conn, reply);
> -               g_dbus_remove_watch(dbus_conn, client->watch);
>                 discovery_remove(client, false);
>                 return;
>         }
> --
> 2.25.3
>

Pushed.

-- 
Luiz Augusto von Dentz
