Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905BFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 04:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB4761409
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 04:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhJEERk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 00:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhJEERj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 00:17:39 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B5EC061745
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 21:15:49 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id g10so4670838vsb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 21:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtxXfra+M4n3fU/PBqoyOdvraBuzKL/ZyAXA3SdKue0=;
        b=FQup+IBrX0VDFyuT8RacrhtlH0yHqWxtZmXI0pXxcgIiAzpttNfgDg+8kT6W6SkHT6
         rQJ829aMFxGlJpiivEQips3fQVYpVxYqKRgx+kNz/JL5UcKx99V1twi62t+CrjPahy/x
         gKkAgBllty7cgRHmo0qMHEfZE4bbDoZm41ngkBzmmf09LFpkBgQYuVf9gZ0xvVWzRx5u
         OGGRfPR+VSPkcoVSCJIGv4E3eHfKb3w9pY2Qj+We/AISciMHQUpIHY+eZKwNe5pD1mig
         XYY+lt5h7Lj1t9mVwo9NsdwV7RlAsRxPmXAORxSO7qds2b/LbeiWsxa8ljd08lXXB4fR
         48Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtxXfra+M4n3fU/PBqoyOdvraBuzKL/ZyAXA3SdKue0=;
        b=fRyMPq0KWwQj/ctZ7XVhJdGqbKAQ6to4oZxbGYmNTUA8S/c/lDUplN/3oE2MahLNwI
         GoECG8bmPlyLkNcvqHOURBLa+gA7yz69wudVoCtK0J06ivJG0F130b3zWkvPlu0wwBUk
         UN7k5lxrxVcPXHg5oGOCUbEmuhTiMkwm66N7RGKgzyo4M1wrVJWjYwHmdUdf5P+9UV3B
         4sjDWwcMnp/vhMsi0fPavJF+uAs1UsgVHi1eIGjcOibw6LUwe14PALPrp9iHmBjWIvl2
         QE3ckRmbx51K/bvUknG33wxU1ZDiNVAIc1sXN4VHN6KoWLyGXx8QyxmNWygt0VG+5tFU
         zhLA==
X-Gm-Message-State: AOAM531Wc975JmOTdQjRZzBTDZ2X75gSobf2bG750O/FavB4jtWKxsE+
        qfVUmfpvyZ1TzFj4C/F21fy6TPxdo7Y6z5nTXQ/r+whk
X-Google-Smtp-Source: ABdhPJxmiASfpxyYG5mn0J/oqtSmFaOe20q79Did2DEW9UDq6L6LOhhqShjhyaImVtl2+2H/Sw7Ao2Vt/cyjRnw6iBk=
X-Received: by 2002:a05:6102:318d:: with SMTP id c13mr17213998vsh.10.1633407348478;
 Mon, 04 Oct 2021 21:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211003101834.45448-1-thomas@t-8ch.de> <61598804.1c69fb81.d279a.fe3f@mx.google.com>
In-Reply-To: <61598804.1c69fb81.d279a.fe3f@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 4 Oct 2021 21:15:37 -0700
Message-ID: <CABBYNZ+-7QASvCoA9XJQ_Jmi8=e2-dZQSnL4Xft4Ci_WGb=nPA@mail.gmail.com>
Subject: Re: [BlueZ] Use accurate icons for headphones and headsets
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     thomas@t-8ch.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Thomas,

On Sun, Oct 3, 2021 at 3:40 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=556811
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.36 seconds
> GitLint                       PASS      0.92 seconds
> Prep - Setup ELL              PASS      47.51 seconds
> Build - Prep                  PASS      0.46 seconds
> Build - Configure             PASS      8.78 seconds
> Build - Make                  PASS      194.30 seconds
> Make Check                    PASS      8.98 seconds
> Make Distcheck                PASS      228.49 seconds
> Build w/ext ELL - Configure   PASS      8.21 seconds
> Build w/ext ELL - Make        PASS      176.63 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> [BlueZ] Use accurate icons for headphones and headsets
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #50:
> are in practice implemented by at least Adwaita, Gnome, Oxygen, Arc and Breeze
>
> /github/workspace/src/12532673.patch total: 0 errors, 1 warnings, 11 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12532673.patch has style problems, please review.
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

Shouldn't they be proposed to be added to the standard before we do
these changes? I mean it is better to have an icon then not have
anything or is there a fallback mechanism e.g. audio prefix fallback
to audio-card?

-- 
Luiz Augusto von Dentz
