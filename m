Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2897AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 00:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C6A61407
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 00:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349983AbhKPAZ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350241AbhKOUWr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 15:22:47 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4BFC0D90F4
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 12:05:14 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id p37so35768060uae.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 12:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TQxdEaRJ4xGjBSCAtc5aUG/uHepU0WDC3Z8MEQU+iQU=;
        b=nDmMNqr9bV4rkgW9l4ndDTJ9dTfmta+n2eJexjuGXYWN6SJrGmVqDokLm/5D0RDg3I
         rvOCIm1eBGhE5b+Tm/7oCGqPtvqes51uPnjsMFWhJPUlq/D5AKd7JNIKzHcx/qYOjUN4
         5hTwtIlYntixrnbMjL0XyklXUPyUz7lshPkU4vKDUfO0k+Ub44b/L0RqdfmPDYGKD3JJ
         pbalhmWXgsQvTySCpCo7EBWtcCN5WNu7sbKikbLlQgzbdaCLq47wBsUgaEw9FhvNWKkW
         npCqTo0TsoQrUefGBUDqU8w6iVRdZ8POVllB3Ccxl64fFoY3bEsBNiU6UT9fhYhknT1W
         pRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TQxdEaRJ4xGjBSCAtc5aUG/uHepU0WDC3Z8MEQU+iQU=;
        b=XOb88nObSeFnpJyLgTbONNULNLCv2ZlaEeZMn2t7i604/agzvxE4RSfX2D5u4OHfAT
         2g0kh5Gj80RVISEDZ4dbmMUs9TkAo6Asi2k9rKNOTIA6KIocit5bSv+IJAc+HBNI/RDo
         x1uayfIpZCt1DkQFRxNzsmcLjJLrl+tZQSTWE+vTWj/61TtSXBcGI3srzOfUeFwSxxTG
         DkcpzPmmoHyIzd69dYn034HfEi72Dbb8giu+Dii6aNiPy4/doduFAfKoluJ8/yAzk610
         lCybYeakDE8PNKc6lerRGBoT4USaSzSFo//cJ4GirxJmRSM7PS79UMLq6EyzGyKeEhJK
         blxQ==
X-Gm-Message-State: AOAM533KvyANzeiJbDhAOua9qG1SkJm05Uzeh33RSONwoQBwFYKUDItl
        0H7APs58lTbncdJkM5CUsS2ftxor8L2lAR1nnLZ0YFHA
X-Google-Smtp-Source: ABdhPJzuL+XqpHcU6JWZUGXtvWUDfi7SlG+U8FqaCQPOXfTBbfItHXOiqbM+Txpy7bvvflEDpvWMmVULoy6d9DPirhs=
X-Received: by 2002:a67:fd90:: with SMTP id k16mr46374821vsq.39.1637006713329;
 Mon, 15 Nov 2021 12:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20211112220538.310085-1-luiz.dentz@gmail.com> <618eecdf.1c69fb81.dd4d3.7201@mx.google.com>
In-Reply-To: <618eecdf.1c69fb81.dd4d3.7201@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Nov 2021 12:05:02 -0800
Message-ID: <CABBYNZJZ6Kuzj6Z9oM9REbRSRK0EdOB6avDY_WYzkdpYAtz6NQ@mail.gmail.com>
Subject: Re: [BlueZ,1/2] sdpd: Fix leaking buffers stored in cstates cache
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Nov 12, 2021 at 2:38 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=579439
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.25 seconds
> GitLint                       PASS      0.64 seconds
> Prep - Setup ELL              PASS      51.41 seconds
> Build - Prep                  PASS      0.24 seconds
> Build - Configure             PASS      9.30 seconds
> Build - Make                  PASS      218.48 seconds
> Make Check                    PASS      9.70 seconds
> Make Distcheck                PASS      262.91 seconds
> Build w/ext ELL - Configure   PASS      9.61 seconds
> Build w/ext ELL - Make        PASS      209.93 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> [BlueZ,1/2] sdpd: Fix leaking buffers stored in cstates cache
> WARNING:NEW_TYPEDEFS: do not add new typedefs
> #110: FILE: src/sdpd-request.c:45:
> +typedef struct sdp_cont_info sdp_cont_info_t;
>
> /github/workspace/src/12617365.patch total: 0 errors, 1 warnings, 393 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12617365.patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> [BlueZ,2/2] shared/gatt-server: Fix heap overflow when appending prepare writes
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #89:
> Fixes https://github.com/bluez/bluez/security/advisories/GHSA-479m-xcq5-9g2q
>
> /github/workspace/src/12617367.patch total: 0 errors, 1 warnings, 40 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12617367.patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
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
