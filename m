Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96185C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 10:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5250E64E31
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 10:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBWKMw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 05:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhBWKLz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 05:11:55 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F0FC06178B
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 02:11:14 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id j14so2615323vsi.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 02:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=XeRGwrVDGUzWSSD6C/GZwIpZi77q3XrWcjogMf5WaAk=;
        b=dsHeUjD1vENQMbIIAlKnIDEmav8NBtizSS27QwI4hRPgLevQdpcENE97xSQm43dAiU
         gXnIdF0RwWBol55PP4WJsDQq6TVFe8R+qboTTwnQxNWD6AowL1DA7QV13dSH1kddh28W
         aWJ7lN1q31/U7AJwuaGqCYHH5MsLs2pGUqouDN+7DVObv0ACxFJncJqib9qLa51rdYSe
         1VENsxJC4458OHMGTKKI43LIjrYy+TY0+3JyDtEunqdBeJJU2s5Hb/SB1Ul3RfziictP
         UEEKxzvxLle5wf2Jr/k/4+/XzA9udI/DU24FV2sVr1d6hFE8FvfxKtyD1gfm5eogKbfK
         kXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=XeRGwrVDGUzWSSD6C/GZwIpZi77q3XrWcjogMf5WaAk=;
        b=eG/1P/tLPflRtHjESPTCEG3856Z64eTL/9+zfeDF8+ZwjRz+4O5/oGgnDYPpY2BQns
         EY34siW3EBG1zRvaUCLhFqq8CgUSZjn6v+oCwO7gvJBL80LrWO0M16F9TAOrQNPa9TkX
         tXaUk7AD3LLZq983QIF56DsHGRA/HYY4Nu6szun1B6ZZQ1GgDBMAlfU/SG3h4YhYWcMJ
         uH5gTeE0dEfKAy9T0ZQn5oqb4qdAZJYc4+ne0xniuWhttDwShbrjA2Q980sbsWduoB1Y
         3P6iDlXWQNQpKkqRmIT+KJDBHjFdjMZWdmgGGrtxFOh12DswJUsKd1ZV6Q9bAuhcM3/Y
         uZ0w==
X-Gm-Message-State: AOAM533RK9RkPJ1UzDVymP8oBLtk6SCGcgAXl84Yq0XbnREPCr7pD4Bc
        4Zvw+416j5VICoSwHL4742RzPIGgiG+fTTYAESNB5QyXt+o=
X-Google-Smtp-Source: ABdhPJwQNjQX/ewZx79ezcFAWwz0Z9KGkgrW6pmnVQZTHA+RPvkheqFjViNkVOjWkiG2xJ2L0qQereXw3trgecfw0Wk=
X-Received: by 2002:a67:7788:: with SMTP id s130mr15589372vsc.48.1614075074067;
 Tue, 23 Feb 2021 02:11:14 -0800 (PST)
MIME-Version: 1.0
References: <CALaQ_hpL36xwJ3zujD6DsRKzQw_54TucEif=icMgN1CUpk9TNA@mail.gmail.com>
In-Reply-To: <CALaQ_hpL36xwJ3zujD6DsRKzQw_54TucEif=icMgN1CUpk9TNA@mail.gmail.com>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Tue, 23 Feb 2021 04:11:03 -0600
Message-ID: <CALaQ_hpGDdmLTrccsTDnquw-+5BVy2-c2nem_ncLHzF7k=ac-w@mail.gmail.com>
Subject: Re: avdtp.c:cancel_request Times Out, Plus Other Failures
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Just to put it out there, I switched back to my previous 5.8.7-dirty
kernel and haven't had any issues.
It's on the same upgraded system, but just the kernel was rolled back.

On Mon, Feb 22, 2021 at 1:27 PM Nathan Royce <nroycea+kernel@gmail.com> wrote:
>
> System updated 2021-02-19
> Previous update 2020-12-18
>
> Kernel:
>     Current: Linux computerName 5.11.0-dirty #1 SMP PREEMPT Fri Feb 19
> 06:30:22 CST 2021 x86_64 GNU/Linux
>     Previous: 5.8.7
>
> Bluez:
>     Current: 5.55-3
>     Previous: 5.55-1
>...
