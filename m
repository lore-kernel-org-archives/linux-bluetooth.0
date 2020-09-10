Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A168C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C8F2076B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxT5rD0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgIJXz1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgIJXz1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 19:55:27 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0E6C061573
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:55:26 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id g26so1870510ooa.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3vcjE6W6V++z0bkq1Mpk4DTV5iecE6QoABm3PzOwgSU=;
        b=pxT5rD0MHT/Z21mcAwb3BSAhf+RWTgeKQhJiN7DbGZFNXWqB02veq7Fr7We+gqeoZP
         yG6Eaj5aHNgyGHD4tLRp8cIUYWgZmF3TESXFWDr9V9YdWpBh+g4Ojdu6cDhhQAPWfWq/
         8qYaNXM97ATZYzGfOrfHP2F8TGaartqwT3RZ7fxS+DDBS3NnUoZFbag06XLF8RZgxCpA
         eAYuTXWn3fvCvwruZeDKtw1rSjD718T8ZON+wUyHqURO5fEjkBRUJMeBzASfnUlH/PT4
         HAIcMFabfrE6JOAEvOShrkJiFES5N7cj2CrLeY/fUQJ0FlkWhobsnMAUUNjbsydis36Q
         JnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vcjE6W6V++z0bkq1Mpk4DTV5iecE6QoABm3PzOwgSU=;
        b=nX2aOfrtXHFLqi2zMxAP8TJdixIZHSg6tE68+sMJoJ1rfp6GILdIBAXY3T0ps9gFuK
         EhNt1Tm6uLQI/oTz62plnJm68bQCccXkkejZwsZCPrwjaY716SepUGFy8U3o+UaJDEQz
         jeD6IUt26FL2f0vTdiEWA0qf/xtz1s0Bk2DtBiUxQCIPsasOAmYin4Y5LdHLVvfFdScp
         QZyXxz0KbyhpA0sLlrEqqgJO1OmY+Unam/FiLJUyUKGbp8GmjPYAiEZVXi9FZP99fVKD
         eghee2ex80+ExrBlru8dTB1h9iBir9Ga7kTUxdsvbQShkHRHaqoH56l+Cczu6Yq0RqOm
         K8hA==
X-Gm-Message-State: AOAM532qk273NacPGMD5sxE3jYlxsQfZmnLlkGCqZxKl2IkTDWNqhqF5
        3uqG96f9KnByW/Afjyox4vuDpF+ChWxPVJV57JE=
X-Google-Smtp-Source: ABdhPJwHj0CO+cUg9W+TSFQS52+9qwAZ1CT9gnaCVDGJINLC5L7bp0LjXRBaQJOTK0ELFDc5m8bWue1BaYEh6Do1/KE=
X-Received: by 2002:a4a:8dd5:: with SMTP id a21mr6308111ool.17.1599782124216;
 Thu, 10 Sep 2020 16:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200910161528.BlueZ.v4.2.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
 <5f5ab67f.1c69fb81.a94e4.274c@mx.google.com> <CABmPvSF1FhoFoz_1yk+eAo-h+xUo2cT4ZHfjN0y37xFLt7wK=A@mail.gmail.com>
In-Reply-To: <CABmPvSF1FhoFoz_1yk+eAo-h+xUo2cT4ZHfjN0y37xFLt7wK=A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 10 Sep 2020 16:55:12 -0700
Message-ID: <CABBYNZJu0X=49XKvJYQH9LT5M9-KBbxXCi+4Anh=50bN12cZVQ@mail.gmail.com>
Subject: Re: [BlueZ,v4,2/8] adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1
 interface
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Thu, Sep 10, 2020 at 4:44 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> Hi Luiz,
>
> The style check was modified recently,so we are not sure about this
> particular license warning. Can you provide some guidance here?

Don't worry about that, I will be working to support the SDPX license
identifier but that is something we can ignore for now.

> Thanks,
> Miao
>
> On Thu, Sep 10, 2020 at 4:28 PM <bluez.test.bot@gmail.com> wrote:
> >
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > While we are preparing for reviewing the patches, we found the following
> > issue/warning.
> >
> > Test Result:
> > checkpatch Failed
> >
> > Outputs:
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #94: FILE: src/adv_monitor.c:1:
> > +/*
> >
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #247: FILE: src/adv_monitor.h:1:
> > +/*
> >
> > - total: 0 errors, 2 warnings, 235 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >
> > Your patch has style problems, please review.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth



-- 
Luiz Augusto von Dentz
