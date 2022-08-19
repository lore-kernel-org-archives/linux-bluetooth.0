Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C190C28B2B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Aug 2022 18:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349574AbiHSStk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349248AbiHSStj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Aug 2022 14:49:39 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6DCEA89B
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 11:49:38 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x10so5310385ljq.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KfOlMsXLbjeHLMGfF1IcsZu4BHLHy8eqFcboRP92QVs=;
        b=GHM0qpsgrVRA3b4MuTg4Z6J3M5beop4I/RZFoOZZpzGxYF5U7dEYqsUGOADJcW0AwS
         JGZNVj1MurDAXmYaCT4xepyhwXoq9TpYbYJBUFvnPgB/wMPWf6dd4JwrxB8ahycPp7i3
         4tPvE3yR13/yhhwtJerrDFaDNCpBBJ8LzbSjQ56o8YFu6PRRZGka+hKhB0wnTKkhdpQk
         wam++vMmvOGF3If/2pyFcnbHcHKzsJfO3BCsT7RasFFrvoRryoZupV1qGJoAl++QPNmc
         oQ5L4aQSrxKrIIm1UMPLTVgyIFSKkbYIstINhpe33YaXuqgficXcG+0684DrTamqFzdp
         BMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KfOlMsXLbjeHLMGfF1IcsZu4BHLHy8eqFcboRP92QVs=;
        b=Lx683zifxJ2ptEMWIFD7AZvJDGG4Ka/r5/P1uMf8CUM8U8vDGLuIvPy8YeVFyQexmQ
         mHhaX2JmwVkiMH8GJ6sRNEQni2F+pLuUNTxP5ooV5eR8a7EbzQF61aXE8QzJe2BElXHx
         ajmUAI8IycnG2znC5jgpmoE51Ow1yBbiOW2MBie8N2meD43AWwTckg7Ctvtd8fkxQJtj
         gP7kdfJKUQ/I5CKZki3+lZC+nGW8cSxnTYYlt8ca+vdrzQtyZ5PW174nfa8odP7+CjGY
         y9S7vNaAQUg9hVQTeaDGF5Z/XmurgPRElCozbepNlAVdDmmE+Js49WZ9Du0v9O2O6YtJ
         Zlzw==
X-Gm-Message-State: ACgBeo0E5hgylwcuNAVegHAm6dKSRiYm4XLUDj/ipdCynp3etWt1E5aK
        AxQu3306XUIOTdBc0SfolGt1e33aa74IB6BCMSU=
X-Google-Smtp-Source: AA6agR6zizCQQtqC+2LYx0qboKE4afjVWN4r1E+nAhc07Z8P3xJPEh7rKVrCTmGAXI+whFt91n04RnKTN5GLrwAevj0=
X-Received: by 2002:a2e:3507:0:b0:261:beb2:d3dd with SMTP id
 z7-20020a2e3507000000b00261beb2d3ddmr1118795ljz.293.1660934976863; Fri, 19
 Aug 2022 11:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220812223939.530428-1-luiz.dentz@gmail.com> <62f6dcd1.050a0220.5ebd8.1241@mx.google.com>
 <CABBYNZLOxE17vp3FOWR2hABjoCD8M62YLa6_LDdaQeJ=nrnusA@mail.gmail.com>
 <CADVatmN_wx=KJ=C0QGMz5ZLoVECjF9kKJa1X8ay4XWwuszeo=A@mail.gmail.com>
 <CABBYNZL93Q+Mmdk3GOUGt5TLyBN6KwzLGTw81iHHkMPvR0iQaw@mail.gmail.com>
 <CADVatmOyd8gUqWMx-5CmbKnAdmppk2sGkG=+mh=W4aN1wS6VFQ@mail.gmail.com>
 <CABBYNZKBRKVWQ9DFFTU0_nBGZg7va8mpPZ_TwDXtBigt2E06_w@mail.gmail.com>
 <CADVatmPsMi+YjS3D=EpeVHWkM79bZgSfTSyejvCP0-VcXAd19w@mail.gmail.com>
 <CABBYNZJryfRZVuJrb902HAXQ9+jFoeYLRVYqB-t_rUUkOXATsQ@mail.gmail.com> <CADVatmM7PKfFoSiTSHR0=+ZvWJoEdu8saztpCEXCFxqDweHgJA@mail.gmail.com>
In-Reply-To: <CADVatmM7PKfFoSiTSHR0=+ZvWJoEdu8saztpCEXCFxqDweHgJA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 19 Aug 2022 11:49:25 -0700
Message-ID: <CABBYNZ+NfJ3-AFBadj5pNGMNsjbwur4mPb41Zu3JGqsJ62C3mw@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Fix build errors in some archs
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sudip,

On Fri, Aug 19, 2022 at 12:28 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> On Thu, Aug 18, 2022 at 11:04 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sudip,
> >
> > On Thu, Aug 18, 2022 at 2:29 PM Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > >
> > > On Mon, Aug 15, 2022 at 6:55 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Sudip,
> > > >
> > > > On Sun, Aug 14, 2022 at 3:48 AM Sudip Mukherjee
> > > > <sudipm.mukherjee@gmail.com> wrote:
> > > > >
> > > > > Hi Luiz,
> > > > >
> > > > > On Sat, Aug 13, 2022 at 8:32 PM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Sudip,
> > > > > >
> > > > > > On Sat, Aug 13, 2022 at 12:31 AM Sudip Mukherjee
> > > > > > <sudipm.mukherjee@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Luiz,
> > > > > > >
> > > > > > > On Sat, Aug 13, 2022 at 12:12 AM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Palmer, Sudip,
> > > > > > > >
> > > > > > > > On Fri, Aug 12, 2022 at 4:05 PM <bluez.test.bot@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > This is automated email and please do not reply to this email!
> > > > > > > > >
> > > > > > > > > Dear submitter,
> > > > > > > > >
> > > > > > > > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > > > > > > > This is a CI test results with your patch series:
> > > > > > > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667285
> > > > > > > >
> > > > > > > > Could you guys try with the above change, I think the culprit is
> > > > > > > > actually setting c = NULL which triggers some compiler to think it may
> > > > > > > > be passed to bacmp.
> > > > > > >
> > > > > > > I get "No patches to display" on that link.
> > > > > >
> > > > > > That is probably because Ive send a v2:
> > > > >
> > > > > I have not tested your patch as the build failure is not present with
> > > > > the bluetooth master branch. Please let me know if this was the wrong
> > > > > branch.
> > > >
> > > > And you can't apply on top of the tree that you are able to reproduce?
> > >
> > > I can see its already in linux-next and I don't see those build
> > > failures on next-20220818.
> >
> > Alright, I will send a pull request including it later this week just
> > in case it reappears for some reason.
>
> Just to be clear, the build failure is still there on the mainline
> branch from Linus. But next-20220818, which has the fixes does not
> show the build failure. So, it will be needed for Linus tree.

So I assume one next is merged into the Linus tree that should take
care of these errors.

>
> --
> Regards
> Sudip



-- 
Luiz Augusto von Dentz
