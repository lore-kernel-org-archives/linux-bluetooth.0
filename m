Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05E6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 20:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbiESULa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 16:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiESUL3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 16:11:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0642F5D180
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:11:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so6193238pju.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NKFVPLlK/wL0rXlq/LRtafC4sP9xV5yvd6JHhV7cOw=;
        b=aJ+ChbDoCbrgHuUFTt4Z9+NxfOZD4RooaHvAAf+NUzrcpObFTKeRLXEH/rBHuoEq+G
         uNtTPk1bcJAuerEsYtOnTd6E4+NGfEhfoql6MBhGzJta4nbeNn9I8igMtzqPxHra/dla
         W5FCfuivAM5stm4dr4yuB/WV5Eq4OC3zw7Fr4nMNbbyhFxwHPVD5liWz58tukJJeduLD
         GrhKQ55ymSlI44HNIopBNAhrxRl5Sqvq4PS5pHeXPZHyj/VbkwTeMyEPAJntHBB/h4/A
         GXQmlR2lbmEjSxxe3yzeUJeoc7t+I4ptYXyKDJoWxfVULjPONOxh0Pb8lClNPWatiPJO
         iVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NKFVPLlK/wL0rXlq/LRtafC4sP9xV5yvd6JHhV7cOw=;
        b=iVgojRhLLfA+/Bu1KipCxrokUTRAsybTT+8zpPLflYwIS8D71PPAj0MaXieNNieRzC
         zUVRLiozcUR1n+aaKrN65UxWBsLDNc1SWIsgdUag6+RWSBKGHW22cUaOQPIahch2SeG+
         ZJn7z3ohZHhzURrsaJIpPHhFH1V5p9D2HZbU/k1AFNEV47LvIob9FY9VgCG37gQSzYQe
         Hn3G46/0sqCL1ZyYCuyPo6HKAnvOKms3ms9ZJPwBt5145o+KWIhxF60QVHLQn5nj03+x
         +Yzey7z+qkB8AQ80f5nsPWU+MvZL1jUEz0PSPEjMnTU3h6Ze93YFMtCWmq3/Qz8mR6oI
         QA1g==
X-Gm-Message-State: AOAM533teLDpyQp3CJ5PuDup5CuR4DBgD2RqGWCbZMbx+pmXME5EmeEp
        s7tQeZELWShvLCUIgCDO8/m3+VZ3gwNkUM7AIYkGLEro
X-Google-Smtp-Source: ABdhPJx72n46WgRHKXfllxmFdutXKFbLa1Qu7xJUZrTx7DfOFIGEq9Z87ZQQJFXYbLWCAbgBhxpK98OFSEP2Y1xKlfE=
X-Received: by 2002:a17:90a:4803:b0:1dc:b4c9:1958 with SMTP id
 a3-20020a17090a480300b001dcb4c91958mr7295969pjh.61.1652991087449; Thu, 19 May
 2022 13:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220516203539.1708251-1-luiz.dentz@gmail.com> <4A5486C7-C1E8-41A3-9E7F-E627BBA79503@holtmann.org>
In-Reply-To: <4A5486C7-C1E8-41A3-9E7F-E627BBA79503@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 19 May 2022 13:11:16 -0700
Message-ID: <CABBYNZKbRhOaUz263-rS9GOUh=rbwNs2NfUWyaZ0Rgrt_Zm0fg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: MGMT: Fix uses of bitmap_from_u64
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, May 19, 2022 at 11:09 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > bitmap_from_u64 expects at least 8 bytes to be declared since it doesn't
> > take any parameter regarding the number of bits causing the following
> > warnings:
> >
> > In file included from include/linux/cpumask.h:12,
> >                 from include/linux/mm_types_task.h:14,
> >                 from include/linux/mm_types.h:5,
> >                 from include/linux/buildid.h:5,
> >                 from include/linux/module.h:14,
> >                 from net/bluetooth/mgmt.c:27:
> > In function 'bitmap_copy',
> >    inlined from 'bitmap_copy_clear_tail' at include/linux/bitmap.h:270:2,
> >    inlined from 'bitmap_from_u64' at include/linux/bitmap.h:622:2,
> >    inlined from 'set_device_flags' at net/bluetooth/mgmt.c:4534:4:
> > include/linux/bitmap.h:261:9: warning: 'memcpy' forming offset [4, 7] is
> > out of the bounds [0, 4] of object 'flags' with type
> > 'long unsigned int[1]' [-Warray-bounds]
> >  261 |         memcpy(dst, src, len);
> >      |         ^~~~~~~~~~~~~~~~~~~~~
> > In file included from include/linux/kasan-checks.h:5,
> >                 from include/asm-generic/rwonce.h:26,
> >                 from ./arch/arm/include/generated/asm/rwonce.h:1,
> >                 from include/linux/compiler.h:248,
> >                 from include/linux/build_bug.h:5,
> >                 from include/linux/container_of.h:5,
> >                 from include/linux/list.h:5,
> >                 from include/linux/module.h:12,
> >                 from net/bluetooth/mgmt.c:27:
> > net/bluetooth/mgmt.c: In function 'set_device_flags':
> > net/bluetooth/mgmt.c:4532:40: note: 'flags' declared here
> > 4532 |                         DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
> >      |                                        ^~~~~
> > include/linux/types.h:11:23: note: in definition of macro 'DECLARE_BITMAP'
> >   11 |         unsigned long name[BITS_TO_LONGS(bits)]
> >      |                       ^~~~
> >
> > In order to fix the above this initializes a variable using
> > DECLARE_BITMAP with the current_flags and then uses bitmap_subset to
> > check if the flags being set are a subset of hdev->conn_flags that way
> > all the checks are performed using bitmap APIs and conversion to u32
> > only happen when really needed.
> >
> > Fixes: a9a347655d22 ("Bluetooth: MGMT: Add conditions for setting HCI_CONN_FLAG_REMOTE_WAKEUP")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/mgmt.c | 43 ++++++++++++++++++-------------------------
> > 1 file changed, 18 insertions(+), 25 deletions(-)
>
> what is up with the kbot issues?

Will fix that.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
