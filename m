Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0389C64E7B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 18:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5772151B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 18:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETUiqMKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgLASZM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 13:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgLASZM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 13:25:12 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F28C0613D4
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 10:24:32 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s18so2806113oih.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLQxIt81qTsc598c5JsKHl+MQzqwl88z+WvCFTniS1A=;
        b=ETUiqMKGhDtNRACPBOOUhNYPrr+Pg4+pXyTnr9B/Oqmx35B3VZhsJ2leCSydfAJept
         pswSfO1QXm9tDJkgwbB75A2dUIFcIXknXKBjE/uC940A93GdYKfNjU3F2jBBU4iMcn3O
         p7VwxzyrvbG2vdt34hzxb/VYQ1Ac918BQKpIQxwuSKJD00pQar/HPxr1hEuVXlpLbUxJ
         QBl6GKQs30UkVzNoh8VcTxaWvvV9AOjFuRD6JW5btMG3jQfZXHktPs7g0XhS8XdkH2AQ
         gyVQTh44i+7hp0PoftfFEJa9p8bgBmaAchxY0vHPRKmjClGqfou6R7Q4bQeV8eAb9cDs
         d4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLQxIt81qTsc598c5JsKHl+MQzqwl88z+WvCFTniS1A=;
        b=Bl0Vtq5f2fLDssrKeQVOyl9gMcrw5/v8+6chs3nwgSfHbo3CdCHFLCEmaWyUvdQbNP
         DAzoTr0JOLnYcC6sc2tDciKSaup5FwapKNeMEf6orebadDIgeivrSAzT10M24bhBXi1U
         Qz8CSICB3LWzNvuNLdjo4ZUyQDyXjZVyyE9okBz460KpwWKrKGoJTFkMbCiJYv5rv5Zj
         77hGXkOeGdO9ByWKw2kRKfkHLDJKHWVJvAnxT/DvuBVF1KhHqvkBIkCT42DMTDHtETlA
         qqMnS8KgdfbVeCEHqjNgrUodewjNNId15cvr71FEq1J9MxuwpmPSMweJgecM+Yp5aKqh
         9TOw==
X-Gm-Message-State: AOAM530Omq07o+8y4A1dADifJFCW//fDch5trOWpGlORUNtuyQRYKG83
        /eQth36NRrM9kQxW7tkqNnqqlIUwPulCGrzD27A9WRRl
X-Google-Smtp-Source: ABdhPJy7KQQ4RKrYzB/9ClI/WS1BBJxNAMps3Cu/WDIYQmGdrGQMuzOVCnBpKoba9nTvlO7MEDTxWqSEYjYA/BLkrzE=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr2532982oig.161.1606847070912;
 Tue, 01 Dec 2020 10:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20201124101832.Bluez.1.I3f5d0cd1842ec756731360d5ef1a6c5eb8543336@changeid>
 <5fbd5137.1c69fb81.316dc.ed8b@mx.google.com>
In-Reply-To: <5fbd5137.1c69fb81.316dc.ed8b@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Dec 2020 10:24:19 -0800
Message-ID: <CABBYNZJCNojUYUSddYayF02eZa=5BwM4-nn13k_dkk5FT_=vwQ@mail.gmail.com>
Subject: Re: [Bluez] doc/mgmt-api: Minor reword for Supported Min/Max Tx Power
 doc entry
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Tue, Nov 24, 2020 at 10:33 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=390435
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
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
