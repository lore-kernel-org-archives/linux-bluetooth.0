Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A77C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 23:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D336C61179
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 23:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhDBXGC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Apr 2021 19:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBXGC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Apr 2021 19:06:02 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFF7C0613E6
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Apr 2021 16:06:00 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so1586260oof.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Apr 2021 16:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkolnSOed/sic9v3uEHY2PYZtAzNx4BTgZc9yuLdSh0=;
        b=LqHazo9m6n6/A4PDw02t2QIjPVVve/wrZO+bbucAhAimVMLzbQTvoPEJC4VrsOjSd4
         WFzCf/9ZrkfK/V3ziaPhUqIly7gwD0laUqBUi3f+Z2mWK15vNCOS8dzG/MXQSfQloMKR
         McSyzlnEIAdluilybdI/1gJ1K+fBW5JanjaAE4SjCcz2GkgxuOkowFc870xqAtmOTkOP
         pvHAnFNsSmoQVRmLhxJiw3Z9X/63GmjrQy/prSYxBhKH3BJUnsoVfT5TI0xuUmSIRbnf
         sT4JlL1FXOOG6eKgZmhd70msE0oyN8m56vjeKg5hooWU9TXiayV17ATjh7sgpmuonEjB
         3ZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkolnSOed/sic9v3uEHY2PYZtAzNx4BTgZc9yuLdSh0=;
        b=AvKE+Si9nfD5yiL5PQGNZTRQTPauBX1yWw1oHuOLLi8LlrdENuRosWFqJZ4klgV/Ec
         /WvE1wtx/TuL2PwoA8iYvE1lo3eUFA3HJfBSVv58fhWg3t0LY+msTCcLRjrCE9Y1bdgd
         jjoubh9PJEF5YxSzIRwaa6S8geRk+ACFW8xPebFYe/nYT/mZE3+jF2YNEanEBOc/jVxY
         wpnOWodP5teJnCBP5aAtdwtF//98pNdWjB2sX04vmhl/8r6c5zj+f1JjA+i4Ov4tdh+s
         KEF3NBeGHaPKWRGc1YB6zko8ly3k+UWvHPzplq4azk4LFj/Ix6yn2sJM1paclcwGuLgX
         uG9A==
X-Gm-Message-State: AOAM5320kcDY0AnQdde4qXfe6r1qDRdtrly8wM6GHoQ6V8Cq65uBq5j4
        DA6M6jBEww1dmGVKRAQGg3eOkHEss3tCHXe2P4hksBlM+6U=
X-Google-Smtp-Source: ABdhPJwGvXKDzLQi9N3NPbBFmp6jtRWkilbf1UG02y+jqymcAKRRS1QlwLzBnHi5C+CHuYOHJ4eVd1pQ1DUmjOkHddk=
X-Received: by 2002:a4a:21c2:: with SMTP id u185mr13544782oou.63.1617404759020;
 Fri, 02 Apr 2021 16:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210402110008.v1.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
 <60676858.1c69fb81.d8cc3.d6d1@mx.google.com>
In-Reply-To: <60676858.1c69fb81.d8cc3.d6d1@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 2 Apr 2021 16:05:48 -0700
Message-ID: <CABBYNZLhnNqVPBEnxbe7=wYCG0aT-hzC2_bCZCSOJjasLGPy3Q@mail.gmail.com>
Subject: Re: [v1] doc/mgmt-api - Return connection direction in Device
 Connected Event
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yu,

On Fri, Apr 2, 2021 at 11:56 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=460347
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
