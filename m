Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91FAC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 21:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9123B60F39
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 21:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhHPV52 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbhHPV51 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 17:57:27 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11DFC061764
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 14:56:55 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id c5so22551216ybn.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7RajyIJimWAbsaO6/MeXAdLO/9Rj3cwVJrFIYRih40=;
        b=YcBa0L2CCjyw3DkI8pQaOUcX8bE8KPN5DmL2zDQrLtP437szFBG5lgf4TYC3ChN/rP
         TA44Qvtfz41ON/v2JEIWFo3oS7R4Zh9/5zcFe2klS2A/RTCSWs2ewA+gd8Ina8l2ekkZ
         Cz6nmdxhJKahhpEOeJZpZY/WCjJw7XXKgFUcM7ioWRJ/cE5NTFoTXzottRT3UxArm8Aq
         2Ib4iU7pk4oSh5hjDhII/JA50vdPw0Mywt4cfTMiHagMMYksYem7lA6ItSg2zNsX+gn9
         zpnbLgyo0fnKygKa2VNrUXMvvRkl0SFQI13zns0nOpnGCoEzs7bvmDUtyzksZ5wqgaVa
         LgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7RajyIJimWAbsaO6/MeXAdLO/9Rj3cwVJrFIYRih40=;
        b=cBNK+0/ucGeFYTiI4pdTKbWxgYF9l1n8ghMDjdbjfFimJUesHV3zRq1GuZApdJWvXR
         1pcUFlWmlXVLf2RNHDi1F56zM486v342fLfiLrkC0APFTJ8XJK/da+/Hb1ouaAdBZOWP
         zKQQg4JIWh4moJEf7eriQ+A02oJXxPga44DgUYAQVJrUSXnxeADGSPnBcCmdh00yOwtb
         W/hkqKNH6VSeuCvBC5cVog2BBFCudq+vKP3ej7Ft3qOvYVf0rJgk4N37m7KJ5k5Cvlb+
         nnGlvscNuT0NL06//Hd8EyFtK9KVfYZBBX2URke4P7JtgudKJMxIokzBeb5OaiXmThKM
         K9cQ==
X-Gm-Message-State: AOAM531tWiUR+DTWDDPsM7+sp8bUBnoJIoc4VVGWrEgiGfrITVQlLTDJ
        6CsfsCNdjmDU8BXkuQuf2d0LMarNQ5Xw8QwVLuXTfnDF
X-Google-Smtp-Source: ABdhPJzUpF/3nJKmgBDsYYJ5NhZHYJ08AhqNEK8D+aR0kI7gXBMlIHmuX05Dm261XZzusBojTi4ew5Hq4AqznRwKZBY=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr268790ybu.282.1629151015009;
 Mon, 16 Aug 2021 14:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210815001550.24643-1-kiran.k@intel.com> <61186d44.1c69fb81.b18a.85e6@mx.google.com>
In-Reply-To: <61186d44.1c69fb81.b18a.85e6@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Aug 2021 14:56:44 -0700
Message-ID: <CABBYNZLKioLkaSNVzoBP9TKxbBOEa8_dKZd_ybAEL+G-DHzKSw@mail.gmail.com>
Subject: Re: mgmt: Set offload codec mgmt feature
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Sat, Aug 14, 2021 at 6:31 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=531599
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      0.33 seconds
> GitLint                       PASS      0.13 seconds
> Prep - Setup ELL              PASS      49.03 seconds
> Build - Prep                  PASS      0.11 seconds
> Build - Configure             PASS      8.66 seconds
> Build - Make                  PASS      212.24 seconds
> Make Check                    PASS      9.79 seconds
> Make Distcheck                PASS      250.51 seconds
> Build w/ext ELL - Configure   PASS      8.76 seconds
> Build w/ext ELL - Make        PASS      199.76 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> mgmt: Set offload codec mgmt feature
> WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
> #20: FILE: tools/btmgmt.c:2561:
> +               error("Set offload codec feature failed with status 0x%02x (%s)",

This will need to be fixed.

> - total: 0 errors, 1 warnings, 56 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] mgmt: Set offload codec mgmt feature" has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


-- 
Luiz Augusto von Dentz
