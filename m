Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B08BC433C1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 20:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3C361993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 20:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhCVUUF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Mar 2021 16:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhCVUTd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Mar 2021 16:19:33 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B7AC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 13:19:31 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id n140so14459843oig.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 13:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWmoeEeDSAFxIBbGtfveCErAkGQgDTMZ2bj1ApTgHHQ=;
        b=CmHNo5UKhTGLCsbswgmtaom2HzMUUdtxjTL6Cc4qkNkEzSgoL1nrzrHzPs5rudYVQh
         W2kBAvVD4CUbPVHyCZVYk4LVpz5NGG4eTlFEf0BRhQDWULTcjuv+WPfVK0LpVk3kEE9z
         ukqTNx/puMV/mO90cJAbL8wON/ln3S493Z+w36F9p4Cq0314jnxy5Xhd1ysWE77j+lLx
         4qPFWMZ6QEjE1cEuTJK7HS6HctDEmiBcZunlrO3IXQ9UliAd6VjdQqOmnYmp8mFSOUWB
         zqMOQuWZtN+JuoU8lEqHG1fLV0nmtQxetmR2pf/BnjedrFiWv51p+pmeTQ6YoWdPqcHV
         OKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWmoeEeDSAFxIBbGtfveCErAkGQgDTMZ2bj1ApTgHHQ=;
        b=uBZuiK6eVm0Xl8ebE20LbPCysihtl94wnPZ0NGjkEPvcnAji/z7jZ1hMsxGHiXaMvc
         0+ma3+VrKPDKWmVK7NUaeUumRs8BQy/7/KEceC2FNw6Xda2ZXBnGvuvfGTIVC2+Hjf4A
         f+Oc79+sLHDz+s96+ZTk6dksM6vRO9dDEhpZd8eANVFgtlrR5WQAoabdKS5jCOBsfNGs
         B/AS3IkHCJpfEIV0WIPr/QE8etj8o49BZcB+1ldBCEl84LpOOgZ5Q01fXt5Zh9YHNASr
         zw/Qh8RhovOcjvQkn++MLfMgv2I9B64S/ZGIEGEW9L5QgH9aP/zZQ5QxbN5+tYenPqF+
         NTCA==
X-Gm-Message-State: AOAM533aNzfiwe71mg6+XRCNrTLXwaeN6su7inznvFbzJLCK4QSTIx+Z
        3Mh1W2yASm430jNsFezwwv7SRMbbhcyxXazrFnI=
X-Google-Smtp-Source: ABdhPJw4vLXxVy2z9Q3Sm8DLdH0ayfl2XVEQ4nFQwAxxQIouihgbEezHzlpUkFVFiQbF0tu2nsUYZtJmgS1NDnmyjJ8=
X-Received: by 2002:aca:b645:: with SMTP id g66mr600451oif.64.1616444370533;
 Mon, 22 Mar 2021 13:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210316224957.3294962-1-danielwinkler@google.com> <CAP2xMbthhGqO89va4Z9VKwnZi_h_Bg1AeOdxzLfPHCM_AXJW6g@mail.gmail.com>
In-Reply-To: <CAP2xMbthhGqO89va4Z9VKwnZi_h_Bg1AeOdxzLfPHCM_AXJW6g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Mar 2021 13:19:19 -0700
Message-ID: <CABBYNZLoDpH-QbyR+jwhainpTGA2X5EPewU1xDpr96M1LOj0ag@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 0/2] Bluetooth: Fix scannable broadcast
 advertising on extended APIs
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Mon, Mar 22, 2021 at 9:32 AM Daniel Winkler <danielwinkler@google.com> wrote:
>
> Hi Maintainers,
>
> Friendly reminder to review this V3 patch at your convenience.
>
> Thanks!
> Daniel
>
>
> On Tue, Mar 16, 2021 at 3:50 PM Daniel Winkler <danielwinkler@google.com> wrote:
> >
> > Hello Maintainers,
> >
> > We have discovered that when userspace registers a broadcast
> > (non-connectable) advertisement with scan response data, it exposes a
> > limitation in the new extended MGMT APIs. At the time that the
> > parameters are registered with the controller, kernel does not yet have
> > the advertising data and scan response (coming in a separate MGMT call),
> > and will default to a non-scannable PDU. When the MGMT call for
> > data/scan response is received, the controller will either fail when we
> > request to set the scan response, or return success and not use it.
> >
> > This series along with another in kernel will allow userspace to pass a
> > flag with the params request indicating if the advertisement contains a
> > scan response. This allows kernel to register the parameters correctly
> > with the controller.
> >
> > The patch is tested with a scannable broadcast advertisement on Hatch
> > and Kukui chromebooks (ext and non-ext capabilities) and ensuring a
> > peripheral device can detect the scan response.
> >
> > Best,
> > Daniel
> >
> > Changes in v3:
> >     - Use helpers to determine scannable rather than generating earlier
> >
> > Changes in v2:
> >     - Check kernel supports flag before setting it
> >
> > Daniel Winkler (2):
> >   advertising: Create and use scannable adv param flag
> >   doc/mgmt-api: Update documentation for scan_rsp param flag
> >
> >  doc/mgmt-api.txt  |  5 +++++
> >  lib/mgmt.h        |  1 +
> >  src/advertising.c | 24 +++++++++++++++++++++++-
> >  src/shared/ad.c   | 17 +++++++++++++++++
> >  src/shared/ad.h   |  2 ++
> >  5 files changed, 48 insertions(+), 1 deletion(-)
> >
> > --
> > 2.31.0.rc2.261.g7f71774620-goog
> >

Applied, thanks.

-- 
Luiz Augusto von Dentz
