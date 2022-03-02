Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74E3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 23:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiCBX6w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiCBX6v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 18:58:51 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C6244746
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 15:58:07 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id h126so6820958ybc.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 15:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mIB9s1H5H7KxKZ+VAlxL6nBmS3S++2KAof3OvwSiVg4=;
        b=PRYtjF4r2kfJvPbtYNyrHAm6q4wvnIOq1D5omKbBuRv46A3iyonORjPeBntuJbJRan
         sCmlj8AvL4Ix9fjBq+UQrk1ppTe0icm5kB9qu1Kh/gc9Nnp0oOTT4hawOe6x/lQ6bZCI
         PaUuD6wEaqhRbI3JwiI3YwCU9HPB+fVvdfSbyLmi7g6KM/2w+qkLhYCDMVUQ3D1aEqnU
         jgijqhPb6PMMolZu4D43oPmzu4RgOFb6eNlEx5BJuLbY9DRTA7oFqK9h/876QFSw06J1
         wOvHk47aDX+22aKH1HHTcUQQoqY3XVSKh2pMsebwWrZe2qJEBedO8FRtGZjN+3HMzyT3
         bANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mIB9s1H5H7KxKZ+VAlxL6nBmS3S++2KAof3OvwSiVg4=;
        b=Kw1BZJHV1SDYh3IdqIXIMNR0bYjUOtkS6GEgG+ww/YpooCqgH2Hf8xbXAE0sDoULNQ
         HUReOB0ou2bBp4PUDBM4iE9UtYiMUgd4Zs3W5g8LdGHLU/5CLGXyH0rgEbUJ6bDu0fIU
         BEUU6QSfrfoiGp0gQ+mVmlaW13OpZYvZ+uW7/02/FZ20ufaOMETv5jYES+bzDDAt1pF6
         4QlRFNCsMnASoYLb0VxRhpT1u7xGaAW/gSkkuoZiPKaXunhrMooSsFIwHxelLeynyCia
         la/5R1FAerM+KEDUt3X9ivfKKXIOOYiTwNmwLwFWgSojYCC9fjDs+1xDGSqxWI8T5FWi
         +GbA==
X-Gm-Message-State: AOAM533rK+hSfLWgDawezsxbV5ffl019tLy5QeKv8j1pyKWfdyf9Rgn3
        cO/f+saYOcl1ri2H2J1sGi7L9vi/uUcvEyKh11Ze11D4
X-Google-Smtp-Source: ABdhPJzmefAlFyUAe8RDHYW4S9pnfrD+z42BKZ5/WPKPFJzDqwX6E5e4gxNSAWW7iXL57BGVIhw10a8wjdDLZiLc5KM=
X-Received: by 2002:a25:9742:0:b0:61d:9526:ebc3 with SMTP id
 h2-20020a259742000000b0061d9526ebc3mr31981844ybo.578.1646263308515; Wed, 02
 Mar 2022 15:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20220225223905.571204-1-luiz.dentz@gmail.com> <6219e3d1.1c69fb81.90a9b.e4cf@mx.google.com>
In-Reply-To: <6219e3d1.1c69fb81.90a9b.e4cf@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 2 Mar 2022 15:21:36 -0800
Message-ID: <CABBYNZLan03KhJ=0AmEU1KarsvQ8OqEFcVYWLZppyhfTWQE+og@mail.gmail.com>
Subject: Re: [v2,BlueZ] hog-lib: Fix not waiting for UHID_START
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sat, Feb 26, 2022 at 12:24 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=618207
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.55 seconds
> GitLint                       PASS      0.99 seconds
> Prep - Setup ELL              PASS      48.60 seconds
> Build - Prep                  PASS      0.77 seconds
> Build - Configure             PASS      9.84 seconds
> Build - Make                  PASS      1447.35 seconds
> Make Check                    PASS      13.06 seconds
> Make Check w/Valgrind         PASS      514.12 seconds
> Make Distcheck                PASS      269.49 seconds
> Build w/ext ELL - Configure   PASS      9.91 seconds
> Build w/ext ELL - Make        PASS      1414.84 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Pushed
-- 
Luiz Augusto von Dentz
