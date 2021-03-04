Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7B7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 18:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9329464F67
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 18:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhCDShE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 13:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhCDSgl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 13:36:41 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AE0C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 10:36:01 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id t16so8696774ott.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 10:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgR/zcGMwEVaj8fUoO8R13iq5EDKk+Gn14fF3lKjDtI=;
        b=h0m87K0Px7DNqZfXbFf80KjbBGzjjH8j3rzW7OO35fDeaMTJNMKmK6f7VvciSse/f5
         mnyxv7KXAmElwWE1B85KZt5xlvSMdV4zJNmOY6cVPpgdTg+o+gNOZy/GLVp/0oF3V2g5
         Ginqx22aMyxyFuorJyxgaQKKE0GSGkYGYs9VxPmP+TpmnR4M6QDMq6XD4c7F/q+qegiI
         i6btwvETgROfSqMARG6ZrMjmvyXi5aeip2DmmpDu4pDPlzmODGkikO3G6z9QjhKTaUt6
         zW05ouffPIViYdSaXOhMJ+1kP39+slyb62/CpSFBj4cMs7hzJ9zoiQwvGReO8tgppI2Y
         BNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgR/zcGMwEVaj8fUoO8R13iq5EDKk+Gn14fF3lKjDtI=;
        b=eVkyahKVNB3R1150OFgitjuxcj3gHn24hLz3yPzBx1lhUm1XWG7utrSA8rXeEaexI5
         czwRop8ikP8SbD26aCI3pi4Qu+dqXqo8OjmlIYRB5hN3LB5Qy3ErnINzoVRxoZfQ0M88
         OvmQeV3aTDy+fyy7NoyvlAGD7wdbpXiNaZeDqYJE/vf/8k4dQ5/+z3OaqU5De1FNd2FE
         2dMN7P0p0CNXFuL5aetcR4mQ+bez90KoII0y+1dTpuIjjK//xn7iFZ2/7BSjxTJV/ucB
         q0DnT6wBEB4aKZt7PEiumfljlyWZYK5WsG8Vwxg9jmjFoQ9yKjREhaA75kTiCOS9VYBN
         zQ7w==
X-Gm-Message-State: AOAM530Ok8KGd62cqwPRF5zAWwcFSp4f/G7nIYGqf8sH/Op+r+pPband
        xdU7t3b5xhYfOXAu/HweCWfPTHPMlOG3FTwtlusLf+x6Lvw=
X-Google-Smtp-Source: ABdhPJyjwALw0wIcADC3ePTWWC0DjdnQFrrhfYA/IXGCgcuQLZ4aqLBEM32w132Qpb55P6xQkMwFvkegIG0ph5l+xBM=
X-Received: by 2002:a9d:7b44:: with SMTP id f4mr4789863oto.240.1614882960665;
 Thu, 04 Mar 2021 10:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20210304124851.219154-1-hadess@hadess.net>
In-Reply-To: <20210304124851.219154-1-hadess@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Mar 2021 10:35:49 -0800
Message-ID: <CABBYNZ+yY6=WsFhA45fy2Tr33sLq0hgw7zJ3L15o3E7SQop84A@mail.gmail.com>
Subject: Re: [PATCH 1/3] build: Add warnings for non-literal strings
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Thu, Mar 4, 2021 at 9:21 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> ---
>  acinclude.m4 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/acinclude.m4 b/acinclude.m4
> index 529848357..6ae34b8ae 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -21,7 +21,7 @@ AC_DEFUN([COMPILER_FLAGS], [
>                 with_cflags="$with_cflags -Wredundant-decls"
>                 with_cflags="$with_cflags -Wcast-align"
>                 with_cflags="$with_cflags -Wswitch-enum"
> -               with_cflags="$with_cflags -Wformat -Wformat-security"
> +               with_cflags="$with_cflags -Wformat -Wformat-security -Wformat-nonliteral"

Does it actually have any benefit of having the format as always
string literal? I'm not really a big fan of using pragmas.

>                 with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
>                 with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
>                 with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_32"
> --
> 2.29.2
>


-- 
Luiz Augusto von Dentz
