Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2DFC4360F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 22:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345872133D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 22:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqOcLL1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfDCWzd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:55:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35285 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDCWzc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 18:55:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so319781pfe.2;
        Wed, 03 Apr 2019 15:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RkUkwfze+MZOB6v+aGJ6P55p2QH7EQqjX1pUMD3Y46Q=;
        b=pqOcLL1iDMmtZnCpKHfGYQwRwHJ3gHQ3mVeGpPRi0+FSfSfYKPMG2b3MRukwgFxb0K
         Um2YACfJb4dN3c29VNAw6acgYo1vfWNVXPfSDX2AgaH2+7jYp/hsjQhKV/lYhY19RgFQ
         SUJIlxCw9CXJIMXfUhODjFbRcBx+j7+RPsazu0FnJcpdPplUIG7Tf0A11TFyQVXi2YpD
         q3Dy0ySYLE2OM+7tsdsyHaFqXz2Ans3JE21a667AEYieWYIylkXpZtqnxW9VDke0K2g5
         lAfQAWzDb6e40AocPmJo+RqDQVZHE2ZpNSyB99p4UPBqet07mxhHJq3QrUTacDMoTtHj
         kzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RkUkwfze+MZOB6v+aGJ6P55p2QH7EQqjX1pUMD3Y46Q=;
        b=Ai8jkjqiGXKL4xemlelw6Z/U+7L4YqSb9CfL5W2Z9nJ0TyZSADsOYRdvqD6E2chkxv
         3MI+2Ju8DTc5yXqoCir+quoM9FwU1hd/PqK8ISIo+GelVSre3BvLwW1LjFOKHC1jNk2j
         GFt4hDRK0K60UEyH1UzHwU1lnemLdA8uNb1ZmDv54Z/X+62rRsVdaFbFb+Q9UwsGhzJd
         JtJRnO5atRvwfeqy+ltH/a7yc+vBGUsdlaM2ZlPB202osxlL3qlEwPqfgUrLoxXwFg0X
         7wQGxTzPI7IUPm2z5GNukb0KDsW4jeIRtjQ2pXHSPCpjm3PUoZ4BKY4PmuGAjXiBAgaD
         8/hQ==
X-Gm-Message-State: APjAAAWZr4I66Kd62UIfciB9/dxCM/9fZtIxKFx6rt4TlZ8A/f9B8Bm8
        aZQhivfUNQ8mCKUrBu5jl48KzQDznzZIJPr3ds4=
X-Google-Smtp-Source: APXvYqxh4MjNc/BpFMe30JuWtcBGrfye6Y1Ru4fnWb2Bh0QOQXUvRymdlQJZgFB3hmlbhCkFqFjWSPydBZ0vJ58H+8c=
X-Received: by 2002:a63:c10b:: with SMTP id w11mr2278022pgf.39.1554332132076;
 Wed, 03 Apr 2019 15:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190330072511.GA5502@kadam> <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com>
 <20190402063313.GA32613@kadam> <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
 <20190402195537.GF32613@kadam>
In-Reply-To: <20190402195537.GF32613@kadam>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 3 Apr 2019 15:55:20 -0700
Message-ID: <CAM_iQpU2qwezhk8XdnX+kvUi8Oi0mwNxRuFOo8uGvjZaPZGNWA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing ADV events
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Apr 2, 2019 at 1:51 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Apr 02, 2019 at 10:42:38AM -0700, Cong Wang wrote:
> > I think these likely()/unlikely() are reasonable, ill-formatted packets
> > are rare cases, normal packets deserve such a special care. We
> > use likely()/unlikely() with pskb_may_pull() in many places in
> > networking subsystem, at least.
>
> The likely()/unlikely() annotations are to help the compiler optimize
> the fast path.  They are not there just for decorating the code.  We
> should only use likely()/unlikely() where it makes a difference in
> benchmarking.  Otherwise it's just a style question, right (obviously)?

That is not a requirement.

Unless you have a strong argument to believe likely()/unlikely()
doesn't help in this specific case (ill-formatted packets), we should
by default use it.

Coding style is not a strong argument, it is purely a taste. At least,
does CodingStyle forbid to use it in this case? I tried checkpatch.pl,
it has no such a complain.

Thanks.
