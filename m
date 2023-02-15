Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCA5C05027
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Feb 2023 00:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBOApJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Feb 2023 19:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBOApI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Feb 2023 19:45:08 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D810CD
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 16:45:07 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id v17so25725418lfd.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 16:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GuO4KzjqzOsPm95Uf3DpX3EnhkcH5s2FZAMXMS/dM/Q=;
        b=vs5rLTyh+PwCGkh5/LZnPwDy+T9kg8PYvaBNpDk3X85IMJW9EIsKrtrMfuzgL3PiKp
         C4t/upRKTLfjataYXbeiDSczMn242G/7JZ9gGvPKLYt+us6q0vIT2p+4VF9lKILvWAVG
         31v7Vv3PCLI74Di9IFOG91Pv4W+uYRQ6nlWjuhSsjxUtRp/a2RjxX+ykWvNbc/3Hhekt
         2l4n9P5xVPW66qLE5XNjHvgtu5o6RJyjjAK4m4e8OdYFCkSqzlBOiANI9k4w7QSZt4u1
         fKyglthJfswtkzV9Jd3NUrjPsEXFAW2Kv1rK7YkHVk+aJ7cbnj3TsVt1s9IPlDcNZuLz
         cERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuO4KzjqzOsPm95Uf3DpX3EnhkcH5s2FZAMXMS/dM/Q=;
        b=RF6OlLE0uf3Yd9u3PfPV5WIgFQsgMV8U5pvflPS2mWF8tOGFzcSLbbn2sP53jbGjaX
         YtC+ZaOqcqFAkmb4crUufiIY17rwz4mtbuCMFSUKdN7mqwkAelCoNahLL32glx5CTNLc
         CNrqUnimOmM5Eu9XVzhrKs12wQn5YArVQ+ERlzC4enZgLF7EWulev5xKEZhGm53GM1dn
         EIseDENR0825Htx75ZT14iFZ+qZLYcYBkOzsJ/S1wKp2nkMxHMQz2z74OZuBSaIalSop
         rdHyUZSrlpI/v9ao/IIyIyrEg0yiyUi5PontiK52blm7I0O+85TR2gDu+sDaOfIef4K7
         vlnA==
X-Gm-Message-State: AO0yUKV9IJo0w9y3/0uy9QtbFnwSInDGREh8eyUVMWcWLX3Php3c+uFD
        NIK7vrkCtX2UhhLVN03Y35albBF2l6SWAynG3uTMlg==
X-Google-Smtp-Source: AK7set/stKalvFD21HFDnJjI+Cud7ud5Ndwbslm68xTF840FPBs1oCOVlMTHOwCgkVeBmCppriSNgodyRlj5DjB7AVA=
X-Received: by 2002:ac2:5bc5:0:b0:4db:19cf:5212 with SMTP id
 u5-20020ac25bc5000000b004db19cf5212mr574751lfn.1.1676421905345; Tue, 14 Feb
 2023 16:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20230201220704.1543663-1-luiz.dentz@gmail.com>
 <63dae95a.370a0220.25d9.c141@mx.google.com> <CABBYNZKHRbx-uCBQs1kRnbjLETLZ3+_if_68UBq9VzMfHxBbww@mail.gmail.com>
In-Reply-To: <CABBYNZKHRbx-uCBQs1kRnbjLETLZ3+_if_68UBq9VzMfHxBbww@mail.gmail.com>
From:   Alexander Coffin <alex.coffin@matician.com>
Date:   Tue, 14 Feb 2023 16:44:49 -0800
Message-ID: <CA+hUFcu_E_ixNUbYGOyVKJJ79DX_H2TPaBZDp2uaokLu3WGaBw@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Fix potential user-after-free
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Sorry about the very slow response, but I just wanted to make sure
that it worked well on our robots for a while (the crashes were
sporadic before) before I confirmed that this patch seemed good. We
have seen no issues with your proposed patch, and I would be happy to
sign off on it if that matters (I don't do much kernel contribution so
I don't really know if my sign off means anything).

Regards,
Alexander Coffin


On Wed, Feb 1, 2023 at 3:47 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alex,
>
> On Wed, Feb 1, 2023 at 2:36 PM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=717902
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PASS      1.17 seconds
> > GitLint                       PASS      0.36 seconds
> > SubjectPrefix                 PASS      0.13 seconds
> > BuildKernel                   PASS      37.93 seconds
> > CheckAllWarning               PASS      41.71 seconds
> > CheckSparse                   PASS      46.75 seconds
> > CheckSmatch                   PASS      126.54 seconds
> > BuildKernel32                 PASS      36.61 seconds
> > TestRunnerSetup               PASS      525.34 seconds
> > TestRunner_l2cap-tester       PASS      18.69 seconds
> > TestRunner_iso-tester         PASS      20.41 seconds
> > TestRunner_bnep-tester        PASS      6.76 seconds
> > TestRunner_mgmt-tester        PASS      129.22 seconds
> > TestRunner_rfcomm-tester      PASS      10.65 seconds
> > TestRunner_sco-tester         PASS      9.84 seconds
> > TestRunner_ioctl-tester       PASS      11.64 seconds
> > TestRunner_mesh-tester        PASS      8.60 seconds
> > TestRunner_smp-tester         PASS      9.80 seconds
> > TestRunner_userchan-tester    PASS      7.09 seconds
> > IncrementalBuild              PASS      34.40 seconds
>
> Looks like it is good with our tests in CI, that said I do wonder if
> you guys could enable it to run tests that may trigger these problems,
> since they normally are not found by normal tests.
>
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
> >
>
>
> --
> Luiz Augusto von Dentz
