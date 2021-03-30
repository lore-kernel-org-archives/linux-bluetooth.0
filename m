Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7132BC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 19:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBC2619CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 19:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhC3T0U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhC3T0M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 15:26:12 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81539C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 12:26:12 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id c16so17598760oib.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGrfVhhYkapBljBOvqCQ+Gle1MhfEmvkJ+ciLDgs2aM=;
        b=kkPyY/B6Xm6AGACECkeVHELZn1gfiZzG/Mw7l8zLOrVeWb1wuULfskg9YjRr1iORzg
         n9wsQIREx9FWgt8xIJtor75boRhz2Fl8ct0X8NpJ2tJDjYSGnSPZIx/PRjKang//L45f
         IVAeuixZOC1DoHqU/853IIz7yUPSfJ2VMUREtoYqirY1LvNHLLGM14F+unMlnQ6uQcRa
         pje3UNw8FWfdUNIN2aIG8dO8ULRwHO4OU9gcDszjjH9rde3yn3VLLrTbAoH+ZyHpOlyR
         WD1slh3m6AdtR6OsedfLhIr8ehsObFbkjj/SqfL09MtrVHZ4PK5YTJEv8CQCh9aRVypo
         lVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGrfVhhYkapBljBOvqCQ+Gle1MhfEmvkJ+ciLDgs2aM=;
        b=VXN5zpWpV2XxdZPm2E0DaNUk9hnDSpDCimnZr+QmHDvDUYCoVujbbwFsySjLYqhhDM
         XHCeMt1U5CvH/vhyrJOBI+pO0ifa/eSKb8XyKC/ykREdLNO8/XswN8sIF7KjsN2/DcdA
         7OUWxQWDKkFtWNQ0SAEix+Ga40jKqDcxVgNc0yCU5r57sWNImP8ApoTWvWL7Syo3zlOu
         bkTG01uxr5eQ24lNuRY147gyGChzFyAYEClFdqmBZ087eZMttJIhr3pxjhHQUNtd7llm
         9nlPdrA+YIQaFhzuozJrKhwbKT6QyzN/ukD577KZC7zWDPTPj2tcRYth74Ucq1AOYtst
         qAhw==
X-Gm-Message-State: AOAM532A+L6t3kyeGkWGbo/IrSDFwYxpjtBv6E1vemGE/Qfnv5J1wuZ7
        YasX0u11CbkXG80tICIn//4uOgI6EPqqPvJFKCZ7aY/5Q8A=
X-Google-Smtp-Source: ABdhPJxFAIN+2wcns0TKL3jioqccAaUF0u8lOoSZplErK9D1rfmAsyePJ58cKJeC28XNaujH5fPPldx6Tr7IPgpNTdo=
X-Received: by 2002:a05:6808:10c5:: with SMTP id s5mr4365299ois.58.1617132370443;
 Tue, 30 Mar 2021 12:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210330183835.17714-1-sonnysasaka@chromium.org> <606373e6.1c69fb81.3c9a6.4c1f@mx.google.com>
In-Reply-To: <606373e6.1c69fb81.3c9a6.4c1f@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 Mar 2021 12:25:59 -0700
Message-ID: <CABBYNZ+6VZ9Oe3pTUpxBxKtJ-yTsxD5defChc2xEgNQAwLSsCQ@mail.gmail.com>
Subject: Re: [BlueZ] profiles/battery: Reset battery value cache on disconnect
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Tue, Mar 30, 2021 at 11:57 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=458277
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild: Setup ELL - PASS
>
> ##############################
> Test: CheckBuild: Setup - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
> ##############################
> Test: CheckBuild w/external ell - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
