Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5385C28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 22:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbiHVWzT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiHVWzQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 18:55:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A9154CB8
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:55:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z6so17294985lfu.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wyn4yL3+v1cpJ9zWPsCJf33Bou9D3gKSFGHzDQH0GAg=;
        b=Xl+sXzgD9tm+IwmLEFb/A5mnDDtU5tWMZ+li6MYE6SavxqiqThkeqRC0mmPu8L3RhA
         ehXRfSGjmH26dtUU8a3rUq+HKA2zX1MPQvXUdk85YnTOXPVSvw2rme8HHprkYwWHPXFn
         /IzRtgPkHYYVyfhCr8ajwPhe2qb+G6mVYPRaPhhn5+W0YTRGkb48Owkr4ddRttHpFlNa
         WKXqh97eZk+8DCbJKv+Dwa74k7T3XM3mKVHRgHAidOE099+JHmhSGrTTwdp8o1GWq/rQ
         fAMWSwoDYZ925d+7A3hWLHIJ5BbsIcUeUBCda7+GTuPEBrzI+tzR5ujyAKgRn/rQsKXN
         oMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wyn4yL3+v1cpJ9zWPsCJf33Bou9D3gKSFGHzDQH0GAg=;
        b=AKcO3vYaO70pSqwCBa0JDaS7WpcGLy7+Z/l4dapDjNt5Fyfia4rFkEd7PsxXW5dBA7
         kVVLn3YL7AvIIpvvOifFhQNmqP+xIfcm0/O+XgRSdBBg1HytKm+F91cZrr5oRugm7f5R
         O/pxm1VnEVRgc1oXH40wlrxLq5d+iQF6FNwckE6Yu9SSVZO6Pdk+1CV5bNLoS4zCV3Jq
         8yTYtX+iMmnZWqYR6B8I9A5zoURn1XKSYG36Zfo9FC0LGGSCBWueY+6Z7wDs6T4M1NsG
         jaP1nFEW0Zea9UVFuBsO61TwmOHcCQtfE68ET4PG72y5tFQxi8RLvyHI2ArJgCgOOorw
         bmPQ==
X-Gm-Message-State: ACgBeo1y31EtzGyBst5h695KMYDPPtMIijh4KEmrMT/jyXPE7CszzvPv
        TcGt7tJzCn9qYKNXg2tKYmA5K0Mdmuy3Tj5daEASVc9D
X-Google-Smtp-Source: AA6agR5n83FeCdbMEk12jJnNexFNiGpCNx6obnhQV0VScajtSoyMpE8BYdMUAcDx3aHX2HOeyzbj7g4pSrBlLO2Zf88=
X-Received: by 2002:a05:6512:1044:b0:48b:49b1:cc85 with SMTP id
 c4-20020a056512104400b0048b49b1cc85mr7783908lfb.57.1661208913952; Mon, 22 Aug
 2022 15:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220822023242.18162-1-ronan@rjp.ie>
In-Reply-To: <20220822023242.18162-1-ronan@rjp.ie>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Aug 2022 15:55:02 -0700
Message-ID: <CABBYNZLe2ZhgQUVs3nN_7mVxnm90n31NhUMXF7mzqUsko96-3w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] zsh: drop no more arguments message
To:     Ronan Pigott <ronan@rjp.ie>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ronan,

On Sun, Aug 21, 2022 at 7:33 PM Ronan Pigott <ronan@rjp.ie> wrote:
>
> This usage of the _message as a completion function is invalid, and
> will result in an error if invoked by _arguments when the user has a
> format style set for completion messages.
>
> We can just drop this message, since it is not necessary.

It might be better to include the output of zsh when it fails to
auto-complete, or actually a pre and post patch output.

> ---
>  completion/zsh/_bluetoothctl | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/completion/zsh/_bluetoothctl b/completion/zsh/_bluetoothctl
> index bf35e503e..610ca2b8d 100644
> --- a/completion/zsh/_bluetoothctl
> +++ b/completion/zsh/_bluetoothctl
> @@ -68,8 +68,7 @@ _bluetoothctl() {
>                 '(info)'{-m,--monitor}'[Enable monitor output]' \
>                 + 'command' \
>                 '(info):command:->command' \
> -               '(info):: :->argument' \
> -               ': :_message "no more arguments"'
> +               '(info):: :->argument'
>
>         if [[ $state == "command" ]]; then
>                 _describe -t commands 'command' all_commands
> --
> 2.37.2
>


-- 
Luiz Augusto von Dentz
