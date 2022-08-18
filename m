Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA21DC00140
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Aug 2022 21:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242446AbiHRVav (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347182AbiHRVac (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Aug 2022 17:30:32 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDD9B1B81
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Aug 2022 14:29:37 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3378303138bso35442997b3.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Aug 2022 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WnKP5vI8IXZEV08RdCCoZoNI6TfD+BfxJAloiRFKBtA=;
        b=ZAM9ifX9xqw1MQnzhcEZ+2GsB3p3msIT0XIa9y5WNodYvC+ck4f8i0Hud9e4US0RWv
         gDH/EY0C0uK3TLQWzCSxYDH+cdRwBK153M+eT56TgYqyxji68Uz5/OxGOpmqEa8tMB4E
         OpnYzNmzg3P/SFACr7HN4+usrve+niSJt3D0j7odlz0Z6NidRSjKk2NBD6OU3IfcFR8D
         Zwncd4ZqaRK3GLmD/2vFWz36h5L36zulru/anO19Zpt1BeBdfdgIyz79aEgqtW+2+sDD
         dpvSZL4AjTqlgpRE+IKwhlIdgPREs7/s1L6CxMththTwQXtVAas5w59sOtPr8awc+w4T
         RrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WnKP5vI8IXZEV08RdCCoZoNI6TfD+BfxJAloiRFKBtA=;
        b=8NGCX+xYJ6Yhah207V0DdwhHNTWSP6a5oYNd3asB8txd4z5fiHNZEFdVyY8dfWLZ/2
         5C/UEoSY4lWAr/Ejxfm39XJnIZ3YnTBA8OiGDDBsDVA8zlV5FCiiIYjxL5ZNvPnHmcCi
         DBUQg/buWAeS3V5Ned+44WF2AmPmqTAY4zGuicOW8VrcuJJUDC4fjoNZXKJ7kbWW29r7
         P54mrZB8WBt+hVZaMLrgWXJBS140arplYaARaDOwImgf5IGb/+MScHSmK7ZPa3WzzVkx
         rIeRCmbdjAxggx/0fitkcw5bEIY+JyXlqLLW+bMbJvSBMOg6UoNVGxBDK1lzL8A2suEf
         DISQ==
X-Gm-Message-State: ACgBeo3NcB8kNsYNDA9lf+DdmAZYrSQzruQdjvdCHbt4r8d/ShjhQmZp
        PcdOhu1K+lOyFzj1DNRPi5Mv0jo82lyYkNGht/F371UgTog=
X-Google-Smtp-Source: AA6agR68aJZYb54WLhiWghabCC56pUafXVkeYKuCCGVZiYmf0t8FicBUEi1nzvkFxeVE6VYGFCklfEe2s2lvfNbXjWI=
X-Received: by 2002:a81:99d7:0:b0:336:f7d3:8b4b with SMTP id
 q206-20020a8199d7000000b00336f7d38b4bmr3588207ywg.194.1660858175556; Thu, 18
 Aug 2022 14:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220812223939.530428-1-luiz.dentz@gmail.com> <62f6dcd1.050a0220.5ebd8.1241@mx.google.com>
 <CABBYNZLOxE17vp3FOWR2hABjoCD8M62YLa6_LDdaQeJ=nrnusA@mail.gmail.com>
 <CADVatmN_wx=KJ=C0QGMz5ZLoVECjF9kKJa1X8ay4XWwuszeo=A@mail.gmail.com>
 <CABBYNZL93Q+Mmdk3GOUGt5TLyBN6KwzLGTw81iHHkMPvR0iQaw@mail.gmail.com>
 <CADVatmOyd8gUqWMx-5CmbKnAdmppk2sGkG=+mh=W4aN1wS6VFQ@mail.gmail.com> <CABBYNZKBRKVWQ9DFFTU0_nBGZg7va8mpPZ_TwDXtBigt2E06_w@mail.gmail.com>
In-Reply-To: <CABBYNZKBRKVWQ9DFFTU0_nBGZg7va8mpPZ_TwDXtBigt2E06_w@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 18 Aug 2022 22:28:59 +0100
Message-ID: <CADVatmPsMi+YjS3D=EpeVHWkM79bZgSfTSyejvCP0-VcXAd19w@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Fix build errors in some archs
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Aug 15, 2022 at 6:55 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sudip,
>
> On Sun, Aug 14, 2022 at 3:48 AM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > Hi Luiz,
> >
> > On Sat, Aug 13, 2022 at 8:32 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sudip,
> > >
> > > On Sat, Aug 13, 2022 at 12:31 AM Sudip Mukherjee
> > > <sudipm.mukherjee@gmail.com> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > On Sat, Aug 13, 2022 at 12:12 AM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Palmer, Sudip,
> > > > >
> > > > > On Fri, Aug 12, 2022 at 4:05 PM <bluez.test.bot@gmail.com> wrote:
> > > > > >
> > > > > > This is automated email and please do not reply to this email!
> > > > > >
> > > > > > Dear submitter,
> > > > > >
> > > > > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > > > > This is a CI test results with your patch series:
> > > > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667285
> > > > >
> > > > > Could you guys try with the above change, I think the culprit is
> > > > > actually setting c = NULL which triggers some compiler to think it may
> > > > > be passed to bacmp.
> > > >
> > > > I get "No patches to display" on that link.
> > >
> > > That is probably because Ive send a v2:
> >
> > I have not tested your patch as the build failure is not present with
> > the bluetooth master branch. Please let me know if this was the wrong
> > branch.
>
> And you can't apply on top of the tree that you are able to reproduce?

I can see its already in linux-next and I don't see those build
failures on next-20220818.


-- 
Regards
Sudip
