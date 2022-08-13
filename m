Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65452C19F2D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Aug 2022 19:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiHMTdG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Aug 2022 15:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiHMTc5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Aug 2022 15:32:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E47021A4
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Aug 2022 12:32:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f20so5441642lfc.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Aug 2022 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ufzpsu6ZDcEfySmql+zw0pvXL36xtj37uPAmBmZuDCk=;
        b=Fs3j6+2FqBSIw3ddYnurYz9SutEeZn8tRPvdyKAlX/tqz90ktHCaxD1XnUaZ279rWQ
         fJuUZEI8hnGxk0AXj1LMXEaFjSgHsBRkz+cle0aH3oUPkmeNaPXgPX+tF83y++a96WEt
         UgCjkWZrv/Mk3qpZaEM7I3g3s59n0cfI+Bv1UVyAzy7Ir+5BP+zZVZVxlyT6QhmMpUJO
         wZFAKPQYuFexkLkGrmjX5CgKmum4bnpTlpvUGCGih3bDw8X9b/8dg+M8GKYgWnx8o2nM
         9YKW41o5tyTnxEQwynsEkyrkNrhjO0uLN0QLXKH9KR6sQs2GnB02fXC2vTu3W687knfM
         JvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ufzpsu6ZDcEfySmql+zw0pvXL36xtj37uPAmBmZuDCk=;
        b=nPXw4PPZ54Rt+Hvb1V3ZILTIXuHwyChwBuEO1wKLpRxPmkbayOOEAgKWAKoD9hSNNC
         EHLvEh1ZzKjCdH50lb7ez4qlHgTEJFhT+0I8fZJjHxhQb4btpHCsDiISgzSeVxc/10Ho
         kdD2SClYyklqAx1y6Xpbh0d81ebU1kAKFGyNPafe62MEhz8ALOIs0Bnyv0zTGcLMnd4S
         p5p9+HaHCwT5HZz0i2IWjwlHQn93VkviB9JeaHVWKFu4fOGhNVyjiZuwqpcS5EKch48z
         AOxvPalZLuyNk5LPW6dPqpWRyjff7XsMenrsLxCfpnoNBRd1j0j6LdfL8XfjmsRPT4Jn
         XakQ==
X-Gm-Message-State: ACgBeo20S2Jgj4/3vgbqg8hJQSUKcnbfqP3wX+WG5j9bJ0w2Hs8B5Llt
        AqglghblrvjTmtXbZBgqfMuw2hFXrPMRxjIEIo8=
X-Google-Smtp-Source: AA6agR7lryXxwQ3SsMqLtXLX252nfxfqV94tWEUKZo0i9RwYQwLMgBEbHELGmMT3vZpUdc5yBT/Yy3+94ZjkhlQiaCg=
X-Received: by 2002:a05:6512:2316:b0:48f:db2f:6395 with SMTP id
 o22-20020a056512231600b0048fdb2f6395mr2402599lfu.106.1660419174420; Sat, 13
 Aug 2022 12:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220812223939.530428-1-luiz.dentz@gmail.com> <62f6dcd1.050a0220.5ebd8.1241@mx.google.com>
 <CABBYNZLOxE17vp3FOWR2hABjoCD8M62YLa6_LDdaQeJ=nrnusA@mail.gmail.com> <CADVatmN_wx=KJ=C0QGMz5ZLoVECjF9kKJa1X8ay4XWwuszeo=A@mail.gmail.com>
In-Reply-To: <CADVatmN_wx=KJ=C0QGMz5ZLoVECjF9kKJa1X8ay4XWwuszeo=A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 13 Aug 2022 12:32:43 -0700
Message-ID: <CABBYNZL93Q+Mmdk3GOUGt5TLyBN6KwzLGTw81iHHkMPvR0iQaw@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Fix build errors in some archs
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sudip,

On Sat, Aug 13, 2022 at 12:31 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi Luiz,
>
> On Sat, Aug 13, 2022 at 12:12 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Palmer, Sudip,
> >
> > On Fri, Aug 12, 2022 at 4:05 PM <bluez.test.bot@gmail.com> wrote:
> > >
> > > This is automated email and please do not reply to this email!
> > >
> > > Dear submitter,
> > >
> > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > This is a CI test results with your patch series:
> > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667285
> >
> > Could you guys try with the above change, I think the culprit is
> > actually setting c = NULL which triggers some compiler to think it may
> > be passed to bacmp.
>
> I get "No patches to display" on that link.

That is probably because Ive send a v2:

https://patchwork.kernel.org/project/bluetooth/list/?series=667289

>
> --
> Regards
> Sudip



-- 
Luiz Augusto von Dentz
