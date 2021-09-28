Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBE5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 21:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5656F61390
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 21:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbhI1VoF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 17:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242954AbhI1VoE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 17:44:04 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0D6C06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 14:42:24 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id y141so586667vsy.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 14:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FU7nrQtTEoOSaUvBqOz6qRicVVFN7E+tvu6/F7YtNmQ=;
        b=nRakV/jT3IxzigyWM58KkLvAvHg2wcP/M1uV8BdAJpVF1hWYEBb9f4AmOwXTbCtMeF
         M7WpKocLX+Mi90WyK+sdj+Y/alm+Rho3yKzKf1UjYCXwq3ThtHfPdrGbv3awQevKp0PT
         v4nZ5XXf78eiO239ejG3+bww00qn/4sEZNiXJonPIcZK523m9eeRt5UkfqWmJw5a8Ynf
         pHKMTHon0FzW4QACz/iLyCuIGs9vhETtAdSsEEaa6p9uUdH2Em3hJKKJWdvrwfQduHxr
         BgBsRPas/HbV0q6hxAF0CUgm5yavDPz6H5sqtyyTsdrU8RiTR9dr8NVEob03bbmZnXbe
         pH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FU7nrQtTEoOSaUvBqOz6qRicVVFN7E+tvu6/F7YtNmQ=;
        b=rbsxFGFOEMvn+BNtQ345mXYznAWzBqf/bsxHwR+PYPbR8Xt9vpTRlFL1Z1sY1A5w1y
         HSaD8hCRAjIhxD6Y5eI2PG5hZ2uVqEzgFKlUloWNsu6mmavBWz6LT8+uCyX9MB4O7xbA
         kX99FKwUU9I5JwulhIxXKinq+DezP4RPcBc5MYvn5vwHVsjvBvxdei3vXYNkdZPD3x2t
         8jElNpzvXqiwQUHk6HqF9SUAKurdHd1LFla3Jvzwu3sgCOi0OUF5u/NmxHypQcyG+kUW
         +8qK9bmBS4oNc6bH5wqGGd7wBraEhDhTpiLOD948UykMRgcfmkSVemsBzeCtwLr82+XU
         88pg==
X-Gm-Message-State: AOAM533pLHZx5A8gMtJ9tpUKTEiB7RQzJ8GIkuponYyuM5YB9quXVZeQ
        jMrllIVhxpA0epdWy1YtOIzCbKZfwBeph2m73Fz2H5be
X-Google-Smtp-Source: ABdhPJxEa2/BuVSBIrMDoaGYCxg/B+g5xnJeBUidZtFf302Ubajeo//h2xue0E9NMfrAxSDvJThJaoZF854DSd2KCUY=
X-Received: by 2002:a05:6102:318d:: with SMTP id c13mr7930247vsh.10.1632865343621;
 Tue, 28 Sep 2021 14:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210928101015.27026-1-marcel@holtmann.org> <61533dc6.1c69fb81.11664.6d67@mx.google.com>
In-Reply-To: <61533dc6.1c69fb81.11664.6d67@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 28 Sep 2021 14:42:12 -0700
Message-ID: <CABBYNZJX4_+u43LwYuJm=+MfLazt2g-GoF0HxUxKBCNWxzU3Jg@mail.gmail.com>
Subject: Re: [1/2] Bluetooth: Fix handling of experimental feature for quality reports
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Sep 28, 2021 at 9:09 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=554141
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      2.98 seconds
> GitLint                       PASS      1.76 seconds
> BuildKernel                   PASS      565.64 seconds
> TestRunner: Setup             PASS      418.20 seconds
> TestRunner: l2cap-tester      PASS      9.41 seconds
> TestRunner: bnep-tester       PASS      5.05 seconds
> TestRunner: mgmt-tester       FAIL      81.04 seconds
> TestRunner: rfcomm-tester     PASS      6.25 seconds
> TestRunner: sco-tester        PASS      6.48 seconds
> TestRunner: smp-tester        PASS      6.54 seconds
> TestRunner: userchan-tester   PASS      5.32 seconds
>
> Details
> ##############################
> Test: TestRunner: mgmt-tester - FAIL - 81.04 seconds
> Run test-runner with mgmt-tester
> Total: 452, Passed: 451 (99.8%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.103 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
