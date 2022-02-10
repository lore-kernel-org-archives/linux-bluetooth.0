Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF337C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 22:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344118AbiBJWbI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:31:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242808AbiBJWbH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 17:31:07 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B207BD9
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 14:31:08 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id p5so19548997ybd.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 14:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Y4gmwPRqOL6dIXAUKMKjpvtszgp2SMLU2VPgvcRR5NQ=;
        b=AMOaIOsIB3R5wVKz/VXk2fqsk7VvawT/kP5UZiKzHwl+PvWP2fL3Tbq5KdHWPAEBH3
         faJVPVWwpi1Zg0lwxyc2Va0inEc0Jd1Avn0hmo30HM8s5XfqJFaAJJpBX+wVkVfyPy4s
         Tp8nW7ktcOC+5wyWB7419J7gPnsi3Sy/lo7dvmwh6kXe0ZUL9ztCzcCsKGLC0wi8ETE5
         lciWuxVPWNetGcgw7p+VkVNMYnHjCo5qlb1+fgavWDNgDyK8YtmRAGBVCuBMcpVF9lhq
         3/wHRr9e6VwNASmu/528ZhJ6qS6Ajr6wblu3gDg7EOaCKfjJmk2h/NTtcrl8bN5QhVfc
         Kj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Y4gmwPRqOL6dIXAUKMKjpvtszgp2SMLU2VPgvcRR5NQ=;
        b=PVNktsl+AkyPBS4fq8GhSIuSZ9ihyFrhkZvbanjVCLBj41p/RyejzZSTYhejJfdJEY
         MORStCoqOsIuT2kZnepLqAh0Z4/RFQs+SqBGuU9HqhYKMCGyvVVni3JJsZtTNwa6wcry
         iDnbc3bKMLBhkTVleUjj/qJ14HeJZWNvxzko8yKLzn8Yg3lTeiY50DIuTIh+9d08aQ4D
         Q9tWL2+lH/Mz+la3woXilMfnOAoBv8Gj8EwNOhRLMUTJBzdGTqIGNVXlWljwN4hR/Yok
         T1NumgZPROM37nWBsxz7q1FVToPeDGC/17n2VwotK/zn03JS1kZwCQ4IlbnK6WRzpeX5
         dmEA==
X-Gm-Message-State: AOAM533Fb/L5DgFt5gYq1ejzUOcTjWS5FoveAFOzLXVT6pxEfK7Kb+/R
        6TjbhzR8BkdFcYsjDsp4nsWfF20Bif5lQV24qiPrRESb/rk=
X-Google-Smtp-Source: ABdhPJxY5pp6HryGkjR/tzgctOCRg7jcFMqqfxVLVxTkDDVRlWuiM0bBQ8FFcnkkGESOifmGhys/hGAwpZOG5kzahv0=
X-Received: by 2002:a81:b626:: with SMTP id u38mr9245227ywh.150.1644532266520;
 Thu, 10 Feb 2022 14:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20220210000903.162318-1-luiz.dentz@gmail.com> <620481f8.1c69fb81.53c23.7e66@mx.google.com>
In-Reply-To: <620481f8.1c69fb81.53c23.7e66@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 10 Feb 2022 14:30:55 -0800
Message-ID: <CABBYNZJNaDzaBKWZGy6egr-SWYw52+p6wfR1bF-_nN1n1nCwTg@mail.gmail.com>
Subject: Re: [BlueZ,1/2] adapter: Fix crash when storing link key
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Feb 9, 2022 at 7:09 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=612844
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      2.80 seconds
> GitLint                       PASS      1.95 seconds
> Prep - Setup ELL              PASS      42.04 seconds
> Build - Prep                  PASS      0.71 seconds
> Build - Configure             PASS      8.25 seconds
> Build - Make                  PASS      1316.49 seconds
> Make Check                    PASS      11.14 seconds
> Make Check w/Valgrind         PASS      419.52 seconds
> Make Distcheck                PASS      214.99 seconds
> Build w/ext ELL - Configure   PASS      8.17 seconds
> Build w/ext ELL - Make        PASS      1270.52 seconds
> Incremental Build with patchesPASS      0.00 seconds
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
