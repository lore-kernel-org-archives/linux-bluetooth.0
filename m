Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A38C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Mar 2021 19:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F2E6522D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Mar 2021 19:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhCITak (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Mar 2021 14:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCITab (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Mar 2021 14:30:31 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6234FC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Mar 2021 11:30:31 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so5551877pjc.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Mar 2021 11:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpDWDL8r5qJP8JjgudgrI66SUIg4IDGie1h7LRo5bSA=;
        b=WQyWmolNOsJ0cipKigEquVaMLL+lOis+SgoCNNJH3iZWHrGlNi6OVDoEwT3WbSKtSd
         SLdYn9AF6Bj0B7tswC1L5CnqmcorLgJCDAWHSep5X5xvqEJA80iLL03gAZ/MTJv57RRr
         m47pa9IfNsRTenN+xvuFSeyplIPUYMkGyTF+CJACDSmIe3V4R9E8bXDQHxUc9wDv9PQv
         LU+ST52htU1FB/R6fbE1+L4096bk6kFbfjIzAVNr15JhAJ/mLMLtjBTempplWcrJQzk+
         WOXPyNU78JdBwNNcNpecLkyA0yoz99LBzZHgumgZTMC2kfzHDoQfR2nOVyOo1dlQ/MOj
         0ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpDWDL8r5qJP8JjgudgrI66SUIg4IDGie1h7LRo5bSA=;
        b=LF39fCc/SvObK+13JrgdBWsbk4W4ibDGx4tTTqYUViXOp5Osm0+2m+y/wzm1aGSXXd
         oaXndAjYFH/Cp11Xhf0OpLD42lYnXn54l8jVFSvOLVuqfswBHVerAkKDdP2ypCivwZE4
         D+DIo9V1jpsWEwR3qLFFKKVaXdXpZz8f3p4AfAOHs6i7llM91tjFm3w7a+PPMCQYtW3T
         I0ImDiRs4h58U+kJ8umO2PYthSJrZbUnpA0GHH5H3iJGUwzbBOIfVM/7vyEZXl0eFPgx
         vRPLxkAS3MH61Q3tjPW1PJarSFjngNXE5h3FWzLH4RNnxfrwcSzVidqN57emOz+7jW2H
         1slg==
X-Gm-Message-State: AOAM532qPg1G9KfLK1apuJ2hzzFKR3eJJGolIJdnzwnnbilNBPcZ6dLX
        lBWbmmbivs/BLZ/tomYsQXjgp8HvMnEASX449dw=
X-Google-Smtp-Source: ABdhPJy2nx9zVCG93Q7caUtpM4mKkmEQ1nEJ485eIFC97ZrxsN1+J2KFtVjHoGhfut4UAcb1V1RhBQn11KMHpRqy1vE=
X-Received: by 2002:a17:902:9f96:b029:e5:c28a:103a with SMTP id
 g22-20020a1709029f96b02900e5c28a103amr27390488plq.8.1615318230914; Tue, 09
 Mar 2021 11:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20210309183911.514959-1-luiz.dentz@gmail.com>
In-Reply-To: <20210309183911.514959-1-luiz.dentz@gmail.com>
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
Date:   Tue, 9 Mar 2021 21:30:19 +0200
Message-ID: <CAMCGoNxk66fYNgwsHKHV=_GFW9btQMnK9xe9B6tR+VW9pwgwNA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: SMP: Fail if remote and local public keys are identical
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ti 9. maalisk. 2021 klo 20.42 Luiz Augusto von Dentz
(luiz.dentz@gmail.com) kirjoitti:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This fails the pairing procedure when both remote and local non-debug
> public keys are identical.

Would you mind elaborating why we need to disallow identical public keys?
Do you have some specific attack scenario in your mind?

>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/smp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index b0c1ee110eff..9e7e3655e4ec 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -2732,6 +2732,15 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
>         if (skb->len < sizeof(*key))
>                 return SMP_INVALID_PARAMS;
>
> +       /* Check if remote and local public keys are the same and debug key is
> +        * not in use.
> +        */
> +       if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
> +           !memcmp(key, smp->local_pk, 64)) {
> +               BT_ERR("Remote and local public keys are identical");
> +               return SMP_UNSPECIFIED;
> +       }
> +
>         memcpy(smp->remote_pk, key, 64);
>
>         if (test_bit(SMP_FLAG_REMOTE_OOB, &smp->flags)) {
> --
> 2.29.2
>

Best regards,
Matias Karhumaa
