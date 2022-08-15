Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139D3C00140
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Aug 2022 17:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiHORza (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Aug 2022 13:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiHORz3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Aug 2022 13:55:29 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172E062D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 10:55:28 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y23so8315872ljh.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jiJZjxAV2C6zOdZA9h5auf49dWojCMKb/Tmz/s5DbzA=;
        b=nSKxV98nPuolrGdQ6MV6rJsD963JlRmVhDGgkhOf5Spx74isxzFkx8+Jdroxk12Osu
         1uBDF817jBzSNleI6BflaDbLTI5xIPVMfeuO76KKcMya/7m2MwckJPxmPQ0aMJnfnDPZ
         NnYNGZqn2WWBy5Q8wCIXYUET8hU3NQLiSgac8g7O191iUcrjFcnvBzBeCqEvNHJEH70h
         g+ygtHxvKLo3DPyEdev/0vuyuFiHwurjuC10lW8Jwk1lO//9dBzOH/JSllXj9QyRvIGI
         hn7BgAk9woT6nMQZr6H7padUQ+fYJ0HceIUvdiZdxIr4xRPl5bHX+HWovxaDsRjEfWV9
         5bIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jiJZjxAV2C6zOdZA9h5auf49dWojCMKb/Tmz/s5DbzA=;
        b=4LMebHs5wwjJ3MYZfdbRZThkY6tV8UmKLCYfzsMmDThw37/yJ0gWOMRTzkKAzrIS+G
         vElf/g42dikNvKo7skCshHXipiXmGQK5n62y03PC1dVbmnu+ukSr7OIZm9tuh2wBb7k8
         DvixvtCPnHYK4DHi6HaTZqVBn/4P2U5tHOe2HM6N26StL/vMWITuYw5iLQiph6opzDzj
         CEuL9H4xZguXqVNF/fzEIQKvPJtByje+sMlJMf3tSGAEiIbh19UwaSs7fqj+alAxgoU2
         ukCZ2KbRXdS2ConurhJF0r9jGZZsNvB47eQuc/DcPevOgYeedXBs1B864Je3w2veoxHR
         unjg==
X-Gm-Message-State: ACgBeo0yYoh54QIVR/76ATH6nCugohT539J+DVL7Su1EGNzTLrv+5C/0
        yHxZPIEbF2Efqp2rsXG3ZERbpkq+BhMob7a194a+h6M6i5c=
X-Google-Smtp-Source: AA6agR7jSXJV/s7YSX7Bk3duETL2KzfIOk56fNyIHUdhYgp+HekuiVdhjAmvC2Mb6Af0ZT1VBMzeYbvWKjzujVQ4wiw=
X-Received: by 2002:a2e:b0ee:0:b0:25f:ddf3:e523 with SMTP id
 h14-20020a2eb0ee000000b0025fddf3e523mr4906321ljl.260.1660586126432; Mon, 15
 Aug 2022 10:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220812223939.530428-1-luiz.dentz@gmail.com> <62f6dcd1.050a0220.5ebd8.1241@mx.google.com>
 <CABBYNZLOxE17vp3FOWR2hABjoCD8M62YLa6_LDdaQeJ=nrnusA@mail.gmail.com>
 <CADVatmN_wx=KJ=C0QGMz5ZLoVECjF9kKJa1X8ay4XWwuszeo=A@mail.gmail.com>
 <CABBYNZL93Q+Mmdk3GOUGt5TLyBN6KwzLGTw81iHHkMPvR0iQaw@mail.gmail.com> <CADVatmOyd8gUqWMx-5CmbKnAdmppk2sGkG=+mh=W4aN1wS6VFQ@mail.gmail.com>
In-Reply-To: <CADVatmOyd8gUqWMx-5CmbKnAdmppk2sGkG=+mh=W4aN1wS6VFQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Aug 2022 10:55:14 -0700
Message-ID: <CABBYNZKBRKVWQ9DFFTU0_nBGZg7va8mpPZ_TwDXtBigt2E06_w@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Fix build errors in some archs
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sudip,

On Sun, Aug 14, 2022 at 3:48 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi Luiz,
>
> On Sat, Aug 13, 2022 at 8:32 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sudip,
> >
> > On Sat, Aug 13, 2022 at 12:31 AM Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Sat, Aug 13, 2022 at 12:12 AM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Palmer, Sudip,
> > > >
> > > > On Fri, Aug 12, 2022 at 4:05 PM <bluez.test.bot@gmail.com> wrote:
> > > > >
> > > > > This is automated email and please do not reply to this email!
> > > > >
> > > > > Dear submitter,
> > > > >
> > > > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > > > This is a CI test results with your patch series:
> > > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667285
> > > >
> > > > Could you guys try with the above change, I think the culprit is
> > > > actually setting c = NULL which triggers some compiler to think it may
> > > > be passed to bacmp.
> > >
> > > I get "No patches to display" on that link.
> >
> > That is probably because Ive send a v2:
>
> I have not tested your patch as the build failure is not present with
> the bluetooth master branch. Please let me know if this was the wrong
> branch.

And you can't apply on top of the tree that you are able to reproduce?

>
> --
> Regards
> Sudip



-- 
Luiz Augusto von Dentz
