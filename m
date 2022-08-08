Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4DFC3F6B0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Aug 2022 21:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbiHHVvP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Aug 2022 17:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238812AbiHHVvO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Aug 2022 17:51:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0401837D;
        Mon,  8 Aug 2022 14:51:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kb8so19024332ejc.4;
        Mon, 08 Aug 2022 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otg60AufERYTqDC1MTXvUQXU1Bq6/yb6ZQ9eUtFwppA=;
        b=B1muCApCKw0PKw5o0QeGdtTWIadHlNhwuGcHpHxSAXwv5SnZ9w0iUkOsUZBv16877L
         NEHUZJJb69YKj7ZYb2LCtZaYWGKqsfP0BSUySuecaPvuKbKl28PJTLc8GZCngMe7ZY8p
         HtI1PfLJIrv/xjdqYoLNYL1/Nl8nI6nb6XP3mSt4KrgrnM3a5qqgOnbI+zABhyssiJWO
         9Zik4iGeawLcQEmvuJvPrdCbccAjqts6EIonKoC/mXXdW+3/fP+gGJz+e/7KgOnrpcts
         N2J21TJxIyQBjDpeFVXa9gOYBhxvSxdBr1L6pRt2b/s0sDzmkt+cZ88xJoA2nMIm2/3i
         TLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otg60AufERYTqDC1MTXvUQXU1Bq6/yb6ZQ9eUtFwppA=;
        b=fr7HlXLr2WT4/g/Py8mss5TPrS2+u0vgdy4WaBUhPUucP5aDkh03fgZU/InKdBIDkh
         /OsZquzWm6QsdHY+4np/JYtZFnihTLBFWZ2gtKnh/4KYtYdxG5q9yUuxjjF1gPvkjPEU
         ipZHJlr33xVbRlSoJ1iQ9I9cYrfwgwE398ksWUFNPxtkEGS55Oe5+WZyxN63YcVTZvtc
         2Fu66bjbImmf4Z2SFunXVDgHbCxhbsVxksm56Z+o9fpnj9zAUYpe68AsDG1ML8ZTsZ9Y
         XZEyYV1thuXyck1X3p5MXOZ6szBR63UHoU0zTKYmFcv/H0ooDYxP+YKtJgWYBFna8uAz
         RlBg==
X-Gm-Message-State: ACgBeo1r7fRJ6VkxF/k8LsKIapeJxY9N3lGHT5WiKlPNIsDwObn1WQdT
        Oudz+BZo8A9/h9OVF8c0v8lHzXXE4KM9Gp9txTU=
X-Google-Smtp-Source: AA6agR5GZc/2WVDCq80du7287di40nBg8bw9b0KXfn3G6wRl1MJwcc3dWhmsrJxskHCkUtZ3D92y56AAqc7u2MqAmNs=
X-Received: by 2002:a17:906:4bd3:b0:731:3bdf:b95c with SMTP id
 x19-20020a1709064bd300b007313bdfb95cmr7408694ejv.677.1659995472416; Mon, 08
 Aug 2022 14:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220805232834.4024091-1-luiz.dentz@gmail.com>
 <20220805174724.12fcb86a@kernel.org> <CABBYNZLPkVHJRtGkfV8eugAgLoSxK+jf_-UwhSoL2n=9J9TFcw@mail.gmail.com>
 <20220808143011.7136f07a@kernel.org> <CABBYNZKmuUpmUChz+tixFCOE_pUeaJq0Sbqkvjy54zd9H=GB4A@mail.gmail.com>
In-Reply-To: <CABBYNZKmuUpmUChz+tixFCOE_pUeaJq0Sbqkvjy54zd9H=GB4A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Aug 2022 14:51:00 -0700
Message-ID: <CABBYNZJXdt_aL2SOH_Eu9PDaLhHksTRJDBPKSDitXKURPqG-7w@mail.gmail.com>
Subject: Re: pull request: bluetooth 2022-08-05
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jakub,

On Mon, Aug 8, 2022 at 2:36 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Jakub,
>
> On Mon, Aug 8, 2022 at 2:30 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 8 Aug 2022 12:38:25 -0700 Luiz Augusto von Dentz wrote:
> > > > Did you end up switching to the no-rebase/pull-back model or are you
> > > > still rebasing?
> > >
> > > Still rebasing, I thought that didn't make any difference as long as
> > > the patches apply.
> >
> > Long term the non-rebasing model is probably better since it'd be great
> > for the bluetooth tree to be included in linux-next.
>
> You mean that bluetooth-next would be pulled directly into linux-next
> rather than net-next?
>
> > Since you haven't started using that model, tho, would you mind
> > repairing the Fixes tags in this PR? :)
>
> Let me fix them.

Is there a script or something which can be used to verify the Fix
tags? Or you can actually tell me what are the hashes that appear not
to be on net.

> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
