Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2ADC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jun 2022 06:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbiFGGkf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jun 2022 02:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbiFGGk1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jun 2022 02:40:27 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA02DB35A
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jun 2022 23:40:16 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v22so29521809ybd.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jun 2022 23:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEc7mGmsNlxPGgRKnQouLQVLN0FyFFR8zWtxf+XLT5Y=;
        b=VQj7yiUvQgoiAFcdz7ifEFWqZ+y0VZzKesE/2UODgVLs6F7vG0DKMgDEVIGf76/DE5
         iMYM+Daqcyf6MRRrzUbWhmfM9wvehOqeVorRfylT4d6EsI5JJPCFMEE5UGr6cxwzhrIU
         NnX+KsnAI6ZM/fES0xf0lgZDkWf3+pM5MC/Cj2P3fRJiIBIYD0ANf29DdlaRroTKWv+i
         S7xCs6CXlvp4LYCvCy6tFAoTXLfAoeNwCDRn1rv3pd7UDqeGrOMVzAj/OV/6UpDblPHo
         LvEXqi/Hohj0RY6uHknuMCQ5KjzrGwbe92Hmb8FzGpRPkrDh+o8WJRZvVIyP6uZi57qn
         Y2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEc7mGmsNlxPGgRKnQouLQVLN0FyFFR8zWtxf+XLT5Y=;
        b=P4L9bkv0N5zN4Xbfm3WukAsyk+1zRBr8qMjldPh6sLE6ASquL7jMHcfuqoKs/8hqIZ
         72yekfeAzZiPQ15cUw4J5OKVvGiMLeRf80Vf3tlPjplBAu28K72THDK+4bfwVDr/oPtp
         MW26j37ckMnjkdgMixbSTXu3l0B9HdlTQXZyDUBZj6O1FJz/Pu1E9EleG3VK1bk4/5oS
         IEH0zYAPdQMpRcSEYlRctVk3cqcIncUl9t0bBJe3+ZLLsZZMszRe7AkNr90V8GHfvKgB
         cPv06wGREaofNcmV6JzPwHExxrvSSaf/J4P7fMlaVCtvrB5w+rOCMvHUMj04eTPFUY/C
         eCqQ==
X-Gm-Message-State: AOAM532/MmdX0HfAN9Y+HkNX6Y1M0+oi5DYpPYBjnTxRiYS8YZRfJwGM
        qt2IkTopv2zaFSgaOr3p5PlMM+BgzghYdIq6QxFp1W6l13MH1g==
X-Google-Smtp-Source: ABdhPJwPdrDiLaYd3HSf/i6sxrTLFp0xHhw+fCEH5ebNWy+b4QDFcH/Jznd1yceQcN6Hk1AN51jkQ3OnOiRZEHFeyBM=
X-Received: by 2002:a25:9ac8:0:b0:64d:fee6:1c8 with SMTP id
 t8-20020a259ac8000000b0064dfee601c8mr28674355ybo.344.1654584015888; Mon, 06
 Jun 2022 23:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220526112456.2488536-1-josephsih@chromium.org> <165418561283.15613.7221303146796113568.git-patchwork-notify@kernel.org>
In-Reply-To: <165418561283.15613.7221303146796113568.git-patchwork-notify@kernel.org>
From:   Joseph Hwang <josephsih@google.com>
Date:   Tue, 7 Jun 2022 14:40:04 +0800
Message-ID: <CAHFy41-LJLt4r5_wsHgg9pCH4jZL0+uKH-guNGGOH8pAFvn_2A@mail.gmail.com>
Subject: Re: [BlueZ PATCH v6 1/8] doc: Introduce the quality report command
 and event
To:     patchwork-bot+bluetooth@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel:

  Do you mean to apply the first patch in the series or to apply the 8
patches in the whole series?

  It seems that only the first patch was applied in
https://git.kernel.org/pub/scm/bluetooth/bluez.git

  Just would like to confirm with you. Thanks!

Regards,
Joseph

On Fri, Jun 3, 2022 at 12:00 AM <patchwork-bot+bluetooth@kernel.org> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Marcel Holtmann <marcel@holtmann.org>:
>
> On Thu, 26 May 2022 19:24:49 +0800 you wrote:
> > Add the MGMT quality report command and event in doc/mgmt-api.txt.
> >
> > ---
> >
> > Changes in v6:
> > - No update in this patch. The patch 3/8 is updated to resolve a
> >   patch conflict.
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,v6,1/8] doc: Introduce the quality report command and event
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=93850c827d54
>   - [BlueZ,v6,2/8] lib: Add structures and constants for quality report command and event
>     (no matching commit)
>   - [BlueZ,v6,3/8] adapter: remove quality report from experimental features
>     (no matching commit)
>   - [BlueZ,v6,4/8] adapter: support AOSP MGMT_EV_QUALITY_REPORT
>     (no matching commit)
>   - [BlueZ,v6,5/8] adapter: support Intel MGMT_EV_QUALITY_REPORT
>     (no matching commit)
>   - [BlueZ,v6,6/8] tools/btmgmt: fix quality report command
>     (no matching commit)
>   - [BlueZ,v6,7/8] monitor: print quality report cmd
>     (no matching commit)
>   - [BlueZ,v6,8/8] monitor: packet: add missing decodings of MGMT commands to todo
>     (no matching commit)
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>


-- 

Joseph Shyh-In Hwang
Email: josephsih@google.com
