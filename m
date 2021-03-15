Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90294C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 21:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E37B64F51
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 21:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhCOVql (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbhCOVqY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 17:46:24 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1B3C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 14:46:24 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so5870532ote.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 14:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVwQapsFOeUxT4+g38rpgPjZiB0nvJWje2C5Aur1mpQ=;
        b=el6McsgmGU4X0eDzqGWQyENT02uWef1KtlRDw54r4JCbfRdFTjE0deXvjRaoXfifm7
         xXTpG2QJejV57Xy62eJ8lxOx1IRqSFUZVPIr2lwEBZLYv9+UxkRWJ+nTX+nckAGU6pGB
         ligZ4xW8Fm4zNigENEhI9xTYpQiU+h5/XT+c92oOMxGvhIc+IOjngQrf9d8Ppq8C4jIn
         I5gebpXSkB6Akkn0xbwJJD5iO+UIqnJQjPlXDp/zjJo/9pgwokrjEZ1aOqWbmVWgiP98
         Zv1QRdd+pHlv6pl7vEC1XXtKzHJUEyV7cCbbuBGrtkPcaF/PRsn5FvQpcvwmOC3AFx+E
         EqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVwQapsFOeUxT4+g38rpgPjZiB0nvJWje2C5Aur1mpQ=;
        b=E1qYxOZqX2oQLq+bjBvfM3HzfxhXRHBsTM2shMwGEa8IC050VqyL43OUgSYYmTIZTq
         8l6EYPP+2Lmj2i1fEJ2oFKPjsS9ndenpvht9582G4kSwBnL0uEiQedmuYJCCtPCQEDe4
         iI+MpTZIeo6u7xIqlLdXKDmJKYghHCsN+g5/9Gy3jvb2RiD/ffRBGwJWQsYbF9wjWXjW
         rVfh7kh0uUfu4BglOYlEH87b5f0gxi/pLstF/iRJhVJsWMDQbVk1WrIEXjX4jLeT32CL
         T3PWFHuM6GfnwZx2a5kyBxW1vqriNDwVCied+khjCoaIzUAhwR+fY0BIECO3SUltawvK
         btEA==
X-Gm-Message-State: AOAM530YMasw9CiT6QhlFl6hu31CGqDbtBzX/hXVZ2GNDSIpMKd0m5iA
        2whsM4V3iOfCo3yQicPqclAYqba/0t2RA1Uu6id9tmMPnVs=
X-Google-Smtp-Source: ABdhPJzChKj+kaQ0nteLlU3I8FNEwZCFohEFlSMTTxxxIEkkblPknoIFHRsSrDtJqDsg9zBxlf/vbo2K0tkDvmgL7FY=
X-Received: by 2002:a9d:6b13:: with SMTP id g19mr938463otp.240.1615844783861;
 Mon, 15 Mar 2021 14:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210311183550.11150-2-cdwhite13@gmail.com> <604a69f7.1c69fb81.885eb.efc8@mx.google.com>
In-Reply-To: <604a69f7.1c69fb81.885eb.efc8@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Mar 2021 14:46:13 -0700
Message-ID: <CABBYNZLypSpPXcABC+2Kv27vwz1_srHtf8mSaov2CoeJLpq7Ew@mail.gmail.com>
Subject: Re: [BlueZ,1/1] emulator: Periodic Advertising Command
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     cdwhite13@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Thu, Mar 11, 2021 at 11:09 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=446503
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
