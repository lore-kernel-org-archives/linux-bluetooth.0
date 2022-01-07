Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EFEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 22:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiAGWqS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 17:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiAGWqR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 17:46:17 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9CDC061574
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jan 2022 14:46:17 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id d201so20731488ybc.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jan 2022 14:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=SHl/9zcDxJKicrqdkP1HxMz+9gl0bIPqZNojx1TvFz4=;
        b=kgAN60wfYdvysi9IZelAQKgowsg6BUYcnwpVutfKPHbO7evFo/cY5NvXEII07EvFUp
         MopIDb5dgQdLVVraFPJ3zNIDaevxhiIouLDcEuDNftQhvakQWkse2cgizXyP9uZAyhhk
         7LkiLdFhndqJJ+3cvymRMqLWf1KCvBHmX6zojS74hH5lXuuu23xVeNmNfNQulsvUIzRG
         NkxXg2tNCPM8WvpOoW1yXKrS4m6ZcZob481s0GH2+KGEFL35c62MfBbUawb/ZY+y6IVx
         15zqy/FrLNlJrYQCIWrOTMQKWTNRi9G6krpui3B0kC3v4N4EoFa44HnEuoxZ/5xIcOu8
         Itzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=SHl/9zcDxJKicrqdkP1HxMz+9gl0bIPqZNojx1TvFz4=;
        b=K8BN3in9mroZfWrqnSLXElCC/VXiqPLUPNAjTeysf02LESSDd6U4RkPimnABM57JDi
         btmI2TUiPW0T4/qQ0+H9RmbOyKwjoXxR2YhV3aJiaSKLp4jNwAgV1ry9PWSh+Kv/wZlp
         w17GM7awc4FsQOiRze5ZncX78r4njbbIQHW10fx2ZQYx4yQI64cgKBCoJxPnHzhLrUg+
         jF7EFr3zfHr7Hd26rLV3MegfliSksXH1SXXFDrWb2fu4o/9MUxbFt0PR6xMBwpdzZUbn
         GN99an6d3aPhG9vFWxOCYJ4x3ZAB06lq4rd+DUf510SzXBlOCR4SaaFcjiNITJm6B2ht
         jJ2w==
X-Gm-Message-State: AOAM53228kDbovg9cobKgvMBTjUSrYJTt7hGhK/EkYBBcWW1f3o7uhkK
        UPMlEmopXRfTMrE2zcawejxd2lG44WzHhxeLT8HvCQvK
X-Google-Smtp-Source: ABdhPJwpiGZ+BtQJ9xqnUwala48eGE4TfRHX18Ly90jojXFC6kT3D8eojGkJ0JW5ER/bvE7g8xSQ3+UySIdPto3fDqY=
X-Received: by 2002:a25:6148:: with SMTP id v69mr71085215ybb.188.1641595575610;
 Fri, 07 Jan 2022 14:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20220104234326.3001935-1-luiz.dentz@gmail.com> <61d50096.1c69fb81.3ebbf.15d7@mx.google.com>
In-Reply-To: <61d50096.1c69fb81.3ebbf.15d7@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 7 Jan 2022 14:46:05 -0800
Message-ID: <CABBYNZLCvd_XtOaLJug0pQXf=NJhU7EgF=6-o-mcjdf79BHXbw@mail.gmail.com>
Subject: Re: [RFC,BlueZ,v2] emulator: Add support for vendor commands
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Jan 4, 2022 at 6:21 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=602734
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.56 seconds
> GitLint                       FAIL      1.00 seconds
> Prep - Setup ELL              PASS      47.91 seconds
> Build - Prep                  PASS      0.64 seconds
> Build - Configure             PASS      9.26 seconds
> Build - Make                  PASS      1615.44 seconds
> Make Check                    PASS      13.15 seconds
> Make Distcheck                FAIL      147.40 seconds
> Build w/ext ELL - Configure   PASS      10.01 seconds
> Build w/ext ELL - Make        PASS      1559.50 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> [RFC,BlueZ,v2] emulator: Add support for vendor commands
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #297: FILE: monitor/emulator.h:18:
> +} __attribute__((packed));
>
> /github/workspace/src/12703916.patch total: 0 errors, 1 warnings, 146 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12703916.patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint with rule in .gitlint
> Output:
> [RFC,BlueZ,v2] emulator: Add support for vendor commands
> 14: B3 Line contains hard tab characters (\t): "        ."$........"
>
>
> ##############################
> Test: Make Distcheck - FAIL
> Desc: Run distcheck to check the distribution
> Output:
> ../../emulator/btdev.c:37:10: fatal error: monitor/emulator.h: No such file or directory
>    37 | #include "monitor/emulator.h"
>       |          ^~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [Makefile:8003: emulator/android_android_tester-btdev.o] Error 1
> make[1]: *** [Makefile:4302: all] Error 2
> make: *** [Makefile:11227: distcheck] Error 1
>
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
