Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4887DC47094
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 23:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F2461246
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 23:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFGXwd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Jun 2021 19:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFGXwc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Jun 2021 19:52:32 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3A4C061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jun 2021 16:50:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f84so27601838ybg.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jun 2021 16:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ua5DP5R135MkRA1loD+tp5x/oBgjQjutwmL0d0O0dSo=;
        b=DCbSMS0EX9iIW+SFgKVX79qv/XH6d6UynxO1OTKYVmPJV8z/R8TWxilvPP7OO89VzJ
         TC54usdYPencrZrxQIwdmw8zaIvUAE4Zqu6dJbwEc3t1Ar8XhfjlRnHO7wc9aOY6Bc2A
         rtrixg1R2uHlVA5IbspbwxIKJKIYoSqcwgxB39RyA3NO51AmAKmpTc6C2rQrrjmOJ1xz
         QnkhDlsWniVQ19KW65hk0Gkol8pZasRttqdYMx6EXmw72WFo4QAgLmHvcD9OSHAxhc/n
         neLFJJJWzN+odGWlCRNa3c/N6Z22XFmxQ49KDx1QLl756VxAAi3Da+cxEXwLgbST0IQh
         keQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ua5DP5R135MkRA1loD+tp5x/oBgjQjutwmL0d0O0dSo=;
        b=UvcaH+/n/QSmUpyJ2O+QOdWzksUW85Itq8UXPVhtH0OYGmhwd3Y6LoNsWY2begh/X4
         zG+iVXRyfwxYIgk2Nf4VRTepYKlkL6mt8LvmDRtg6NMfWWVJJMz4kE3o2cWSpHQrQipk
         RvqmHSyHrCkFYypT7Qbx4vx1U6EG1oMVTDGanVeJqPYCiF47b/VpDaJ9fkQYqHqStQMt
         iKjIogjn+JLU0R20pzCdDwzhjPs9ll6FPbn/2uTgudyi6HPk0TofSx9TeLiMS4HV1XOG
         xhtgLFkjJdX+dNWllD0l44zpygP6tr5T1YrVu/J10Dgu2ITXp3LKxho+nF7AaKYvhcgB
         Ebzg==
X-Gm-Message-State: AOAM531+FlpZjQuc8YHH0KkdFl+fAggwk89bt/ZLw2Pf0HP+urqbWBmN
        K6JSEO+VLpZxpBg52i3TsVCz8k0puwJfdcmMepB35xqZ
X-Google-Smtp-Source: ABdhPJznZhkzDZ8ZeXdCVLmQ4N/2318gK/b9XM8GbaApatzLg/6AqcyXVRz28GXrrN9DEegu13PRroWevpGR88Jzo4U=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr29237604ybu.282.1623109829510;
 Mon, 07 Jun 2021 16:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210606063719.339794-1-inga.stotland@intel.com>
In-Reply-To: <20210606063719.339794-1-inga.stotland@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 7 Jun 2021 16:50:18 -0700
Message-ID: <CABBYNZL9vMY5cuwi0j40Z_aq+Ys-DeEnSMjgUrtD-SKi7YkDGg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/11] Convert tester tools to use ELL
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "An, Tedd" <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Sat, Jun 5, 2021 at 11:37 PM Inga Stotland <inga.stotland@intel.com> wrote:
>
> This patch set contains non-interactive tester tools modified
> to use ELL primitives in order to remove dependencies on GLib.
>
> Two new files emulator/hciemu-ell.c and src/shared/bttester.c are
> created as an intermediate step before removing their GLib-based counterparts
> subject to the vetting/approval of this patch set.
>
> Inga Stotland (11):
>   shared/bttester: tester framework wrapper to use ELL
>   emulator/hciemu: Create ELL based version of hciemu
>   tools/gap-tester: Convert to use ELL library
>   tools/sco-tester: Convert to use ELL library
>   tools/userchan-tester: Convert to use ELL library
>   tools/smp-tester: Convert to use ELL library
>   tools/bnep-tester: Convert to use ELL library
>   tools/l2cap-tester: Convert to use ELL library
>   tools/mgmt-tester: Convert to use ELL library
>   tools/rfcomm-tester: Convert to use ELL library
>   tools/hci-tester: Convert to use ELL library
>
>  Makefile.am             |   4 +-
>  Makefile.tools          |  36 +-
>  emulator/hciemu-ell.c   | 641 +++++++++++++++++++++++++++++++++
>  src/shared/bttester.c   | 279 +++++++++++++++
>  src/shared/bttester.h   |  32 ++
>  tools/bnep-tester.c     | 115 +++---
>  tools/gap-tester.c      | 107 +++---
>  tools/hci-tester.c      | 289 ++++++++-------
>  tools/l2cap-tester.c    | 680 ++++++++++++++++++-----------------
>  tools/mgmt-tester.c     | 772 ++++++++++++++++++++--------------------
>  tools/rfcomm-tester.c   | 290 +++++++--------
>  tools/sco-tester.c      | 231 ++++++------
>  tools/smp-tester.c      | 210 ++++++-----
>  tools/userchan-tester.c | 151 ++++----
>  14 files changed, 2391 insertions(+), 1446 deletions(-)
>  create mode 100644 emulator/hciemu-ell.c
>  create mode 100644 src/shared/bttester.c
>  create mode 100644 src/shared/bttester.h
>
> --
> 2.26.3

Just a heads-up that it may take a little longer to get to this set
since we are dealing with LL Privacy we want to include tests for it
first before we change the whole environment to use ELL.

-- 
Luiz Augusto von Dentz
