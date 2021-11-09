Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAD3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 22:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBB961073
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 22:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbhKIW76 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 17:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbhKIW7x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 17:59:53 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8110CC0797B3
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 14:46:59 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id t13so826906uad.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Nov 2021 14:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=KhyFE/RGDybH9ShWGQp+pQA8mmNWmFEU12x/hwGiWdY=;
        b=FuaqUTaXd6M0QhUHWV64AHVpTWHh4j2GNoScbvXF3cNbW2kwnVTwq9w0wvrgiMxanq
         wMb/3l5iueZbJcU5q6yK0Y70HVB003YbwQUk3mCCqndtASy13DYl0M1rOr8qBgWZXnb1
         Ki2JxqNBHKuYNnzAbD+hgnlnkOGo7SOGavnf+VehUb99KnASz0scB5RPQp+KQ10VXxo5
         ptHk1Vv6LOXUPzXC/O4WTkAqodY6Y+vl0Azmmjmc9XmjMpfewKfvgITx5aE8e1cFGCVU
         hXNUhbnTTt7P8y8v26IZAf4XfCAiFp/HuqMRYRJv90HIHCrWtIn6Lx7E2k5IWoR//5YM
         lHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=KhyFE/RGDybH9ShWGQp+pQA8mmNWmFEU12x/hwGiWdY=;
        b=M5HjtHLVLjmKmC/IAE+z+EAlbrc4F86i4wRQ0O5xmLvMPkIc1xyMlzky7kooNXvU6S
         E+ZvyIx2BT+wF8L0R0d5uIsoPhhiwncXdTi3FiyTPvNrvtUBMjiYZ7/DiVpw0pqXvexM
         +1u5A1quyYq9j3CwM8ccZAM9bVMiOLBlJF4fk/xGe/LKrPWaN0aE0Je+XUxpv8Ew6bJz
         YsyqhcwV55xzR282ccvkFgtZZsGOZpVdqJxBFp1ua9a4JScBqsL437V+jqIqqk2xpktt
         AGRZVOlDeCMBIqFwq1nAu627woirOwfADzfPCQi8U7IT0JpwPfuxBqie+bYhR8kYymvO
         01zg==
X-Gm-Message-State: AOAM533WvRQja6t1kvOuGb2f69daV7WGVrI2mzFm2ApfmUG/iKPsDEn1
        dzdZxu51u0a9RtfYPVxgY0Z3rAjUG8ee50ru2yeK6xYb
X-Google-Smtp-Source: ABdhPJz++sxm/aE+T5SKJkyh1r4Mh9kpDxSX0Xdn3GId4ll2A6f6CRmLyToRv8RUuZyAahmRYGPYpDKPXaqD+rSPB+M=
X-Received: by 2002:a67:d893:: with SMTP id f19mr5226667vsj.39.1636498015536;
 Tue, 09 Nov 2021 14:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20211109213721.1121677-1-luiz.dentz@gmail.com> <618aee11.1c69fb81.4dc68.a49d@mx.google.com>
In-Reply-To: <618aee11.1c69fb81.4dc68.a49d@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 9 Nov 2021 14:46:44 -0800
Message-ID: <CABBYNZLA09hUE-sraBrjQ6PEcozjz45GffrF-bEKd6Pf=_xbXQ@mail.gmail.com>
Subject: Re: [v2,BlueZ] client/gatt: Fix using atoi
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Nov 9, 2021 at 1:54 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=577649
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.46 seconds
> GitLint                       PASS      0.90 seconds
> Prep - Setup ELL              PASS      40.77 seconds
> Build - Prep                  PASS      0.47 seconds
> Build - Configure             PASS      7.68 seconds
> Build - Make                  PASS      175.76 seconds
> Make Check                    PASS      9.67 seconds
> Make Distcheck                PASS      208.11 seconds
> Build w/ext ELL - Configure   PASS      7.83 seconds
> Build w/ext ELL - Make        PASS      166.39 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> [v2,BlueZ] client/gatt: Fix using atoi
> WARNING:TYPO_SPELLING: 'prefered' may be misspelled - perhaps 'preferred'?
> #84:
> likely the prefered format for the likes of handles, etc, so this
>            ^^^^^^^^
>
> /github/workspace/src/12611125.patch total: 0 errors, 1 warnings, 126 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12611125.patch has style problems, please review.
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
