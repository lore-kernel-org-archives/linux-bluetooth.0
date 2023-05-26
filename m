Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFF2C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 May 2023 22:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjEZWiA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 May 2023 18:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEZWh7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 May 2023 18:37:59 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B024A9C
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 15:37:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af24ee004dso12148231fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685140677; x=1687732677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gFSwrXFrTeBjWGXtLFbcxuSH0Z3UY4nYLB5242pCmg=;
        b=a7PYdT4Z6cNbHRKo3Oqbiwr3pHiM4VrR2BtB3SbVY7Na9ASsM5H/rAkgaQXQkULvXH
         tQg0if4hZhnwCl8I5bNTfBVm+e1/k1CAOogwjBsD8eOHXh1LC/1ajxr9sw6tfg6ZKC/Z
         4vY6cXDBQqzoNebrief8pRmeE3tW4hU6jI0cvoothu8iPDwQ5UOG63Rk7sUM2mtXxeOq
         1/33e37y92YEZYPERY8aJE6KdQn387W5OLQ09r55ZcPR6YccMyNu7f/dOYqzW0C1KZ+K
         LgP8WdrvyJhEBYInXSuI0IvcJEtIHBw00p/+Vu2b4DnhGDExRZ4/j6ip5jYA4gm6WSrL
         BJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685140677; x=1687732677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gFSwrXFrTeBjWGXtLFbcxuSH0Z3UY4nYLB5242pCmg=;
        b=jcJ0lE9IRwJ9OoJ2zdqnSy52r7kHy2MErqzawJPUxiVznLGfrgQGcsUyEyQxKEZQR3
         TIFjwM4hdHFNPCTGMTJNSmnMHlmxMgJ/pSq+HWMyCobnD7WoK9yH8vIcQ2phSsdhTyua
         esMwVYmliB4IxJ5jr7n913JCpFkAhd0ScHhIXnO9X6HdoAgmRkcQ953vCgwcvnUutnEQ
         KMoe42vkIOuPfek6MOnA7ZmlUOweAru22FgXIhH+TaMIzVDcuJ6M5geIkKdRZiMBWHct
         kpJPe4AoD09RWCQycm1qWv7b8o4exYxMqFcS17kKADks367r7Kxfmi/iErbyQU+rD0f9
         dcqw==
X-Gm-Message-State: AC+VfDxc02g2k69Fs5dMsEtD/5l1ITZATXrlo5NYuRDC3OEnWbKSWgAo
        /6rWhxxrCmyKOMhMA5ur9UtwqKUK1LyC8Fin9WQ=
X-Google-Smtp-Source: ACHHUZ5L6fRv48fmaCrPPzA+4itDHNdK67YoR0mHRP9dkY5d0HzDMKI64VKFIQmNoNYdj91j6kga3le47ZNzh7FCgDY=
X-Received: by 2002:a2e:a317:0:b0:2ad:dd7e:6651 with SMTP id
 l23-20020a2ea317000000b002addd7e6651mr1179391lje.43.1685140676566; Fri, 26
 May 2023 15:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230525153452.125789-1-silviu.barbulescu@nxp.com> <168513902178.4400.7735618892742799772.git-patchwork-notify@kernel.org>
In-Reply-To: <168513902178.4400.7735618892742799772.git-patchwork-notify@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 26 May 2023 15:37:44 -0700
Message-ID: <CABBYNZKD+nL+fan95r8rca8ivg_9Ng=EH8QOk6tfky8VBoLduA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Add initial support for BAP broadcast source
To:     patchwork-bot+bluetooth@kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Silviu,

On Fri, May 26, 2023 at 3:22=E2=80=AFPM <patchwork-bot+bluetooth@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Thu, 25 May 2023 18:34:46 +0300 you wrote:
> > This patch adds initial support for BAP broadcast source.
> >
> > The current implementation allows BAP source endpoint registration,
> > media transport creation, transport acquiring and sending broadcast ISO=
 data.
> >
> > Currently, one BIG containing one BIS is supported.
> >
> > [...]
>
> Here is the summary with links:
>   - [v2,1/6] Update Docs for BAP broadcast source
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df808fa065396
>   - [v2,2/6] Add macro definitions for BAP broadcast source support
>     (no matching commit)
>   - [v2,3/6] Check for ISO broadcast support in controller
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D97f3386268fa
>   - [v2,4/6] Add support for setsockopt (BT_IO_OPT_BASE)
>     (no matching commit)
>   - [v2,5/6] Update bluetoothctl with support for broadcast source
>     (no matching commit)
>   - [v2,6/6] Add initial support for BAP broadcast source
>     (no matching commit)
>
> You are awesome, thank you!

So Ive pushed changes up to 4/6, the last 2 have a lot of coding style
problems so please fix them, and I'd still recommend you to split
those as much as possible to make it easier to review.


--=20
Luiz Augusto von Dentz
