Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0344AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 22:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344900AbiBJWb0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:31:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242808AbiBJWbZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 17:31:25 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DBDBD9
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 14:31:26 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id p19so19711603ybc.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 14:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RNn7QyJNwPWtNHEsCf+g5tcWQcO8Jm7SKb4RKTSdyyg=;
        b=jbsALpRCG+gOj233isJv1SwkmVHoLfnXHc79cPLasOYEaNpSQErbVr4upAkecDpZ0p
         v8spm1PDLDoa5Mfr1hI6ReeRhuKuGJSv0pRdNuCO0d0yoTW1bLhoQaJdC+Lo+AgUn6E7
         ivh2bgKvDMvYTxr9wy4ysFxqRNw2s4OOhSILrQQ2H2XhzMnHd349E9PwZ+uFIM/u3ADS
         oR/TlXSgHoed7SnLW2DkR4bpWKV/ZK/i4Vmxyl3+uxAKAWQBObEnjKsJFM9ePvqePGqt
         Jrcj5Gr9SOMgml5EmKsftduvSF6efO842MMJgqAYtWnVSiqlTNDBupAgphP+/vXmZfPw
         I4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RNn7QyJNwPWtNHEsCf+g5tcWQcO8Jm7SKb4RKTSdyyg=;
        b=zTDgSCyr0yYRlE84YIzF38nFuphEDr3bux+U/kDoasrcrJD+IxK7ZpVlbtsipvPTBI
         pOi4qP8d0n9qmuYbVCeMdBhyhffpvJDiBHC7wvR8JB7Ad+xP2Kp/0rau+RF+y2QlabNx
         IyZhJ5NidnJZWrwKHexoknMkfTq14PyUjDnZMwABheMM2/X1/KGXOULf0Zz4qbLRLjmI
         MFcTI+yJRH+fdIu7a0PCFFiissdCcY54XjKPf8g4n2vgWnnzQCZQk9JuO03c+0ewtjTs
         Z7D0ecGqP1uuGTwOsHWj7JJiqIw/0H9SqiU7OjrrPJGab7fvF/MUsOL7yBXtOOkPPZn3
         XJHQ==
X-Gm-Message-State: AOAM533pokOpF2hAavjju+Y5JkYTsDTQraHUo07rKbP0d5YRdeV20kX/
        r7yDrBgTJPDxJhwYcYeDGw+ih2b7MFNvukcYKd+WgKAgOyk=
X-Google-Smtp-Source: ABdhPJzeW6eXq85YL3Z6RQy+gaxdKAWvfILFBvMm+F1dPc8avCcCEy+E4qKbEf27qI3iJpFYUEa5vtXHvR1yFnMOh/M=
X-Received: by 2002:a25:3857:: with SMTP id f84mr8943030yba.733.1644532285415;
 Thu, 10 Feb 2022 14:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20220209235553.150294-1-luiz.dentz@gmail.com> <6204a403.1c69fb81.eb5b9.84b7@mx.google.com>
In-Reply-To: <6204a403.1c69fb81.eb5b9.84b7@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 10 Feb 2022 14:31:14 -0800
Message-ID: <CABBYNZLuy8vG8M1CtUDwFV81qj_cJqENa-2zZxR6XwsM3x2Mzw@mail.gmail.com>
Subject: Re: [BlueZ,1/4] bthost: Fix not handling ACL fragmentation
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Feb 9, 2022 at 9:35 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=612835
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      6.03 seconds
> GitLint                       PASS      3.97 seconds
> Prep - Setup ELL              PASS      52.60 seconds
> Build - Prep                  PASS      0.90 seconds
> Build - Configure             PASS      10.70 seconds
> Build - Make                  PASS      1847.93 seconds
> Make Check                    PASS      13.01 seconds
> Make Check w/Valgrind         PASS      549.65 seconds
> Make Distcheck                PASS      294.08 seconds
> Build w/ext ELL - Configure   PASS      10.33 seconds
> Build w/ext ELL - Make        PASS      1833.60 seconds
> Incremental Build with patchesPASS      7382.33 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> [BlueZ,1/4] bthost: Fix not handling ACL fragmentation
> WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
> #257: FILE: emulator/bthost.c:2560:
> +               /* fall through */
>
> /github/workspace/src/12741130.patch total: 0 errors, 1 warnings, 192 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12741130.patch has style problems, please review.
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
