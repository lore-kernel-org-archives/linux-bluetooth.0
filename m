Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B20C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 17:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D80960F92
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 17:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbhI0Rvu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 13:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbhI0Rvj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 13:51:39 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B1CC051753
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 10:44:54 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id h132so7296768vke.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Q/bXon93v85/DTGzFg+e94tdgDm6Y/++iZ0ek0d/xCg=;
        b=V9URbC9XDK2eMZWP/G8Vi2Cv5O8Gg72CwgUILsc0cVNc1UTngwd854cWr8P1AmTt2C
         qNA2Yiz7pa+lG5AtYZjpqbXKtV2vA1zryb9uL8HfOU78e4DRTzHY6DF1TG7gwy71+NVK
         HgdbPkPmtJ9dIbxW6WpmtNrtmoiuAouL92TEF5U/lo16yWTUZRzkkkatJphQ1pJULB7b
         suD0k8Jv01JjdEhpv8dHmQ4QSMXTNNlh1YETol4u23LRA0DQ5oUbxS36DtveXjgMV35V
         uaqz1kHCZpR0n2PyTfNTcOxyy/3YB6joJYIgLKiXbOnGxxDUT9hysA4hrGlHKxAkW2n8
         d7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Q/bXon93v85/DTGzFg+e94tdgDm6Y/++iZ0ek0d/xCg=;
        b=7Vg6T8V2sut9KA57YEKxYkDhmerq3kmPnAoDGmga0dVLyJTLmFVkbP5l3eQLCarBNj
         yRt1XHBkBtUjhrPCrwPGEUs1EdWghwpn3+AUHlIgZNWj3AHfcIKk2Zq8czTai8MsqfKR
         6FeVQurVzL3xIKBLzgGXVzvwGfP7V/B27Z6gXWN75lDz216+u0CjjTovOwUNF6N6id9L
         IhQ7k2SjJbabvY7wwiaWgBNXZmloSKSjA5FPcbUXCxCsG48UE3dQsu529aQfS81R+Ajf
         vQqHrU7M3l5KFxHrJ0ekI3bKP3lYwjbrSEHK+c7AtQ+sC9w9HxTmneeR047F5SydKga4
         NKpA==
X-Gm-Message-State: AOAM532YSn/3l8ihd1rLUIiSNxrHygarAnW6jr0mbnMmZH4SwudQTBbX
        k3Ux/1C2f3liW4mHP0boSEl1RNtFS38jTCwAJp+qsGQz
X-Google-Smtp-Source: ABdhPJznriQ3647PciWy7yt515hFJU5BFrFtJlF0p+otK3wzezFIlhB5oO7oz1mxXll1uPeM1nq2CSem7e0TeIOfjIc=
X-Received: by 2002:a1f:ae8a:: with SMTP id x132mr1365159vke.23.1632764689999;
 Mon, 27 Sep 2021 10:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210924211824.2318562-1-luiz.dentz@gmail.com> <614e44aa.1c69fb81.97ea4.01fd@mx.google.com>
In-Reply-To: <614e44aa.1c69fb81.97ea4.01fd@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Sep 2021 10:44:39 -0700
Message-ID: <CABBYNZKVGK3P+bGjAKOi8sG023uW4_ReZAk5DdCiY0p0Wjvzrg@mail.gmail.com>
Subject: Re: [BlueZ,1/2] avctp: Fix not handling when kernel has ERTM disabled
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Sep 24, 2021 at 2:35 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=552627
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      3.15 seconds
> GitLint                       PASS      4.05 seconds
> Prep - Setup ELL              PASS      53.45 seconds
> Build - Prep                  PASS      0.52 seconds
> Build - Configure             PASS      9.81 seconds
> Build - Make                  PASS      238.59 seconds
> Make Check                    PASS      9.85 seconds
> Make Distcheck                PASS      286.99 seconds
> Build w/ext ELL - Configure   PASS      10.04 seconds
> Build w/ext ELL - Make        PASS      227.25 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
