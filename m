Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DAEC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 20:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC0760FE8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 20:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhJUUeC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJUUd7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 16:33:59 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE6EC061764
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 13:31:43 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id j8so3605510uak.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lmfqr5Fu9jmDg0cbF4n5MijwhyOGp/KbEHYGLfPZi48=;
        b=Yu63CBwQkn/t4QFCPndNvWS2GL2qLjDizVKBUmpaBZEo1VFR+DRjIx9Fdijeb255sK
         CIQFTJz9kl4mc/bJmd6N6DeqnZ+QxFxDQM5pFAMQOV0P/db1I8uZEvqRoq9y4LKyagOw
         18WlxefJyMQUIbi1s6Ca4iEw1CLwvYSRx1sePPgMvWqrNGY9Fod8s0j+ee6uxPPmUxz2
         R8C98BUgOW90jFtK409exO8OJ/CR3FpgdCxiu0LhdomyyVM3ZWeNuZQc4bWWwqBv1Ib+
         WtXJHuiCT0Jeynd0Gl6eFIXhk4GROjOV/UBnLvhdMeB5x4Cx0Vl3FUqPEo8hdYZDyRLd
         jPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lmfqr5Fu9jmDg0cbF4n5MijwhyOGp/KbEHYGLfPZi48=;
        b=NAlowx38CSpNA6znyUtGl41iqD2+nQuCpxMot2c3UV+F+P3diUp+Hl7nzDQdayChPg
         4aKV44soocnASO0ZJ+Jm8LcDeey7mBfYaZNRkOU2y6STY3OhDE0d2Itj+9GBzgF/KNzA
         5a5PNcZ406MHSqIUCmMZnpbJMT4Uq9QoxwEBgNY1CQIb4UH297BhTbSEhVK9LiACQbgg
         LFhALfSfxKhTAwMaZz44nYirTjcy6NRDICvrmP+eDWXFJa15Qf+kAQcUvP7bpr92635W
         qYSPzW9i4yz7E7tksdqF6YWY/M6Xi5LiVmFcbYEeGm8yEW2WCKfvZgywN7GLutLyG1z4
         i0nA==
X-Gm-Message-State: AOAM5314cZvaFbWdY6FmC4zxC1dxJnOxNjPTxkUOo8Wk9x1TpUlzVerq
        nnbI4YXeT+RexOXkEkns9oFy8iAD0OyIiQIlJXi8OG3s
X-Google-Smtp-Source: ABdhPJwouCFR1IKVObZQDp2lBLPSJC8I+nDR//IV/opzixdwmJxXVLAR0AhcvDYzacgJtoO7bLWoMhYNDOvbnQNDJ9E=
X-Received: by 2002:a67:d81a:: with SMTP id e26mr9510403vsj.23.1634848302198;
 Thu, 21 Oct 2021 13:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210924172910.Bluez.1.I9b71a5f022d2b7197de347c7afa6005bd1d21b5b@changeid>
In-Reply-To: <20210924172910.Bluez.1.I9b71a5f022d2b7197de347c7afa6005bd1d21b5b@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 Oct 2021 13:31:31 -0700
Message-ID: <CABBYNZLuRBaBN3PzSucuzzPzYxZfD7LUN9CmgkQ_LjHe1B9kxA@mail.gmail.com>
Subject: Re: [Bluez PATCH] tools/hcitool: Fix the descriptions of leal* commands
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Fri, Sep 24, 2021 at 2:29 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> The descriptions of leal* commands are copied from lewl* commands.
> However they should use "accept list" instead.
> ---
>
>  tools/hcitool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/hcitool.c b/tools/hcitool.c
> index b6f4a4e665..639ee6a511 100644
> --- a/tools/hcitool.c
> +++ b/tools/hcitool.c
> @@ -3400,10 +3400,10 @@ static struct {
>         { "clock",    cmd_clock,   "Read local or remote clock"           },
>         { "lescan",   cmd_lescan,  "Start LE scan"                        },
>         { "leinfo",   cmd_leinfo,  "Get LE remote information"            },
> -       { "lealadd",  cmd_lealadd, "Add device to LE White List"          },
> -       { "lealrm",   cmd_lealrm,  "Remove device from LE White List"     },
> -       { "lealsz",   cmd_lealsz,  "Read size of LE White List"           },
> -       { "lealclr",  cmd_lealclr, "Clear LE White List"                  },
> +       { "lealadd",  cmd_lealadd, "Add device to LE Accept List"         },
> +       { "lealrm",   cmd_lealrm,  "Remove device from LE Accept List"    },
> +       { "lealsz",   cmd_lealsz,  "Read size of LE Accept List"          },
> +       { "lealclr",  cmd_lealclr, "Clear LE Accept List"                 },
>         { "lewladd",  cmd_lealadd, "Deprecated. Use lealadd instead."     },
>         { "lewlrm",   cmd_lealrm,  "Deprecated. Use lealrm instead."      },
>         { "lewlsz",   cmd_lealsz,  "Deprecated. Use lealsz instead."      },
> --
> 2.33.0.685.g46640cef36-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
