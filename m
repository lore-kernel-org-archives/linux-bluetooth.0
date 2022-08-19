Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D33C25B0E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Aug 2022 07:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347032AbiHSH2q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Aug 2022 03:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347035AbiHSH2p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Aug 2022 03:28:45 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2767966A5D
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 00:28:42 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3376851fe13so67116427b3.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 00:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6hQTf/rUqfUoApaKhZbvOqKuIZGyo3ccMInHQdDuWyc=;
        b=MpU0F/NONeMp38YPz16+O2IOQtaL8/RZa0CAXtYzqS8ZPARHrKelv2kHhHDU8u1K9j
         MbgaSmO5dx6Ht4IWiA0A9EGN87EdrXhLJalyFmgsC+JXG5NYWcRpDiGgqrdrY7v0BM+8
         43YTJDl97QGX0C6C6i/kXFCTQQkzlWvBJu/o+F0suTw6JsKAkcMRgL/GcTrpelo1xOp8
         iVGo1BjQjHBFCIWZzht0n5xs411CsU7z8fepqi2ORiH62QBNriXQSlmsBVwuwjOs4mUT
         Ckejncvl6w++Ar0y/5TcFX492xVbhVVtuKJRRdeFfYNMW8FGuGrG9cnCvFSpE0oMLFUM
         3hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6hQTf/rUqfUoApaKhZbvOqKuIZGyo3ccMInHQdDuWyc=;
        b=MBB1fvYLbV1yHCcxz6BdRdfNfg/OwLH485jWUjXmSg01LhFVHVNH+FeNTkk4Q9pEp3
         ic1fRRLlcN/qDV9ZgHaCv9jLLWuRYnQTYvyAkf3MPpK1rhHapIYuEoMDVTKCmmhJ2AlL
         6RfHsvdBH1gySFtmlKJS26E/2t/ZhsVee6BF/MT8PJaPJz9cPk5kt5wqjo/GntS1lzx8
         bmD5whSSlde//dA6NW3nwCniXe0rUnTSOR8HrsFMvZAujGEq4tn4BFQrIXJaaC2F25Cj
         CD+pAGOcxZ3LWxX1zhxf6zvwWmr7TRe2QX6FVKZQJwmwM9zzTx4OmHkWosCnlwV+ESEM
         MDJQ==
X-Gm-Message-State: ACgBeo1ig+vX4IRYQTZTvfaz2quzWu4eFOLiwrYx5HR67k6Zp/zdv1ts
        PKrRDZtyK/4O+H794sMzDh1alcXOh2LIumT3jvk=
X-Google-Smtp-Source: AA6agR5fS2TlALyH6JCeZjnKb8KweLOE9Vgjrk8txRpDxwnm+WEc6cSNkLGZQ2uJg2lVnjkY053g9BYdQcWuZLLCMgk=
X-Received: by 2002:a81:7783:0:b0:338:7f4a:fd7b with SMTP id
 s125-20020a817783000000b003387f4afd7bmr268580ywc.478.1660894121095; Fri, 19
 Aug 2022 00:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220812223939.530428-1-luiz.dentz@gmail.com> <62f6dcd1.050a0220.5ebd8.1241@mx.google.com>
 <CABBYNZLOxE17vp3FOWR2hABjoCD8M62YLa6_LDdaQeJ=nrnusA@mail.gmail.com>
 <CADVatmN_wx=KJ=C0QGMz5ZLoVECjF9kKJa1X8ay4XWwuszeo=A@mail.gmail.com>
 <CABBYNZL93Q+Mmdk3GOUGt5TLyBN6KwzLGTw81iHHkMPvR0iQaw@mail.gmail.com>
 <CADVatmOyd8gUqWMx-5CmbKnAdmppk2sGkG=+mh=W4aN1wS6VFQ@mail.gmail.com>
 <CABBYNZKBRKVWQ9DFFTU0_nBGZg7va8mpPZ_TwDXtBigt2E06_w@mail.gmail.com>
 <CADVatmPsMi+YjS3D=EpeVHWkM79bZgSfTSyejvCP0-VcXAd19w@mail.gmail.com> <CABBYNZJryfRZVuJrb902HAXQ9+jFoeYLRVYqB-t_rUUkOXATsQ@mail.gmail.com>
In-Reply-To: <CABBYNZJryfRZVuJrb902HAXQ9+jFoeYLRVYqB-t_rUUkOXATsQ@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 19 Aug 2022 08:28:05 +0100
Message-ID: <CADVatmM7PKfFoSiTSHR0=+ZvWJoEdu8saztpCEXCFxqDweHgJA@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Fix build errors in some archs
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Aug 18, 2022 at 11:04 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sudip,
>
> On Thu, Aug 18, 2022 at 2:29 PM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > On Mon, Aug 15, 2022 at 6:55 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sudip,
> > >
> > > On Sun, Aug 14, 2022 at 3:48 AM Sudip Mukherjee
> > > <sudipm.mukherjee@gmail.com> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > On Sat, Aug 13, 2022 at 8:32 PM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Sudip,
> > > > >
> > > > > On Sat, Aug 13, 2022 at 12:31 AM Sudip Mukherjee
> > > > > <sudipm.mukherjee@gmail.com> wrote:
> > > > > >
> > > > > > Hi Luiz,
> > > > > >
> > > > > > On Sat, Aug 13, 2022 at 12:12 AM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Palmer, Sudip,
> > > > > > >
> > > > > > > On Fri, Aug 12, 2022 at 4:05 PM <bluez.test.bot@gmail.com> wrote:
> > > > > > > >
> > > > > > > > This is automated email and please do not reply to this email!
> > > > > > > >
> > > > > > > > Dear submitter,
> > > > > > > >
> > > > > > > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > > > > > > This is a CI test results with your patch series:
> > > > > > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667285
> > > > > > >
> > > > > > > Could you guys try with the above change, I think the culprit is
> > > > > > > actually setting c = NULL which triggers some compiler to think it may
> > > > > > > be passed to bacmp.
> > > > > >
> > > > > > I get "No patches to display" on that link.
> > > > >
> > > > > That is probably because Ive send a v2:
> > > >
> > > > I have not tested your patch as the build failure is not present with
> > > > the bluetooth master branch. Please let me know if this was the wrong
> > > > branch.
> > >
> > > And you can't apply on top of the tree that you are able to reproduce?
> >
> > I can see its already in linux-next and I don't see those build
> > failures on next-20220818.
>
> Alright, I will send a pull request including it later this week just
> in case it reappears for some reason.

Just to be clear, the build failure is still there on the mainline
branch from Linus. But next-20220818, which has the fixes does not
show the build failure. So, it will be needed for Linus tree.


-- 
Regards
Sudip
