Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB8CC25B06
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Aug 2022 10:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiHNKsq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Aug 2022 06:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiHNKsp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Aug 2022 06:48:45 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA8615FDF
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Aug 2022 03:48:44 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31e7ca45091so45375267b3.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Aug 2022 03:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6MQh6dZviKiOoRw4ektrcjWZuHaEw3Ur+b1LHdKTMY4=;
        b=ScAXuJI7aKkopWiz8VqpZf728sY6g+V+KKgEwZlNZEjeA+bsGJjUelP/YjzPLfV4cz
         kH3BnpL/1YubVJYSfr6n2EmkTHADpKnqbQUdudGGtnoolphJPsG/rrr/0da5pZvlUvEv
         cTtcXAuXK8eOQXYNSCl9gQYV0/Cf2gWCb2XNpw7AxftiWfchWeIuZuusnkRayMZMbHrX
         hodhoUsJyuws+Ua1Cqd/vf26Cpe9KsRPEMh/IT1g0UVmYI+GMNMH8v6lGCrVnyiNjGyW
         3T93gFLJdPA+1YXZW6nvJ8A8tzAPAQA87mAp+Rz1PLNtwHZnwRyGTgoXzYp8FuKBmB/g
         XROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6MQh6dZviKiOoRw4ektrcjWZuHaEw3Ur+b1LHdKTMY4=;
        b=VHenbDvTXSRfehUFZZYwysa993PCeXcjEV39mgmCPfHsE3svZc6rBvyVODmM38X4Yg
         IOejgtfyjsbcWBx5zFrB8RKuRFZItT1ek8EZWqbkxd3jWN4vtNiOtojcC7EFHk5QDubW
         QsIS8Kkk02wUcBv2wZpgZDQjDhjRUG2IdSWODpSQnuz4e5lv9hyO3Yj12xZ1//saNSSN
         L9tQroTiKTIznACRfxy/VsZsnOKIE7x+dBxyg+vCpAEGZqTbPM/rvs0DWKRv7Gt9ewRK
         fwATTrZsAc2/L5Sqw7gc1A3PsXYr4LrFvSfTE/LIJY1EOvsm3X74PLixpyYAoe1EKt4N
         Mh2A==
X-Gm-Message-State: ACgBeo2OwcncLgykM4EMPsFFhOWpMqdIZWr/1Aj8PHBFUmr/OVmYjjgz
        uLvYBLrFHd2jiWFcfXfZwsp+GF2i3uCVbB1Hc9Q=
X-Google-Smtp-Source: AA6agR537QbegArKfpxr+VkzPCwtbyWdsT1pdJFXhrNh6+6ydUKse9juYtx0+WOlBuW+5MUqSpYcXRjYVmHX58AAyhI=
X-Received: by 2002:a0d:d7c2:0:b0:31f:56d0:84c0 with SMTP id
 z185-20020a0dd7c2000000b0031f56d084c0mr9642940ywd.361.1660474123483; Sun, 14
 Aug 2022 03:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220812223939.530428-1-luiz.dentz@gmail.com> <62f6dcd1.050a0220.5ebd8.1241@mx.google.com>
 <CABBYNZLOxE17vp3FOWR2hABjoCD8M62YLa6_LDdaQeJ=nrnusA@mail.gmail.com>
 <CADVatmN_wx=KJ=C0QGMz5ZLoVECjF9kKJa1X8ay4XWwuszeo=A@mail.gmail.com> <CABBYNZL93Q+Mmdk3GOUGt5TLyBN6KwzLGTw81iHHkMPvR0iQaw@mail.gmail.com>
In-Reply-To: <CABBYNZL93Q+Mmdk3GOUGt5TLyBN6KwzLGTw81iHHkMPvR0iQaw@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 14 Aug 2022 11:48:07 +0100
Message-ID: <CADVatmOyd8gUqWMx-5CmbKnAdmppk2sGkG=+mh=W4aN1wS6VFQ@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Fix build errors in some archs
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Sat, Aug 13, 2022 at 8:32 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sudip,
>
> On Sat, Aug 13, 2022 at 12:31 AM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > Hi Luiz,
> >
> > On Sat, Aug 13, 2022 at 12:12 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Palmer, Sudip,
> > >
> > > On Fri, Aug 12, 2022 at 4:05 PM <bluez.test.bot@gmail.com> wrote:
> > > >
> > > > This is automated email and please do not reply to this email!
> > > >
> > > > Dear submitter,
> > > >
> > > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > > This is a CI test results with your patch series:
> > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667285
> > >
> > > Could you guys try with the above change, I think the culprit is
> > > actually setting c = NULL which triggers some compiler to think it may
> > > be passed to bacmp.
> >
> > I get "No patches to display" on that link.
>
> That is probably because Ive send a v2:

I have not tested your patch as the build failure is not present with
the bluetooth master branch. Please let me know if this was the wrong
branch.


-- 
Regards
Sudip
