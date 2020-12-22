Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE914C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 21:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C6122AAF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 21:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgLVVYy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 16:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgLVVYy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 16:24:54 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B66CC0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 13:24:14 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id a109so13248243otc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 13:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDeH2EyE3QYGPcn75Ulnfm0MAO3kSqjwbZe0nKe92qk=;
        b=Vdpa8pWWnyRLdcljBV/Jcm5bzK36TeOnY4jEafGoP2UJlDNwYXI/Vmj+IgE7RanJ1K
         8m8dJOCdj00+T2Q4iex3u6PwX3Cy9xG+nEC7iuKuUzXqlUOSUtB8CEAc+RF40u8HD9hB
         5PUc8X8Bse1aahK/WofvnjVNc/cBtpmiFSvgk/BkTbJeLiRV/50BVHPfqEQfpdoAyb7+
         obcFPLjAw8x+5g82n7ybB+pZCcnV+FrdDqIDjET9Oazl7EJ46VaVqk73KTpXX9tbCEJu
         JgxZyZA4rya1Uey3noGXloFjYZOOMR/5KQXuU3ZTe2MCe6dH8DU45E1wUz2fv93fyC9O
         0sMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDeH2EyE3QYGPcn75Ulnfm0MAO3kSqjwbZe0nKe92qk=;
        b=I+CSLZ36IztMKab1W/Xcy3j/05d2FF9F+kjElUmT9X0070kiuvocr2HUwcuRCoSRxm
         T9aHbV2ZTiGvIXLnuuvesHvTbA4Wxmzby6H/qegVsDDDRZvYfzmXX5ZpLsPR5TjQg/kT
         s1OYAUsZGsgxXn1Pzxf2H4w7d7WGrjNpJWqfswBXdgdU1oEY3Fgeh8KmPD8dnCnfpDYA
         T2fK7wzKGpbaqHALl6FAftIvU2j4yY611JxC/9sOzQUbKsW2745wg19V6uFzNoHkx4ng
         IcfhzA6UuC3hXPeem3C2EZR8oZFbBipJvjuS6Tb4NACHlSxwDzQOOAlSE5gS+U8xm1jl
         TxxQ==
X-Gm-Message-State: AOAM531QTEiJkdo/C/Jw1y48gNrZGSbMdleHQe0vzv98HCWb8abu/idU
        ZRhLhUykpaD1NvkLO5rPcysSgUUc3O7xRRlz8b2QdQeM
X-Google-Smtp-Source: ABdhPJyTm+59FcA8K2VdktQP4QF5AcSMDADEh7U78n54YCn6hoIsODGBFn6H80I9H1nILXJGKqBLdOn+sCZn3PEmRiM=
X-Received: by 2002:a9d:6f17:: with SMTP id n23mr17349091otq.371.1608672253603;
 Tue, 22 Dec 2020 13:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20201222204547.27839-1-jacob@teenage.engineering> <5fe25e1c.1c69fb81.113cd.5f32@mx.google.com>
In-Reply-To: <5fe25e1c.1c69fb81.113cd.5f32@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Dec 2020 13:24:02 -0800
Message-ID: <CABBYNZLe39BOJ6f+gLPK_D3B6KTRcg06e=w_apRaKxJBh3fV0g@mail.gmail.com>
Subject: Re: [BlueZ] btmon: fix buffer bound checks
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     jacob@teenage.engineering
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Dec 22, 2020 at 1:02 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=405519
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
