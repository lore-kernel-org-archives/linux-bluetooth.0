Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E74C64E90
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 00:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAFC0208C3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 00:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUGdGxHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbgLAA2f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgLAA2e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 19:28:34 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF66C0613D2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 16:27:53 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id x15so41422otp.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 16:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5eBeLmDrGmA1tQmyh3S8NxjsCXSrI3TXbkUQPw5wX4=;
        b=IUGdGxHBfjlLDPoyOPYEyw9t2Dgkux9vn0GhQKBN+bwu6C+PK8X7kMqggRDDLngfzn
         OYAAaI79yRmLsvV6i8GFsf3hvsUSQLtmCqHDn0vQ8vQfMKmZpqj+00fDmK/64HddrGva
         CrXesOVHBAnkNBcJoqY/U3iXJVDo2so2juV63bD8TFZxojiIwKbSSQ+49G4b6amXLEu1
         +8abELJaCmy6yrgtKMmqgO7b6rOvGL7ar178/ZmDNsBXFUgQJd6lewix3blr9c2U4daL
         6SlEX8etH6c/BOVO7p9UHhs5bd5Q95Rg5fS9/QwuwYeNihPk7lwKtpiCZ6Z5oRCsOBGl
         VDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5eBeLmDrGmA1tQmyh3S8NxjsCXSrI3TXbkUQPw5wX4=;
        b=Wk29r06x30VLfxUAJBU3NRaPTdpl8RQ/sqMJvtfZiI4BO7X5EqVhAK9pXa6A0hI9BX
         NfAqjCgRXwo68uNpZxmhlsQGGfB4iC9ZVXaBwym2vcE/5UWDoz/twEWu+q472+G+4qHa
         G9rPU7Jvvg687i/++mHBudYbz1EA8PBJKirppAGDx1dEG9D1SC+onSe+hntVwoUmjUVI
         ++twcLfeqYb+sXIOSgoPqehpv+k4hvVwzhYlYLD7Db0105AQv/EPC0wa2B5UZQjFc1Gk
         DrwglPOkqhDTcARbbMr0Vjs5m8TOfNBRmItEvFF6wh9o03MT0si1QcPmk/IUe5SBy2eb
         JJDA==
X-Gm-Message-State: AOAM533qsg7v8F1TqntSzA20fvYR4duitPqlVYdSuhXAqV6zqB7/VsXv
        D4LZOKnWgj6lgy52BeRDtEFoqJmieUNUQ4LYGkBs8X1g
X-Google-Smtp-Source: ABdhPJx5cyGUEcPntXUbbgQYrVJejjilxZLdmZK8BU6k3bMUzDSH4gqto1PMV9FpWtobl2xUN3h45Gr1AmVi71pqMMQ=
X-Received: by 2002:a9d:1a9:: with SMTP id e38mr43370ote.240.1606782472893;
 Mon, 30 Nov 2020 16:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20201130215602.386545-1-sonnysasaka@chromium.org> <5fc5738c.1c69fb81.8e7df.5ba8@mx.google.com>
In-Reply-To: <5fc5738c.1c69fb81.8e7df.5ba8@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 30 Nov 2020 16:27:42 -0800
Message-ID: <CABBYNZKGAujDpR3V4hRhsgSKO_UpYk9C1ge1w5rLg-jGFVc4pw@mail.gmail.com>
Subject: Re: [BlueZ,v5,1/7] battery: Add the internal Battery API
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Mon, Nov 30, 2020 at 3:13 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=393559
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - FAIL
> Output:
> battery: Add the internal Battery API
> ERROR:INITIALISED_STATIC: do not initialise statics to NULL
> #71: FILE: src/battery.c:38:
> +static struct queue *batteries = NULL;
>
> - total: 1 errors, 0 warnings, 215 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] battery: Add the internal Battery API" has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> test: Add test app for Battery Provider API
> ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
> #12: FILE: test/example-battery-provider
>
> - total: 1 errors, 0 warnings, 232 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] test: Add test app for Battery Provider API" has style problems, please review.
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
