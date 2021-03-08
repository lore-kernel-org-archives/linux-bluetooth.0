Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF138C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 23:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F6E64F96
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 23:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCHXeA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 18:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCHXdn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 18:33:43 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56B7C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Mar 2021 15:33:43 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 75so7776559otn.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Mar 2021 15:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=KJunn9DwuJGr8xAo85faDE5eoHZhZEuZ5H2epQAT//E=;
        b=UnxThMpJT0KuQ0vsXOPBiQQJm4806ReRtOrodEEZuJ/jozZVayEjDSID4wE3j7/hhA
         Fv6faaisZcH5jVSfJTRXXRnzNAmSbHnYYNTWioZi/nqyHnladR/iP4mc3YhxT7m3pVZv
         SVAvOE+DMe5scS+JF+pAwPWpLpPHVSl2cqy4tm63ZWyY9xbDf2rK9GXL84te6Um45MIK
         GUJDHqKJZe8+VplWmAy1pREaEMwxfOF2okXm1nLCuN7/rthpZjptOMdJ/lMISO0CRKd9
         vRfAkiorBxGUZa1OdfAF4bJPEbMyS4iLp5XtHbRQIv2qyS7xrzPLqef5yD/w76rmpn2o
         +3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=KJunn9DwuJGr8xAo85faDE5eoHZhZEuZ5H2epQAT//E=;
        b=VelcDdpIGKU4TBN4+6fEfgIrv7+BOyvMMZqdULXEbJM6AohuojI4+7ziH1UDFe8IcK
         G3JKSDmvEzRHtvqRyv//51XM3fbIFqlhe0WsvExf9cOwUE0v2yRTXahW1KbX/29zs2Ys
         aplDMmjpFuNe5Dh8+dk36QPJk1SxFpFp55tkZSl2JU73aJ4pbBdeuVGDpIR1jFYcQwNr
         CiB9lrvpBNXXkEpVn+M3v8e76+EdMaUzK1tXrt+MH+Bhx+jZRQm/w3/qLJHDrw0hS6YG
         Y72PF03yoqy1KNG7Oswo1o42UiPWcaubeWMXZOcVe121f8jw6TLFFwP+J7u5j4Td7iGp
         /BSA==
X-Gm-Message-State: AOAM5312dLzxnrBJ91tPHLcKW5hyLOXE1gjDLjBMAHSIf9szWkWCWVLD
        GktbBYh/vmZ9x/2tBAEcnmSZhsGTXhKT1/3UeOP3L8oz+2Y=
X-Google-Smtp-Source: ABdhPJyTRwsJR3W7uNN1ZuKZvfIA57nvyC8EWxXejmuxdtMpuaVIIIxkz1QYui9pnKSkHD7bDrJ2y4rPEY0xFRx3Ryw=
X-Received: by 2002:a05:6830:57:: with SMTP id d23mr12649otp.44.1615246422833;
 Mon, 08 Mar 2021 15:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20210308224228.344888-1-luiz.dentz@gmail.com> <6046ac9b.1c69fb81.dabbc.6173@mx.google.com>
In-Reply-To: <6046ac9b.1c69fb81.dabbc.6173@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Mar 2021 15:33:31 -0800
Message-ID: <CABBYNZKeOV-Tp1RHZyxAD9_vvsC8Y_+F2=BiV0r_Szi=H-ij8Q@mail.gmail.com>
Subject: Re: [v2] monitor: Fix invalid access
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Mar 8, 2021 at 3:00 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=444125
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

Pushed.

-- 
Luiz Augusto von Dentz
