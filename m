Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71A0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 20:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E00560F14
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 20:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhJHU7U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhJHU7U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 16:59:20 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C2FC061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Oct 2021 13:57:24 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a2so3493385uaq.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Oct 2021 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=dKn4fy6eolnWpox4rVTgehdrKMqkYmCTcyjfrIcR+lM=;
        b=i9MHOhIzAnFzqsdeP7Bkc50CUFwiCJPd2OMSixQ+RbnsSpR1HXDh2Pu1a0uqXGpwZw
         V53rj14V87w6lls/0rCBPaTp5TB4ID8rmfUN4tyL/5nXLICW7pRWBQ9zwp9c6V5b7ZNG
         sTNcd59x/MU2EFH6HzpbTg9pK2pmymWbeFsOEnbdV5d3106ymAcJSx/sWkGGF/IYfU48
         1/K9mmuxJU8bO3UvVpe1M8tu+yr61tcxl8RFEZfO+8esoogEOjWsVX1GRALtuqBAfokV
         ICx2xh9PvgMI4D9oy7xUvZTnlddcINjwOul2xLYx8QiIV3OJc3KIqvz0izuKAo0vLLJJ
         roHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dKn4fy6eolnWpox4rVTgehdrKMqkYmCTcyjfrIcR+lM=;
        b=oTWf+W789gcw+46pi8n/7gEazJoE3yowWlIVsVtfMR2eJLygG775AT18RDD9CWhjE3
         6Vi665ojECSKLC46K4pPc4CBt9rIq6sLDebn4RyhsAmXBnjFZ4NqcxrNF7EaKiSOVoEY
         Ycs/SzRMSVvbhlA4jGAw2ravPxLiWgDMrk3VcAgVfph7KE3+l0BgX1CHBp5nNoytutiY
         l5TulSAUPXDsbsuEETJBjwfj4lRTyjfbisjcXoUNTVP9FalQIhckHVecfon9Kt+2BZKe
         wok9dEbUmaVuokDYwx1/4b0lz0FjBd9+3f267QkXfiNhzaqSZYPImDtVi46lxb/s9NlJ
         58SA==
X-Gm-Message-State: AOAM530uEkoVAG/2lu5skqF1Ps46bfXqkL55ED/k/CfxHNpzyISvgbMH
        k6myWXMiT20yRvOMIAbIyLgM/rpVeFZ96JemVq6J1A43
X-Google-Smtp-Source: ABdhPJyo3ckcqK1BX4pkaXT8dcTWwpEhJX+FLpLJq3ngq5dUZDsndFmK9Sbrl5lkKrtIzxY32FnodgLyCGKzU/5oMEg=
X-Received: by 2002:ab0:2404:: with SMTP id f4mr5766514uan.102.1633726643218;
 Fri, 08 Oct 2021 13:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211006213704.1093265-1-luiz.dentz@gmail.com> <615e1b5a.1c69fb81.a4f79.9f91@mx.google.com>
In-Reply-To: <615e1b5a.1c69fb81.a4f79.9f91@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 8 Oct 2021 13:57:12 -0700
Message-ID: <CABBYNZKTgHAdV8Z9YxHOVQ07KOOgLddmcA7SqZxE+X-i-uy40A@mail.gmail.com>
Subject: Re: [BlueZ,1/4] shared/att: Add bt_att_resend
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Oct 6, 2021 at 2:55 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=558803
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      5.91 seconds
> GitLint                       PASS      3.81 seconds
> Prep - Setup ELL              PASS      50.39 seconds
> Build - Prep                  PASS      0.45 seconds
> Build - Configure             PASS      9.02 seconds
> Build - Make                  PASS      207.69 seconds
> Make Check                    PASS      9.60 seconds
> Make Distcheck                PASS      248.44 seconds
> Build w/ext ELL - Configure   PASS      9.30 seconds
> Build w/ext ELL - Make        PASS      195.77 seconds
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
