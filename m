Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D345C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 20:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC4360F57
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 20:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhJ2U7r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhJ2U7r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Oct 2021 16:59:47 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92F1C061570
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 13:57:17 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id q13so20500481uaq.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=u3EPlnPZK0b0/RginPA1sZlivnf+ZAIKzZfk56+rP8c=;
        b=jr6K3cfmWwiYEy5tXQHzbx+m6x+RFX1kFH4xsjU4ridGbXJ5KTQwmq74+umIEZir9I
         milJHQCEosRdCO/AzcDfnGuGYQblaNaz13F2D7kbM+TdH0tLNN9kWteakpBem1Ahbh+C
         7nhj7Vj8BdUtIsYMF2IulbqbSUlKppjxvtM/3sNujy5LmI+YIGmNXetAYC/UqlA+zQjt
         IYCFtyx6C01Ses2rrovSOusrM5wQ+uEAO0BbIQ03B4PXsH6DABKi/+5EMmE2ZjvuASzS
         oiqA16fOTCvtyPbANM/W0pLRSVmDGpt0ui2UFjS6IbsmN2JrHAyWB42cA3d8KjBZiXZ/
         dFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=u3EPlnPZK0b0/RginPA1sZlivnf+ZAIKzZfk56+rP8c=;
        b=idO6P8iTxs+ai9yWS8Yxw3B7ZVya8TAbdapFg8wJDo3lcSgWCUoaF7USQZRK+FJLQh
         5naeKKHOWfp45SfWDY6uSxHRZx/dqwQ3/Xfefs2xPwOIAB35xKGMGanRWVfQJc6Tkl2R
         sL35my21avMZcx80nkMDvLPQJrffejgKjNQFMPLHebchs3dt0234sCZ44X8+AyYmPTT5
         R5PD1qYXj2Ws7NhBpReV+VBQnCHQW2aR05G8GZYcx3QzCfCRA0HFQMFnfGh6OIgaJr/O
         dUKcu0ebBSK2qrn8K+cQdW98i3J5L7UMSyevKqJEGSqZZbe9yOCccEFxmLPzgDga/12q
         BUSw==
X-Gm-Message-State: AOAM530Ro+miD4YuIOsJjVTbf2VzENsKb7IsdxA8DOl+2HzObKvHBom/
        OYb+kTMy6xPj/9kPdjpwGv3/w8H/IBICGCgS2wzBfqLH
X-Google-Smtp-Source: ABdhPJyc1HdGkoCy/r08TAu9ogiEXypZPkfc8RWCxGagZjJbAaLqjf5LyFdPi9KtOykTfl0Dh7kF2rvTS+FehK99nTM=
X-Received: by 2002:a05:6102:3589:: with SMTP id h9mr967717vsu.39.1635541036905;
 Fri, 29 Oct 2021 13:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211028213712.2045457-1-luiz.dentz@gmail.com> <617b1be3.1c69fb81.cb33e.52a8@mx.google.com>
In-Reply-To: <617b1be3.1c69fb81.cb33e.52a8@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 29 Oct 2021 13:57:06 -0700
Message-ID: <CABBYNZ+Uw2uv56CHN__2QY-N7+sXxdt24vZcUeMLb53byzJZOw@mail.gmail.com>
Subject: Re: [v2,BlueZ] device: Fix not clearing error on update_bredr_services
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Oct 28, 2021 at 2:53 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=572167
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.35 seconds
> GitLint                       PASS      0.95 seconds
> Prep - Setup ELL              PASS      41.40 seconds
> Build - Prep                  PASS      0.46 seconds
> Build - Configure             PASS      7.71 seconds
> Build - Make                  PASS      178.31 seconds
> Make Check                    PASS      9.05 seconds
> Make Distcheck                PASS      212.02 seconds
> Build w/ext ELL - Configure   PASS      7.82 seconds
> Build w/ext ELL - Make        PASS      168.61 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
