Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E54C55199
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 14:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E27B920656
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 14:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVvmP81Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgD0O6J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727073AbgD0O6G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 10:58:06 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25101C0610D5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 07:58:06 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w145so14105404lff.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9yWHu/MnZh09x46GPkTbS23TLN5+4dZz+TmcsF3+LA=;
        b=YVvmP81QmrAM8kfC9K+hXLTYF0xX2OeeareLvZPwysTZoHY08My23cp0uYg/9Vh+fo
         wSAZcz9iJgpKdiaxBjcnEVtAZ9NqmgeuP7tEHFxWA4Q0T47hzZQCk+RLSKu+P4fd0iXc
         UHE4/5a1I5boyY/KFadEz/E5FfPLEZsisogMiDeKaepYVk9j7K8ZijQGDaMdcf4rDR9Z
         T3/55Y4HqvpRP5a2Dv2XdfhLerju5eOE52tvK+bpghkRzBOzN5lE7oOh/ryGisR9AG1+
         YUVKh85xjTy8pAFyxMNYtYxY07a+8WAk9iTEgiQsfF3DKoKRisSysMqxpPIrZq9ApTfA
         kzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9yWHu/MnZh09x46GPkTbS23TLN5+4dZz+TmcsF3+LA=;
        b=QVKQqr5yZmhN00YyeIBNuIiW44/OBcorKx5yaAfFgwlPPFDOMKDrqbKIqnFAQH+zGr
         txqfqMLcOgqyt1UooDj2Xk8DlQY3aXWSUlNt7SVL/yAa2toCJovi88NWvkOH5DAjhQZY
         lErCGQQfWd3s6IA7HNKe1R3AEp34+NXU1VOOOjeknNSk+qW+M6yYXM2H25JlVJmvhl1k
         cxgc27TMZwePuBkfkGeYSDPykyCvd0ulRWKEPOkGDPIFSXWFQj9b/hB21YWzQHgRJLVP
         zqKEqt5DgLY37l3oYvBdHtrcX6aibZbTbvB+GplrplWVzNvnZ5j2Vy0DjLZPg/5jeVN6
         7nYw==
X-Gm-Message-State: AGi0PuZc3kan+4Z6R+/V5iP1Hqt0zWAmQ/YDYbIvg+YxtO6p11JRfy8l
        h/ttRSGJ7JTLnF09T0S37xIeNrwwdvhOgkwJ2wQP/Q==
X-Google-Smtp-Source: APiQypJUgZYtdw2e8Tj+NCOfSfGb1LHscHo/UpCu/45OpsNVNKbPlnjnHnUSEH5KFJYby/KFD1ZWHxu48O/RQyLj3V8=
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr15335725lfo.69.1587999484274;
 Mon, 27 Apr 2020 07:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200423142305.66778-1-alainm@chromium.org> <5347568.DvuYhMxLoT@ix>
 <CALWDO_Vk-JCtViCWSoCZRxhGtKKhFkJZTJKctOw7NBRJwT_zdg@mail.gmail.com>
In-Reply-To: <CALWDO_Vk-JCtViCWSoCZRxhGtKKhFkJZTJKctOw7NBRJwT_zdg@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Mon, 27 Apr 2020 10:57:52 -0400
Message-ID: <CALWDO_XsouHaxheRgR7HGkLxf4U1ag0pxCnVN6zLLqbZF=rjVg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] doc:Adding Roles property
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Any more feedback on this Api design?

On Thu, Apr 23, 2020 at 10:51 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> On Thu, Apr 23, 2020 at 10:42 AM Szymon Janc <szymon.janc@codecoup.pl> wrote:
> >
> > Hi,
> >
> > On Thursday, 23 April 2020 16:23:05 CEST Alain Michaud wrote:
> > > This change adds a new property to indicate the support for concurrent
> > > roles which means that the controller has reported the appropriate
> > > LE_Supported_States (hdev->le_states) and that the controller's driver
> > > has reported correctly handling the various reported states.
> > > ---
> > >
> > >  doc/adapter-api.txt | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > > index acae032d9..1a7255750 100644
> > > --- a/doc/adapter-api.txt
> > > +++ b/doc/adapter-api.txt
> > > @@ -326,3 +326,11 @@ Properties       string Address [readonly]
> > >
> > >                       Local Device ID information in modalias format
> > >                       used by the kernel and udev.
> > > +
> > > +             array{string} Roles [readonly]
> > > +
> > > +                     List of supported roles. Possible values:
> > > +                             "central": Supports the central role.
> > > +                             "peripheral": Supports the peripheral
> > role.
> > > +                             "central-peripheral": Supports both
> > roles
> > > +
> > concurrently.
> >
> > If this is an array os strings why central-peripheral is needed?
> The keyword in the description is "concurrently".  Not all adapters
> support being peripheral and central concurrently.
>
> >
> >
> > --
> > pozdrawiam
> > Szymon Janc
> >
> >
