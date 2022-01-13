Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B83C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 21:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiAMVhr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jan 2022 16:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiAMVhq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jan 2022 16:37:46 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62570C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jan 2022 13:37:46 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id g81so18839234ybg.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jan 2022 13:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+ZPNWrFZZ5UrpZSSEELfOFllKSxfvPN4z2wi6CuOD6w=;
        b=DsakU/EPLM4xpLFoDP7wy2icIKb6ptl9R2VXY3tsepg/MhFOtmVa9UXJ0CzaKyX5Qm
         aP1Ph/l7ullNmvSqvxF724V+uTA8TV7s3SCyhXuYvyKeU0uFtjoWtJKJctAvYiiGiTma
         C48vH+audX8jjGwelXGMq7ciAzQF6PzMQZO2dFB022TSscJRokHTBu4MX7yeB3PjmFRg
         UCVIOqHZJIe1twjn9PazFwKA1Sz/1tTKrjx7H6X7N8O/+CSDF9CEqL3u00P2uwlJRZ5W
         MoVnsdti1PmESXIDRF+cT7/VpNZD5m370MvTQakPD20b9hiKiAWgkrrIuBe7+tFX6Kh5
         CkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+ZPNWrFZZ5UrpZSSEELfOFllKSxfvPN4z2wi6CuOD6w=;
        b=6HVdWUr/hvrxdyiw2T9w5QL+Z/DrUNodzb0L389T/z2vNFSah37yVdolIdZ/TBtsIJ
         xNF/xtOitA6xKjv90MocwAzOU+3VEmpUkBUF4YlatQJVhuAANFFDGWl1PQI/QHLnNf5F
         1cvpJ0H6Znd+VZuSGj4o0ieXIVC5y6CdN+anK6rWfR64JtNHBeCI/7nchviqd5paNVkp
         dq/n+757KX3eclsuE6Zxrs4EvRNn/7wUqbcytE8osEe2A4nyX+xrmISYnUmf1ryc+09T
         KiCjRR1CvJ4+jf91iQV/USrUmJZQjFsgBMBckl4hhRrWvI5Pf06n/iKIX5sEAASS8kdh
         Du+g==
X-Gm-Message-State: AOAM53375P6ZcaGEaHv+Oa2o8i5HuUo0H6nltkiBgkCWNKbHTGSiJX8C
        NwiA1beZySvuAwUxh24AH8M1CMzD9cCdrQbPNSszZo2a
X-Google-Smtp-Source: ABdhPJxtsBdUCx6DLgTwYHMW5DseyccNQb8hedfaWxnXkbj7qPXom0JPcBL7ZljjYG31OApztCSAbxFMbBC1U0Iss+I=
X-Received: by 2002:a25:c41:: with SMTP id 62mr8729680ybm.284.1642109865413;
 Thu, 13 Jan 2022 13:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20220112153529.338208-1-luiz.dentz@gmail.com> <61df08b7.1c69fb81.22f6c.1c7f@mx.google.com>
In-Reply-To: <61df08b7.1c69fb81.22f6c.1c7f@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 13 Jan 2022 13:37:34 -0800
Message-ID: <CABBYNZKCJFud7mK88zFdKiZzN1gRUnQfJz=ScbVsrtDVoKuwEg@mail.gmail.com>
Subject: Re: [BlueZ] media: Fix crash when endpoint replies with an error to SetConfiguration
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jan 12, 2022 at 8:58 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=604907
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.44 seconds
> GitLint                       PASS      1.00 seconds
> Prep - Setup ELL              PASS      40.83 seconds
> Build - Prep                  PASS      0.70 seconds
> Build - Configure             PASS      8.44 seconds
> Build - Make                  PASS      1376.47 seconds
> Make Check                    PASS      11.17 seconds
> Make Check w/Valgrind         PASS      431.65 seconds
> Make Distcheck                PASS      225.72 seconds
> Build w/ext ELL - Configure   PASS      8.40 seconds
> Build w/ext ELL - Make        PASS      1364.92 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
