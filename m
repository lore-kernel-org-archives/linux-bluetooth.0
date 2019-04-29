Return-Path: <SRS0=fAjn=S7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EB9C004C9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 15:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073EF205ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 15:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV0l7/Db"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfD2PJr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:09:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37428 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfD2PJr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Apr 2019 11:09:47 -0400
Received: by mail-oi1-f193.google.com with SMTP id k6so8576311oic.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2019 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R1QkfhVqGp9HK9Gc4LEj6zs6sL/ELk3UtfFFbhYAPiU=;
        b=iV0l7/DbDyz/K2cT13k/nuGfSv6OpZ7jqf/7N4TIbxIePw9BVDP8gMace72Usu61wh
         NzfWfMlkmIgvFi/w0sZRVbEplDjCrsPmxP/n4Rdic5wfLmLi5sSpmmAj80idsUuE6tBF
         Bw5l2BkqJOTQJNOvwko3XWOjJ37oSjhfj6OEU7fPsFS4xHRWKh6UGEMLyghDQJTSN6S1
         M/IgX9fkVEpbZqfeABptrWzAa6ImH8utmmzj5poMwSw4L/r4puEgZ9P1ozhU+kbdilJw
         iexlcEC9+HAPP2t5HKlzbYeRcONyeHL0zhctFPqQVuUKC+ty9rb0mNAZjDpIi3kp0Oh6
         WM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1QkfhVqGp9HK9Gc4LEj6zs6sL/ELk3UtfFFbhYAPiU=;
        b=hVT+74lBzoS0KblvZ2GZ+N6sD0jEKctim8sgGwieR5Xv6SMtCU3tUb2PHov077nsgM
         VC4iWbkxDZ6nJRV8YoUk5xGecUZpolnkVBYThMlzAAf/wVbbTSNRN0ianOMWd3rqrFQK
         z/TMxT/DoM/bUFPX7/U6m48A0YwWDOs2y437u2lPb0eRmatqIg0LlgJvDqIB1MlZrgHX
         Lkeof1qBIuLzJmeuZxAtzHFG8wd5oxHq2LgH5enm825cj1FMlJ2txVAwbXIMy/0FFwux
         AZ8LM83UeaT/UMMcBmu7w31hiBPQ4P/r/uIQbUycfvEg2lq+st3BimQBKt1X+A/Pv2YC
         ktDQ==
X-Gm-Message-State: APjAAAXb4hHOpifrKVQJp+PKEbANP24lvCQ8BsDAHiSx+2W3ulrNAHQp
        N3QPZOOK2YmgG0S3CrAN3DkvZuYeC+cSWeHoeec=
X-Google-Smtp-Source: APXvYqznxKqtjzxhZxjde1JPWwCpQ5O/38N8aLzpj60D/aDJ5FFvMzWipM5c48We28f2bsT1aPeT9WjtdZqLjAfTELE=
X-Received: by 2002:aca:d984:: with SMTP id q126mr16923670oig.108.1556550586225;
 Mon, 29 Apr 2019 08:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190429111441.20481-1-troels.d.hoffmeyer@gmail.com> <20190429111441.20481-2-troels.d.hoffmeyer@gmail.com>
In-Reply-To: <20190429111441.20481-2-troels.d.hoffmeyer@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 29 Apr 2019 18:09:33 +0300
Message-ID: <CABBYNZKUR30FQXTpRhkkDC+XivCthrLacSAtkCCBKT9GXynQQg@mail.gmail.com>
Subject: Re: [PATCH Bluez 1/1] advertising: Timeout of 0 should not fire a
 callback Setting a timeout of 0 on an advertisement should let the
 advertisement run forever. The client was released immediately after,
 although the advertisement was still in the air.
To:     Troels Dalsgaard Hoffmeyer <troels.d.hoffmeyer@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Troels,

On Mon, Apr 29, 2019 at 2:16 PM Troels Dalsgaard Hoffmeyer
<troels.d.hoffmeyer@gmail.com> wrote:
>

Please rework the commit message, the subject should be rather short
and you should put some stuff in the description.

> ---
>  src/advertising.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 2f187edcf..26e24ee01 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -587,8 +587,10 @@ static bool parse_timeout(DBusMessageIter *iter,
>         if (client->to_id)
>                 g_source_remove(client->to_id);
>
> -       client->to_id = g_timeout_add_seconds(client->timeout, client_timeout,
> -                                                               client);
> +       if(client->timeout > 0) {
> +               client->to_id = g_timeout_add_seconds(client->timeout, client_timeout,
> +                                                                                                                                               client);
> +       }
>
>         return true;
>  }

While I do agree we should handle timeout 0 as no timeout the reason
you are hitting this in the first place is a misused of the API where
you are setting a Timeout parameter when there shouldn't be one.

-- 
Luiz Augusto von Dentz
