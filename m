Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2044FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 23:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiCBXsV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCBXsS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 18:48:18 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D4D17186D
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 15:47:11 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id f38so6778295ybi.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 15:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FJZkRFzKGAl/Ew42Wnb+N+61YLUPXkuLZU6C/6TlhOo=;
        b=eYFNQxZ1HpiK++8Nw1rEL1K1K8nmWXyPxu3UzoJTx5X9SNRuDPtV76h1BCGeVX9pJ3
         BkY1DsXGQxrovpO8334AQu9v+gKLWzMGkMj2QuqXWHvvyyERT+3qohiu+13K2vxrBK3/
         GL0uaKRZeByvjYJJy/Emv28IsmV4JGrbbX69lrhr+cC+iGacxMKMMjhytd7MVTyZpLpF
         X+BJlZBU3e9HpNcDly26gD1o5LGi6MG4Q13o2IzWkbXL5iviWXeB0R7gxZo4bKTQPyJS
         vk66skSXJr7pql3zXRWV0aZtCF7hYwcewdKEwR6My+hmmosjtjo3Qg+caOyfOmEqBs+G
         WT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FJZkRFzKGAl/Ew42Wnb+N+61YLUPXkuLZU6C/6TlhOo=;
        b=OEIz6hrKvdn92jJEvE9gtUJTn9du0BcUpkvxf3iPKtgcZTNqgZNpOEgqhkfALE7KNO
         8Y3Op3S/AEDUttwAWVjnHr3X2ILVspjnxtCkDJHOna6JrOtrE2NTUSsUQPNd/62DIXJy
         ofrN+Xdh6d6W55hVUE510NGK/Jfe8T9ZHoB6o7H8yzTJwZg9LFkUti4PtbshiFpjVZWk
         3SjkoTiIM8V2f95t0yNsjhXEuYMWle+m74j237GZrFPjFIsPoev4R7jO0y/up/m2rVL7
         /SxZshx91nYa0zy/qK7GQAzZEMLGRnoO+nqFzXhZhIcinE6frwzE/lLLQXtw/r+TSxRU
         cy/w==
X-Gm-Message-State: AOAM533wFsPdVOtt/Kk024kKVgXvEUPnkyFSiTuPHwdQl0Oflr2ts49Y
        xp02dnV1w/JdNn+1DW22EeknXK7c0ba5cZi6BhWttC8E
X-Google-Smtp-Source: ABdhPJxcxPGNcZ3/utqyGKZLXtInfPND7+fMXQMcHshzHbnYUp7Ju/X0kqVd8serLjp1SKQjMbdYZ/9oLYN690wb9Qo=
X-Received: by 2002:a25:19d7:0:b0:624:7b8b:1bd3 with SMTP id
 206-20020a2519d7000000b006247b8b1bd3mr30268228ybz.401.1646263353568; Wed, 02
 Mar 2022 15:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20220228232720.1614099-1-luiz.dentz@gmail.com> <621d6a3a.1c69fb81.cfda5.a0ab@mx.google.com>
In-Reply-To: <621d6a3a.1c69fb81.cfda5.a0ab@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 2 Mar 2022 15:22:22 -0800
Message-ID: <CABBYNZLBZQSaV1ckEzYXTjyqwpEFLLXdPUSiy73V_J05z0qmBw@mail.gmail.com>
Subject: Re: [BlueZ] test-runner: Add option to start emulator
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Feb 28, 2022 at 4:35 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=618913
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.54 seconds
> GitLint                       PASS      1.05 seconds
> Prep - Setup ELL              PASS      43.02 seconds
> Build - Prep                  PASS      0.74 seconds
> Build - Configure             PASS      8.82 seconds
> Build - Make                  PASS      1440.03 seconds
> Make Check                    PASS      11.46 seconds
> Make Check w/Valgrind         PASS      446.11 seconds
> Make Distcheck                PASS      231.77 seconds
> Build w/ext ELL - Configure   PASS      8.81 seconds
> Build w/ext ELL - Make        PASS      1433.12 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> [BlueZ] test-runner: Add option to start emulator
> ERROR:INITIALISED_STATIC: do not initialise statics to false
> #98: FILE: tools/test-runner.c:50:
> +static bool start_emulator = false;
>
> WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
> #119: FILE: tools/test-runner.c:605:
> +static const char *btvirt_table[] = {
>
> /github/workspace/src/12763863.patch total: 1 errors, 1 warnings, 152 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12763863.patch has style problems, please review.
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
>
Pushed.

-- 
Luiz Augusto von Dentz
