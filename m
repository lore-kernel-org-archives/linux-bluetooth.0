Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DC7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 22:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354041AbiBKWVD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 17:21:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240543AbiBKWVC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 17:21:02 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1EED48
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 14:20:59 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id v186so29091719ybg.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=MLPx3NlNTXvpdN1sQ19Hn8v2AJ2oB1TBGetHcj8opKg=;
        b=M5KiBvdJ/bTcAG9turhNIwznG8u569JP1n10+1Bb5LRy3ygF+jTmN1lBGWHwe4Rsim
         UsODpBF5i1L2R7fW02LzwEJytexqHDGzVGJzCSHEjEstkrvtgVq6WCVLY2kPQRPYNNbc
         lz2Sa/CoUwDHXhZwNqSed7hkc0sTvn84zbBlnO4b/oq6jzt0+h0PQGP4fdyEb66ArV6E
         3jbv69SmKxl348zd5EDD07SiUU7ICvmkcMB3OcGEJVcUBY4AZdNX7sMkRwYn6/G8tpOc
         KED3ljXtizFL3v5iOemrHenGgyCmi/MrHz+c3irkUgjQOayO4Y+zql2uoQZO7CuA5lAi
         gdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MLPx3NlNTXvpdN1sQ19Hn8v2AJ2oB1TBGetHcj8opKg=;
        b=uO+FR6hr1Ex7JKwPafJRb7+WZixHkQTLDYRu5pZDtO3O8Mx6IOpbuvaGWvFFnbZBDc
         D0RPlYbDut8AfBOuyPKuJvqvPbK2kz88QO9d2G/30oeyhmqUf3nQR1Mh0pqqMq4n8wS8
         fLVW0u/Z1e+m7cx+L7KLX6+LrVN6c+S1AgCqO/wtVuhidqDFfTeYsANHU2sXhaKTSmGP
         ddgl7hAhVPaMYIdgGcqw0EyrK2yGLhoPWXzewDvZ/MgF0NSA2mW5psffMZPxkLh3R8Wm
         IwTxKXJ3H9lF1SB8heACi0M1nN1Dzlq644HKY+NuLYndRKz1UacAUf4GvMOn9mdi3dgM
         J0iA==
X-Gm-Message-State: AOAM531FwBmFYHZbwHiQIoGTRTLQwkNQlanZrgPNFaI/By7KrACKsWig
        R1cr+47bzJaZ1y+x8W2DtBH4shUlCZwgv4XfnB7b7lS3fLs=
X-Google-Smtp-Source: ABdhPJw/mI02wK1HfIRMLwVMg/YUoghmV2Ywix57cFxoH/kloRJ0wswpengiznkWhv9SnlOqUEYeiGddSlFcHq3tDAc=
X-Received: by 2002:a25:b310:: with SMTP id l16mr3500283ybj.752.1644618058268;
 Fri, 11 Feb 2022 14:20:58 -0800 (PST)
MIME-Version: 1.0
References: <20220210225552.573320-1-luiz.dentz@gmail.com> <6205ac70.1c69fb81.e6be8.b6a2@mx.google.com>
In-Reply-To: <6205ac70.1c69fb81.e6be8.b6a2@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 11 Feb 2022 14:20:47 -0800
Message-ID: <CABBYNZJ-BVYyGrWpfnMOUh1YkmR4TgvxCFS0G9MPRMioSmJenA@mail.gmail.com>
Subject: Re: [BlueZ,v2] device: Fix crash when removing device
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Feb 10, 2022 at 4:23 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=613256
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.46 seconds
> GitLint                       PASS      1.00 seconds
> Prep - Setup ELL              PASS      41.27 seconds
> Build - Prep                  PASS      0.75 seconds
> Build - Configure             PASS      8.25 seconds
> Build - Make                  PASS      1386.15 seconds
> Make Check                    PASS      11.95 seconds
> Make Check w/Valgrind         PASS      440.83 seconds
> Make Distcheck                PASS      230.47 seconds
> Build w/ext ELL - Configure   PASS      8.17 seconds
> Build w/ext ELL - Make        PASS      1374.80 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> [BlueZ,v2] device: Fix crash when removing device
> WARNING:TYPO_SPELLING: 'immediatelly' may be misspelled - perhaps 'immediately'?
> #81:
> cause a crash, so instead of removing it immediatelly this set a the
>                                          ^^^^^^^^^^^^
>
> /github/workspace/src/12742555.patch total: 0 errors, 1 warnings, 64 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12742555.patch has style problems, please review.
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
