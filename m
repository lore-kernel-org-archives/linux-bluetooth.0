Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E821BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 22:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiAGWou (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 17:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiAGWou (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 17:44:50 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5031C061574
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jan 2022 14:44:49 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id m6so10426714ybc.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jan 2022 14:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=kWk3HBCHET9Y/HlimePsKZHz2DCG4MrXA+u6qUY5Vag=;
        b=cKViLG+qj1TTkTexxVMK+jFbAXY1dbiRyAFeZkEvfB4VLmKaMMR2AHlq5XPt0qGZdg
         yqeDZrP0++NlxGLv+6nxdVdPfOeXK6ZTFhk6B1Dnpi7Id0xlWkuroPZwENbkx+0ATnCt
         uXZ/p4KMYI3zABcEBh2D1t/5l1bDA2ObJslbWLvjxUolb1sTbGSw5c1oSptlouXRdM2Z
         tOigITDUShbXxRDtsZcgY4j+7ZwDCjCh5GKWIuba/cmW7fDw2HZ30kbfi2UaFR5Ab5iD
         35HZ3X3LqKW2eBxY0y14O+cHhIU3HSXVHkKv2W0seqq+tKjUmiX0M7oJtjOYaWLqrN6B
         pYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=kWk3HBCHET9Y/HlimePsKZHz2DCG4MrXA+u6qUY5Vag=;
        b=GG9V34+QAD3T1ww5fK48u+ef4AKxsPXzYH7OnAZkUKpO9xtTiPyRKukqquFgny8XGK
         J7pYRn0d54EhGwoX9CdOWeXQXvZDz1w4z8Bi+dUNQ1Kw0TuDIOtpltteQ0+oXLMLIwo4
         D8vCAAedQPT5o8akFIbO05sxww8uhOWvpMDMRSyMVunKuMv8+RppjQjAdMo46TyHBJWs
         T2GjVBOyCTDtr7baURd3hpfPr7SWYUTy4ihwVlmzxy0ujfFRWiEuznwaluCqIl+jAbNM
         +DIAFQSXgev+akieTuol7Ri9YvTndFJWtpJp2RPkzFTCn1ypqJARm0fe4xxW8er7OkJl
         Sf5w==
X-Gm-Message-State: AOAM530urvNcIhw56ZNF5G6GfedrYmNZbAENGMcDusoDMSuYjy17XX+A
        f38xrwN6GvAgtoAAT5AD0thX75RyheGZtSNXs6ar+mhM
X-Google-Smtp-Source: ABdhPJxTa5ucLzoUAdc/YYyxoEy2gQbrej3fHHj6gT+6ZhGNoAGGnw2zBhiAzUKc7cbC+H2JuTfcEnOVuS6/Y+DS3Is=
X-Received: by 2002:a05:6902:72a:: with SMTP id l10mr6022574ybt.293.1641595488695;
 Fri, 07 Jan 2022 14:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20220105222946.3235852-1-luiz.dentz@gmail.com> <61d62dbe.1c69fb81.2987e.0ebf@mx.google.com>
In-Reply-To: <61d62dbe.1c69fb81.2987e.0ebf@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 7 Jan 2022 14:44:38 -0800
Message-ID: <CABBYNZL82jC6CrLkwbZZuD9dbfY7eiTrnA-o=O+HOvujd9QGpg@mail.gmail.com>
Subject: Re: [BlueZ] configure: Fix use of obsolete macros
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jan 5, 2022 at 3:46 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=603033
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.58 seconds
> GitLint                       FAIL      1.11 seconds
> Prep - Setup ELL              PASS      43.34 seconds
> Build - Prep                  PASS      0.68 seconds
> Build - Configure             PASS      8.63 seconds
> Build - Make                  PASS      1436.54 seconds
> Make Check                    PASS      11.94 seconds
> Make Check w/Valgrind         PASS      451.87 seconds
> Make Distcheck                PASS      237.29 seconds
> Build w/ext ELL - Configure   PASS      8.83 seconds
> Build w/ext ELL - Make        PASS      1406.07 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> [BlueZ] configure: Fix use of obsolete macros
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #86:
> https://www.gnu.org/software/autoconf/manual/autoconf-2.70/html_node/Obsolete-Macros.html
>
> /github/workspace/src/12704810.patch total: 0 errors, 1 warnings, 330 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12704810.patch has style problems, please review.
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
> [BlueZ] configure: Fix use of obsolete macros
> 13: B1 Line exceeds max length (89>80): "https://www.gnu.org/software/autoconf/manual/autoconf-2.70/html_node/Obsolete-Macros.html"
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
