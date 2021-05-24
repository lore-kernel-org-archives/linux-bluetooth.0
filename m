Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EF8C2B9F7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 May 2021 20:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B1E5613CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 May 2021 20:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhEXUUf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 May 2021 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbhEXUUe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 May 2021 16:20:34 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E48C061756
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 May 2021 13:19:06 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id w1so28485139ybt.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 May 2021 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiZZl+iXTDOdMf6PQXGpsWK2MoBQJ5Kdk+UeU9nwODk=;
        b=jBTUa2RMmnhLBUGxFtSGHKMPZFvX0i9FbQGajy0c4apoapbOMjk09et5263oDZba2N
         7B/c/fOqvcFc9ffGZT8OYfvIPH9v6DxzI3cnlziAcXDKA1Law9CpetwVIe1qmofxPR95
         7wpCT5zNogfD+8njcOpsFbXxzSQbkntrlSngtRhMaTSxQNiItedQaabK00vIii6i2kcf
         yoOv5FmHoDgPrziu2bbyZ77u+8fgOQYBKzgvZfMiaY5XibVbYqRZDXN80ck+lUpU3wAw
         Axa/mseDAv0zuYun+eFxiPMmqpN2EG5Yd/vQNi1hc5S5bROSJLrJj5okEGo1IZJ/lUB3
         xQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiZZl+iXTDOdMf6PQXGpsWK2MoBQJ5Kdk+UeU9nwODk=;
        b=BuxadhjzxZwdpvpNKrbGA3PFvvjm4zTRp9Qmz0i0qJ8SV1LIuaMgznxFJjN7swY+Fk
         3HwV6XV+VjoxNCQw+T8scH5GGGy2HHLE/CrV6vIqmWd0lXIdjLNBrTaXxXqD6LTI5frr
         pZ8bDCJXhEwQTi3XDYJQj8HqJ0XoXy2iIwICmPtyX7J+kIXvjuj1gg9PSkIh/0ul3/nP
         fWO+5QM+rY2hJKW3t4DgXFqtgaiUi+Zy7oAsBJHbQGA9GH7L1pAVJM+1xSRfwdpAyJmf
         l/fn0K8SmZHFwQdTZhlZlko8gsuQEpduOqOWBIxXQuTvEy1bRb0tv72gxMuUarEdGZOh
         JIEg==
X-Gm-Message-State: AOAM530EkcvROyzQxmLPux7EKJonsLCM2mlf/9Of2Br/7h8K9WLqehIB
        Hc3u4y1+a141oIQgfEksmRYWSeogMhaZ1yrVdNjBimRK
X-Google-Smtp-Source: ABdhPJwltZxI92YJ5EpgATd8HNOxw+DWrfScsx5Ma2UtJW8IuEcY/hgwN2tyvDyPByUPUYLIXFbUdAJf0243i8SUG9A=
X-Received: by 2002:a25:a466:: with SMTP id f93mr35707987ybi.264.1621887545552;
 Mon, 24 May 2021 13:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210524104329.Bluez.v1.1.I3f63cfa802b3602a4ddd7604acc8e886f223912f@changeid>
 <60ab16e3.1c69fb81.2ef14.32a5@mx.google.com>
In-Reply-To: <60ab16e3.1c69fb81.2ef14.32a5@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 May 2021 13:18:55 -0700
Message-ID: <CABBYNZKh-uV3OZrN9LOfBoz31s76cC9KVm2frzsstoK+7zTTiw@mail.gmail.com>
Subject: Re: [Bluez,v1] core: Add RSSI sampling period in system parameter
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yun-hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Sun, May 23, 2021 at 8:02 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=487211
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      0.38 seconds
> GitLint                       PASS      0.11 seconds
> Prep - Setup ELL              PASS      44.60 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.98 seconds
> Build - Make                  PASS      191.14 seconds
> Make Check                    PASS      9.02 seconds
> Make Distcheck                PASS      238.86 seconds
> Build w/ext ELL - Configure   PASS      8.53 seconds
> Build w/ext ELL - Make        PASS      190.53 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> core: Add RSSI sampling period in system parameter
> WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
> #74: FILE: src/main.c:148:
> +static const char *advmon_options[] = {
>
> - total: 0 errors, 1 warnings, 93 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] core: Add RSSI sampling period in system parameter" has style problems, please review.
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
