Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0AECAAA3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 18:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344806AbiHZSec (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344903AbiHZSdn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:43 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48856E58A8
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 11:33:29 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bx38so2357223ljb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ojne3zL5EmkXrrM/c0Bxi3rKGKnZljXvBL5fDPKXH1M=;
        b=plzOGRn5WNAsKc6PXDCm777o+JK4A2SBn5WmaufHpkBjVFBqV1fj5FTcoG+ER5FXHI
         4FH5IzIGyGFB3w6QgkKB2g2imIGU7NLIMI+99N4b+xibtl3w1LAp5UmyWvSY4GujAoL2
         EEqi61v3Z94NzA/Rv7MLzAclzE4T0tMktdg48pNLCkyVh5XFl03633LMXKdPeS9A8nr1
         OrZw1WopOB0lviYvPbLuJD+nOrKpgqUUFwY0qHSmmYoFP9I+hKVxMgz2+CwS6ugkNzJy
         3o2T6cH7AuatKQXJjypOppFmEEVOTTv6EYhy2tGF3xOzmfCUwunTsFvo87z4Xcu8z3mQ
         Cbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ojne3zL5EmkXrrM/c0Bxi3rKGKnZljXvBL5fDPKXH1M=;
        b=ogqjYTl0Uksg4+H8WS+LrgotInVm4wDC6MTWdmU+9BZZc8Bm46Gt8pKKmNCkWyVzxV
         saeWHyIbGpW59HOrHW3x6oKGOVJdG+twCwM8ST7EPibVOCfHcc+0No3rhZlzovSbVz5J
         C2V/gWymTdQz6wfcmobop3nXDoGQst31begJ/wD1aCUTma8DrYUe2E6bXKvf0cujG5e1
         QeAUb6DOF7z4OofFJsgkGnhnm2X3GPHLy78d4S0Ksi3DKr+qWNPUFwsdMPM99nHOxWy1
         8G1AMp7jrQc3gavQpGoAzaa7X9dMeoiPVIcTBAuzmIQXI6/yjB0VsVunfHJ0icOHoIs/
         +sfQ==
X-Gm-Message-State: ACgBeo1A46c6v0bHENwxNhV8hccpaA0m7aeta11hACVNvpvcmCam7/As
        78DfwylgQ89irFnEytHfbaPKtOUYxsoCZFUfYr4=
X-Google-Smtp-Source: AA6agR6ciO9DtXwwWZOv5NRj4PcXGbhuQlT4UEC5oex2xl2r3vmw6Uoqe0F6nhcyTUuQ5uJFHqkEvOD+5owlyZW/dq0=
X-Received: by 2002:a05:651c:54c:b0:25f:dd42:5d06 with SMTP id
 q12-20020a05651c054c00b0025fdd425d06mr2873832ljp.161.1661538807425; Fri, 26
 Aug 2022 11:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220826101509.124704-1-hadess@hadess.net> <6308a0a8.170a0220.879ef.1fff@mx.google.com>
 <75d7a9e5eb2a1025c7a353016d6173e91c989560.camel@hadess.net> <0dff9adb525bd19beb29ebb95dfb28b85a4aaaf8.camel@hadess.net>
In-Reply-To: <0dff9adb525bd19beb29ebb95dfb28b85a4aaaf8.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 26 Aug 2022 11:33:16 -0700
Message-ID: <CABBYNZJBeY4C9Pa9DX4hKXbQaA2sQwYzLAy_SkbJ=M9ytnbDsw@mail.gmail.com>
Subject: Re: [v3] adapter: Implement PowerState property
To:     Bastien Nocera <hadess@hadess.net>,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Fri, Aug 26, 2022 at 7:26 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Fri, 2022-08-26 at 13:44 +0200, Bastien Nocera wrote:
> > On Fri, 2022-08-26 at 03:30 -0700, bluez.test.bot@gmail.com wrote:
> > > This is an automated email and please do not reply to this email.
> > >
> > > Dear Submitter,
> > >
> > > Thank you for submitting the patches to the linux bluetooth mailing
> > > list.
> > > While preparing the CI tests, the patches you submitted couldn't be
> > > applied to the current HEAD of the repository.
> > >
> > > ----- Output -----
> > > error: patch failed: src/adapter.c:643
> > > error: src/adapter.c: patch does not apply
> > > hint: Use 'git am --show-current-patch' to see the failed patch
> >
> > I don't understand why this fails.
>
> Is the repository that the test bot uses a different one from the
> git.kernel.org one? The github.com one is lagging behind by a bunch of
> commits.

github action has stopped syncing the trees, I'm waiting @Tedd
Ho-Jeong An to return.

-- 
Luiz Augusto von Dentz
