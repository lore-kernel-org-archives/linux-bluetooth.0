Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C9BC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Feb 2023 00:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjBOA6W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Feb 2023 19:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjBOA6U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Feb 2023 19:58:20 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7463E2FCC4
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 16:58:13 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id cf42so25793574lfb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 16:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yqQ09GviUPVVrhVbYwFF/0rOpHJfu11IY5x9b/I9Ufs=;
        b=AbCs7Y4oT/V/OwaTotHXsBUVlbOUJCPy3ljEgm6ih7yHuqUKqJxPYr8Zlb4BqA+7Xu
         kGRHTzlakkC+a/ibrC0BDU7q0I2XKu1v6fo9pCyWCpl9BPlSmBcyt8U7BZIcr3zu5ODC
         7KXI358X+0VpPGib1kISJKW1LHwm+umGf+4odPx6DSJIxOEnj6KDUBd2ED7qoRUhUkpi
         nQU8RM3bSKL0aGXvRzLsv1v49FSxIS0Nl6xW0Gj9lHKe/N1ZRkBKB69MsM7Ul6/jUpFo
         Ftoxvox6WY8lc0n3d3oda+QD7X2EtwRS6jRAABHg3b0BuJbCd6YaS+0r4G3n64bp7wuu
         BTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqQ09GviUPVVrhVbYwFF/0rOpHJfu11IY5x9b/I9Ufs=;
        b=km6tfLXfF8ql4fXcyozE67aQTViVpXzk44Tt86VGJOEOU04W4EK3vI8nE2ri75hIdK
         9/kNbWnSPcN+HfGNl1raLuu1qlsbty9NgIBJII+43GRScQPH2ieYxUMylC3LuqZgvDnP
         QRnRxYmQPz5WXKBPxnuwOSgOjQzu7Uno/RffjxO5BB3Hr78KYv+FPLCIDf6c5tsk6iJI
         LCrvE2fBAQrUOCluZsUVxrn67h2LZKW2379SgOytN+8CQT0hSWHECY4MsMy5raT520k6
         gB/vqwD6JR2ge9hXC/Ul6FDnkY6Ih8bR+3B3Cjt+mLAL9vgrQbuk0CIL51+904e/xa38
         qzWg==
X-Gm-Message-State: AO0yUKV7XZJ4gQzsyVxzBjktSU5ivQEOuD1+Sxu56YTUGuOeioXS5d/v
        eRBPuhFESN2A6xiTMX3/XO2xsEMPZWOmotO1UUw=
X-Google-Smtp-Source: AK7set8Vt4gpKrLTNVrb9iPPfad4XQknM17zqnFFOC+hj8tclPxZcIxzOF542RC90qUyaP2f3ToEjG0qVpsd5zTmxtU=
X-Received: by 2002:a19:5003:0:b0:4db:4604:6325 with SMTP id
 e3-20020a195003000000b004db46046325mr869794lfb.8.1676422691556; Tue, 14 Feb
 2023 16:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20230201220704.1543663-1-luiz.dentz@gmail.com>
 <63dae95a.370a0220.25d9.c141@mx.google.com> <CABBYNZKHRbx-uCBQs1kRnbjLETLZ3+_if_68UBq9VzMfHxBbww@mail.gmail.com>
 <CA+hUFcu_E_ixNUbYGOyVKJJ79DX_H2TPaBZDp2uaokLu3WGaBw@mail.gmail.com>
In-Reply-To: <CA+hUFcu_E_ixNUbYGOyVKJJ79DX_H2TPaBZDp2uaokLu3WGaBw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 14 Feb 2023 16:58:00 -0800
Message-ID: <CABBYNZJUYZZAvDXM83Ytc_ZzR8aOi1PwM=qaxV=RdXKc8HNpxA@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Fix potential user-after-free
To:     Alexander Coffin <alex.coffin@matician.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alex,

On Tue, Feb 14, 2023 at 4:45 PM Alexander Coffin
<alex.coffin@matician.com> wrote:
>
> Hi Luiz,
>
> Sorry about the very slow response, but I just wanted to make sure
> that it worked well on our robots for a while (the crashes were
> sporadic before) before I confirmed that this patch seemed good. We
> have seen no issues with your proposed patch, and I would be happy to
> sign off on it if that matters (I don't do much kernel contribution so
> I don't really know if my sign off means anything).

It has been applied already, but thanks to confirming it is good to go.

> Regards,
> Alexander Coffin
>
>
> On Wed, Feb 1, 2023 at 3:47 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Alex,
> >
> > On Wed, Feb 1, 2023 at 2:36 PM <bluez.test.bot@gmail.com> wrote:
> > >
> > > This is automated email and please do not reply to this email!
> > >
> > > Dear submitter,
> > >
> > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > This is a CI test results with your patch series:
> > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=717902
> > >
> > > ---Test result---
> > >
> > > Test Summary:
> > > CheckPatch                    PASS      1.17 seconds
> > > GitLint                       PASS      0.36 seconds
> > > SubjectPrefix                 PASS      0.13 seconds
> > > BuildKernel                   PASS      37.93 seconds
> > > CheckAllWarning               PASS      41.71 seconds
> > > CheckSparse                   PASS      46.75 seconds
> > > CheckSmatch                   PASS      126.54 seconds
> > > BuildKernel32                 PASS      36.61 seconds
> > > TestRunnerSetup               PASS      525.34 seconds
> > > TestRunner_l2cap-tester       PASS      18.69 seconds
> > > TestRunner_iso-tester         PASS      20.41 seconds
> > > TestRunner_bnep-tester        PASS      6.76 seconds
> > > TestRunner_mgmt-tester        PASS      129.22 seconds
> > > TestRunner_rfcomm-tester      PASS      10.65 seconds
> > > TestRunner_sco-tester         PASS      9.84 seconds
> > > TestRunner_ioctl-tester       PASS      11.64 seconds
> > > TestRunner_mesh-tester        PASS      8.60 seconds
> > > TestRunner_smp-tester         PASS      9.80 seconds
> > > TestRunner_userchan-tester    PASS      7.09 seconds
> > > IncrementalBuild              PASS      34.40 seconds
> >
> > Looks like it is good with our tests in CI, that said I do wonder if
> > you guys could enable it to run tests that may trigger these problems,
> > since they normally are not found by normal tests.
> >
> > >
> > >
> > > ---
> > > Regards,
> > > Linux Bluetooth
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
