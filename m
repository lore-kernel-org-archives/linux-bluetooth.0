Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737FDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 18:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35EB222D04
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 18:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbhAESok (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jan 2021 13:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbhAESok (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jan 2021 13:44:40 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0026C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jan 2021 10:43:59 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 15so603481oix.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Jan 2021 10:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxmL8pWXF+dgOFsihR4V/k9s75zjdHZ/h0Cl3G9DqFE=;
        b=V9euizrbky/6al7XYusZfWG8ADeiCgjPJOQ7Gr/YjR7O/e3pQ7uhC3bYJ5bVWLF7/+
         DRCm5OwumgPqHzkwDqQawroJ+2wQijK3zIMONoQ0JfK4MFuBOmTBI8TJWVfNo+vHJPmf
         X8bagsMC4GLTQV35rAg4jV6O5vrqCKUb+D8fpVQPWDW2Km0uTrRXlXa/MMGDAu3Z04Px
         3AdRrNVb5XuyiZwn7P7iu3UVk0MOi1MoCxDnq+Qd+9M7TOB1M1j/9p7eom4ccGFfp5oz
         FN7WMM6jPzMYm9oPhJz1iT+CEtcQOKefz2ophPpLqBlKIbB7HSCcDxvdDVxQ1whTjOUe
         VQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxmL8pWXF+dgOFsihR4V/k9s75zjdHZ/h0Cl3G9DqFE=;
        b=sT8Vyf8/gdSoxgm8Z4lFDsb6bLO8qCTveyRqrfO4rWjkEI/R9YvuDL2d9JQfFnsE1x
         9OqckuyAHQ2/iHv4n27MsjkK6LHQdYaF3El70Q3g4IN+UQ3ubcsMncDo1klAAu1fYbXd
         h2iCFCRl1lJUdE2xWQmeowP3WBVGKDf2k4ImvTat3rnUVL5lh3s8PQPC3uu3vJnRpkKv
         dcSyKAWDIcdWPj17d5j5o4Cd/IGz5AfBz1e3tpuqBO6ILrjOktm9yZdHnF+xRGxotnpT
         xAN90ZLWwjmF0kfVx6b45+tzyhFXOKdMI7+KiaHM6Llex9UW3+Bepz6TEhsx7cTCt4JF
         LVOA==
X-Gm-Message-State: AOAM533vJk6RJ7smkatfLUyvzv66adb9mrimaLUy69LDiCYG+HRepu0M
        WxBKEwW3TbBXkJoqRS0vhLAVOmCPhvlkB9kCLADtDfMf
X-Google-Smtp-Source: ABdhPJxE1cZ3lm7u0oCqplPgMVdjCi+Fiasn6nCREUjtJq3tjcNrZvbU4QXYXyxAmmF/VYRzhzQdYfC2xxz9dewBZqI=
X-Received: by 2002:aca:f456:: with SMTP id s83mr710941oih.58.1609872239001;
 Tue, 05 Jan 2021 10:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20210105111219.Bluez.v4.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
 <5ff3e8b4.1c69fb81.827b.74bf@mx.google.com>
In-Reply-To: <5ff3e8b4.1c69fb81.827b.74bf@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 5 Jan 2021 10:43:48 -0800
Message-ID: <CABBYNZL87cMLjEZOeVM+dmdh8noVgxN3hQBzKosKYKRjOEQm8Q@mail.gmail.com>
Subject: Re: [Bluez,v4,1/4] shared/mgmt: Add supports of parsing mgmt tlv list
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yun-hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Mon, Jan 4, 2021 at 8:22 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=409009
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - FAIL
> Output:
> btmgmt: Add command set-sysconfig
> WARNING:NAKED_SSCANF: unchecked sscanf return value
> #42: FILE: tools/btmgmt.c:1817:
> +               if (!sscanf(input + i * 2, "%2hhx", &value[i]))
> +                       return false;
>
> - total: 0 errors, 1 warnings, 121 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] btmgmt: Add command set-sysconfig" has style problems, please review.
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
