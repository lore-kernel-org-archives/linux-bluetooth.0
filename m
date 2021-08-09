Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DE8C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 20:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9BA66101E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 20:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhHIUhG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhHIUhF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 16:37:05 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48CBC0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 13:36:44 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p145so31905379ybg.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ryv20aPbIu6uD2C4M3YrpsmICBxdwbVCK6ndQjLctTU=;
        b=Ti2swcWvMq8PpSRWCqG+jqoebjhUTgMQJrKyKAGMN+HbU3XNqgZoW5wkb5jYv2JC/g
         Zs305tDJLk/cMjvsU7Wg20nCQ9gELKIABKt8LSTUZxJrTHfFj9cUni0LBqj8YfbSReCx
         sDL6D3Zdn2wrzJbw58FtbbM5K4/L/7ywmiEpajcwAhIElqzhLk3Fx6PbbTgSTtK/lfTZ
         OL2Zx9oL/2N7DQCDZtPu50/0PHhhc6ajtpCNdrgVs2K2XGNflhThSB4FWNokAZW8jUot
         AFnpmtUyPvP5usf8r3mH96tdCcDlsKGSAcpLt0fCXWE01DXm0foYSLBga3gwHTuPIkzU
         JbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ryv20aPbIu6uD2C4M3YrpsmICBxdwbVCK6ndQjLctTU=;
        b=hlBGrQYWLp46k3T/+3U0G7T6evMvU42KTdJoblyzc7sHFyUzdVhFhShqAjjDZpWVsU
         dFUu6k/O8c/ms2Mg3kxYI9lP84nMq0n4kTqw1KrPFaZkknIr/wVxvQUUD2w9xZhrvfPr
         0MgjLu1asLqHB0H60/Ioot4+j9mSSGpbC/u+T9QRCcUFfYu0680mXisdv5BPavb0CuhK
         N3Js5doGHljpQ8BiNpnISF/ndvREtk6NWxJQ+9aJOqTjqsUawrYnwLKQ1X6+Hk5uaN46
         JW58wLyfJHY6hPDXPD6EGHOUW47sHs8yh5WppCfOZrVXZzNU5Qt3tvcnQtZv2AHn0ZUT
         FUGw==
X-Gm-Message-State: AOAM530k78gZ+aZ8TURbkU4nQ+qRvbzRT5FUSVnuBXA0Kio3Q0tj2QBs
        ODyKoHdiNtpSaTRutc+E0BvYWotqIc/+MlXh0QRPBRax
X-Google-Smtp-Source: ABdhPJwnUlyboc/9jFaW31Dxmpj7OabknV8ZvPW3GO2vSuAeAFcAUhZwc1Cn+BdGXSYXNKEiuz6yHi3Ub34fgq6GFMs=
X-Received: by 2002:a25:be02:: with SMTP id h2mr34346456ybk.91.1628541403879;
 Mon, 09 Aug 2021 13:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210808143526.99726-1-marijn.suijten@somainline.org> <610fefe5.1c69fb81.531e9.1e1a@mx.google.com>
In-Reply-To: <610fefe5.1c69fb81.531e9.1e1a@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 9 Aug 2021 13:36:32 -0700
Message-ID: <CABBYNZL0f=22W1ZDiUnt+9Yqcy0Smf0yufiboNwRMWYP=NREdQ@mail.gmail.com>
Subject: Re: [BlueZ] audio/avrcp: Use host/network order as appropriate for pdu->params_len
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Sun, Aug 8, 2021 at 9:01 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=528099
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      0.27 seconds
> GitLint                       FAIL      0.11 seconds
> Prep - Setup ELL              PASS      39.58 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      6.91 seconds
> Build - Make                  PASS      171.89 seconds
> Make Check                    PASS      8.76 seconds
> Make Distcheck                PASS      201.76 seconds
> Build w/ext ELL - Configure   PASS      6.97 seconds
> Build w/ext ELL - Make        PASS      161.73 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> audio/avrcp: Use host/network order as appropriate for pdu->params_len
> WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'e2b0f0d8d', maybe rebased or not pulled?
> #15:
> Fixes: e2b0f0d8d ("avrcp: Fix not checking if params_len match number of received bytes")
>
> - total: 0 errors, 1 warnings, 11 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] audio/avrcp: Use host/network order as appropriate for" has style problems, please review.
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
> audio/avrcp: Use host/network order as appropriate for pdu->params_len
> 11: B1 Line exceeds max length (89>80): "Fixes: e2b0f0d8d ("avrcp: Fix not checking if params_len match number of received bytes")"
>
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

Applied, thanks.


-- 
Luiz Augusto von Dentz
