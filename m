Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86456C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFB922285
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 20:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgLHUSI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgLHURx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 15:17:53 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E05BC0611E4
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Dec 2020 12:17:25 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id f132so6313178oib.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 12:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7gggLUMbx6m2RYhALGTMcNyeixCVDzYv2btApbrsK4=;
        b=LqWooF1vkybc+/JA6fHSZU459MnEL0QKmValAHMou3esKj1nqSiTamS/K4zgB6PwcI
         yPsGLOqnundK3Q4mGfAU6cgehDGLLd2agCchUSvkfvk47mhBgVTNX78LA0i1T/cu6Q+L
         AfUSCNVDvv4UkJDdOJjR5LsL7dllXdCm0f3VVJ9XSRL7dcRGctk6LzpiDl6aqHD4kR/X
         eoKrNTbITFp2egkP2Ja9/f3Pd+3bmERaagrp9pVqQ9+q9BzwuuiTjnfIqO4SOE6NmSTi
         Bggu/q3tzYeqOXkdpB7S4umIxrxxNpM1q7Rlq1YG+YHIdknRczZtBXNLMLcJbdU4JwrT
         Mx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7gggLUMbx6m2RYhALGTMcNyeixCVDzYv2btApbrsK4=;
        b=XirYj8PGnR7aqsZ6FVx4T0NfTP8PvS88hEFVRr60KSGMVMO21VnwNTvQFD93OzwmMy
         uzBpihujiYcskLloMO7IKu4IzxzG9G/HGDn3a5ml1WlU1hnxv6tsFeVskRryXuYtLvvE
         geGEu8+JNyKx+bVz/CJy8Kuna7CIXtT2bahn2/J3yTsQh4GLcbCzJcLHEkEBl+GYlIJ+
         VvGgXl7cw7kx5Q7QQ5wgSOlx5pFkQtdwCXvmvolii0BWW5JsTOYOD34RyNt0e2iAevrx
         DvK3so/o+vQHF3kYLNkK5eACUXxKCRsuNhuBwUdfS7agqEG6Nrczc2O4vHmU/zXLZKmt
         J2hQ==
X-Gm-Message-State: AOAM531Ql6bLd4vn49OWrYofET61aj9A4MUs+mPVVHkt3wraqXRHPJV/
        FYvhPc5BMlxtDFZ8eLICdgScCFTVKzsQLdwpG/wg7wm7
X-Google-Smtp-Source: ABdhPJwn7Qk9YS/n532Wr47xpNv+5Sne6mKGw09SdtMF8Bzuy+UJtuicIkT7xy/ntVkzpZwRuD4CdkTxD6Q5EYve3RA=
X-Received: by 2002:aca:f456:: with SMTP id s83mr3815086oih.58.1607454181677;
 Tue, 08 Dec 2020 11:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20201125075707.492685-1-tedd.an@intel.com> <5fbe16ba.1c69fb81.6e3a4.361c@mx.google.com>
In-Reply-To: <5fbe16ba.1c69fb81.6e3a4.361c@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Dec 2020 11:02:50 -0800
Message-ID: <CABBYNZ+_pFFOX=DrwPD1Gbj-7oTVjMLPscT3-VSygsDQbrgNPQ@mail.gmail.com>
Subject: Re: doc: Fix qemu unable to mount root fs for test-runner
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     hj.tedd.an@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Wed, Nov 25, 2020 at 12:38 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=390729
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - FAIL
> Output:
> doc: Fix qemu unable to mount root fs for test-runner
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #9:
>  Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
>
> - total: 0 errors, 1 warnings, 4 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] doc: Fix qemu unable to mount root fs for test-runner" has style problems, please review.
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
> doc: Fix qemu unable to mount root fs for test-runner
> 8: B1 Line exceeds max length (84>80): " Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1 04/01/2014"
> 17: B1 Line exceeds max length (102>80): " Kernel Offset: 0x2a200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbf)"
>
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
