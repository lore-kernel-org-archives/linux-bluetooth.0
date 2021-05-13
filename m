Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BF9C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 21:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69002613C8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 21:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhEMVMz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 17:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhEMVMz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 17:12:55 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF65C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 14:11:44 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v188so36389776ybe.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lO4Y9kTjPr7jW6LdiF2nTrRQVu3Rxx3XddF7pXSsxXU=;
        b=n3Hy2fEtlzkBpxqMP6OhO5bFWO80FxLW2fy/9YOnpFaDzPgL1fIj9VllS6oiq/QdKg
         I+jHJpBhdAI/vWoUpd973jRMxZQC2aw/O7qiMEClckL2Rp8WNNjrx6KxdfMRNY8yF7mk
         oXFgd10/RAyHJlbKeLFJg0XEo3yj3V08WIeqd+wMlEBAQ6u7PJfHm/2nS3T/m6CeFvwh
         ck4c5ZQvHJOeZeY9JPAvV8DTQ5USKR1q85nYCIsTSkYxzBjSVZWG4WpQChogiBAYWdCw
         owLwDkGgsHVWrt8sUoZ+shXJ6db0T+fIewEFz2s30f/T18c0qHh60PrQ1DzaI+jVOY68
         LDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lO4Y9kTjPr7jW6LdiF2nTrRQVu3Rxx3XddF7pXSsxXU=;
        b=Vyb5Kkd867zHfRjZYdSGsobupV9LgU5JqjQ6G9idy9/uPA/jZkfw6HXlpu8ficcBnK
         UQ6/xe2F2XkC+Oic2MOSvtFGoqfpZYj7UYz3oKOgabTvfjV7qlnQKk6d4yB+FIXOwE9E
         qsdmR5UGVXzvJkhj7YbMJCb2Kn7B+9AE42YQWpiMDbBdDUKbEwAb24qYuaZJFRfZeI4A
         kfgcYjNo4xdhkkN4yCim72BNF2wFdYxaS6RXO72bcWY1JtqAbcjmTORKZrj42LJJ846a
         Wv1cPT7klzuy92MthkeQ4GA2l6VQvmgxUKYhBaJ/DmhhYcmtatJq6swU87IOfWQ5eodq
         BZtg==
X-Gm-Message-State: AOAM5311vkmqeEeHBVOaT/jCF7r8EBpNirk4UYQjbP1F8R2Ag3oBQjfo
        tTu77RZ0LoZLWGBNRkjR8hgbul5pk1F1qZUuSgi8++o9
X-Google-Smtp-Source: ABdhPJzzvaYl4knYDz7U6Ro1j+FDKNzUQYwkMseMph0Rw8GuO66dw105w+uUI6z/1IhcEY3+dkPToLg00SA/zq3HjVs=
X-Received: by 2002:a25:ac94:: with SMTP id x20mr58399696ybi.432.1620940303498;
 Thu, 13 May 2021 14:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210504111454.29697-1-sathish.narasimman@intel.com> <609131d4.1c69fb81.c3723.e825@mx.google.com>
In-Reply-To: <609131d4.1c69fb81.c3723.e825@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 13 May 2021 14:11:32 -0700
Message-ID: <CABBYNZJm1CbiM4ThmFaUu7GA9UkZJHMiHuZrFA6hsOz7amEANw@mail.gmail.com>
Subject: Re: [Bluez,v2] btmgmt: Fix enable adding irk when turining privacy on
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Tue, May 4, 2021 at 4:48 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=476815
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.34 seconds
> GitLint                       PASS      0.13 seconds
> Prep - Setup ELL              PASS      48.83 seconds
> Build - Prep                  PASS      0.11 seconds
> Build - Configure             PASS      8.51 seconds
> Build - Make                  PASS      208.97 seconds
> Make Check                    PASS      9.35 seconds
> Make Dist                     PASS      12.80 seconds
> Make Dist - Configure         PASS      5.25 seconds
> Make Dist - Make              PASS      84.21 seconds
> Build w/ext ELL - Configure   PASS      8.62 seconds
> Build w/ext ELL - Make        PASS      198.03 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Dist - PASS
> Desc: Run 'make dist' and build the distribution tarball
>
> ##############################
> Test: Make Dist - Configure - PASS
> Desc: Configure the source from distribution tarball
>
> ##############################
> Test: Make Dist - Make - PASS
> Desc: Build the source from distribution tarball
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
