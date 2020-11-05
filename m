Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703E1C4741F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 18:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D326206D9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 18:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH9g+4tl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKESys (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 13:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgKESys (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 13:54:48 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D667C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2020 10:54:48 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id x1so2718824oic.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2020 10:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=uc2IvffaUtsOM9KoImQgVx4zx52N4WsioY5p6fRQYfI=;
        b=cH9g+4tlnAB8ln60JqqpYim0YScGI7IV+GJeb1eRjFuJAj7CAgj/iZrwa6ZSlNY40J
         ph1JX9+I4TK+YDHmZ/9KhHeUFd9U+5Hs4JI4ETEXhYoDVYbKUCGmGX6sfKsZqGcrIgjY
         kElLyr+9yhfrtIPOYYTYlqY/nhdgRbuxAMEEKuVIur/44PUPWmyHEsTk6iY7OZAobDIh
         8sYG52hPB3b8rt4jW07+vGtIlb12rnrUJWTqF3pg3bEjFnpNvPBFpt4VWj9vnVdpo6+Q
         QdKFN5G/nZsKKaw7+lYFE55PjZW316s4deEsl2a9t5J6xNcXU8Jhxk2LvxiL1tdyB4OR
         +zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=uc2IvffaUtsOM9KoImQgVx4zx52N4WsioY5p6fRQYfI=;
        b=FqcW5beMerLnfAq9US/BGQK5kLGq6xkUr3YLNQ6gElaWK0YUWuTFLtQhwxTzIxxL/3
         5bNmF7vT1vmS0UPPjXVzLI1kp4oIOOgD+B1uBzIo3ELlHy/NFx1vv3ES3KLt+mE6GGoK
         5tWJBvBGrRSAZnWZrVEc33gjL52AGk69i9sWIGKKUYtUReepprdzUZDbMQGYbYkyqr7v
         mVE91z1CuGTbd0DnW2oHg6ckBspMR7+4nZUYPs6fXFrWZMSbXD/H3TppFGKVYf4Jb92Y
         ElrF5LFjywVS3UmAArJUVGAyV+XT6QjxljGdLBILEg6zcqQQdtHSPc0XlZc7TU4o5Ez9
         L9Ig==
X-Gm-Message-State: AOAM530oqUrly7K4Kjmc0kukKgK61x337r9E//xLDjRH2wewkp6QLTVS
        NPJAoeHHkXru7/P0Xqja3Vjw7hUCOGcj0k1R70+J9rvgqNE=
X-Google-Smtp-Source: ABdhPJx8XZzCExkAE8+CsYOi1vjwxXnnZlnPSZ31Q52UfkqkIA2DWmE6FOkqz7E8b1WHmWrg2MrXmn/Hj7Mr0wolvKg=
X-Received: by 2002:aca:d889:: with SMTP id p131mr512552oig.64.1604602487135;
 Thu, 05 Nov 2020 10:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20201104234228.2257427-1-luiz.dentz@gmail.com> <5fa34d29.1c69fb81.6ce35.55d9@mx.google.com>
In-Reply-To: <5fa34d29.1c69fb81.6ce35.55d9@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 5 Nov 2020 10:54:36 -0800
Message-ID: <CABBYNZKWmiA6-ZjfKCdJ+zZ0FVT4cXksi4jqCemsQmPtLsuBdw@mail.gmail.com>
Subject: Re: [v2,1/8] doc: Add tester.config
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Nov 4, 2020 at 4:54 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=377723
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - FAIL
> Output:
> mgmt-tester: Update set_connectable_off_adv_param
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #16:
>         Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
>
> - total: 0 errors, 1 warnings, 78 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] mgmt-tester: Update set_connectable_off_adv_param" has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: CheckGitLint - FAIL
> Output:
> mgmt-tester: Update set_connectable_off_adv_param
> 13: B1 Line exceeds max length (89>80): "        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)"
>
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS

Pushed.

-- 
Luiz Augusto von Dentz
