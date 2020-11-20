Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6A2C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 22:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE0622470
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 22:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KlizvF/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgKTWLW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 17:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgKTWLW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 17:11:22 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3122C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 14:11:21 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a16so14979544ejj.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 14:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=jumuMyLDMpRZ2LMewYlrpSZGTOyDWjEL4q3GXX1ylhY=;
        b=KlizvF/CODuPMRqds8ZIMr+7uLUGUbqlwwKNMPI2Tf0KQebDCjwoh//yzExQMGZGLG
         cgUMmcpn9rDFD/nLyYsrO0D9qcTwOp/Gx49fEJodPMFm+EDdHzLhqK3zicnspA7T5YOR
         pfBpyy910+7k1jYpN8n81zokXHrha0LWUvwMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=jumuMyLDMpRZ2LMewYlrpSZGTOyDWjEL4q3GXX1ylhY=;
        b=PK0K+kAid78NvDalGzfjDPiDzVQMdbCTJqUUVdXpP7248YCB77W79zjs7K+d8yWFlu
         dT4U2/lznB2oZaKOdDNHu86LnvkZVjrxvFk5kDS0DFSu1iZsgdOHhB+TNopTN2BpxAyI
         zrKIpmKgdl6IF/B9iBmHR/fsykPk3NUB9zOjDDI/xcJNXJ1/JgBEEd3EQN2kfFYp6/xL
         tJtS3zHENCB9OujTcqew9NLo//O1NCwhJXSFSBsmb3HuDDsJ0Ym2pviXL+dTw4rpOil/
         4W5m8Lv9/NMvhYvvy7Fi86XHKziLR0qkT9fXG2Nrt8jxY9KVKwmx0RJf/8vwuugltlYR
         gSRw==
X-Gm-Message-State: AOAM5311dNbuktnzcZYqSePJD8y8vehaiOgRHYVL3+wAxUfny8fxHrpY
        Pl/wtx4jP1SNQdddf8SXPJrgmCUiG4wNAQ==
X-Google-Smtp-Source: ABdhPJz93DX/JsKjMwHq/zJC8WIpS7wjHxHzX3ywKBZz3mG8IIJ6GfnIwwzljvy3RnwzaiTL3CNlPQ==
X-Received: by 2002:a17:906:7c9:: with SMTP id m9mr34042707ejc.178.1605910280371;
        Fri, 20 Nov 2020 14:11:20 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id o7sm520714edv.17.2020.11.20.14.11.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 14:11:19 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id s13so11679812wmh.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 14:11:19 -0800 (PST)
X-Received: by 2002:a1c:6306:: with SMTP id x6mr11854534wmb.154.1605910278718;
 Fri, 20 Nov 2020 14:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20201120205728.339325-1-sonnysasaka@chromium.org> <5fb83499.1c69fb81.6e77f.22e1@mx.google.com>
In-Reply-To: <5fb83499.1c69fb81.6e77f.22e1@mx.google.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 20 Nov 2020 14:11:07 -0800
X-Gmail-Original-Message-ID: <CAO271mkbbaHmECWdyXVNcH-X3-9MPMPfs6UKaDSVSV599mTMyA@mail.gmail.com>
Message-ID: <CAO271mkbbaHmECWdyXVNcH-X3-9MPMPfs6UKaDSVSV599mTMyA@mail.gmail.com>
Subject: Re: [BlueZ,v3,1/7] battery: Add the internal Battery API
To:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi BlueZ Maintainers,

Do we actually want ERROR:INITIALISED_STATIC and
ERROR:EXECUTE_PERMISSIONS checkpatch errors? If not, I can help
changing the checkpatch config to exclude these.

On Fri, Nov 20, 2020 at 1:26 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=388695
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - FAIL
> Output:
> battery: Add the internal Battery API
> ERROR:INITIALISED_STATIC: do not initialise statics to NULL
> #71: FILE: src/battery.c:38:
> +static struct queue *batteries = NULL;
>
> - total: 1 errors, 0 warnings, 215 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] battery: Add the internal Battery API" has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> test: Add test app for Battery Provider API
> ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
> #12: FILE: test/example-battery-provider
>
> - total: 1 errors, 0 warnings, 230 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] test: Add test app for Battery Provider API" has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
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
>
