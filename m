Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC74C00140
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Aug 2022 22:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345767AbiHRWEQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Aug 2022 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345587AbiHRWEM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Aug 2022 18:04:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD6B481DA
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Aug 2022 15:04:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i19so3820429lfr.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Aug 2022 15:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=o5W9ga+m72zrs6XJfsXJecGYV8URqMBFcn+EaoXHwvY=;
        b=oBKdSXxI6lwSIhwTgHrToFvXXLazr5oOu6Kytt0A9NvctG+71XRSoXzcdBKszRDKuQ
         BY162JVJiM2k19MK7fgxEiHSODSPW4Jy89lLA9qV+hBej3OTQ+HnBTHlGPXdlCa/gG32
         QTVyBf8DsSq0TeInkh0p13YV+3wXw/7eee3SPvpWeUkRntrSs8gGVgifCRR9wWEAb9Al
         fTKIVHk9GVZFTc9XCGpJJXbGfjXXeioJYDV20WmD8e7fgUxSf+Dc03PTroY9u1H3PFEs
         COBXI55EEqYQdgSMjXo2EdsDsjut4+VXWSmpcnV4DtLbqGWLhZ5TauzN+x4nMsG3pz3x
         W7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o5W9ga+m72zrs6XJfsXJecGYV8URqMBFcn+EaoXHwvY=;
        b=BjL9KBfPIfSKazOh/Ef6HtXGTh/TJELfJApvYJhOtUnoZdu4wyo/8lyRG7e8LGAR4f
         OIsVmsI12AnxsmJYYrzjOYYfWzyAsd9BgkTTKYWuOkpleSJrW8UnAyaMMG7vhzlCZjlY
         r2u4CRqdni2hNUCKVlKrRilnHuY3PQolmAN5vlswEJHQL/8+5eirAZuWeugciOKJBrsU
         Yltl7HNKAtAvwGTY8MxcVs8fn6Qjor3nbU2i3U8qwQRfQbjKQTfKm+OdHQEF30ejwtWs
         jo0l77TWtz2dabfCHRneoZpMOs7m+XuLt8Fg46/035bvJU2GNE0Cq73dh7RAw2ly8itp
         YqCw==
X-Gm-Message-State: ACgBeo1G+wkFgY9QP8GFyRlNxAOpOI9W75NnFYDJUACv2ABuR/5LHmpQ
        ZFKIJrG10aiWHE3d5nGiV1IATFRy2VfrUO3S+1Q869id
X-Google-Smtp-Source: AA6agR7aUjehtP7WZ7xfdQHWlECTm2H5nWZUkMsu/xa5dU8P+03iqvjh0oY+mORaVn5fxRsMsqjqIVeJC2ulg2OQYhY=
X-Received: by 2002:ac2:47f1:0:b0:48a:ea6e:b8fd with SMTP id
 b17-20020ac247f1000000b0048aea6eb8fdmr1467707lfp.26.1660860242021; Thu, 18
 Aug 2022 15:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220812223939.530428-1-luiz.dentz@gmail.com> <62f6dcd1.050a0220.5ebd8.1241@mx.google.com>
 <CABBYNZLOxE17vp3FOWR2hABjoCD8M62YLa6_LDdaQeJ=nrnusA@mail.gmail.com>
 <CADVatmN_wx=KJ=C0QGMz5ZLoVECjF9kKJa1X8ay4XWwuszeo=A@mail.gmail.com>
 <CABBYNZL93Q+Mmdk3GOUGt5TLyBN6KwzLGTw81iHHkMPvR0iQaw@mail.gmail.com>
 <CADVatmOyd8gUqWMx-5CmbKnAdmppk2sGkG=+mh=W4aN1wS6VFQ@mail.gmail.com>
 <CABBYNZKBRKVWQ9DFFTU0_nBGZg7va8mpPZ_TwDXtBigt2E06_w@mail.gmail.com> <CADVatmPsMi+YjS3D=EpeVHWkM79bZgSfTSyejvCP0-VcXAd19w@mail.gmail.com>
In-Reply-To: <CADVatmPsMi+YjS3D=EpeVHWkM79bZgSfTSyejvCP0-VcXAd19w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 18 Aug 2022 15:03:50 -0700
Message-ID: <CABBYNZJryfRZVuJrb902HAXQ9+jFoeYLRVYqB-t_rUUkOXATsQ@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Fix build errors in some archs
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sudip,

On Thu, Aug 18, 2022 at 2:29 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> On Mon, Aug 15, 2022 at 6:55 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sudip,
> >
> > On Sun, Aug 14, 2022 at 3:48 AM Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Sat, Aug 13, 2022 at 8:32 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Sudip,
> > > >
> > > > On Sat, Aug 13, 2022 at 12:31 AM Sudip Mukherjee
> > > > <sudipm.mukherjee@gmail.com> wrote:
> > > > >
> > > > > Hi Luiz,
> > > > >
> > > > > On Sat, Aug 13, 2022 at 12:12 AM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Palmer, Sudip,
> > > > > >
> > > > > > On Fri, Aug 12, 2022 at 4:05 PM <bluez.test.bot@gmail.com> wrote:
> > > > > > >
> > > > > > > This is automated email and please do not reply to this email!
> > > > > > >
> > > > > > > Dear submitter,
> > > > > > >
> > > > > > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > > > > > This is a CI test results with your patch series:
> > > > > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667285
> > > > > >
> > > > > > Could you guys try with the above change, I think the culprit is
> > > > > > actually setting c = NULL which triggers some compiler to think it may
> > > > > > be passed to bacmp.
> > > > >
> > > > > I get "No patches to display" on that link.
> > > >
> > > > That is probably because Ive send a v2:
> > >
> > > I have not tested your patch as the build failure is not present with
> > > the bluetooth master branch. Please let me know if this was the wrong
> > > branch.
> >
> > And you can't apply on top of the tree that you are able to reproduce?
>
> I can see its already in linux-next and I don't see those build
> failures on next-20220818.

Alright, I will send a pull request including it later this week just
in case it reappears for some reason.

>
> --
> Regards
> Sudip



-- 
Luiz Augusto von Dentz
