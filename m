Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99735C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 18:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E682610A0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 18:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhHSSex (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Aug 2021 14:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhHSSew (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Aug 2021 14:34:52 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFBFC061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 11:34:16 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g26so14167366ybe.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Fk2hz2YJqC2IUuLJnYeM+uvegb2QNN70kFsJKiE+VsY=;
        b=UiroQ3xDnnXZS3ge5EjaKErUeM2ouF2AAbQbx0alNsB2UZgiFntmUBu98b/ZFnUuXJ
         mtKxWRcJxTr42Lb2S3zBwpoahLNDEjXqmoxuofDsh5C6pQr98W2gYjba1fM+V5igsQXm
         hn3HeJwd8wafm/3XqaprNFUh2ES1FyjsrtgOjyUkvmq6VMgs/QFJmSwHbhRZJ1/9UVO9
         tYUZWVAh7XW02WR1SHu6zEgWEg5J4vVaFT6/BzLC0ForO3MSqZ53Jw6FqHi2IymPj3Ll
         E800uVEv6p5gqTtd/6giM+Z9WR/70k6hXHJ2HsI2LliXcbdV61BoE/qrEWB2cWe9cWZl
         53og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Fk2hz2YJqC2IUuLJnYeM+uvegb2QNN70kFsJKiE+VsY=;
        b=WxW+nUmvuurEzEjt3QvGJ+fOPAizVFi4bMbJcaLsJHa2J1lrn3prt5QgKBMLSuJyj2
         6VfkrKJjT4jopy6Sxt3fnpM9EC9LQ2p49wluHflqRC26jdmW3hVKx1iVEhvtGpcVVpE6
         Pe1rKLa952JA3R2H5XGoqYoqQNkPu0ed1bvsaYaMXU7+9WX6ghkWrznuQJ1muvL9NjpQ
         RcdCQJSJxrmIrCoRDx9SBc/06pDH7NwqJfAYK71MqukM445AgrX5QieV8Dlp+gWakvU8
         Ff5DXGX8ntGKQBtuDdsQQIntRHHQXqi/pCBH9oKUqeKzV7w2FSXn7Q5yPreFHswab8kL
         2ZFg==
X-Gm-Message-State: AOAM5308lr19Y0oq/T2LC962EXbVSlGgf65e6jWwUvBE7w4mxxA9wcAV
        bjbPFHzrvvf1WcTDcDNUqKtR3jxYayIv9MFJWchlx8A4
X-Google-Smtp-Source: ABdhPJwCSAsBpAWs8ANvHY3+4MsQz4JsMKiidsQcCQ4AdcBPerbIKivLquOXXN/aYzFDxQEp6PkFYEqb9F9VOnrYI/I=
X-Received: by 2002:a25:9b03:: with SMTP id y3mr19074573ybn.264.1629398055392;
 Thu, 19 Aug 2021 11:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210818230641.168705-1-luiz.dentz@gmail.com>
In-Reply-To: <20210818230641.168705-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 19 Aug 2021 11:34:04 -0700
Message-ID: <CABBYNZKOSH1oXavF9P8fKF_uLqPxy3KvW_XcNx2irvU9kpY1hA@mail.gmail.com>
Subject: Re: [RFC 1/3] btdev: Fix sending terminate advertising event to the
 wrong device
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Aug 18, 2021 at 4:06 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The device where the event should be sent is the same that had created
> not the connection one.
> ---
>  emulator/btdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index 6e1d3c346..cd0cfa45f 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -5118,7 +5118,7 @@ static void ext_adv_term(void *data, void *user_data)
>
>         /* if connectable bit is set the send adv terminate */
>         if (conn && adv->type & 0x01) {
> -               adv_set_terminate(conn->dev, 0x00, adv->handle, conn->handle,
> +               adv_set_terminate(adv->dev, 0x00, adv->handle, conn->handle,
>                                                                         0x00);
>                 le_ext_adv_free(adv);
>         }
> --
> 2.31.1
>

Pushed.

-- 
Luiz Augusto von Dentz
